Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B344020248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDPJfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so10106078pfi.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=po4WJV6YsjA9gi2cq/NqMMFAA2vXJSzk6sJVMo3WaSQ=;
        b=Ag69nNpKBUzwjGecuRFW9mHv94+7x//F/VF1H/tiarUq+kcRRhbQwzSxUWr5DZZler
         Xxidjfr+SMzv8eAD0YsYmI5j7hSlFRCXPA04e2Jcl41khAo7aVIbMqPIzzGEEd24UMCL
         VtQdcHbqq9suVv7Rtb11UA5eSYbLK9bZl+x5rVGja2DHwzrAg8R88RB96tkz023XSFjd
         nKpO+wNy52X4068qqulJIq49L2nMRMHM66xR+SHozyvnvoOjdowgIg1XISMlspXtkBhP
         gg6qi5EhEV4yED8efLKNd4OcJmF5+Nue0dHX+dPgfiG3zfDaarN0LnJo648kRmmuLWu+
         i1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po4WJV6YsjA9gi2cq/NqMMFAA2vXJSzk6sJVMo3WaSQ=;
        b=ELvb9hN0iD//EMuzRxiQFqDKGpFICz7Ra0YLUlSk8gyK3jWh0sZ4eKVb3g+kPU7IF5
         zqxpJtYsVWKkzr3HypGD78rZQTG6aEmPBOM4uqO3gnJ/Q5B98maXLwB7mH6Ebfd1o/Jg
         ZS3q2724hQ6uTSfcupBWLJmvVXA/mmgEcHVA2uQxirSPCxVB1W2jaFVH44+uBlKfH9Wj
         9edZLXq1nFjKtNZIcKdfQbKs0XUXkE/xu002aM5BDXOcPf7GvcTPKAK+HjeK8lXeSE4h
         fWyQfCy1RsjLp/ndgWlElxvaZqyeS8YWAqZkiJY4XLaLKDdA5PH1KfBPRPxIj20rYgiz
         8PpA==
X-Gm-Message-State: APjAAAVXNcXLiBj0x6xOkBGppnNuqQG5eK2/RrcghVHklh+7+xe7/Ns8
        1/F5WQCAn/nWQ+bc+ktaY1M=
X-Google-Smtp-Source: APXvYqzSJJ7O1LoXL5/Yohd80XPjeqWyLloXrEhIWIJ8L/1mq7OUUH72MT2nqhefkb1OcNgO1YycKQ==
X-Received: by 2002:a63:5b0a:: with SMTP id p10mr76098849pgb.282.1555407309683;
        Tue, 16 Apr 2019 02:35:09 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id 10sm68404795pfh.14.2019.04.16.02.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 07/34] refs.c: remove the_repo from expand_ref()
Date:   Tue, 16 Apr 2019 16:33:14 +0700
Message-Id: <20190416093341.17079-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

