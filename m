Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B540C33CA9
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FACF2082E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v11B6/3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgAKWfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:35:07 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:35812 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgAKWfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 17:35:07 -0500
Received: by mail-pj1-f74.google.com with SMTP id l8so4035403pje.0
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4qq8sdn9CGxJlxck5P+2mqiHETCZS7//xSgAUVFaXUU=;
        b=v11B6/3HMxyU6s1OkwYQ04HjtK2gSkBCTlvYUUuENFxKZhy87zRPc1tXFWnGFY7LN7
         bV68rQLbU1AVPdwu9JF9ebz2S0ekjyQ8KTHevrnAvMNaSmx4C348ncItlyrYk0PiAU9d
         pVpctqXwTS4rqWod7YCHjkhGlWuz39zmHxSkXs5cxy1fbN4OvsKsj1neGiakKfkE4FQa
         HFr1P567BbelfshwI/jTTR3SGhbs3hwTEJ537kAa0L67deKv3vU+3jsPPjtaZ+QSCcaC
         2Yz+Rgh7Q7dXbYc5QESE8DIkMbimFToBBzGxxbKI1EvwSfNGL7ENL3kmP137EcZHunI7
         GlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4qq8sdn9CGxJlxck5P+2mqiHETCZS7//xSgAUVFaXUU=;
        b=lXJmyd9e+YzI09TTx+ZyzHpl/JDc9NI9v+KdQM33QkEc8LeEKlAZ3G7ogm8rgYmADx
         Y00jnThEmk+NHxoKkAXJvKNpqwJ1XaGRMAWjjOWivncU9JbtKd5KU54t5MTsuK0n3RH2
         YPULsKg+kV99EzuRKm20JDWQz2UqQ1IvjF9ULP383Qtp7saoG8L6NSHtd3eNcNTSkEy+
         nWXYdVzpxoINEzWXdDkpxQZVn4zgm/e/HZuYd7QXc84aMDX5uQqDT+50pk3TfQL7Nadm
         p+blX3uvb+sISrSImGoeI6eDwLejmt/Jo/tm4/TiFnBp+0XcnXiOEW6njOqRbUUvTyf/
         rlfA==
X-Gm-Message-State: APjAAAWD9f7aQ1+pDjbqUha+rf61rTIYe4uwObnQW3T5sIykrIeXAw3j
        YtH+Kv1cuFi9BjFQyMpHw9yPc3vG0vps0oAGqH8v/tSI35O/7Paf0pjehdqxujH7ABTE3lJ6+K0
        tv3YvV3PLY1wzWMSil/Z/ByoOQiQOs/5lHgGZSBvdxuDR+f8tvtXUDV1RevM9tcsUfumPFPAPnF
        aU
X-Google-Smtp-Source: APXvYqyCjUrZ5dNtg29j4AmXp84aglLw2YlooXA9M4EBK01nNjDatLLx1rc0vE4J9eHCz1N51XjCNsPzRYpwifM90kfn
X-Received: by 2002:a63:a34b:: with SMTP id v11mr12836036pgn.229.1578782106078;
 Sat, 11 Jan 2020 14:35:06 -0800 (PST)
Date:   Sat, 11 Jan 2020 14:34:56 -0800
In-Reply-To: <cover.1578781770.git.jonathantanmy@google.com>
Message-Id: <af19f5486f87f23e2a0c390de2d8710cdbad2d49.1578781770.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191228003430.241283-1-jonathantanmy@google.com> <cover.1578781770.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v3 2/2] revision: un-regress --exclude-promisor-objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before commit 4cf67869b2 ("list-objects.c: don't segfault for missing
cmdline objects", 2018-12-06),

  git rev-list --exclude-promisor-objects $A_MISSING_PROMISOR_OBJECT

succeeds. But after that commit, this invocation produces a non-zero
result.

Restore this functionality: since get_reference() already does what we
need, we can just use its return value; skip the arg if the return value
is NULL, and use it otherwise (if the arg is invalid, get_reference()
already dies). With this commit, --exclude-promisor-objects treats both
promisor objects passed through the CLI and promisor objects found
through traversal in the same say: it excludes them, so it does not
matter whether they're missing or not.
---
 revision.c               |  2 +-
 t/t0410-partial-clone.sh | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 91ca194388..0659a09b02 100644
--- a/revision.c
+++ b/revision.c
@@ -1917,7 +1917,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object)
-		return revs->ignore_missing ? 0 : -1;
+		return 0;
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..b251985e82 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -397,7 +397,7 @@ test_expect_success 'rev-list stops traversal at promisor commit, tree, and blob
 	grep $(git -C repo rev-parse bar) out  # sanity check that some walking was done
 '
 
-test_expect_success 'rev-list dies for missing objects on cmd line' '
+test_expect_success 'rev-list accepts missing and promised objects on command line ' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	test_commit -C repo foo &&
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
2.25.0.rc1.283.g88dfdc4193-goog

