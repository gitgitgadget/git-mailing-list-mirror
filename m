Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85621F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeJQH2p (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42567 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQH2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:45 -0400
Received: by mail-pg1-f202.google.com with SMTP id s15-v6so18747553pgv.9
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o7I7Ak/8GnkK2vi4y9xPluiGxF5/EQ3Xj+ItwOtXWLI=;
        b=Kkkj/a3sCuOozNADyXkbJF6IfmuIPwQuWFwDZ6BeRqN+pleb/1VETHK4eUcs9VUVzv
         ttai3BXSBGufVw1ydISLX1PZC5of13+BBMqa0/RfEWsxvwpt9scLrwiHX9SjhN8LSrf9
         XCrPZSifvVdZLwgS7/zt47z5U28/9MSrMaUfvXtNRaUf4/3VO2cQIxnUu0JvjWUpPH95
         zK2gAzz6x97iJ6ZEaHmP3WP4Wxy+WM1gDQ2qPiXeYvyE8XCK0yi88hmUsGVwuag7XQa+
         YYeajU+5vqs2NpdHFzD+3WyibSmt+hBNW1G9I7p94YeBKABxG6v628bDii9Y3Q0bEi50
         0IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o7I7Ak/8GnkK2vi4y9xPluiGxF5/EQ3Xj+ItwOtXWLI=;
        b=NUHVK13YCuRLeG3zNOE6f0TuaYVkzlBogylV24F/JWKZz6taex6c4j6QgjTKuFx4oM
         DkvcX+2m5Dxotru+gh4zuWWUupy1JmDPnkC2LxFrf4acoOqO02NYr85tg7DMF6poyzHX
         3Le6W+OPa087avdmgKNwFNHYiEIVUnAobiZDlYG2RHlaN0a4atKzpbNate/NwkFxQt7P
         XGd3IHLPrVq0EwXRn7Nx9NGpKNx4iJxeNmbgMTcQgSkerd+K5ttl0+PZtqKoN3yJDxgz
         z186obTIBnIi3sg8x+jB59tnVavDoLvhSFJbMc3tkQ3tVVVaB3L8ipOt7/nUx6/Rcx+k
         BUEw==
X-Gm-Message-State: ABuFfoj+vO1kOAcjIz/jmeZRkal3F2E1KEk/Sk57YbZwlPkE6K7EecRF
        64haxZCPMhGP+dqIFZY/bFwRcjmfmpY2YwGjRAOf3ZJsyk7lAQ7RqQ+XiRt3Dktp5p91+zjDdEc
        xjeDvYXh1pJOU3us39TvJWsz7oBrJ1KKO3fDe8GgvCh8w8wnESjZYe5f3AtQb
X-Google-Smtp-Source: ACcGV62nAsxvvB7MSajPW7La2hZxm8FGi8w9rcZlZVL15u5Lt8mCeOPfVeDNFTFW5hyGqB9PkF3iaX03640/
X-Received: by 2002:a63:5a55:: with SMTP id k21-v6mr11088686pgm.67.1539732960549;
 Tue, 16 Oct 2018 16:36:00 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:33 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 02/19] packfile: allow has_packed_and_bad to handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_packed_and_bad is not widely used, so just migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c  | 5 +++--
 packfile.h  | 2 +-
 sha1-file.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index ebcb5742ec..40085fe160 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1024,12 +1024,13 @@ void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1)
 	p->num_bad_objects++;
 }
 
-const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
+const struct packed_git *has_packed_and_bad(struct repository *r,
+					    const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
 
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = r->objects->packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1,
 				     p->bad_object_sha1 + the_hash_algo->rawsz * i))
diff --git a/packfile.h b/packfile.h
index 630f35cf31..1d2d170bf8 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,7 +136,7 @@ extern int packed_object_info(struct repository *r,
 			      off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
diff --git a/sha1-file.c b/sha1-file.c
index 647068a836..13b3c5cb79 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1432,7 +1432,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(repl->hash)) != NULL)
+	if ((p = has_packed_and_bad(the_repository, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
-- 
2.19.0

