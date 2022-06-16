Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA8DCCA481
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 19:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378455AbiFPTxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiFPTxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 15:53:32 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C743F337
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655409208;
        bh=4rh4dczs2L3BVjwYWE7sea0xQkA45STxoZT5Ge0wvpU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WJLMGwB7CDCD59X5sUVZVeIUqr7fIUHYtD2il2XftPDsKEoaDC1GYRhNjidnsDgFw
         4STm2s7jpPSYTKa6nIbjuIQwMgaqUkOLWG660LdOepBD3OUJnT4+6dGv3DNmKV3Mjy
         sIGCN2Xth/2tusimcHZaJP5DIFNaG7CK+8unMwnQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDv9M-1nuGZo2tDo-00A8XR; Thu, 16
 Jun 2022 21:53:28 +0200
Message-ID: <98ff788a-d621-cf3f-aed5-66ae763b381f@web.de>
Date:   Thu, 16 Jun 2022 21:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 01/11] mingw: avoid accessing uninitialized memory in
 `is_executable()`
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <679ea7421f73ce41515aca549982233f88bcefef.1655336146.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3kD9KQdfbt38NnYP5u97iPAxG+JWWqAH1KPIOdCAb8reyVmgWl
 NPur8XIK0za8b2+ox6qFE+yhXj+JK1hk7Z/vhMRms1w3tc1mMA1ELu8LOsBd/IGji18ghPX
 FnGTlcsZ50ZQQyLavEcsn01yWA9Man5gY1RbPeuuws/kQanTwsD76nP2gULlWJplF664Ocz
 UfZM+gOPdlv0J2C2ZtFow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/jNgTApuy2c=:2sJB2FMMRjaNKWg9PCrU4u
 LUg4J3P+t5oZNOL8cTaOqkSOwBPImph+IjHq6xkFvGt6ob34/foG11aJoAPJ6wHISwbYjIsxs
 ptog0JUSGG0Jq3gSCtA8z+T5VOUFUXRVbiZ0EELOXt5x+OHL/7+C4Vl+GDAFzTDca22vtVUmX
 D50QJLWloDwqxf2rNtNb+aRbY1EH/tbTtN+EVQ4zdX8VJEaFNlqJSRH+JDKkYAX69YwROU9nb
 VXAOhtvLlBWyFCEalfc9MLwea2Ab0RiTZ1LmSXpLvDBwpFc8/VcT67K6Otz8qxwle8kzv2vxR
 YObTFuAo5ryAp9cU0vtX4a7bizq16jnGEAWxr6bRqU/+6rJrQ254jHKwZtZ61Lm7DnHjyVukj
 ZF2K1ZiZ70gMsZKZS00sf2NjQ+OgpvODYRDeelo6p0PXBmQbLiQq8MIr7KkU5ZqgvUz3/hdV2
 B6iquYju2N/ilYBakC9m+pgI8dE9cvaJykJgwGeP/Oq/l5wONSl+UCsgkx2kcnwGkR/Hwy4dk
 o/qWoIYYLpOuQ5dzRt+HspPfSsOLxfy5rD1MMODhbpncQPqMj6CWeAUxwFtTp+usNuw8ZZHIF
 DuInx6orDB1cuW0VRFBAs+Gs+LAR9wTZ7vsOsG4fJc2RWudGuaBjBpVeFA7dyDwtTiEBn0iZX
 kRbq1KTCDXvwnvaiPYsWa2OAtnNkHE3eFCpuqFD9MON1mfpj6D+QM9E5yTYEdpTuGxAiM/0Zu
 p6i8PnPScPMBbInvGp21qXMjViGD1NQQBJiuPfm5hApycIhYIwfLyZXibppquHNI7HQ0K531K
 UFKYOrrgPLqqA5ns0bMlOuix7IhLcHONdxpPYk29/hH59B5F3TgkjmR+Nniz+DShoBskQPsDU
 4MgvCgsBMQMsMvsfqsIEuntv8M5djZa9zzf+oqKOXzBSJcWJuiAYPuL/iDnlH1Um1SkGM9ymu
 3QeT3aApfiabeYSc88gh0NPByo/fxGQQRfT61v6Rn8pdw38PMZGk3waaeS7u4XgJnn/ncdch1
 kQyLK2DPqrq6rgNWeUwinh1qZB7XCi5D/hriuzgnDzJrN+bUb54h8voqqYq0lUzQPqj2n2UDz
 wlPMdaSWSAaiERUkHHC21Wy9aU+7UdLRHI3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.06.22 um 01:35 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, we open files we suspect might be scripts, read the first
> two bytes, and see whether they indicate a hash-bang line. We do not
> initialize the byte _after_ those two bytes, therefore `strcmp()` is
> inappropriate here.

Hmm, but buf _is_ initialized fully?  Line 149:

        char buf[3] =3D { 0 };

C99 =C2=A76.7.8 21: "If there are [...] fewer characters in a string liter=
al
used to initialize an array of known size than there are elements in the
array, the remainder of the aggregate shall be initialized implicitly
the same as objects that have static storage duration."

>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 14f17830f51..2ba38850b4d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -154,7 +154,7 @@ int is_executable(const char *name)
>  		n =3D read(fd, buf, 2);
>  		if (n =3D=3D 2)
>  			/* look for a she-bang */
> -			if (!strcmp(buf, "#!"))
> +			if (!memcmp(buf, "#!", 2))
>  				st.st_mode |=3D S_IXUSR;
>  		close(fd);
>  	}

