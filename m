Return-Path: <SRS0=w8S9=2S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA90C2D0C3
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687C620828
	for <git@archiver.kernel.org>; Sat, 28 Dec 2019 00:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHfVOX+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL1Aeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:34:36 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35838 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL1Aeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 19:34:36 -0500
Received: by mail-pj1-f73.google.com with SMTP id l8so8939632pje.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 16:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zs7d5qkuzui/qg5FqXp539aNBo8IEXWoeIScryTlcGo=;
        b=kHfVOX+d6FyIVOWh5dZFQapd4LLxeh7dCg4JAGCItrOWvsUkdJum4RJy7TgF4M0KBF
         0i6p5jNK1VDEMs/cLOYZ4XpxHQPfs9KOyyk3ZSaO48WoEd2CZ+PzPSLWpnRyOtfImA8T
         6UewCU5PqxyqwuguAkkKSUF5K4LUG1c48nNb+4+kGWeVYEs411ntidaGPyScJWs/DXm9
         aY5LIDZ8ktDQnu2Bq64CyOZ2KRZWoIoxDbx4MHAgp5AXw+vARrKezbJGrXSFdfjg9Own
         lDo3toAPge7LX3IMv7CegpVyp83I5flIoSfmjQC0CMH/qNTjl/Jah10P/j5QJJMtc0vP
         ePqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zs7d5qkuzui/qg5FqXp539aNBo8IEXWoeIScryTlcGo=;
        b=iM4UZXI96pXoJImMtTGD0G9kct39vs7jOfEQx66rHspG65yiDQgHvaGItPJoY22k/m
         MIRezCHQApcPtD5TzPttyjxEDeeOuuDK92cYq8UrQjEMh1mqiocSJWr18iK/myQ4hlrJ
         3IF48q15onC/7ceV1w02nAK8G/BYmnFZpa1x8otcOeY7rgy2xBxxuND8mnfZKtbOja/S
         rdkJyZXbw/f3GM+2Gie6nLs5Y5zE5G9v8bOVI9IZ9gmM4SqZnSdl1JqckNZhRx4DqKnh
         qs5jkByg4m+QHVeCmuhGVFlicz2PZRHEuFGPAgJD6SqrTTBeyHKu7NMsJm0TX5tWmtXE
         gthg==
X-Gm-Message-State: APjAAAVAi0XA663NVFTOJFt5nibFtK1HLZgYihN7ukHEpo20Ozj8TWmq
        sR4zlEMyGgKvelDLmzXXeZCT3zeyq8w1YMJSjyOeykQ1EWp8ZJQv191Iw0UOOPPuE0oMBXgj9Y0
        P1uz6rpYKTTLZRiVZFpXhKjX49yU+fFgTIgV+6gRtbYpMDGV43B8kSXv/QyMI1X1iq16AtN+6AG
        WN
X-Google-Smtp-Source: APXvYqyiRenvMurgp5rjPtUevwKKfNhjbh61/8H+57geq0z4v++glPasFWpaQksrxfE1dOsmAdog1CxX2i35l9EFQGzK
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr58972020pgt.208.1577493275322;
 Fri, 27 Dec 2019 16:34:35 -0800 (PST)
Date:   Fri, 27 Dec 2019 16:34:30 -0800
Message-Id: <20191228003430.241283-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] revision: allow missing promisor objects on CLI
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com
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

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
For those curious, I discovered this while trying to extend the
check-targets-only optimization done in dfa33a298d ("clone: do faster
object check for partial clones", 2019-04-21) to fetches as well. While
investigating my previous work of adding check-target functionality in
addition to the usual connectivity check (for correctness, not for
performance) in 35f9e3e5e7 ("fetch: in partial clone, check presence of
targets", 2018-09-21), I discovered that at current master, the check
was somehow no longer needed because rev-list dies on missing objects on
CLI. But I don't think that the current behavior is obvious, hence this
commit (which also restores the need for the check-target
functionality).
---
 revision.c               | 10 +++++++++-
 t/t0410-partial-clone.sh | 10 ++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 8136929e23..345615e300 100644
--- a/revision.c
+++ b/revision.c
@@ -1907,7 +1907,15 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object)
-		return revs->ignore_missing ? 0 : -1;
+		/*
+		 * Either this object is missing and ignore_missing is true, or
+		 * this object is a (missing) promisor object and
+		 * exclude_promisor_objects is true. In any case, we are
+		 * allowed to skip processing of this object; this object will
+		 * not appear in output and cannot be used as a source of
+		 * UNINTERESTING ancestors (since it is missing).
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

