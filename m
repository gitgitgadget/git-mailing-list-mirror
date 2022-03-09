Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B83AC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiCINTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiCINSy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C797178688
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so1455942wmq.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5ohsgUvXlHYOPZEEGG9KEDVSVvA5NkI0oWq+RxUdGI=;
        b=e0BNeWbtEcS2NiGmQ3suhC4VgbVfpvZcOYELJWDkHxU/EmuWAzDV658Rd7ZKOvEkwg
         vykB4Y/V0AzzBX9OLVf6zMT6fpkb9/6dMeLuAS2zDkKfeTAR5/fq8rUQ6I7K1IP9LlRf
         oRyjb1jcHKaUcHYlF03fi/4Nr6irfljN5hM2J76JNr9uBZjXpYW1M6abjvok+FOIhxWy
         uPj93n4om9+k5t4qKqrfXTc3TI62uT6MO9k1H/h8hdHJFAcLQs5Rhp2q++EEhY04TyBB
         Ncj0aa4jPmhOBfTmtkLN2NeOb50OSxhMo+j9ysET9asJXsw4Q97j7CtsSdiX9OyCRh1v
         KWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5ohsgUvXlHYOPZEEGG9KEDVSVvA5NkI0oWq+RxUdGI=;
        b=lKEwQB4he751elwNi0Nsi6Q5Jjh4VLHX9WRe7JxODYv+HbwGx2cunpBdn2SrSZaty2
         FxZtMYcMaHSZu3+unXZdBP7hWCgrHALWVzngJujQ99nD96oamij/IBHsPXs5+M1UCLUT
         wTkp0rMWzoBd5DfXq5699wivz8TOzKL+TldHLT1YcCG7FFyoY3rN2gO9CoIEPhAZTVlq
         r0T52AhzYW92w/prm0vTnhwZ73HsTlnEQoAWiXddQ3up/6iiReE90U9DzTaydNTxZuOa
         g88J4JCX9n7btyYKBLgiPPKX1cbiOf2NFBeTgd84bKsZlVJhj+yjNUzXTCMKEevGfR5o
         ZSBg==
X-Gm-Message-State: AOAM533ydzRsefGxdidF8TChw4PCmJA624d4o9TWSYVW8OWIUIBVgo+f
        Yx3iVADOxnZjYA4lz+qMAgHKd9AridB//A==
X-Google-Smtp-Source: ABdhPJx+p4f6prqJOlDc97z1wP3AUxjFUgiTSukhzQ7tEz3HCGaiOzChAFd3/DTZ4usMybKqoePATQ==
X-Received: by 2002:a05:600c:1d1b:b0:389:d0a5:c7c4 with SMTP id l27-20020a05600c1d1b00b00389d0a5c7c4mr2573591wms.88.1646831872677;
        Wed, 09 Mar 2022 05:17:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/24] revisions API users: use release_revisions() in builtin/log.c
Date:   Wed,  9 Mar 2022 14:16:40 +0100
Message-Id: <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for having the "log" family of functions make wider use
of release_revisions() let's have them call it just before
exiting. This changes the "log", "whatchanged", "show",
"format-patch", etc. commands, all of which live in this file.

The release_revisions() API still only frees the "pending" member, but
will learn to more members of "struct rev_info" in subsequent commits.

In the case of "format-patch" revert the addition of UNLEAK() in
dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16), and
which will cause several tests that previously passed under
"TEST_PASSES_SANITIZE_LEAK=true" to start failing.

In subsequent commits we'll now be able to use those tests to check
whether that part of the API is really leaking memory, and will fix
all of those memory leaks. Removing the UNLEAK() allows us to make
incremental progress in that direction. See [1] for further details
about this approach.

1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c          | 20 ++++++++++++--------
 t/t4126-apply-empty.sh |  2 --
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 00846c2c8ac..3c1edc27605 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -294,6 +294,12 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	cmd_log_init_finish(argc, argv, prefix, rev, opt);
 }
 
+static int cmd_log_deinit(int ret, struct rev_info *rev)
+{
+	release_revisions(rev);
+	return ret;
+}
+
 /*
  * This gives a rough estimate for how many commits we
  * will print out in the list.
@@ -557,7 +563,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 static void show_tagger(const char *buf, struct rev_info *rev)
@@ -676,7 +682,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	if (!rev.no_walk)
-		return cmd_log_walk(&rev);
+		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
 	count = rev.pending.nr;
 	objects = rev.pending.objects;
@@ -731,8 +737,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
-	free(objects);
-	return ret;
+	return cmd_log_deinit(ret, &rev);
 }
 
 /*
@@ -760,7 +765,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 static void log_setup_revisions_tweak(struct rev_info *rev,
@@ -791,7 +796,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	opt.revarg_opt = REVARG_COMMITTISH;
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_walk(&rev);
+	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 }
 
 /* format-patch */
@@ -2290,8 +2295,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		string_list_clear(rev.ref_message_ids, 0);
 		free(rev.ref_message_ids);
 	}
-	UNLEAK(rev);
-	return 0;
+	return cmd_log_deinit(0, &rev);
 }
 
 static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 33860d38290..66a7ba8ab8f 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,8 +2,6 @@
 
 test_description='apply empty'
 
-
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.35.1.1295.g6b025d3e231

