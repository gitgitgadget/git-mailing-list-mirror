Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E660208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 07:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdH3HLV (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:11:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35943 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdH3HLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:11:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id 83so4487223pgb.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTV9U/GBoTLGQi398xNOoD3Mh7UDYmG8GzLNK7gajP8=;
        b=QD7F0fIoJ+EoJ/AlHdmWUOW4q87asAU8PWEJrLHQdGvYkBzjT0dGcYqDk8P/FajPaV
         vUN2ujAv1AaFOFaBD5Y3gwM4lgzD+KXjvUj5rov+fJGKHaVR4z/4iTyIcE9PHrG4tzzH
         i8bIiRibcg5FQ5TJ7vehUhXCDSB5FxnfE2Ju8OXqDs5LXaLpwIT58VNUYhsklEU+G6WX
         eEOiqWu5e3K0DMFeQM3zTbwXc9Z3uE1hLESMkZiSgp2F5+uZ1QBwZmyo1BJoGOL3nHhK
         o/W8WUc9+GgM/pvsQ5b8BAwuW/LcdHFr8SRyOPtWvmByHL7AUbVM2FXS41p+5vVPAwrZ
         p6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTV9U/GBoTLGQi398xNOoD3Mh7UDYmG8GzLNK7gajP8=;
        b=q3akwRPiM4R4Wj4scoTGEXj8UxeNLfYmzbtI/2UOTgqnS6dYHDfKY3xC7I6TL84ljG
         etLJEf1u7ed2tVh4DyomwzE8+w0b6MP1zezFdCSGU7OnAH00ZepZeGhSfGEoBXWC3IJn
         PJq/Qvl2NwOYWVDiGmDcDRwleexHOjxkPMjyZMmaiptd4muuykmo16rToS3WxvmMvngM
         6uZp6z1Lc9iLNhUlj2lVsaf9I65CQl4NNJrzgKtZPSAItRWSxPwkaAy7rzBiHtpyWzEY
         qXOtlJvcx/2j94CPrrIg3pki/Nl96pEpC2Tymy+iDoYFi9A1g5dFaF25eBxy7iTc41yj
         1siw==
X-Gm-Message-State: AHYfb5gaKfxyprn1ES5K5OQoavwGLVGvcVU59cCY/1hZuNUxGVC+rDYp
        /NodzmhM6VuIF4MNIGo=
X-Received: by 10.84.229.70 with SMTP id d6mr783443pln.214.1504077080154;
        Wed, 30 Aug 2017 00:11:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id w6sm2234186pfb.13.2017.08.30.00.11.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:11:19 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:11:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 27/39] object-store: allow foreach_alt_odb to handle
 arbitrary repositories
Message-ID: <20170830071118.GB153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h |  3 +--
 sha1_file.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index fcf36c7370..518da80367 100644
--- a/object-store.h
+++ b/object-store.h
@@ -68,7 +68,6 @@ extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned lo
 extern void prepare_alt_odb(struct repository *r);
 
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
-#define foreach_alt_odb(r, fn, cb) foreach_alt_odb_##r(fn, cb)
-extern int foreach_alt_odb_the_repository(alt_odb_fn, void*);
+extern int foreach_alt_odb(struct repository *r, alt_odb_fn, void*);
 
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index 452c8f0bbd..81bc1ab309 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -604,18 +604,18 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
-int foreach_alt_odb_the_repository(alt_odb_fn fn, void *cb)
+int foreach_alt_odb(struct repository *r, alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
-	int r = 0;
+	int ret = 0;
 
-	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
-		r = fn(ent, cb);
-		if (r)
+	prepare_alt_odb(r);
+	for (ent = r->objects.alt_odb_list; ent; ent = ent->next) {
+		ret = fn(ent, cb);
+		if (ret)
 			break;
 	}
-	return r;
+	return ret;
 }
 
 void prepare_alt_odb(struct repository *r)
-- 
2.14.1.581.gf28d330327

