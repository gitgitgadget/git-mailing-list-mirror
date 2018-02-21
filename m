Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5951F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeBUBzX (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43497 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUBzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id f6so56380pgs.10
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4LdEEY/JZs2qDUvYR2Y6qi0zzEp3yk2INRcnmtGVDU=;
        b=EWGO7jGlEUzTdMd7/7QhdHwpA/VdvenmPX4YXKM0DZJdW36UxmlCczwJAX8M68grC8
         TwgVbMGUAv+BaGy36ZHEzOspxov6MreuSQjFkqgEtXsHvt7xqciMDFT6mdzb0ZMusJ6U
         6olANBUsrtvttntkZtGWBL65rfB9d3awdXD/2+awSqr1Xnv0riPrY6D1jacSLgCyymIw
         wgXcr5S/+WMosOWKd+BpNF1VaDvbEOmPXKVj5RzHifEauKLyZIbBSPOabLoBp5/8JeSI
         ItUwRbyPOET31njCzGsW1ZQ6KRBiUA3+NftWgz7BY1+85A95Es3jwb5K7xfR7JpQbilQ
         Sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x4LdEEY/JZs2qDUvYR2Y6qi0zzEp3yk2INRcnmtGVDU=;
        b=amAgkm2yVAlUmLITGBMuBRSLjbtKSSRgRkldnjTFVp2/PDlLcWvlO7qdBRvUe/i1q1
         BFSiPVQgPMeH/pMJikmjpXh4UrG/TPcdkrY7UUpVRW27bzqzbK7D3EtnsOeKHKkrtKk6
         x+5nd8h597b7k/EHX/xknWwzPOYmnGEKK8aD8yJm+57xkqiMXcsLMWkwZp9df5E3Aqgq
         495Wr+ZpqHLhREQmbXh21KdzsJZNmGoj7XYdUaVba09D3Ps2miTDmslb1vYRpctY81Ef
         ev+lJXIUZirdvBIsJYk1bn2e5xhEzkA4mgAdxt2dzNP+jSwe3qs2h96MaeYW42pjXsDU
         0sew==
X-Gm-Message-State: APf1xPB2+VfIdP4JFwSrTApMPO2owmSzV7wXvayLzT5RQchpDcxsOdBd
        B2PC8tL5t76EfGHEjBBctV9t0xXYYPk=
X-Google-Smtp-Source: AH8x227BMkZl23lBD3zGKbfWfqWN0tVY6mjKqOpaBFQBlGmSnPemJEXDM4xp1dwv9WZB4OKYAMxbAA==
X-Received: by 10.99.141.200 with SMTP id z191mr1300907pgd.418.1519178115839;
        Tue, 20 Feb 2018 17:55:15 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a22sm28030312pff.119.2018.02.20.17.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:15 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/27] sha1_file: allow sha1_file_name to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:25 -0800
Message-Id: <20180221015430.96054-23-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index a37d74a0c5..146358fe33 100644
--- a/object-store.h
+++ b/object-store.h
@@ -127,8 +127,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index d1f77a4c80..8fad523d85 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,9 +323,9 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, r->objects.objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
-- 
2.16.1.291.g4437f3f132-goog

