Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F0C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbiCKJqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347661AbiCKJqc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:46:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF91BE4D4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:45:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t11so12037955wrm.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHkoWKW2Ghs5kmTNgfYSHda1Ncul6Xzq1jA2fmPsmnE=;
        b=RJWw/BTn4e7ZTugBpJNhAktDNFSt/PVUSnwfZu90HdZTv+wy4uE999piS/coBS5n+Y
         pjpt0fAO7HSFT0MoECZMn7iJkj2TPhVBozdajlGIXauo2xvHHZjsVbVWtXctWI8MqzOO
         qhBpOw0FkZyJHitcKTbphg8XKw+pXdVZHMATINFCJWy0AMqs6AQcekrXfxTP2qEbLRai
         9IaWFCKOWA27nWT0GmgFN8lrrNOQyfiZGV9bYO/p/6krcHInoBN+jXtTiQIZPbuJgA5u
         dPDlSCcZMshm97XnA361Hfitv2eYU0NQQRMYvP/j5l90ff3X3lREv/jawu0SbUW2J3Zn
         1gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHkoWKW2Ghs5kmTNgfYSHda1Ncul6Xzq1jA2fmPsmnE=;
        b=fMev2dU1J2E5+0AK4GSPtXR8uSQ+fuIjzqDfVuXD93uHfDKU2hubvKD6S5zgZjJAC4
         bS7jR4oNXWrgGXLCqEdFs/V2hQxetImr1PpGa3trB4vfjxG0RKwSVAEwXJM9HO/YdJAx
         upOrvqrL9GMGekfjVg2yNQN2FyD56kQjbAYOlZhdachEpJAs3KpYcQPoN3ntSHnBD8aZ
         uRe82vIivNve+6WV7lFrACDLlaKBN86PpBFu+C6LgTLiaq0vdmvt/9DEI4Ol8T9ooYDs
         c3qk1zzE2REW33sORKA+Vlftyb6hU8scvyh42HHPKBv74pMr5DgUg/4+iU8ghugzohLK
         nVFQ==
X-Gm-Message-State: AOAM531xctfFL288ithPFs90yeilkYMfy65m5Od6abXtqLJoL5P1Bobj
        rs969AJ8KGPhbn93EA0BsYBokIRD/0JcVA==
X-Google-Smtp-Source: ABdhPJxtH+17YDMdxNkD2p4DG+cv6HSq3BKimK2btabMoyfcUx4LWSo1BNg6SR81xJEEpmMuyK7j8w==
X-Received: by 2002:a05:6000:228:b0:1f0:63aa:785 with SMTP id l8-20020a056000022800b001f063aa0785mr6467304wrz.332.1646991925963;
        Fri, 11 Mar 2022 01:45:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm12766241wmp.13.2022.03.11.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:45:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] parse-options: add per-option flag to stop abbreviation
Date:   Fri, 11 Mar 2022 10:45:14 +0100
Message-Id: <patch-1.1-d2ae423d1ad-20220311T094315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1334.gf8cd03b07c8
In-Reply-To: <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
References: <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For cases like "format-patch --output-directory=dir" we disallow
abbreviations entirely, because we'd like setup_revisions() to do a
subsequent option parsing pass, and it accepts "--output=file".

That's one reason for why the parse_options() in diff.c added in
4a288478394 (diff.c: prepare to use parse_options() for parsing,
2019-01-27) passes PARSE_OPT_KEEP_UNKNOWN. I.e. we need the
"--output=file" to be retained in the arguments for passing it down to
setup_revisions().

It's not stated explicitly but I think "--output"
v.s. "--output-directory" is the specific case the author had in mind
when adding the PARSE_OPT_KEEP_UNKNOWN case in the pre-image. That was
added in an earlier commit in the same series,
baa4adc66ae (parse-options: disable option abbreviation with
PARSE_OPT_KEEP_UNKNOWN, 2019-01-27).

As that commit shows we had to disallow "git difftool --symlink" as an
abbreviation for "git difftool --symlinks" as a side-effect, even
though that abbreviation wouldn't have conflicted.

So let's tweak this rule to be more narrowly scoped, now we'll allow
abbreviated options regardless of PARSE_OPT_KEEP_UNKNOWN being set for
parse_options(), but we'll provide individual options an opt-out. By
using that opt-out for "--output-directory" we can have that case work
without overzealously disallowing others.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

> On Thu, Mar 10 2022, Linus Torvalds wrote:
>
>> On Thu, Mar 10, 2022 at 2:13 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>[...]
>>> Here's the stupid patch that "works" but doesn't allow the shortened
>>> version. Maybe somebody can point out what silly thing I did wrong.
>>
>> I just created a short alias to do this. Maybe there's some smarter
>> option, but this seems to work.
>
> ..you needed to do that is because we pass PARSE_OPT_KEEP_UNKNOWN
> parse_options() there, which turns off our abbreviation discovery logic,
> i.e. where we'll take a --foo, --foob, --fooba if we have a --foobar
> option defined.
>
> Looking at it there appears to be no good reason for why it's so
> overzelous. If I remove the relevant PARSE_OPT_KEEP_UNKNOWN logic in
> parse-options.c our entire test suite passes, except for one obscure
> part where "git format-patch --output=x" needs to not abbreviate to "git
> format-patch --output-directory=x".
>
> Which, for reasons is something where we do option parsing in two
> passes, i.e. we hand the "output" option off to the revision walker.
>
> We really should just teach those callsites to "grab" the revisions.c
> options and do the parse in one pass, but in the meantime this is a less
> invasive way to have that case work, which makes your code work without
> the OPT_ALIAS() hunk

It even passes CI! I think this change makes sense, with/without the
RFC topic.

 builtin/log.c       | 3 ++-
 parse-options.c     | 2 +-
 parse-options.h     | 1 +
 t/t7800-difftool.sh | 5 +++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..adacc65bc7e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1811,7 +1811,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
 			    N_("dir"), N_("store resulting files in <dir>"),
-			    PARSE_OPT_NONEG, output_directory_callback),
+			    PARSE_OPT_NONEG | PARSE_OPT_NO_ABBREV,
+			    output_directory_callback),
 		OPT_CALLBACK_F('k', "keep-subject", &rev, NULL,
 			    N_("don't strip/add [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback),
diff --git a/parse-options.c b/parse-options.c
index 6e57744fd22..9d0c4694482 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -332,7 +332,7 @@ static enum parse_opt_result parse_long_opt(
 			rest = NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
+			if (!(options->flags & PARSE_OPT_NO_ABBREV) &&
 			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option &&
diff --git a/parse-options.h b/parse-options.h
index 685fccac137..f6372f60edb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -48,6 +48,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
+	PARSE_OPT_NO_ABBREV = 1 << 12,
 };
 
 enum parse_opt_result {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 096456292c0..ae47426f66e 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -582,6 +582,11 @@ test_expect_success SYMLINKS 'difftool --dir-diff --symlinks without unstaged ch
 	EOF
 	git difftool --dir-diff --symlinks \
 		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
+	test_cmp expect actual &&
+
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	git difftool --dir-diff --symlink \
+		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
 	test_cmp expect actual
 '
 
-- 
2.35.1.1334.gf8cd03b07c8

