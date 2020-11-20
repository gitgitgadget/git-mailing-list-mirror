Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38842C6379F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43422245F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WKEBDHr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKTSwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:52:55 -0500
Received: from mout.web.de ([212.227.15.3]:38243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732041AbgKTSwz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605898372;
        bh=0PRVolNvMBNb2/1TFMb9idG7pFmFOenJuZVghy/xtpo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WKEBDHr4pLkK2CHWW7FfTs4cQJEqsGvYR6/d4MB5KVVKvw8IgCaeFAs1Xn58daxrI
         m4KxxXmNC5LB/lW/AqCYiwNVMUHRj0B1133YPGk98uXH3MahYmsOPONXZwlzX1eAPO
         81aH8iEbb1EBzrSnB8ppZZJ9GAH4PClfk5fIdm2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgNS-1kTYUI3GT4-00EDHJ; Fri, 20
 Nov 2020 19:52:52 +0100
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on
 [was: (no subject)]
To:     =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>, git@vger.kernel.org
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
Date:   Fri, 20 Nov 2020 19:52:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SN+3T1jMkoVPhCy7QBaiZZ/5G278yb+5/yaoEreLExpia+9epFD
 qGpkiLfsn+feEwEIkJwB2UIn2A8Fpcj/1U6rubMLRdLBfjFm/bu9RVw6YdIFt+BknvT799W
 F4RPsIllnH1tQoXhdFDgszcz5EVnWgGvE8U9SSFLuVhHkgVLtJcfxqdM7g0vv31pR/F1cHu
 iwMeFKXyds3SqdMt4muMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNnbWsMZVoA=:QPHaiYqVqzI6g5Ly52+1I6
 2/plIbx1X1vCZhgIgiqxsaZHaSIyfkUJJNq0eDLblFwLI0Jm5Vh7iBXp0eU9jF3pjF+qu7nQj
 s+xAUF1MikW9dstbtTvBRvU3tbzwQ3Ql7Lp5DE/aOM21i6UiJLtXjX894g26HXCrPyVWyanTU
 paQx0cbGVaa67tr0vAzsORo5mzMi0ww24yM6FjMAfveM0DwqbFb5cGNhpd/o45hYrJchuz0gt
 Y0g0e6U+YJw9moezm48Z/jjZPxTLX3rgRC31OmsNHnA2QlbF3SupdJPYM4cGurfEDvlQbSvAo
 AvG9qaIAA+UXHQAHmLVAapqxSUqWmTkl16GmkmEWc+8Fb4UCx8tUg98+o4S7AkXpeC+HwepYQ
 2oiPCquLxOS7q1COTwGoqCsAF1kjCNnCphrrBzZxRAYmJVfDS3HEbdOTCRiQQNCYokv7MUy95
 8sOixbeniA2L99NCRaaqfLETHRir4W6n5eenrN6+OSyXb+Csjxj1fVGLhCQgn/ATpUKLP9Fi3
 6xnOuTNQ57GCJ8ZvVBic2x2zUkxnX5pBzG9+vAXRmDH0U/fmSNJTThpjAdiWlEJX/0nLEb8B1
 kFuccx8Xv+v0DO0vNdJ+P/8QZticldlfCTNYPOlO/mgm9bX19BalFnMxuoBNjrXBa0ExoLFqw
 4YysIbcU3RiHuyUkRCySgyRGJuikjQEzy3ulIa5908T2dikVMT9o0ojqhzzp0cXryriZkOYmH
 v420ltG5ShwiZn9knU/4tpYGQrozbT64KFwHTAMMkm0dHpux8Vthhz73+/Ve7O2iCwZLt0wja
 Aw9FJcADGiJ2JZJF49Egg3ULuSC8vyadE68G8V9OLBVEe+3DxIoQFDnec6Pi4/xlf7TLstjfD
 qqKwlw9In/Rtl/u3WdFA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.20 um 09:18 schrieb =E5=94=90=E5=AE=87=E5=A5=95:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>   1. linux environment, prepare a large repo to give you enough time to =
debug
>   2. clone that repo
>   3. during clone, send SIGTERM to the git-upload-pack process
>
> What did you expect to happen? (Expected behavior)
>   there is no git process left
>
> What happened instead? (Actual behavior)
>   there is a git pack-objects process which is forked by the
> git-upload-pack process, it becomes a zombie
>
> What's different between what you expected and what actually happened?
>   there shouldn't exist zombie processes
>
> Anything else you want to add:
>   you may need a docker container environment to reproduce this since
> mostly init process will cleanup zombie processes for you
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.26.2
> cpu: x86_64

Have you seen this working as you expect in an earlier version?

I suspect it's a matter of turning on some flags (patch below), but I
have to admit I don't really know what I'm doing here -- and why this
hasn't been done already.

Ren=C3=A9

=2D--
 upload-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 5dc8e1f844..e42dea26fa 100644
=2D-- a/upload-pack.c
+++ b/upload-pack.c
@@ -321,6 +321,8 @@ static void create_pack_file(struct upload_pack_data *=
pack_data,
 	pack_objects.in =3D -1;
 	pack_objects.out =3D -1;
 	pack_objects.err =3D -1;
+	pack_objects.clean_on_exit =3D 1;
+	pack_objects.wait_after_clean =3D 1;

 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
=2D-
2.29.2
