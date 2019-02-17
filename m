Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68431F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfBQKJm (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:42 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41543 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:42 -0500
Received: by mail-pg1-f176.google.com with SMTP id m1so6988116pgq.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOGJAjALw4ShWpymMwXQoi649DtE3cJee05xIVCBrl0=;
        b=FF9NkC5Xum+nP5lsoGS0ZTagYv7fHEzfsUjr75aKZFm6SNMdYeCzNVrxiOSoho2XFB
         AKe9/r/eHj/3KJcBUe2YoVoVNykKbNLVldjB2agyu5wTtVn8CTt+SdQllhsybdXFDOX6
         lHmSNC4BX/rwz0dDADcyAuAMtveGiC/totGc5PfurRlPD/v+Z8GCYWpjpKrZTw4OtfOm
         NRseBACFueATw4ax8UxAGybnzVbj59XFiJokUqme34jXbNJcTv8yH8ZWQkOlVXlNHHAd
         XcuoXJNTLLMDN+WG6Tp7++Wq6i8Uf0nrVm8vmXmQqJpn8Lg/qreQaFISVPblvhirQEs9
         uAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOGJAjALw4ShWpymMwXQoi649DtE3cJee05xIVCBrl0=;
        b=PTeeOFSkLNXQOIoBcfxKO1YanN8wAewXVcIesOtidSaNGKoD9ygDRoWD5xlKaN9wqy
         W2J6/IAGk1coyjeO9zLlEg4mBGpjJQ9u4aMyshzooH+PggHbnmsQVMI12NobjdEtw3nD
         AUmXRzlnN35SvV6Z/L0XmaKoPBqj9Q3ykhcz3baNnNo0IMpanbKVjNHSQkF19UW+bZ6Q
         9Z+msY0960ufL/xqR4gAOUxRgQ2bCqo4lQFYjhNl+d92NQwqdPDSrgynR/pHta/bzn9l
         lSosq0+1fsxrdZOEeGkAdwgw4L6t/uq6jOEivZ4gNueMQBvLxTjwzJiNNfxKMvLlfPRt
         JBSg==
X-Gm-Message-State: AHQUAuY8uLJ8YaE2EdO5naV6uJcQbs12+Gd4+u0xxhb8iC/+l3pWeCCW
        g9lm+d6AOBxTD8YC08Yb1vzCS8Yn
X-Google-Smtp-Source: AHgI3IZ6bISTSu6aWsEaamoVk2L3kNAZK8Q2eWYm8+oFzXprxjEoPyYfLRVsouvsqOsbJt9jrDSx0w==
X-Received: by 2002:a62:2ad1:: with SMTP id q200mr1029568pfq.34.1550398180870;
        Sun, 17 Feb 2019 02:09:40 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f13sm14375536pfa.132.2019.02.17.02.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/31] refs.c: remove the_repo from expand_ref()
Date:   Sun, 17 Feb 2019 17:08:47 +0700
Message-Id: <20190217100913.4127-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c        | 10 ++++++----
 refs.h        |  2 +-
 upload-pack.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 44df049796..1f5864aa36 100644
--- a/refs.c
+++ b/refs.c
@@ -558,12 +558,13 @@ static char *substitute_branch_name(struct repository *r,
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(str, len, oid, ref);
+	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
+int expand_ref(struct repository *repo, const char *str, int len,
+	       struct object_id *oid, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
@@ -578,8 +579,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
-				       this_result, &flag);
+		r = refs_resolve_ref_unsafe(get_main_ref_store(repo),
+					    fullref.buf, RESOLVE_REF_READING,
+					    this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
diff --git a/refs.h b/refs.h
index 5627570241..b630d5bde7 100644
--- a/refs.h
+++ b/refs.h
@@ -148,7 +148,7 @@ int refname_match(const char *abbrev_name, const char *full_name);
 struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
+int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..56505d60c3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -834,7 +834,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
+		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
 		string_list_append(deepen_not, ref);
 		free(ref);
-- 
2.21.0.rc0.328.g0e39304f8d

