Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A291F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBXAsO (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:14 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36788 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeBXAsM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:12 -0500
Received: by mail-pl0-f68.google.com with SMTP id v3so5857828plg.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QikMigaRoXrQ21CXxBz62fAEVXlWhN+J1iBjVE0KFXE=;
        b=v4ywas2SMREtCOXB3+Gr9/7Z26t/j4+8vzIFrLjtxAHumiuHMl0jqyQMgxgVnteNWK
         SqD1Ib+JycepAjq8J8dHG1v1EII4RVOFaEY0p0oYs7AopeFVIRLebX8he92Z3DnufWwM
         PDb6jrjQPnPuThTnEuD4BYDn5WxEfrv1+nyFwX51ZLb151FhiWtbkFrlX+eOrPHgm+zC
         9HXod70cS7vUNHIRCrq24Q/MNFSSVNXMeSkzod9c8TGw4LIubH9chbsxsT+5IUCleQuz
         ocJbnCjcfBwEwKXKumw8FqgVFB5rwCI0dzMKPVNcJzsf+6kVE6KlXhh42cEnZ3BLAnOV
         eAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QikMigaRoXrQ21CXxBz62fAEVXlWhN+J1iBjVE0KFXE=;
        b=ZExVFnBuwPxJExoO1vU5U6e1KFeCEXh+pMnbJo5HYvAqTezr/AUfXoNc4NKyaC6ZN8
         Nk5FqT11XZiNzqvT8TXzekSfgJF/i1YyPp1PaFsgIYsKRTXviA9xSN29qgzb535W1LXZ
         y68L+i037V8W2mwE7snTUV89OcVn+oBTUr13qqUslR7z7FZo+54nFVp68D9gsDKkCROP
         TQiJvPdLDlV/xW7zLQj/QheuwWC0E3OrW83fGzW8qUwNLU9mSj0UWS6X42RVuIwyvIMU
         xnxF5c5JyH/iKBmGGZjSnLbCqISTG3iI/GKxY9/OXDvreI2+2LyE+KD18kAaIRRULaoK
         sx5Q==
X-Gm-Message-State: APf1xPCiQ8E3g81sNJiNHeQNaIHmJE3TKkYdpL1o9yhs4IE5eJUHjV0L
        Ri+X0SqfFZR3eEiLcEp/sH+0s0t3Wgg=
X-Google-Smtp-Source: AH8x225W5L2N0377CrN6jrbzSG7jd6tO/ny0aKYOTjrs8IwNGFWw9F8p1Xh9jyLGTSNsJiuq/5TNMg==
X-Received: by 2002:a17:902:b686:: with SMTP id c6-v6mr3310495pls.339.1519433291423;
        Fri, 23 Feb 2018 16:48:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 76sm4285009pfm.124.2018.02.23.16.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 09/27] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Fri, 23 Feb 2018 16:47:36 -0800
Message-Id: <20180224004754.129721-10-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ac25146076e..8e6f213f9d9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -344,7 +344,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -360,7 +362,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -412,7 +414,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.16.1.291.g4437f3f132-goog

