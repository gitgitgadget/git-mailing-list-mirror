Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE985EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjF0QdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjF0Qcn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:32:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A00D3A91
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687883543; x=1688488343; i=l.s.r@web.de;
 bh=t6j5a+QYpnS9Bo5B2fNNMZtR2yhQZPFqQDvQWZDeWfY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cagYZvZul116z9SSDlS3ivrQIjyaHc2PGpLbRx1Y9I9iFxw+kCP9Ujnzx15O6mJxSdZaaLj
 JkXDnZByZAgeUOhusfTipuFtESMbbk9Pj51giREkYD/XDNHb3t1gxEuUrzmWg4reShple94JE
 gpA5aQHki8v/5pADpZe00L+pCHFZZnVsMqSj6XGqiDqTF/gsdBKICFjoP+AKLKbyLI99PJHbA
 15yLJP7dwc/IZIYtqtbUW08ztHXdmRALJpbtKh2AHG5gBMYRf6qUzQ8K8FOmRJQDT4SQqkAWb
 t09bLtNZwEGgP+w385EIYw3Yh/PgyeBZnylQ4oNyDcAh8w37dFDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.106]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVet-1qIMTu0Y6r-00DNrL; Tue, 27
 Jun 2023 18:32:23 +0200
Message-ID: <3654f95d-5709-28f6-eeb2-ca62a1ee789c@web.de>
Date:   Tue, 27 Jun 2023 18:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] strbuf: simplify strbuf_expand_literal_cb()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <ded69969-158d-b05f-fdd4-91b26e9b502b@web.de>
 <20230627085701.GK1226768@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230627085701.GK1226768@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tRu4sl5nvh+qlu2TcG4wa8m830H81vSFF2KAnBp/cVwC1gzeDtO
 53beZJdy7EH6yZtf2shhG9mKaaoiBwIRN00pI8H7e2ENi6+iT7SPTcsu+yWXc3bskpHYVWk
 u0yIaLLB2up/n6n8xDhAlSDROKz4brfpwAwWTtjkkSGRz31yCUH96spA5dm2Xz3ozRcSxE9
 RXyNZWIbqsTz4musFKLqA==
UI-OutboundReport: notjunk:1;M01:P0:IJEWvOIcOiA=;8UorLCeRfYdgMQ/cNpefdIqqrx/
 1bYvg5Q4e2l4TUSJdCkyA8caK4mxb/ISsHK5Ehs2XVfX7HbjJ3kvKrhmbbVfVubfzbl6gnX/O
 Ko5uJ13lG3BU+FDZhj+paOn5D0EBP+vxZ2otZ3DrUtmqEy0gqVOz4t0Pl3VsNF8XDbArpR086
 UnzH7es3/01sQ4cP69NUDT6Luf/iTGu2LzqT33jBAi1XP0t1jj/dis7kD5hogmF/RZLiSLDM+
 upVFF0zb0AAbVsG/rpLYeoWC3PaTQeWA8XqDD8SBSqrZ1lWbNcY3P288qkT1zvU1GbdhSDcuv
 n4PDjHtjUb4d7bOp58afbJVTNCNQe0kuHc6DypIFEtutOPTAnTcxGEPaRO939SnS7Tp9D2pQz
 H3J/FgSrP6oDZcZ4PsXFwJ07Jr9L2iSxxtbW3dM9+BWZXorxSdanZRawV2JSftlgxDQYgWNNb
 2+D+1fZVWLmumq65WHVcx4SBtg7OeqDvLMHtaJBL2cC2boA1wjSEXgTAfL2wk7jX9lxMM9bm+
 g/YnOfI2TYguemdzQJczAy7fC5oEh0l5Qn6kcBy7fzJzpch+94e+OM+kWnq3UZCTux4ILUJnL
 8OhFB5hHm/yiYpqjr9Sj1yq23nuuwCinyKUVJ0j4XCl+n2vciq+HaDE8ulf0NyPXqb4EY4f00
 2oxuWY2zUIK7EgIinfTSrJpLWtq4F0PFZUnJvR9yCXmLJJCqX0gVarTw+HtLl+G4MSq3KYjrM
 tkQYJQ62J+/RsqPCfayb/BPcIng63MaEz8hLacfr66g87hC7lXHSCkOzMNVezV3hPp2Id/GHh
 wv900h8BFW5Hu+svyFe81fL6L+LZvY3DK+IWtKCTYYck++DpZcVh9AW1yY/ka3wyOrjaDsBLD
 DyQ7XETnRbkNI1CbwP/uECkJEVbo5yisuDS54zjkkl7t+zsIP6ULxPdEqePhFfpNJoT2D9x2c
 Dt9f9w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 10:57 schrieb Jeff King:
> On Sat, Jun 17, 2023 at 10:44:00PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Now that strbuf_expand_literal_cb() is no longer used as a callback,
>> drop its "_cb" name suffix and unused context parameter.
>
> Makes sense.
>
> Since most callers just call "format +=3D len", it kind of feels like th=
e
> appropriate interface might be more like:
>
>   strbuf_expand_literal(&sb, &format);
>
> to auto-advance the format. But I guess that gets weird with this
> caller:
>
>> @@ -1395,7 +1395,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
>>  	char **slot;
>>
>>  	/* these are independent of the commit */
>> -	res =3D strbuf_expand_literal_cb(sb, placeholder, NULL);
>> +	res =3D strbuf_expand_literal(sb, placeholder);
>>  	if (res)
>>  		return res;
>
> which is still in the "return the length" mentality (OTOH, if it
> advanced the local copy of the placeholder pointer nobody would mind).

Yes, I only grabbed the two low-hanging fruits here.

A format-advancing version would also look a bit weird in an if/else
cascade:

	else if (strbuf_expand_literal(&sb, &format))
		; /* nothing */
	else ...

> I dunno. It is a little thing, and I am OK with it either way (I would
> not even think of changing it if you were not already touching the
> function).

Unsure.  Should I overcome my horror vacui and let the /* nothing */ in?

Ren=C3=A9
