Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816181F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBFAaU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44772 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeBFAaC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:02 -0500
Received: by mail-pg0-f67.google.com with SMTP id r1so170581pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfAFSdnXFDDFhDOo6kBFE06hqDnbs6AbgQfcbSARhlI=;
        b=LKrUkNMTfObXzmEksAq2cbU24ejXxO0pTk366OQjA2plkb5zgRvXYvDrOsgn6coFMD
         w1QbyBwHuFkcrnSupOYPW8sgVARt7/BZLb6z5ngskgMyq2Gt0tTL6gxIdDXZEmK8CHeR
         2PAVVycCo3mUQ5UmgVipX8DHSGqg6C0aiol7wv+F7m85cXmBjHw5bPB+Kpv+8G+2Kf02
         F7ioRFBIeCqmEAjyCrRsi+eBYWzci2JxmO1Zosdep0vN5eLO8kRywluadGqQ2P2YAsbP
         hk7sBwy9wJR3eQmOdI7un5kIcYFWC7SxxbjVVtkccqghCbiaavsjeJf/hwZvLPmKn/Dt
         vNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfAFSdnXFDDFhDOo6kBFE06hqDnbs6AbgQfcbSARhlI=;
        b=L8Rv5iJZ0xyuZNSD/SZzczlNO2rzMdo+M+H4w+Iw4lDPXyIRwi7Xk8A8Yh+Puk0lgQ
         NPt2y/lGNML81Eu5540NpK6tapXCbHFKiDZpzqW7A2mhhtaJ8H0oEtbgOgNHTNdVFwe2
         nsYCGbmUs+HcdCvmg1vXbCtIQoY41l9bqEKBJD/cNsQaooJp8nxyVZ8CPs3kKMgZpSe1
         8qw9Le+GQoJ5rrNi5E+qKWu/HAYOOh3WlXkrkiy3lVWV/QaOEc79FQl7L08K7/x3LPiJ
         Ly6DEtgjToMhqP/KqLumPPlRfvBpkf1v/7h070BD4mBjGxS4EMVvAcBTQwn+e+lxpY2w
         vV5Q==
X-Gm-Message-State: APf1xPAeSJDtl7xex68rNR1CbrejKMm7fNdjLAtizkSl9xKiw7iRDRDO
        xTK8Lv3AQ1otONEhPT5fr/JN4Py36Kk=
X-Google-Smtp-Source: AH8x224u2AAgFjkMih6F74UqBs1KE1FrqwlIIWJbjUf75ZCBTcnCIVbNgoxZt51OIPaHsKnm0Pz7Cw==
X-Received: by 10.98.234.19 with SMTP id t19mr584409pfh.74.1517877001587;
        Mon, 05 Feb 2018 16:30:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e88sm465460pfl.80.2018.02.05.16.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 175/194] tag: allow parse_tag_buffer to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:30 -0800
Message-Id: <20180206001749.218943-77-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 tag.c | 10 +++++-----
 tag.h |  3 +--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tag.c b/tag.c
index 52009bf454..96757f37dc 100644
--- a/tag.c
+++ b/tag.c
@@ -118,7 +118,7 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -146,13 +146,13 @@ int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
+		item->tagged = (struct object *)lookup_blob(r, &oid);
 	} else if (!strcmp(type, tree_type)) {
-		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tree(r, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
+		item->tagged = (struct object *)lookup_commit(r, &oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
+		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index d23af572d8..91208dd2d6 100644
--- a/tag.h
+++ b/tag.h
@@ -12,8 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
-extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 #define deref_tag(r, o, w, l) deref_tag_##r(o, w, l)
 extern struct object *deref_tag_the_repository(struct object *, const char *, int);
-- 
2.15.1.433.g936d1b9894.dirty

