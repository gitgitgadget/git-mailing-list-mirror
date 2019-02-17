Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446E61F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBQKJd (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41554 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so1698914plk.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkDodcI7e1T9w8FvZxiVxikqs4S6/TE+IyDVPGv5Q4A=;
        b=WV9XWUGGK5wIOPkJAu8vN3MH0DuapHgu7egoUTAAxHTq1zL6Q8S+qq70lX0T3icXcG
         viTBx+BqMMYKnaRP95E4QTCYYdPumasvrYuRrASGgFVRFy+fVlb0vJPfK9iOumhSGb0I
         K2gu6YziUzVkaLR4uhFXI4G2PWQzO0s9S+6DjHwGKg4n8KfJ93Hh5NYcyrQjlqGOdbAU
         YpT2qxEF7zSArSFDedGMcOlqnjXREN4ANZMgXrZemLIMaI+p+Lq+06AF3c8bgvlvzoVY
         OTyVLJdIXTSmIS0CP9llYhAFfcUXMeQwc8551KYncZmmiZSzatOArEq3weOzmiKTgTSG
         mOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkDodcI7e1T9w8FvZxiVxikqs4S6/TE+IyDVPGv5Q4A=;
        b=BD+eXKEFCrMY1ZBH7Q/beSBaTP2fJ6VI3dlsCCi80IF40wr2O2cvaLNVxhiwehqD5H
         +O3CaR3PsPv0jcxB5AXzu8OKJtPvu/oJIHmrqTayEHiKFH1Kw2vZGAO0AZS62BIQHwfn
         1yock/QGdrr07LGB0LCoJYYSAxCv32UJXgo41PmB0JdeEj0VhF80PkkEeMwBPcuOSPmW
         MQhPr9geNvRhe1DaDT+LgUvc36mGtw01kkW5yM+wbDZc8eQa5IqL/2QxKeYoynvEg1jj
         NEu0ncZLiM2IJ7E3shkhhHe64Le0aCF8Lqco+zEsDmJ5sMkVFkHFa2Q1IqMGMjtuXX3s
         nDtw==
X-Gm-Message-State: AHQUAuZrwE5d2HoUcHXI7eI8o9sGDiiEB+UuCtt3qcxr39Ci6Shqgcve
        HPJdIItCGRwL2Q+yJxL8jzWaPH8E
X-Google-Smtp-Source: AHgI3IZh+UbdUFq66HJrWPSvuBDZM7ZcTxLw8KEMPhp39guqk6dbACWyiQyNqmYwcolwP77RxzEc1w==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr18872558plb.45.1550398172157;
        Sun, 17 Feb 2019 02:09:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l24sm12907707pff.116.2019.02.17.02.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/31] refs.c: add refs_shorten_unambiguous_ref()
Date:   Sun, 17 Feb 2019 17:08:45 +0700
Message-Id: <20190217100913.4127-4-pclouds@gmail.com>
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
 refs.c | 11 +++++++++--
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b869f32d8b..3dde824aab 100644
--- a/refs.c
+++ b/refs.c
@@ -1169,7 +1169,8 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -1247,7 +1248,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			strbuf_reset(&resolved_buf);
 			strbuf_addf(&resolved_buf, rule,
 				    short_name_len, short_name);
-			if (ref_exists(resolved_buf.buf))
+			if (refs_ref_exists(refs, resolved_buf.buf))
 				break;
 		}
 
@@ -1266,6 +1267,12 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    refname, strict);
+}
+
 static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
diff --git a/refs.h b/refs.h
index 308fa1f03b..5627570241 100644
--- a/refs.h
+++ b/refs.h
@@ -462,6 +462,8 @@ int check_refname_format(const char *refname, int flags);
 
 const char *prettify_refname(const char *refname);
 
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-- 
2.21.0.rc0.328.g0e39304f8d

