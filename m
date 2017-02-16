Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EA31FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbdBPMEJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:04:09 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36343 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbdBPMEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:04:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so1509080pfo.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtyOBjq68SL3clH06AQ+qwQ/3WKecolmyOQ5U8+Bnxs=;
        b=mnU9I8B1XhoxfAS+TZ5rNgi0RqRENfMPy+3/RuiINmNZ8qn8UeVNerO3BvDSPXQZrp
         hFleITzQs1yqRtsuzHbZx0noj17l6I2QXiC+et+5RLQRI0dHoTVq3EEyUbq5fqmprfcw
         wmtgI8chnAyBD8g4rje0TwErMEfrC9RfMCyFR0Yd7LjidAnTUG04SNpfJJOr4dVS+YuI
         U4cHxDMM/+3/60rFeu9+ajF20FKGk53OeU8L+WeqMo25uOTgNs3fjrps0eMO/xU0qBld
         TIfFE6ET4hVqMJJQWEy/K5Be3dP8fzE1eoBtzyuv66DXCxadf/JF0CWqN1o/ryzXJjkL
         hXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtyOBjq68SL3clH06AQ+qwQ/3WKecolmyOQ5U8+Bnxs=;
        b=txBMrbbXo4o4KjFeUyCML1qdqlZP6VwxONsNl/03wF1+jVgp3WjI/4A6NWqkO8oO5G
         qgkcjY3RlqrqFc1MBatkk7Y8IQt0SXc7U1ELyAlrNbYJ1BmY3vtri8KhCZx6R09AWXft
         g8QqupCeVekf87ap46EVXjShuCZIRuo7G3y44GMU4xSiOZeM15O5xahQwhevcStPV7iy
         R7I0lGlolZJhOMtefVDTu3h7R333mwuJ77xaZTGA+d1iKSi+aBuLxn/uRJZ/r7DF9tJJ
         gxPACwnrHN/aiLAI1KJbAlh0zWpYwAs2eOhUd9ZqzEyauoE9SlrebRNLxdCjgs1heISe
         zETw==
X-Gm-Message-State: AMke39l9aavY3e75MmGftraKUS5U9OMKAX+2FJpLMV6I3U0eZnSsLrFXUlaleio7cGVj3A==
X-Received: by 10.98.17.4 with SMTP id z4mr2209846pfi.43.1487246648349;
        Thu, 16 Feb 2017 04:04:08 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 64sm13419765pfz.48.2017.02.16.04.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:04:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:04:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/5] refs: add refs_create_symref()
Date:   Thu, 16 Feb 2017 19:03:01 +0700
Message-Id: <20170216120302.5302-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170216120302.5302-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 22 +++++++++++++++++-----
 refs.h |  4 ++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e0e191107..23e0a8eda 100644
--- a/refs.c
+++ b/refs.c
@@ -1535,13 +1535,25 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	return refs->be->peel_ref(refs, refname, sha1);
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
+int refs_create_symref(struct ref_store *refs,
+		       const char *ref_target,
+		       const char *refs_heads_master,
+		       const char *logmsg)
+{
+	return refs->be->create_symref(refs,
+				       ref_target,
+				       refs_heads_master,
+				       logmsg);
+}
+
+int create_symref(const char *ref_target,
+		  const char *refs_heads_master,
 		  const char *logmsg)
 {
-	struct ref_store *refs = get_main_ref_store();
-
-	return refs->be->create_symref(refs, ref_target, refs_heads_master,
-				       logmsg);
+	return refs_create_symref(get_main_ref_store(),
+				  ref_target,
+				  refs_heads_master,
+				  logmsg);
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 10c2cfc00..694769963 100644
--- a/refs.h
+++ b/refs.h
@@ -573,5 +573,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    int resolve_flags,
 				    unsigned char *sha1,
 				    int *flags);
+int refs_create_symref(struct ref_store *refs,
+		       const char *refname,
+		       const char *target,
+		       const char *logmsg);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

