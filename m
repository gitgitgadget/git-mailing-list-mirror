Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5C91F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfILWMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44186 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfILWMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so14164725pgl.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6u6hgzSr9QcDt14T7nQli2ZUxDVW8VRZ9kXmbPIMzY=;
        b=HEg01PW4wOIKUfsTj3B26HuF+nP7Aga5AaAV3+d1y8e2a1zQS8vEzkBr34yoE7gGPO
         Ap7nza3fR+SIp30mrDRbty2Y6TdXO/XDYLq+rLDVxwejHjgnWxDjF7D7mQ/FwtOTTVlc
         /9wsgrw3YRPlCCboIjl5u//+MU4aQdisMKYOF8Q8c55bieE+L/k02xklsfMtk1j1IKSF
         SOIt0z442DKb2CRF3nQoxUYctK2eeHNc9PImfnWJR+E96nuaxFhjzhtolclSPRuIPgZ2
         aTICzM5wp2ZykIsCb/PDA7e47dPQCmHJRKXVl4fBqSOR4fol9sqh8mVXV90nMeJ6Q3ki
         EXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6u6hgzSr9QcDt14T7nQli2ZUxDVW8VRZ9kXmbPIMzY=;
        b=aZZllulqysHk+Q3/juAbysiShyoObIAYxViuAw3d7rlghbbajM8c3aqOHAx3wrtnJv
         aQijM0u9DaiVLQRhi0Qo7xhouWq7GUlrS49RfvoM7jOFv0y8vb6Jjhm3XBOHj7VnO1C6
         RibZb9Z+dAanJ26jramen6kCWE8HbDvUt3j1q8bQck8I73rcbwrjHTLBc6hhIUi1P8e9
         jXDNAKChUe1l4KSI1GiKknXTpQnbJ79NLQ7Ogy1oKWeWq1cnzM/L4VHJwG/VL5o62F72
         s7IEgefAXgXogZYiTCzjpnV0vJ6naWeAL8UAYOo0JDHFVCsqCWsHeu/tVhIXI0KB8fW/
         qs9Q==
X-Gm-Message-State: APjAAAXsimaxxyvi7KRr5fX4AyEf81PU4O5dxlHU/GOWq8ygCcwnZX9E
        k2tUTFKbOAWXR6g3/XSSpibih6t5cEk=
X-Google-Smtp-Source: APXvYqwxM2zgmBdKlvm6/I6n6aj0qZWM+r0+doE4kkXqL50QJ3Do0zUX/13F3mS27eocZi86ue8Haw==
X-Received: by 2002:a17:90a:6342:: with SMTP id v2mr1126407pjs.8.1568326372478;
        Thu, 12 Sep 2019 15:12:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 06/12] dir: if our pathspec might match files under a dir, recurse into it
Date:   Thu, 12 Sep 2019 15:12:34 -0700
Message-Id: <20190912221240.18057-7-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For git clean, if a directory is entirely untracked and the user did not
specify -d (corresponding to DIR_SHOW_IGNORED_TOO), then we usually do
not want to remove that directory and thus do not recurse into it.
However, if the user manually specified specific (or even globbed) paths
somewhere under that directory to remove, then we need to recurse into
the directory to make sure we remove the relevant paths under that
directory as the user requested.

Note that this does not mean that the recursed-into directory will be
added to dir->entries for later removal; as of a few commits earlier in
this series, there is another more strict match check that is run after
returning from a recursed-into directory before deciding to add it to the
list of entries.  Therefore, this will only result in files underneath
the given directory which match one of the pathspecs being added to the
entries list.

Two notes of potential interest to future readers:

  * If we wanted to only recurse into a directory when it is specifically
    matched rather than matched-via-glob (e.g. '*.c'), then we could do
    so via making the final non-zero return in match_pathspec_item be
    MATCHED_RECURSIVELY instead of MATCHED_RECURSIVELY_LEADING_PATHSPEC.
    (Note that the relative order of MATCHED_RECURSIVELY_LEADING_PATHSPEC
    and MATCHED_RECURSIVELY are important for such a change.)  I was
    leaving open that possibility while writing an RFC asking for the
    behavior we want, but even though we don't want it, that knowledge
    might help you understand the code flow better.

  * There is a growing amount of logic in read_directory_recursive() for
    deciding whether to recurse into a subdirectory.  However, there is a
    comment immediately preceding this logic that says to recurse if
    instructed by treat_path().   It may be better for the logic in
    read_directory_recursive() to ultimately be moved to treat_path() (or
    another function it calls, such as treat_directory()), but I have
    left that for someone else to tackle in the future.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 10 ++++++----
 dir.h            |  5 +++--
 t/t7300-clean.sh |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index b4d656192e..47c0a99cb5 100644
--- a/dir.c
+++ b/dir.c
@@ -360,7 +360,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		if ((namelen < matchlen) &&
 		    (match[namelen-offset] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
-			return MATCHED_RECURSIVELY;
+			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
 		/* name" doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
@@ -377,7 +377,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		 * The submodules themselves will be able to perform more
 		 * accurate matching to determine if the pathspec matches.
 		 */
-		return MATCHED_RECURSIVELY;
+		return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 	}
 
 	return 0;
@@ -1939,8 +1939,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR))) {
+			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
+			  do_match_pathspec(istate, pathspec, path.buf, path.len,
+					    baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
diff --git a/dir.h b/dir.h
index 680079bbe3..46c238ab49 100644
--- a/dir.h
+++ b/dir.h
@@ -211,8 +211,9 @@ int count_slashes(const char *s);
  * when populating the seen[] array.
  */
 #define MATCHED_RECURSIVELY 1
-#define MATCHED_FNMATCH 2
-#define MATCHED_EXACTLY 3
+#define MATCHED_RECURSIVELY_LEADING_PATHSPEC 2
+#define MATCHED_FNMATCH 3
+#define MATCHED_EXACTLY 4
 int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 12617158db..d83aeb7dc2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -691,7 +691,7 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
 	test_path_is_file nested-repo-with-ignored-file/file
 '
 
-test_expect_failure 'git clean handles being told what to clean' '
+test_expect_success 'git clean handles being told what to clean' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f */ut &&
@@ -707,7 +707,7 @@ test_expect_success 'git clean handles being told what to clean, with -d' '
 	test_path_is_missing d2/ut
 '
 
-test_expect_failure 'git clean works if a glob is passed without -d' '
+test_expect_success 'git clean works if a glob is passed without -d' '
 	mkdir -p d1 d2 &&
 	touch d1/ut d2/ut &&
 	git clean -f "*ut" &&
-- 
2.23.0.173.gad11b3a635.dirty

