Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722A020248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDFLg6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44948 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so4482383pgj.11
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=hVT4PlEAhp4QfHDKBPo0B4TJ7ts3kS4L4UGL79iv9vNwKDCz9lGO2H7gbA4w4ApvsN
         xzP3X3c8Y+72Gvt/wcva1qJBnkal7xFYZ/HF5BBBdB6fqxSoYTsjQQcfUhxbjsH1TO9R
         pnW8pVBt0gH8uNquZhpJ8aS7vlVGrKidh88RWVBuWZwKEBmYZTURSDpxS1eACSMqxxqE
         5iPxTdLP/lhpTBTvA3yw9ZEtzXejWQuVy8QhnF3TSfK84eCcqV1p1ZOlAvvwPT9v15QC
         koy395DGKo+Sgv8eQLP+DUu6cG/h9FdOrOqfPvzpergsN3GcwURcTwaJRRXUeNRD9Hvv
         F7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=DcTNycr5O9n5dxQlj0jptSurQbpxuXOOisX/d4ft20sN4QFgkmslqelK93p9wPkCki
         XRWbfHcxu/6RGdgzdTNTl9VphgZtWWbCa5SLkez8GV05967NInyn9Q7n1kS5UTRD50t7
         BhLTwgteTvktGwRcuLW/iAPrFEVPQ/N3aapUIplBU/sS15xwdhiKxe1wwMi69jNfCBp5
         xe7t1n9FzCUq5nFGDmteQ/bLFEYHEqIO4a1LRiFUJbXj1g2gWSfjVcWfNWg+CbeKpnK9
         DolRh0VY+tnisVyaqs4tWDzsKzssjLM/3Yr1NOJ4En09L89lvlbTScAsfzNo5X1TWI74
         RZag==
X-Gm-Message-State: APjAAAUcajYev1XaCuGQ6HXOGtOaJPL/hSUw4cM2xbxkh37a0iCqgGpc
        hWFXPHziFbzVcxXPEIgN1Kg=
X-Google-Smtp-Source: APXvYqzp8Q7p8AQ8wKRcwa+0KUMNAZBnBd+Yvrio/FOaZIstcH9jZrpsVpQX8FZKvmE4IisDvzM6hQ==
X-Received: by 2002:a63:e653:: with SMTP id p19mr17174291pgj.284.1554550617468;
        Sat, 06 Apr 2019 04:36:57 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id v15sm34892431pff.105.2019.04.06.04.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 19/33] sha1-name.c: remove the_repo from interpret_branch_mark()
Date:   Sat,  6 Apr 2019 18:34:39 +0700
Message-Id: <20190406113453.5149-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index af8bf5b351..7d9512ac44 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1412,9 +1412,9 @@ static int reinterpret(const char *name, int namelen, int len,
 	return ret - used + len;
 }
 
-static void set_shortened_ref(struct strbuf *buf, const char *ref)
+static void set_shortened_ref(struct repository *r, struct strbuf *buf, const char *ref)
 {
-	char *s = shorten_unambiguous_ref(ref, 0);
+	char *s = refs_shorten_unambiguous_ref(get_main_ref_store(r), ref, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, s);
 	free(s);
@@ -1435,7 +1435,8 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
-static int interpret_branch_mark(const char *name, int namelen,
+static int interpret_branch_mark(struct repository *r,
+				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
@@ -1468,7 +1469,7 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!branch_interpret_allowed(value, allowed))
 		return -1;
 
-	set_shortened_ref(buf, value);
+	set_shortened_ref(r, buf, value);
 	return len + at;
 }
 
@@ -1509,13 +1510,13 @@ int repo_interpret_branch_name(struct repository *r,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.479.g47ac719cd3

