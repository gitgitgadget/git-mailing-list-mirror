Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5631F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBFAab (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39456 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbeBFAaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so182097pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sDM69cPCFua4sXOGtG0972+9kMN31HkSaQj5gtmp8v0=;
        b=WbqAuym91HIUgszZWpKLVaGz/COtPjSXA+V3tikYZU49t6L481/YMbIUrZ1PyvM5Jg
         1heJreTxb2PYZyrfgSP9RxppMAP+MGC52URK+84DH/40bV+JwPc4b58lLdvHFRy8IKUX
         /d7A6+lZy1pYfWkYsr/egS1B1ArKMtLAQZ/F/gxlMc1DY9Ma0kuMxSiQbdYzrfcvfByB
         5zbXxYq4fND4hCBOlT5R0JlBgrErBgaCvkKpRckiAf6y35StMGIczRHAKakYzlCcsNLH
         0aU65IOs2MFUUzWqdpRIGnFdJLOnxaJK/AgCs/NBxlJVqjwmcHsOfHMAiGDMNdTpvYpv
         FnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sDM69cPCFua4sXOGtG0972+9kMN31HkSaQj5gtmp8v0=;
        b=UfVODPwOFRBNti6jaQ3iKLu4OX7JzOWdw1LQtjKFb5aDyDqWzy5RtA7WNYg53cmwCs
         U3J3dd0wBxNgz+QXOoNgDvPsqvsKuEIcFv0N6DVVBotRcbcpnS9m69y/S1jJug6rAJGs
         w/jYudEMOarXJFcifoPvnxlcOwC0tSk71m8sIb8dE4+0n8a3/iN9SrDNe+d1534Fcov+
         /6cFSIhfiC16ul9RZEZPLD3rhHRpU6uLVXEthfJ3l3xs+s9rBUEZ/j6ZT7DVs/SYanWf
         bBMQwFjou3F/fD30QyCairOKd3M+EKS9WuzgQEwTQ+8SEMD/5iB+vgjKDM5icyZEzIa1
         PIxg==
X-Gm-Message-State: APf1xPAqifwbPTOfFzgArXq0Q7elba/VSpty4YW/JEH+fAjmzx24yZX+
        l3Od0BhUMZkXdTHRlNcQbOG/I5vvyGI=
X-Google-Smtp-Source: AH8x2253462PHnzE373xU64+dRDDE6CCIpu2Phvvn+M+62ShJgxrd59mswos3kcxf9szziijNjNGrg==
X-Received: by 10.99.125.78 with SMTP id m14mr443484pgn.383.1517877029154;
        Mon, 05 Feb 2018 16:30:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id j125sm14780497pgc.29.2018.02.05.16.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 177/194] objects: allow check_sha1_signature to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:32 -0800
Message-Id: <20180206001749.218943-79-sbeller@google.com>
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
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 47c38170e3..62763b8412 100644
--- a/object-store.h
+++ b/object-store.h
@@ -108,8 +108,7 @@ extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsi
  * The in-core object data should be in "map". If "map" == NULL, reads the
  * named object using the streaming interface and rehashes it on the fly.
  */
-#define check_sha1_signature(r, s, m, sz, t) check_sha1_signature_##r(s, m, sz, t)
-extern int check_sha1_signature_the_repository(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+extern int check_sha1_signature(struct repository *r, const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 /*
  * Convenience for sha1_object_info_extended() with a NULL struct
diff --git a/sha1_file.c b/sha1_file.c
index 8638fae9c4..1cf173da16 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -801,7 +801,7 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-int check_sha1_signature_the_repository(const unsigned char *sha1, void *map,
+int check_sha1_signature(struct repository *r, const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
 	unsigned char real_sha1[20];
@@ -816,7 +816,7 @@ int check_sha1_signature_the_repository(const unsigned char *sha1, void *map,
 		return hashcmp(sha1, real_sha1) ? -1 : 0;
 	}
 
-	st = open_istream(the_repository, sha1, &obj_type, &size, NULL);
+	st = open_istream(r, sha1, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
-- 
2.15.1.433.g936d1b9894.dirty

