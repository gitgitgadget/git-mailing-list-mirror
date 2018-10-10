Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84161F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJJSDf (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:03:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36060 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:03:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so5171346wmf.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ekm3szRaIlbQD3jj0a0ltRNXuzHAlQw0ZvQqXGCgzA=;
        b=Yz9EcRBdMF983tm292wAC5QYaLdujHsbNl4nhvWbP0pH12R2TFDDXcpZojG0tOHmcN
         UBq0230HYZJsKfhF9m5un/JUimxGd30f0CJ0Xxt4ecMbclGwr6/ECcg3a/tc+W9iljXV
         hY/y4AVxHL72jXuwuRLCtisOO0Xm9/KK1CqpRe/1pX9YKXoBaDdwqirBPChUnA9iyb5M
         lHaq9YbOTb7CxiSX8AxO4ul+mStwV132bEVIkr1jboErhP9+5m/sXVjJ6eRuEdfiS4O+
         xXh7lIVTAIxmrxICnC3p37Sz3qzU44tGP751EPJhZJJBdqldRrD+Xjmxg//ClpiNtTVh
         5r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ekm3szRaIlbQD3jj0a0ltRNXuzHAlQw0ZvQqXGCgzA=;
        b=E/GDPRylnnKnAzFcp2q9CbfD2X7uFhGrWnJUt/NU+gxfe3caElHvZEO6/cWUyR2iK/
         UrlFd8oUp2EpeG/wmae21FulFSh6nULPiIWd7mSBeWny5pZm7+NglwN45GN55cAx1yqp
         Y4T4qGiaQdrCMkcm8hHbgh7TGenMVgFi0dP2t2dq4k/BCVAn+nIVbOERmHF41QCOCjlX
         KAIcYVhwI+GRT/CiOIRR4HlV0BFTfgNavwMqbKXqIsHwpOtKH5SQGhg8HlU6vNEdEgXS
         LFR7TCFnion7qa3nHbWIrle8BT91OS5Er6GfVbXwUtajagwqPi/wovYpmseKS7pTzBD0
         xwSA==
X-Gm-Message-State: ABuFfojjM8Ftk9zRMqLqycrzGlLuUvYmweHwbNX3z2ZuaVkhsZb5R2sP
        b+tPGwX3l8/avALO4HQvKKAnB01i2CU=
X-Google-Smtp-Source: ACcGV61nE7pW1g+fJ1CLpHO36jCZCzUL5JI58P8JqrB8aI0XIwQi2eV+Lt5s4mdUUFwOUewB2pgN8Q==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25-v6mr412434wmj.55.1539168119486;
        Wed, 10 Oct 2018 03:41:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 204-v6sm16061644wmh.25.2018.10.10.03.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 03:41:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] push: add an advice on unqualified <dst> push
Date:   Wed, 10 Oct 2018 10:41:45 +0000
Message-Id: <20181010104145.25610-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
In-Reply-To: <20181010104145.25610-1-avarab@gmail.com>
References: <20181010104145.25610-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message added in f8aae12034 ("push: allow
unqualified dest refspecs to DWIM", 2008-04-23), which before this
change looks like this:

    $ git push avar v2.19.0^{commit}:newbranch -n
    error: unable to push to unqualified destination: newbranch
    The destination refspec neither matches an existing ref on the remote nor
    begins with refs/, and we are unable to guess a prefix based on the source ref.
    error: failed to push some refs to 'git@github.com:avar/git.git'

This message needed to be read very carefully to spot how to fix the
error, i.e. to push to refs/heads/newbranch, and it didn't use the
advice system (since initial addition of the error predated it).

Fix both of those, now the message will look like this instead:

    $ ./git-push avar v2.19.0^{commit}:newbranch -n
    error: unable to push to unqualified destination: newbranch
    hint: The destination refspec neither matches an existing
    hint: ref on the remote nor begins with refs/, and we are
    hint: unable to guess a prefix based on the source ref.
    hint:
    hint: The <src> part of the refspec is a commit object.
    hint: Did you mean to create a new branch by pushing to
    hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
    error: failed to push some refs to 'git@github.com:avar/git.git'

When trying to push a tag, tree or a blob we suggest that perhaps the
user meant to push them to refs/tags/ instead.

The if/else duplication for all of OBJ_{COMMIT,TAG,TREE,BLOB} is
unfortunate, but is required to correctly mark the messages for
translation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt |  7 +++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 remote.c                 | 62 +++++++++++++++++++++++++++++++++++-----
 t/t5505-remote.sh        | 25 ++++++++++++++++
 5 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1546833213..fd455e2739 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -320,6 +320,13 @@ advice.*::
 		tries to overwrite a remote ref that points at an
 		object that is not a commit-ish, or make the remote
 		ref point at an object that is not a commit-ish.
+	pushAmbigiousRefName::
+		Shown when linkgit:git-push[1] gives up trying to
+		guess based on the source and destination refs what
+		remote ref namespace the source belongs in, but where
+		we can still suggest that the user push to either
+		refs/heads/* or refs/tags/* based on the type of the
+		source object.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/advice.c b/advice.c
index 3561cd64e9..84e9d0168d 100644
--- a/advice.c
+++ b/advice.c
@@ -9,6 +9,7 @@ int advice_push_non_ff_matching = 1;
 int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
+int advice_push_ambiguous_ref_name = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
@@ -62,6 +63,7 @@ static struct {
 	{ "pushAlreadyExists", &advice_push_already_exists },
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
+	{ "pushAmbigiousRefName", &advice_push_ambiguous_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
diff --git a/advice.h b/advice.h
index ab24df0fd0..d2445cab8b 100644
--- a/advice.h
+++ b/advice.h
@@ -9,6 +9,7 @@ extern int advice_push_non_ff_matching;
 extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
+extern int advice_push_ambiguous_ref_name;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_commit_before_merge;
diff --git a/remote.c b/remote.c
index cc5553acc2..78fa2d9aff 100644
--- a/remote.c
+++ b/remote.c
@@ -13,6 +13,7 @@
 #include "mergesort.h"
 #include "argv-array.h"
 #include "commit-reach.h"
+#include "advice.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -1046,13 +1047,60 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
-		} else
-			error(_("unable to push to unqualified destination: %s\n"
-				"The destination refspec neither matches an "
-				"existing ref on the remote nor\n"
-				"begins with refs/, and we are unable to "
-				"guess a prefix based on the source ref."),
-			      dst_value);
+		} else {
+			struct object_id oid;
+			enum object_type type;
+
+			error("unable to push to unqualified destination: %s", dst_value);
+			if (!advice_push_ambiguous_ref_name)
+				break;
+			if (get_oid(matched_src->name, &oid))
+				BUG("'%s' is not a valid object, "
+				    "match_explicit_lhs() should catch this!",
+				    matched_src->name);
+			type = oid_object_info(the_repository, &oid, NULL);
+			if (type == OBJ_COMMIT) {
+
+				advise(_("The destination refspec neither matches an existing\n"
+					 "ref on the remote nor begins with refs/, and we are\n"
+					 "unable to guess a prefix based on the source ref.\n"
+					 "\n"
+					 "The <src> part of the refspec is a commit object.\n"
+					 "Did you mean to create a new branch by pushing to\n"
+					 "'%s:refs/heads/%s'?"),
+				       matched_src->name, dst_value);
+			} else if (type == OBJ_TAG) {
+				advise(_("The destination refspec neither matches an existing\n"
+					 "ref on the remote nor begins with refs/, and we are\n"
+					 "unable to guess a prefix based on the source ref.\n"
+					 "\n"
+					 "The <src> part of the refspec is a tag object.\n"
+					 "Did you mean to create a new tag by pushing to\n"
+					 "'%s:refs/tags/%s'?"),
+				       matched_src->name, dst_value);
+			} else if (type == OBJ_TREE) {
+				advise(_("The destination refspec neither matches an existing\n"
+					 "ref on the remote nor begins with refs/, and we are\n"
+					 "unable to guess a prefix based on the source ref.\n"
+					 "\n"
+					 "The <src> part of the refspec is a tree object.\n"
+					 "Did you mean to tag a new tree by pushing to\n"
+					 "'%s:refs/tags/%s'?"),
+				       matched_src->name, dst_value);
+			} else if (type == OBJ_BLOB) {
+				advise(_("The destination refspec neither matches an existing\n"
+					 "ref on the remote nor begins with refs/, and we are\n"
+					 "unable to guess a prefix based on the source ref.\n"
+					 "\n"
+					 "The <src> part of the refspec is a blob object.\n"
+					 "Did you mean to tag a new blob by pushing to\n"
+					 "'%s:refs/tags/%s'?"),
+				       matched_src->name, dst_value);
+			} else {
+				BUG("'%s' should be commit/tag/tree/blob, is '%d'",
+				    matched_src->name, type);
+			}
+		}
 		break;
 	default:
 		matched_dst = NULL;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d2a2cdd453..1eabf06aa4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1222,4 +1222,29 @@ test_expect_success 'add remote matching the "insteadOf" URL' '
 	git remote add backup xyz@example.com
 '
 
+test_expect_success 'unqualified refspec DWIM and advice' '
+	test_when_finished "(cd test && git tag -d some-tag)" &&
+	(
+		cd test &&
+		git tag -a -m "Some tag" some-tag master &&
+		for type in commit tag tree blob
+		do
+			if test "$type" = "blob"
+			then
+				oid=$(git rev-parse some-tag:file)
+			else
+				oid=$(git rev-parse some-tag^{$type})
+			fi &&
+			test_must_fail git push origin $oid:dst -n 2>err &&
+			test_i18ngrep "error: unable to push" err &&
+			test_i18ngrep "hint: Did you mean" err &&
+			test_must_fail git -c advice.pushAmbigiousRefName=false \
+				push origin $oid:dst -n 2>err &&
+			test_i18ngrep "error: unable to push" err &&
+			test_i18ngrep ! "hint: Did you mean" err
+		done
+	)
+'
+
+
 test_done
-- 
2.19.1.390.gf3a00b506f

