Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8513EC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42673206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC7rFiQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfL3Xo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:44:59 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:47374 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfL3Xo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:44:58 -0500
Received: by mail-pg1-f201.google.com with SMTP id l15so7256937pgk.14
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lhDjSjsHkTkqGb/sSkYTqecednj5MvH+Fpc3X2c/W3o=;
        b=IC7rFiQ8NhEFKpJvawBhRe4sYv+JIGsFqH5xXnmiZvZFpWyd177uLRLo+Bqy7yc+ai
         vKCBY52O7D6FDT7ju444ZtUelnRiwn3VSV4JEjORCf7NrQqYCKGE2NIjspmJssrOiI+Z
         WK8v06kae4q89PLHD8LH9rNVx/LVKy9LN6lzlRGhLhs0Gnb69bA/tRMluYo+ayxrHyBu
         cipiTUckK5POynTqYYvUmZtdXX6E5sXGmDhRgIw5wttPKt9JSyt1HerTktfRG4ow5Mtd
         QRlp7TpK3AP9fP9+k6XP8VdzelQ8bqGEI9SYMTKuw+nMm+ty9vPQQnDFftJDv9DC7Kyd
         ugtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lhDjSjsHkTkqGb/sSkYTqecednj5MvH+Fpc3X2c/W3o=;
        b=SaHjCo3qG/SDGO3b/qv8KFXQ810VHkzOwQKsSOQhaZLp+FF5CQIGd2TSZhP5ci0aBV
         HF41rUDpNXhNN3pXKh9aEERQ7OJO9736/62OJSB4Nk77tT826Eq4y/Fe8cO0Lob/HOme
         z+8zCwOsA6QkP1IGrvASC8KW2rty8R9z53V/bbHKCR4PynaGqRID2dhHn/L5kdXBNQN9
         7j+YvCw4GQmjqX2tw1fIRnWl0tdUJujR4s64og4O5flnvaGjVSYfxo5/dIzc+tb3NQAu
         /uEbVq8DMsj/fjPoNjTjP/oqdL2CpPm+z0P27TgDREceGJTIM2Oyn0NgriPVB0t8xTYm
         zcDw==
X-Gm-Message-State: APjAAAUcRFTJTXwWJADeadTCk2pe8CwnHpXontGnzazqg76slEFl66Ym
        rOEkAcSiQnnhndksS5AP2C2x/TpQ2q7jQb28ZhFEGQnXbLOZ6ziT7+zH4jcswq4Gz+gie0Sx4b8
        N+DXvISkKsLI2r/WvAB5+vjloVnh6oUBx/5CkqaE75OV+f3IihNxynOq7nhp2K/C5FCmTdCB/UO
        74
X-Google-Smtp-Source: APXvYqxxEkPDpZB6tUdEysalqHL1VpPsUuksqlhLhaqqcNGdSMWMdh6evw715Zb0kELk6WuKfqx+qJY5e9CNjyUGzBlI
X-Received: by 2002:a63:89c2:: with SMTP id v185mr73290013pgd.135.1577749496719;
 Mon, 30 Dec 2019 15:44:56 -0800 (PST)
Date:   Mon, 30 Dec 2019 15:44:53 -0800
In-Reply-To: <20191228003430.241283-1-jonathantanmy@google.com>
Message-Id: <20191230234453.255082-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191228003430.241283-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2] revision: allow missing promisor objects on CLI
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 4cf67869b2 ("list-objects.c: don't segfault for missing cmdline
objects", 2018-12-06) prevented some segmentation faults from occurring
by tightening handling of missing objects provided through the CLI: if
--ignore-missing is set, then it is OK (and the missing object ignored,
just like one would if encountered in traversal).

However, in the case that --ignore-missing is not set but
--exclude-promisor-objects is set, there is still no distinction between
the case wherein the missing object is a promisor object and the case
wherein it is not. This is unnecessarily restrictive, since if a missing
promisor object is encountered in traversal, it is ignored; likewise it
should be ignored if provided through the CLI. Therefore, distinguish
between these 2 cases. (As a bonus, the code is now simpler.)

(Note that this only affects handling of missing promisor objects.
Handling of non-missing promisor objects is already done by setting all
of them to UNINTERESTING in prepare_revision_walk().)

Additionally, clarify in get_reference() that error messages are already
being printed by the functions called (parse_object(),
repo_parse_commit(), and parse_commit_buffer() - invoked by the latter).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1: Improved code comments and commit message

> This is the case where oid must be COMMIT from oid_object_info()'s
> point of view, but repo_parse_commit() finds it as a non-commit, and
> object becomes NULL.  This is quite different from the normal lazy
> clone case where exclude-promisor-objects etc. wants to cover, that
> the object whose name is oid is truly missing because it can be
> fetched later from elsewhere.  Instead, we have found that there is
> an inconsistency in the data we have about the object, iow, a
> possible corruption.

Thanks! I should have looked at the first half of get_reference() more
carefully.

If there is corruption in the form of hash mismatch, parse_object() will
print a message and then return NULL, leaving get_reference() to handle
it - and treat it as missing in this case. It seems reasonable to me to
handle the repo_parse_commit() failure in a similar way. I've added
comments to clarify that error messages are being printed.
---
 revision.c               | 23 ++++++++++++++++++++++-
 t/t0410-partial-clone.sh | 10 ++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 8136929e23..af1e31b4fc 100644
--- a/revision.c
+++ b/revision.c
@@ -370,8 +370,18 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 		if (!repo_parse_commit(revs->repo, c))
 			object = (struct object *) c;
 		else
+			/*
+			 * There is something wrong with the commit.
+			 * repo_parse_commit() will have already printed an
+			 * error message. For our purposes, treat as missing.
+			 */
 			object = NULL;
 	} else {
+		/*
+		 * There is something wrong with the object. parse_object()
+		 * will have already printed an error message. For our
+		 * purposes, treat as missing.
+		 */
 		object = parse_object(revs->repo, oid);
 	}
 
@@ -1907,7 +1917,18 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object)
-		return revs->ignore_missing ? 0 : -1;
+		/*
+		 * If this object is corrupt, get_reference() prints an error
+		 * message and treats it as missing.
+		 *
+		 * get_reference() returns NULL only if this object is missing
+		 * and ignore_missing is true, or this object is a (missing)
+		 * promisor object and exclude_promisor_objects is true. In
+		 * both these cases, we can safely ignore this object because
+		 * this object will not appear in output and cannot be used as
+		 * a source of UNINTERESTING ancestors (since it is missing).
+		 */
+		return 0;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..fd28f5402a 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -416,15 +416,9 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
 	git -C repo config extensions.partialclone "arbitrary string" &&
 
 	for OBJ in "$COMMIT" "$TREE" "$BLOB"; do
-		test_must_fail git -C repo rev-list --objects \
+		git -C repo rev-list --objects \
 			--exclude-promisor-objects "$OBJ" &&
-		test_must_fail git -C repo rev-list --objects-edge-aggressive \
-			--exclude-promisor-objects "$OBJ" &&
-
-		# Do not die or crash when --ignore-missing is passed.
-		git -C repo rev-list --ignore-missing --objects \
-			--exclude-promisor-objects "$OBJ" &&
-		git -C repo rev-list --ignore-missing --objects-edge-aggressive \
+		git -C repo rev-list --objects-edge-aggressive \
 			--exclude-promisor-objects "$OBJ"
 	done
 '
-- 
2.24.1.735.g03f4e72817-goog

