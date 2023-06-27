Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF2EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjF0MC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjF0MCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 08:02:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5599719B0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687867324; x=1688472124; i=johannes.schindelin@gmx.de;
 bh=GXEWYMb46OZQ36y7WkP7hZyAm7SK5zkCijp56+ACmxY=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=L/UOupTz5rgLKvztConeHUCcref3Z7ypTBOKfZhMQ4a5QdkA9kSes3dz+0tTZUYYbb5qgiX
 u5zLVNtHaQxnquHdjTy82Js7F+zKhsFkl2bna64fa74/XcHjXjdElizKZO0ayPWeOKpZFUkq9
 3/Bwc6q8A/o+KvGPgYyJrqobIOJuxjH3cl1I6Ei2M635toU7tXYSRiwirxLrQf051fUpS7IrK
 XO6LndCY49SCMF9IZMg9DdGogmzPDf6b+2py/N/e/PmiZpHiQwHijO4xrJW7BkzYWaRusRRTQ
 DBIpRtA2SKZPVGv1K7P2LmwS64J9krH7hVYjXbK6XIm7p51R7/1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1qDHNZ12fV-003fA0; Tue, 27
 Jun 2023 14:02:04 +0200
Date:   Tue, 27 Jun 2023 14:02:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Joshua Hudson <jhudson@cedaron.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
In-Reply-To: <xmqqjzvt92nw.fsf@gitster.g>
Message-ID: <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>        <xmqqv8feb0vo.fsf@gitster.g>
 <xmqqjzvt92nw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M7BTeSG2H+i5J274dysvdBiSd3RHa1z9r43C+KT0qW2Tt8LGM4Q
 o1cGn/ted/RbmLpatxprArjXY1RUwp4e7GlrN32dyi+7uGhR/bS86hiAok0zvxQ8qHPEces
 jZpLQt/iK4HNiSNt+e7hoa7ADCoNI0DvSsZ8YRwrns5Un+WJ41H8qdfa8lZ69z6EpsGHz2M
 aDQNMHNJ/VzTOxkUPhhOA==
UI-OutboundReport: notjunk:1;M01:P0:fkZrvsmy8rU=;f1qLYLu0mgYFIlpn7cDtLxoAjGN
 OmmouKpiWaecXnbYQzMrQhh9N79U3RXrKlFJ6VIZrjJrj2XdqZitWu87gOS9UxK+049xRhF6b
 mNRADoxo0vdbW+n9ObH4ohEsaKjDT094IEMVXAkoco9F/UKs+8OSOJ+5Ux4YH5euvs7119+/h
 ypa0GNF0V3MFdEGnU6hsnF2M55loa5cDXePG6VM2dE3NcBUfuYFkpLkQ3BO1JTrji2GZZUBvV
 LVTetI7pYMmS3QR2/5WzZ5O6EZNpAI7zBAW9TBVWddD9kjkrTQ3d0Hb7ZrR9n7lie+QKRjnVv
 KuuIHAt7QMXLFaMX9Vd2jUK4Q9y7Py/EaVIa2C3m1rJ37YM/ntMKhEmjRwaK89NTZem7py7de
 KoyxsvM4GZVpoNLypN2lSV99h6AMnoob9/aw1YCySqONclKLvhzZXkHRx2QQoSgznzadfuAZQ
 1Da0QwZ6dEcVWWn8LHdJtiyQBeeRyWeutvNW17U++QZ+ZxRvRx4WJhJ7WnBBeRuXKkGsLXw9Z
 3p2ysULaRX/AQ2bp6+y/jeUctCvYi9rprPAVs2KQIKzizOMqBj4RH8AnTuf+V0dgCyktyRRwR
 Md6thRFv4eT1q3cXRRavZ7O8xYTB3cKZGc43w/elnwMuPOiXaksOJ+lKsd4GYU2gsNxUSX5ER
 LG5TRmEpURtR5yhG04DQVbDD3z0V5drCq0nYTGcbA6ldl/8UZXn8iv7aKyOynTcoG0MSf0W2Q
 XYJoITM3yjHbwcdxdrbsbP2t4Heuw9gm2k2e6D1+o9KJl3Ua5RmuMvlQa+EpdMYlGWp12RdjT
 UGY8479kDL4dgWBbiTDNiLzniPxxVhKjrM/iGZ2cHfrGiUH87I/iEobwiMduENP7VyNjht8Az
 zvMcF92qLF4Y5jAbo3Sm/xVh5Lswt90vZceYygTybLaS3oZlcmhVQqK9bLCLi3YbDpmtMcr99
 e2ZusacS4V6WC0jQs446iiR0iAo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Fri, 23 Jun 2023, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> Reviewed-by: Elijah Newren <newren@gmail.com>
> >
> >
> > Thanks for a quick review.
>
> Unfortunately Windows does not seem to correctly detect the aborting
> merge driver.  Does run_command() there report process death due to
> signals differently, I wonder?
>
> https://github.com/git/git/actions/runs/5360400800/jobs/9725341775#step:=
6:285
>
> shows that on Windows, aborted external merge driver is not noticed
> and we happily take the auto-merged result, ouch.

Hmm. I tried to verify this, but failed. With this patch:

```diff
diff --git a/git.c b/git.c
index 2f42da20f4e0..3c513e3f2cb1 100644
=2D-- a/git.c
+++ b/git.c
@@ -330,6 +330,8 @@ static int handle_options(const char ***argv, int *arg=
c, int *envchanged)
 			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--abort")) {
+			abort();
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
```

I get this:


```console
$ ./git.exe --abort

$ echo $?
3
```

For that reason, I am somehow doubtful that the `abort()` is actually
called?!?

Ciao,
Johannes
