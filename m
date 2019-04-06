Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E74520248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDFLhF (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33415 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so150507pfo.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=gi9adLzpAdTd+P1jLf/Sp+MJouR21MvajFoKU1z9mvChvcEAROwisahAEV0DRDwFzA
         ZNjHOBr8ashzRbREuaIsmoFASyQ2e7NCP2p1bYEDWyu3Msy78Vbp0+EaJeYmgnfd1cuM
         GvUu0BU50YgwU2MU/CvTgnMJY+LNG7pbYPV1/1wA1QJ+ZM/zsV44Z+M9JJKbez1G6w/x
         yGvLDdSVMMZWn/BzIIpMq8UhK/PCvE9+00cXxAd8r5nB9+WvjWuJ+osU7O1NPyLGnmNS
         4OLXRHCm8DjE/JI6HBFv3/TNrGtu7kcYl1Oyb++9o6S6gdwPsvrQZGWRMMIFZZQh3wKc
         dAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5XiUNgZOyJMfbfBOhs6OmmQ4I37YwDc4n2auyrKfdQ=;
        b=NIDRo+SbduSaCVrrs8b+MRkIpai53KmLveG7zoHZkc2ELzG6vF1E5yU2C532Wnixk1
         NFI/QhmbFkV3ClJlu9NfDZqV+ud4TtSGY/YptwT+fJ6PpvUR14IbXgMqnNLUFE77sAdV
         D007YiODCRnmcA85JlICbVOiIGq5et0AemswywQr71jQ1sUo23vlnRMPNTj1IYqzZ+bA
         VNnkjDB5YPvzbpf/KOUfmzr0/tqiaSMYad6KiSrfyuWrWTD/mq0syc0YgvzudC5oQDBv
         4cvp/SPtWVI0AlhWn39T1Mb75fb9Kn+3Hcg57RuWIml5GnaeYyflDVSG5UywB1ov0Gn0
         PvLg==
X-Gm-Message-State: APjAAAU2CwEcsrC3td5e3lQf5qcKjTpWfjdhXKZKC6z6dG4OE0lwdOHZ
        v0p/hO6PAKwZanaqyP7sICTOrd+X
X-Google-Smtp-Source: APXvYqwmlfo0DAU2gkB/v5WpVQ6ztCfvRfzH7+eyLO6mq3vbIpJpLtjPl24Rsj/uf2+ARs/76VT5ZQ==
X-Received: by 2002:a63:c706:: with SMTP id n6mr7750279pgg.310.1554550624462;
        Sat, 06 Apr 2019 04:37:04 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id r76sm19762080pfa.39.2019.04.06.04.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:02 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 20/33] sha1-name.c: add repo_interpret_branch_name()
Date:   Sat,  6 Apr 2019 18:34:40 +0700
Message-Id: <20190406113453.5149-21-pclouds@gmail.com>
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
 sha1-name.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7d9512ac44..49c62d5254 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1390,7 +1390,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 	return 1;
 }
 
-static int reinterpret(const char *name, int namelen, int len,
+static int reinterpret(struct repository *r,
+		       const char *name, int namelen, int len,
 		       struct strbuf *buf, unsigned allowed)
 {
 	/* we have extra data, which might need further processing */
@@ -1399,7 +1400,7 @@ static int reinterpret(const char *name, int namelen, int len,
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, buf->len, &tmp, allowed);
+	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, allowed);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1482,20 +1483,18 @@ int repo_interpret_branch_name(struct repository *r,
 	const char *start;
 	int len;
 
-	if (r != the_repository)
-		BUG("interpret_branch_name() does not really use 'r' yet");
 	if (!namelen)
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
+		len = interpret_nth_prior_checkout(r, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
 			if (len == namelen)
 				return len; /* consumed all */
 			else
-				return reinterpret(name, namelen, len, buf, allowed);
+				return reinterpret(r, name, namelen, len, buf, allowed);
 		}
 	}
 
@@ -1506,17 +1505,17 @@ int repo_interpret_branch_name(struct repository *r,
 		if (!allowed || (allowed & INTERPRET_BRANCH_HEAD)) {
 			len = interpret_empty_at(name, namelen, at - name, buf);
 			if (len > 0)
-				return reinterpret(name, namelen, len, buf,
+				return reinterpret(r, name, namelen, len, buf,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.479.g47ac719cd3

