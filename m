Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DA220248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCLfm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34039 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so7916719plt.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=UWJDhLB41qCyAEsmPhI/+7bHTzLVmuVCoJ8NkWvdPCpdkMAhVlDZ3cyWHf7y8m3G00
         aioi2r3ZYPTxab6GYA+kvp4DVDv70iTCIKoGnwecgzSBj0CjCz45wsAtlVQIFzx7C62c
         Jus62+FtEs2MNxAPtOCwFrdZCDzkztYGa/j0fxEuMSxZA4fIC/xU6j2a0idyhZsOktim
         0eJu4QZi6Lao1I47sX7nUknJnjGswKKgK7vdQ0fEcrnAtGpRXgnCE/65HoMVrE2EsAse
         yRaBHOSiR0XLhu90n+0ni9BisjjsSAs8A7GuHA73cj25aPv+SIywqBqYs6f7+Ou8WpSN
         QgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=sS0zft8DSuwCVt8003hMW7Y4c45JPwhABWymnX1nrUgnys1l2I9CNpiLy6V2aj6o4h
         di1MXrlwC4IuMACBx0WBZAqfQ1B47zaGa9kCT9I7RQayvHCEWY3GR78lhiMOPL+xmTJD
         HbbjoKXi08NkTYJV0+fCkrgbpVN83aRaEuBtO2KednibIPt2iOs2awiJh+dPHcA8zgVX
         ZKwZ/Fqsdnx2KRd3Omde27+JP7ruISCliq8xfMyuvEEjxLtsa0dTPMtfebjyuRnFdRVB
         ehFUDFoMw/9z5FVQtIm97DoLBpp2Jullw0la7lEUkwpIuo5m2wG25CeS1+4tc3NDjEZq
         j6IA==
X-Gm-Message-State: APjAAAWfXceBoNBiqMAWUORRpj2YuFgWm0v7eFNwyKkQb1VRn6co2F+E
        71LIfjQ3pOmIoM4HvIfagMHylyjq
X-Google-Smtp-Source: APXvYqwgwuK4gKPXELthcJ4MRbs8rCBagfRmwHpV2ZOZ11JBe1lL4n9/qA49mOaz8s3KckAZ1lKUhw==
X-Received: by 2002:a17:902:b717:: with SMTP id d23mr57400969pls.260.1554291341160;
        Wed, 03 Apr 2019 04:35:41 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id r145sm13528663pgr.84.2019.04.03.04.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/32] refs.c: remove the_repo from expand_ref()
Date:   Wed,  3 Apr 2019 18:34:31 +0700
Message-Id: <20190403113457.20399-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

