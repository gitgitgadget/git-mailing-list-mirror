Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014FC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjDFI3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjDFI3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:29:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE39130
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:29:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so147451651edc.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680769761;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+WiShJKyGVu79DFX6WrgEzl11YPyRnP5oIWCpbfHHPQ=;
        b=dS+b+WoaX26mCQiwHpK7dQenX0/Zh/m0qlvP0b9zX6PZSPm4W3ssUhKmryj0brOp6P
         iwwFp8vwA2OZOEOH4AGR5m434T7QCsBAbcDryuUMDRpJkPtorVvp19mRmlD1/ZF8/ORR
         XgB7bGQ31YJAu90uueAs0UGi8Bijm6nWsZN69S5HjOnwr46qcPAMOmCPZ9csdV9uDBE6
         Quf3eJeLArslSvLK+nfU2PwuTQ0wH9jLUA/LO9Hq3h7MJARHuTrjNOh1VGv6ASgvUYBj
         xXZv/MYBTe+670LY/d673Fbs3xU7EQdn825fOJGAWSLHVqjwqJ6G//1WpwgKo40FLVsi
         POug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769761;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WiShJKyGVu79DFX6WrgEzl11YPyRnP5oIWCpbfHHPQ=;
        b=H+fiMk1LeP8fKAarV9ZKUCnVfgwHTiXWjupoV9cnfIoQWrcmXBfzOm0MU1p9CLYxuH
         FRA45Z0P/PW1t6rvLUUBK+GoPbkjUC/+v+lnzqnVVZuTLf0PWVCs30yJavhzxRzuZx1B
         MuNthxXChI9/p6v6723pfgXIBPYx90/1E8o0uinJ3Ooz9QyTRw4ZrsXATAu+JdTC8awW
         cmh80GKd9clcWEWxSM6V7btJras6HqipotYzyjoHwI3jJ9wP2TTwKPwCCK4AOtoyY0i3
         Tu8mso8MD/1y1rc0X3njBs4f6TYRFTThN15D5qRsOvU47eC81GcubdC0Pvzl+RqSL7S+
         lTHA==
X-Gm-Message-State: AAQBX9fWpEzaY/lWb01OKQeR9mrZZHpZ7N941Q6oehGpJ7uJIdG1nC8q
        kcOQnh8910GxubMM7e8lrI4=
X-Google-Smtp-Source: AKy350Z8xLcE3Z8Qln0kkOQ0Ql0zhho4ZL1XVpvVboH8608pqM8PrOY1Q9xFYpoY+oTqzxONfRp5Iw==
X-Received: by 2002:a17:906:6c86:b0:932:e141:29c7 with SMTP id s6-20020a1709066c8600b00932e14129c7mr5200296ejr.19.1680769760558;
        Thu, 06 Apr 2023 01:29:20 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kf25-20020a17090776d900b0093b8c0952e4sm480037ejc.219.2023.04.06.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:29:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pkKzf-005Obg-20;
        Thu, 06 Apr 2023 10:29:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Date:   Thu, 06 Apr 2023 10:03:53 +0200
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com> <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net> <ZC2wppC62E7wOcqM@xps>
 <20230405181505.GA517608@coredump.intra.peff.net>
 <CAMP44s2_b0=Bm-NmDQ7ZVBen27ZtK9DpaF0gs965k1wXzzhARQ@mail.gmail.com>
 <20230406033507.GA2092122@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230406033507.GA2092122@coredump.intra.peff.net>
Message-ID: <230406.86y1n5tnvk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 05 2023, Jeff King wrote:

> On Wed, Apr 05, 2023 at 09:18:20PM -0500, Felipe Contreras wrote:
>
>> On Wed, Apr 5, 2023 at 2:09=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>> > On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote:
>>=20
>> > IMHO we should aim for fixing those inconsistencies, and then letting
>> > people set PERL_PATH as appropriate (even to something that will find =
it
>> > via $PATH if they want to).
>>=20
>> We can aim to fix all those inconsistencies *eventually* while in the
>> meantime make them runnable for most people *today*.
>>=20
>> It's not a dichotomy.
>
> It is if the proposed patches change the behavior in such a way as to
> make things less consistent.
>
> There are three plausible perls to run (whether intentionally or
> accidentally):
>
>   1. the one in PERL_PATH
>
>   2. /usr/bin/perl
>
>   3. the first one in $PATH
>
> What the code tries to do now is to consistently use (1). If there are
> cases that accidentally use (2), which is what I took Patrick's patch to
> mean, then that is a problem for people who set PERL_PATH to something
> else, but not for people who leave it as /usr/bin/perl. If we "fix"
> those cases by switching them to (3), then now things are less
> consistent for such people than when we started.
>
> But I am not clear on what those cases are (if any), and we have not
> seen Patrick's follow-up proposed patch.
>
> I did find one case that is accidentally doing (3), and posted a patch
> elsewhere in the thread to convert it to (1). If you prefer behavior
> (3), you might consider that a regression, but it seems meaningless
> given the 99% of other cases that are using (1). If you want (3) to be
> the behavior everywhere, then we'd need to completely change our stance
> on how we invoke perl, or we need to teach PERL_PATH to handle this case
> so that people building Git can choose their own preference (sadly I
> don't think "make PERL_PATH=3D'/usr/bin/env perl'" quite works because we
> have to shell-quote it in some contexts before evaluating).

I just want to chime in to say that I've read this whole
thread-at-large, and I think what you're pointing out here is correct,
and that we should keep hardcoding "#!/usr/bin/perl", and then just have
"PERL_PATH" set.

I.e. most of Patrick's original patch is unnecessary, as we either use
"$PERL_PATH" in the Makefile already, or munge the shebang when we
install.

Then the only change we should need is the one you suggested in
<20230406032647.GA2092142@coredump.intra.peff.net> in the side-thread.

Using "env" liket his is also incorrect. I might have a "perl" in my
"$PATH" which I expect to use for e.g. by .bashrc, but I don't want that
perl to take priority over "$PERL_PATH" for git when I run some test
script.

I also wonder if something like this (untested) wouldn't be useful to
provide an earlier warning of this, instead of failing when we fail to
invoke the relevant scripts.

	diff --git a/Makefile b/Makefile
	index 60ab1a8b4f4..9abc2e52cfa 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -910,6 +910,15 @@ ifndef PYTHON_PATH
	 	PYTHON_PATH =3D /usr/bin/python
	 endif
=09=20
	+define check-path-exists
	+ifeq ($$(wildcard $$($(1))),)
	+$$(error $(1) set to '$(2)', which does not exist)
	+endif
	+endef
	+
	+$(eval $(call check-path-exists,SHELL_PATH,$(SHELL_PATH)))
	+$(eval $(call check-path-exists,PERL_PATH,$(PERL_PATH)))
	+
	 export PERL_PATH
	 export PYTHON_PATH

That should not break anything in principle, as we already rely on these
to build git itself, but note that that's not the case with
"PYTHON_PATH".

In the case of "PERL_PATH" I think that's limited to building the docs,
so if we did something like this perhaps it should be in shared.mak, and
that check should be in Documentation/Makefile.

But perhaps it's all reduntant to just running into an error when we try
to generate-cmdlist.sh or whatever...
