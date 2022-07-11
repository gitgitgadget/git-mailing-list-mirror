Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDBBC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGKLnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiGKLmw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A03E82
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r14so6633376wrg.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCDCdC4D6RE10Ee/IG9XYG/ByOeBHb23CwofGa/bfKY=;
        b=QByXCj/e6p3f4ui3VVtpE+2bByx7qKpzl5hpwFY2wS0YB/KkfIDN6YMxVpgAdYVRzE
         JOtNukBa8bhe1JPU2wGlhQlFJ9XFuRAeqsrdVi1g3I3Q3VlZpDwioBF3dHtUF9kL6Ubm
         ZyFOWCN5MEQNdDKzBrl/yjDhJN+LQjH46cs4tthle1PsOz0fSFm4X/BXi0wVfsrgO7nO
         Ko8VU62K0X291CIoxmdXQ3BL/68jgYAWQJtk/zdjYF8h+Oj/9ueZSuby6gZLGPy03Yaw
         7sB6RrT/g+96rR7uvAttdGpCmPNYlLmIkvmgkryIMpqPnR42u2a4qWkvssZFxAANu2mK
         Djpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCDCdC4D6RE10Ee/IG9XYG/ByOeBHb23CwofGa/bfKY=;
        b=RotMxoR3Pdppw0LARM7JYpeyA77AS8e7cv+EfbkJsupdFgGHiESx/Uxi75Vjo8hE8u
         rsp6U64Yy5GmlRKHga/wuMu4i9gZg/EU0lgi+6gpKGGmD7/C1p5mo/8LzEBk81YWuFZ/
         scmVch3sGkJ4MVQ+whXUINJP33jFp1F0UqcAWfSsT7HJnpPqP2eFK/+b4amn2s/o6HX0
         i/b2Afvat8L4j/TVTQdf8WBMyXxgKyi/D7Uy7MwoXCVcl7+/BDyUv3OsoOAgaoRHqnkc
         QRJRlewJyBp3OtDXcOna7temzhf6C/X74OmW9sSJuG1FYRLMYOey1fGLRN35Hy2IU5M3
         Uvng==
X-Gm-Message-State: AJIora/AMiEyDSvFH4djyfOGCFVeFaJ0JrwhgSko4o+aoEaTSDq083IR
        8IEvROTxh8b716UB47R3Uyk8lmvheSE=
X-Google-Smtp-Source: AGRyM1sJ8NlFp+PdGAkfh/dN/H0HifpdlmKzGHxZc/5B3+ypSgceHfmAVhz0wImXzmYzKHOkCd+xkQ==
X-Received: by 2002:a5d:5703:0:b0:21d:6c55:4986 with SMTP id a3-20020a5d5703000000b0021d6c554986mr16822828wrv.455.1657539457237;
        Mon, 11 Jul 2022 04:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm5562463wrr.39.2022.07.11.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:37:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/4] make headway towards a clean "clang-format"
Date:   Mon, 11 Jul 2022 13:37:24 +0200
Message-Id: <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10 2022, brian m. carlson wrote:

> Having a code formatting tool means that the work for a contributor to
> format the file properly consists of about two keystrokes.  This
> substantially reduces the amount of time that contributors must spend
> thinking about code formatting and simplifies it to an automatic process
> that, if we choose, can even be verified in CI.

I'm generally in favor of this, or more specifically I'm generally in
favor of whatever we can do to make
Documentation/{SubmittingPatches,CodingGuidelines}, t/README,
po/README.md and whatever other "checklist" document we have more
automated.

So we could generally waste less time in asking contributors to read and
internalize these documents, or in fixing submission mistakes, and more
time on worthwhile work.

Whether using an automatic formatter would land us on the right side of
that trade-off is something I'm not sure about, but if it would: Great!

But!

> I should note that we already have a .clang-format file, so we can
> already use clang-format.  However, we cannot blindly apply it because
> it produces output that is not always conformant with our style.  My
> proposal here is to define our style in terms of the formatter to avoid
> this problem.

I think this is very premature at this point.

I experimented a while ago (low number of months) with clang-format for
the first time, and found that the delta between what it proposed as
changes and what it *should* propose was needlessly high.

This RFC is a cleaned-up & updated version of those WIP experiments I
made. I think this series is "ready" in that it's a sensible
improvement, and having a "make style-all" family of rules is very
useful to check how .clang-format behaves.

But I think we're far short of declaring that we should simply refer
to clang-format against our shipped .clang-format configuration as our
canonical style.

At the end of this series we're at a 60% shorter suggested diff from
clang-format, but that still leaves ~13k lines of diff on top of
"master".

And, as 0[2-4]/04 note adjusting those rules isn't always clear, and
there's the major question of what to do about "ColumnLimit", and
things like "BitFieldColonSpacing" which require a much newer version
of clang than we're probably comfortable with requiring.

Someone more interested than me in this (i.e. you:) should really be
building on top of this, i.e. running:

	make style-all-diff-apply

And seeing what general categories these differences fall into, and
whether clang-format has any more options that we've set in the wrong
way, or which we're missing.

There's clearly a lot of changes in the resulting diff that we should
have per our style guide, e.g. there's a lot of "}\nelse {" (bad!)
v.s. "} else {" (good!) and the like.

Before we get to a "clean diff" we could at some point "invert" our
style guide. I.e. instead of saying "code should be like XYZ", we
could say:

	run clang-format, but it might report some differences, as
	long as it's one of the below known-cases that's OK.

I.e. we could one-off search-replace all the "}\nelse {" etc. cases to
the "} else {" form, and then we wouldn't have to waste words on that
in Documentation/CodingGuidelines.

But I *really* don't think we can declare that clang-format is some
source of truth before doing much or all of that work. If you think
nits are annoying now consider e.g. this change to advice.c:
	
	diff --git a/advice.c b/advice.c
	index 6fda9edbc24..e0e453d68d1 100644
	--- a/advice.c
	+++ b/advice.c
	@@ -35,6 +35,7 @@ static struct {
	 	const char *key;
	 	int enabled;
	 } advice_setting[] = {
	+	[ADVICE_FOO]					= { "foo", 1 },f
	 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
	 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
	 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },

I'll spare you the full diff, but if you do that and run "make style"
it'll spew out a ~100 line diff at you, as it re-indents and
re-formats that entire block.

That *is* a rather extreme example, most of its suggestions are 1-5
line diffs.

But if there's one hill I'm willing to die on it's that we should
never introduce any sort of "landmine checks" in this codebase.

Those are checks where we don't e.g. assert that the style of git.c is
OK, but rather just run a "diff" on your specific change.

Then if it happens to change any code that was *already in violation*
will make it your problem to fix that. I.e. the landmine was already
there, but you just happened to walk over that path, and *boom*.

But I'm not an unreasonable zealot about that:) E.g. as running the
"make style-all-diff-apply" target here shows you around 40% of our
*.[ch] files don't have any suggested changes.

That's around 30% with just 1/4, i.e. a 10% "gain" is made with the
2-4/4 rule changes here.

So, in combination with updating .clang-format we could start making
headway earlier by e.g. whitelisting files (or globs, or directories)
that are already "style clean".

It would be a bit annoying if we needed to move code from a "dirty" to
a "clean" file, but we mostly don't do that, so I'd think that would
be OK.

But I think like other "partial asserts" (such as the "linux-leaks" CI
job) such an approach really would need to proceed in parallel with
fixing the remaining cases, even though that might take a while.

I.e. we'd want to have some assurances that we'd either be willing to
live with a fully clang-format'd codebase, or at least that the
special-casing of the style rules wasn't too widespread. We have a bit
of "/* clang format (off|on) */" already, and e.g. for the likes of
advice.c that would be OK, but having it be a common pattern would be
annoying.

Ævar Arnfjörð Bjarmason (4):
  Makefile: add a style-all targets for .clang-format testing
  .clang-format: Add a BitFieldColonSpacing=None rule
  .clang-format: do not enforce a ColumnLimit
  .clang-format: don't indent "goto" labels

 .clang-format | 17 +++++++++----
 Makefile      | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 5 deletions(-)

-- 
2.37.0.913.g189dca38629

