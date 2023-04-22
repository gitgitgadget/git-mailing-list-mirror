Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A5EC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 15:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDVPxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDVPxa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 11:53:30 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E01FEC
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1682178792; i=l.s.r@web.de;
        bh=6WVWdGEycRDraoEK3mZvHyCm6flHcFi2bTlq1IBEGNk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AQWVEfdD2kM2RhC/h9o1CL/k0wRiFmGA0VdAVor2KDXgCDMOug+ZWAQfJGzSDvGei
         S2E5a7swo6DPQEFla349MgeW2Ge3KhHHVZWWd51LTBSq3oat0RllSbQ+xOYkLUljCI
         MkK+wkJefvh2abFOdFQwQBusI+GUX7MjMHLYJl2J233FSzE25YGx87tT2LaUWaEo+D
         ataAPU6OrIRdaAds7iYragJuv8wA6JorDm8VPFOSfMi4VabdcBhGMllvU+aQvWGzsj
         wqjuHEdEnIlhmUkDoyt+c+ocO4n1mycvREJgtQpxaBxlH3v2U2Ww8tk2ZHr4uxZZG7
         nooMMYPs7ae5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01di-1qBvIs0AFC-00xChC; Sat, 22
 Apr 2023 17:53:12 +0200
Message-ID: <7f48188b-2e06-9f01-de8d-a24812fb20fe@web.de>
Date:   Sat, 22 Apr 2023 17:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] parse_commit(): handle broken whitespace-only
 timestamp
To:     Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20230422135001.GA3942563@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230422135001.GA3942563@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F0SyNPqS16i3MJeM5b5JYkUvqbC76VneIBzPkffTx8rOUa/ma4I
 1enCK+yp+j33MKjmu2Nul7x6dFt47P2YRF19xbr9ADMweWDq8qskUf+2VIcGJTbA+FOy8S7
 Omd1k9mvIwsomxFC2UFW1ZhvtJlAVP7EU976rqXWDb6+wFbu23lpEh0eb3PfKbvUByJ9kXK
 aDa6n9dmA5Sk0cGM+iWwg==
UI-OutboundReport: notjunk:1;M01:P0:ZmzNR3DQ/dM=;AJQlmuN9iGQRWhIwGbX61OZ9TNQ
 OISYPbZgNqPNcDZfSn/Dh2fEB439Rsos0lRzkkDNvgrQqoVF3R1dQPjJaLMSdGS6BJBoNZ1IZ
 REjuaXcF+CDB9uUTXh44scl2CELa9wcjbV16NFtVoXl6ks+rTxb79GiI3RiJq2Jfp2ftq8WzR
 vp/BAZzI2yqnsocwgqo0jWsNjljMhauudxkcd9AbKLO7vilnIE8wgkWNFMbZUNAOOd/4P9YOP
 CsS4FtJLf5Lz8NwMUHv01/iZMjdAvOL2LnNLhXIotFPg9nKNx0VZFgMTlai/SSWbQDOsmYKFg
 /yMsFqrSLAB8Kilq7vdAVi+zAl0NjvlI3mxqOX+ZAgVyds+xj8cVqx31xJFuvhvppDruFvC1T
 MDMnjUqurlOOoAaiWi0XtfqANswiayjF3RnmWCo8QciEqn73k+BAaIfgN3MyGnjxwN+k3FhrH
 ZX2siw02teBlz41LJoB4wcZ7+vC58CuqWUA8TJdeOhdRJOm/eKSQTtVJFIn+316/4ibuRKXae
 8KaGrd3bvm8PbDsId59obaDg6LyDTh0DiWcBDB1qwhIaQtDVUpgf04OhYPIz3/OLwOV/tv7Kd
 ezO5SuspD2NDm15jyUoT4uCwJ/msk4jkPaG5NkTeCJc+sGD7Nd0Bbf8F3nKBzfhDLhyeR94hz
 AW//kh9kmhSqinbl3Ui09z15nH/tXfptPnjAyy9xZwwn0jLW+Y4O+iXshVEYhjHB30WBCEf3h
 LHBUyulFxflQGJzFliy4pyNFhDMY3X/0PDAKWMEIoQ2jv8vSQvrYHwRLovTl7Zg7/Jpj71KtK
 vcJVsTpyga7Nvm073Dr4/S6vQzVPHY3aW/6jJ5U9W10sQEq+23w5OKfWoqphMKHf9filEoRug
 v5Vgm8Co2D7zaLj7Y4WaUjUcKdC31dV56f0aqQJVMmE5lXdcafX+FSLwX14olQUgah0r8h2sb
 80SLbA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.23 um 15:50 schrieb Jeff King:
> diff --git a/commit.c b/commit.c
> index ede810ac1c..56877322d3 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -120,6 +120,16 @@ static timestamp_t parse_commit_date(const char *bu=
f, const char *tail)
>  	if (dateptr =3D=3D buf || dateptr =3D=3D eol)
>  		return 0;
>
> +	/*
> +	 * trim leading whitespace; parse_timestamp() will do this itself, but
> +	 * it will walk past the newline at eol while doing so. So we insist
> +	 * that there is at least one digit here.
> +	 */
> +	while (dateptr < eol && isspace(*dateptr))
> +		dateptr++;
> +	if (!strchr("0123456789", *dateptr))

You could use (our own) isdigit() here instead.  It's more concise and
efficient.

Ren=C3=A9

