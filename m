Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBAC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1D2073D
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOSfVZ6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgCCQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:12:56 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43483 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgCCQM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:12:56 -0500
Received: by mail-wr1-f51.google.com with SMTP id h9so4110804wrr.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAYY6ARgeppcpZF+0aExYfXD5uYwd5GST0Afoh6sICY=;
        b=fOSfVZ6nEe15sgTOzbZqgDJDWe3ZvAizdb3Cm8PXyLZLuIawOPDvxwSsIEYaYCFBnE
         7fh8WrXwU3IJqd++LHUELuZwuvY+3F5LlKYFD2srX7QrMUA6259GKJ4W6+k9wuoSfPCn
         ni4vSHEiRQYo9GkwHky7C28ZHalfrJkXdxRb/nK+hMbblSGTw/3pjhgteL+aE0fB6Kx2
         RCY2qI68LE64/VL+cy537X1NrsvreND6zVK9qCEew1UoUactpj39egNosMLCosipuDf6
         GnZTwf74XLg0Bb+jNsk4oD1UtBr2cfEuNZHGhQdAhi+LwakGpTrd6SBYxVdog6yXU79H
         vDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAYY6ARgeppcpZF+0aExYfXD5uYwd5GST0Afoh6sICY=;
        b=aioGhtBYZCGERnFlrOboHr4RqxKkbOhjPMhjO7+6fqdvxQP2vTPW2Q9V40/7pglkmo
         iOPVHULcBoEbSPZ8G4nhYz3KuAdwbf6LFxQV1sj5DQLqe/9q0/gT/RZYmcYesB0p7x/4
         QUrh9mvRKpn3Cg07ROe3tZYv/NK2vqyWLuglYPCmMQVkNRoTjdpap3Zt3bG4toKQKQCC
         nDhtDlwXrWgdDwta6/lB8hDxB2afZU5UWndxoK/daDyvDBljzEEcsJBBrI0n2ZzdZBLJ
         gjYGuysMEROzwOAmHBrGXtLwhBNY/K857nh7PqQHOq3J4UKPlDi0c/MYSRD+4vHEbw1Q
         sq7g==
X-Gm-Message-State: ANhLgQ1gofi7fvalJydLDQpFEuOeKzvTVXwAHSz7frufY637YIQ7l1zK
        VqeIzxtmQjgIVSCTaO/hUJ5BjZwn6q0=
X-Google-Smtp-Source: ADFU+vspHRgyNdPK2VeJDju5wxtRUDBimBL00LtF1Rq63JQ4RkrXdolpjDH61GgoMPrvMNPXXlURRA==
X-Received: by 2002:adf:a419:: with SMTP id d25mr6543822wra.210.1583251974413;
        Tue, 03 Mar 2020 08:12:54 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id l8sm4847472wmj.2.2020.03.03.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:12:53 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 1/2] remote: drop "explicit" parameter from remote_ref_for_branch()
Date:   Tue,  3 Mar 2020 17:12:22 +0100
Message-Id: <20200303161223.1870298-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
References: <20200302133217.GA1176622@coredump.intra.peff.net>
 <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 9700fae5ee (for-each-ref: let upstream/push report the remote ref
name, 2017-11-07) added a remote_ref_for_branch() helper, which is
modeled after remote_for_branch(). This includes providing an "explicit"
out-parameter that tells the caller whether the remote was configured by
the user, or whether we picked a default name like "origin".

But unlike remote names, there's no default case for the remote branch
name. In any case where we don't set "explicit", we'd just an empty
string anyway. Let's instead return NULL in this case, letting us
simplify the function interface.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 ref-filter.c |  6 ++----
 remote.c     | 11 ++---------
 remote.h     |  3 +--
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6867e33648..9837700732 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1459,12 +1459,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			remote_for_branch(branch, &explicit);
 		*s = xstrdup(explicit ? remote : "");
 	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
-		int explicit;
 		const char *merge;
 
-		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
-					      &explicit);
-		*s = xstrdup(explicit ? merge : "");
+		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push);
+		*s = xstrdup(merge ? merge : "");
 	} else
 		BUG("unhandled RR_* enum");
 }
diff --git a/remote.c b/remote.c
index 593ce297ed..c43196ec06 100644
--- a/remote.c
+++ b/remote.c
@@ -516,14 +516,11 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push,
-				  int *explicit)
+const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
-				if (explicit)
-					*explicit = 1;
 				return branch->merge_name[0];
 			}
 		} else {
@@ -534,15 +531,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
 						  branch->refname))) {
-				if (explicit)
-					*explicit = 1;
 				return dst;
 			}
 		}
 	}
-	if (explicit)
-		*explicit = 0;
-	return "";
+	return NULL;
 }
 
 static struct remote *remote_get_1(const char *name,
diff --git a/remote.h b/remote.h
index b134cc21be..11d8719b58 100644
--- a/remote.h
+++ b/remote.h
@@ -261,8 +261,7 @@ struct branch {
 struct branch *branch_get(const char *name);
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
-const char *remote_ref_for_branch(struct branch *branch, int for_push,
-				  int *explicit);
+const char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

