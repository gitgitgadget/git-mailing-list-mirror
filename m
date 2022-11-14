Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CAAC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiKNODO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiKNODK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 09:03:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7822A73B
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668434570; bh=BugYsLsCzGmwHIvHCHUSN3Ph9jSl+MBLsnAjcIu0QtE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YRQKi2ljQienFOTByGCVQDPftWNTsd+8Hw2X7Hx1uuocH59KNmDdXBm/Bw23+ckve
         04yYAAWdRvj2Ie5NGmQissl3ucLz0sMVQns/lH3gYFBbEhjxHT6/OLo4hI7frbXGs1
         H1zH29+QTorIoGaPVJD41LFC8m1KPzl/SOWkvDcGUIar09QmrBuyb9+rBLGE2dzL3K
         R7Cyaw/45f7kN5Gs5GRWKK2IXyR4JMsM0+OpD/46O3w5wlBqmnZgjs/FWccGD8ul0C
         C2t/P0BJCegqYwmAYCyoplWJe5WbWq+FauTbH27K6SHGSAQrwlOGlC13r6GyymwixE
         kxqw85NS4dClA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.27.84] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1oxbFe410h-0048tr; Mon, 14
 Nov 2022 15:02:50 +0100
Date:   Mon, 14 Nov 2022 15:02:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
In-Reply-To: <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
Message-ID: <pss2rp96-qr48-21p4-36on-ns04nnp0944q@tzk.qr>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com> <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com> <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com> <221114.86tu31lnwr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-286723764-1668434570=:177"
X-Provags-ID: V03:K1:2HaQweL8wrK26MK9rfKZA2wjHW3NNl0WF3HMOBCnk7JRPi5Mnne
 ZYZmzAswyBYxYzp4vzncyyqpul7cNLblDsT4+PX9hCGlQywj6V/YlAiUG1k6/i7F3iDyqPT
 gC/Z9QsGLPTQPpsYBH7LzflNW3SYu4Ew248gf26cWfXtaGlxKjnSBmfKx9PynkhxMFqcmb/
 q6tyrg46BtSwqgYOtUBXw==
UI-OutboundReport: notjunk:1;M01:P0:qOi/MLe8Hp8=;UEK0Tyf3V6zAQ3VWauBsZ/ctgdz
 uPrSQ3/xFyS901iqD8NtEmOfsR/n/i5hWoB8g26Gppk4M643EneFs7UeyoeTBu3eIF1utMdgy
 86nRJrRaZzWsSR101jQbQtXMpOvXvd0pXFQl8+rKPzU8vEN3ZIt86DrrXQtzyWR0k9Aes12cI
 b49wJHKyy/fmroraQSXjFdzW9NG/E28vZLPmRcmPSEScJlyoQeSvZIHBSyA+aiYSblXS32qpv
 3XBkbZOcqmVSqOFxsKvmmnNhos8TKNZieNa6ed+cQ5pfP1jPX41+QCVXnxMJkmsdw9gfJF26X
 MN7AXyJl0fvs115YQxaOAyNHosFGaVELrmdTcugK5Y7GYUf5BYHYW7ZNXw3m8mKHwdbP0fIIU
 5vgUQg/5RrwvMN1BrW2rdS2iRIez2/N67PnHbIbX2QNX6t69YBXkHY+Pf8rHCeg6qypT07mNq
 43VdPOMJUdI8CvbkdNuTUXhqgn9Rkvpt0z+JnwP4TM7L2RaxT4FGT4UmrB2pHLFfpSLeqmpF3
 rCI/Rf1026GrFGjwfvxlLbBd9Z3V/BJaxdpiWrciVb//5H2oENxlaynlKAaGwOyTc8zTlnOIE
 N5ItfH35xbtxRVAFoqD6iPc7CbKUf3JcnctYIRAhXNnlY9IO9c1Jd0+JjY4ExxBi5r3gmOgvH
 krNAgoNWXztpKoXgIU5nXurA+V6eXwcGYCrtg64Sjy5M3k8t4fAW1V3LuqWNp0fTqawXngJ+t
 lIyx1RxKJh+ZEnj2WFrvLJ+wTpKGTd4KSmx3vnsZ3/Q33xBMY2QETIWS20Nx6X4argKqigpIS
 4EwQAkjZWPNE521BZArj502m5emYC5A1x0E61Z3lH6T3bW/3fVQr9sjESqoUqSLZZFd24S30R
 guZ9YMrlpvJjgpNI+ggSprgmm+7mdkwE6Wf3zTxF8PK5v4eFtWdXUQye3OpdwX2TJe14GkFic
 XZUUOA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-286723764-1668434570=:177
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 14 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [...] before this we've been assuming that GIT_TEST_CMP is a not-ours
> binary. I.e. "diff", "cmp" etc. If it is a "that's ours" this change
> should be changing e.g. '! test_cmp' to 'test_cmp !', as the former
> would now hide segfaults.

The implied assumption of `test_cmp` is that the command is reliable, i.e.
we are not expecting to test the code that runs the comparison itself.

Originally, Junio shared your concern that `diff --no-index` might not be
reliable enough, but that was "a lifetime ago". In
https://lore.kernel.org/git/xmqqbkrpo9or.fsf@gitster.g/ he hinted that the
`diff --no-index` code has matured enough to be considered reliable. That
is far from the endorsement I would wish to have received (it would have
been nice to see "I consider `git diff --no-index` to be reliable enough
to serve as `mingw_test_cmp`", for example), but I believe it is the
clearest statement I will get in that regard.

> Additionally: We don't *need* this for an initial implementation, but
> having e.g. one of the Ubuntu CI targets run with "git diff --no-index"
> would be a nice cherry on top,

Why would this be a nice cherry on top?

=46rom my perspective, it would co-opt unrelated test cases into the task =
of
validating `diff --no-index`' correctness.

Such a loss of focus in test cases makes it harder to diagnose, debug and
fix breakages. And it would mean that a single bug could make gazillions
of test cases fail. That would be bad practice, of course.

>  * If we're trusting "git diff --no-index" to run the tests, we could
>    also get rid of "GIT_TEST_CMP_USE_COPIED_CONTEXT", whose only reason
>    for existing is to support a system "diff" that doesn't understand
>    "-u" (squashable diff below)

Be my guest to contribute this once the current patch has made it to
`next`. But please only then, we have enough friction on the Git mailing
list and do not need to go out of our way to add more.

Thanks,
Johannes

>
> 1. https://lore.kernel.org/git/220907.86v8pzl6jz.gmgdl@evledraar.gmail.c=
om/
> 2. https://lore.kernel.org/git/220907.86r10nl63s.gmgdl@evledraar.gmail.c=
om/
>
> diff --git a/Makefile b/Makefile
> index 4927379184c..dea6069b5fe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1950,10 +1950,6 @@ ifdef OVERRIDE_STRDUP
>  	COMPAT_OBJS +=3D compat/strdup.o
>  endif
>
> -ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
> -	export GIT_TEST_CMP_USE_COPIED_CONTEXT
> -endif
> -
>  ifndef NO_MSGFMT_EXTENDED_OPTIONS
>  	MSGFMT +=3D --check
>  endif
> @@ -3008,9 +3004,6 @@ endif
>  ifdef GIT_TEST_CMP
>  	@echo GIT_TEST_CMP=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP))=
)'\' >>$@+
>  endif
> -ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
> -	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@+
> -endif
>  ifdef GIT_TEST_UTF8_LOCALE
>  	@echo GIT_TEST_UTF8_LOCALE=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TE=
ST_UTF8_LOCALE)))'\' >>$@+
>  endif
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 4fab1c1984c..cd6e9f797b6 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1503,12 +1503,7 @@ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CO=
NFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
>
>  if test -z "$GIT_TEST_CMP"
>  then
> -	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
> -	then
> -		GIT_TEST_CMP=3D"$DIFF -c"
> -	else
> -		GIT_TEST_CMP=3D"$DIFF -u"
> -	fi
> +	GIT_TEST_CMP=3D"$DIFF -u"
>  fi
>
>  GITPERLLIB=3D"$GIT_BUILD_DIR"/perl/build/lib
>

--8323328-286723764-1668434570=:177--
