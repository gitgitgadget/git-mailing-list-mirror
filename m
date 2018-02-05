Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA3E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeBEX7O (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:59:14 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46089 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeBEX7H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:59:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so101920pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3KKzjaJV0VEa1rCU1qcMs0qx13SLbYhIIuQaqQ3Ul0=;
        b=o5dhjFpIlvmDnfv4biDZtb9906MQTsZxu+MgM5zGSEiU2EURwx33eueUbpRzknZEi5
         EJ2CaDI+YldAlmfrIjXB22jUg41ehAoXDHYYs6W+mmcmiKhkXvQ06di5bmeN4DZO7sV+
         B7AUOYGpRe9U+S/6aYaf5wR3c1XGU8EwqeDX7HyQVogYtn3JZUbY2RIh4IPHwO7KuN/j
         FpaIPKZ8PMxhyfSXiZO1f09QBgKEWFDDxIO+gpyEeZSEsuP4bU50UPMhUMr6XFz17CKQ
         7bDCT2tozxfXU9/tYvOFk+/0CwcxmhcSYdVHicAXKGLdCaZ95vdAWXvlFgiubmsPiTmO
         a8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3KKzjaJV0VEa1rCU1qcMs0qx13SLbYhIIuQaqQ3Ul0=;
        b=A4GFr62mqb8nH0FMn3a6PY3QCgLEfsG5vgOYlFV0UkM7bd2hdCI6D6RcoWncih9MJi
         0D6mSb0WtcJKL4d9/6l6ncc0V+kn34RU84cwGlIwycIgPpXOzulbcK1/I1+xiwL5eAfQ
         8UbhEbQomkEDewwHrX+bcQZ86h7DkD1zi80f/g42lTM9wFg5+GgnxNyC3u6kl8PsmeUu
         DUCWnun61ieEOpE9qYrfD3A73FxN3g+74eqIyjnv65+cjDaSOPiw2SnFeu41UimS2Iv+
         R5WzNUaClo05ctuKUw5aOEDN455H5ylkSoZKRfh7Cs7y2BmmX6QIGI9DNKKTzlL2Mh4Y
         A5xQ==
X-Gm-Message-State: APf1xPBd0iI/e546A8iX8JK0QQiuLf9I//UHWs8JV39zwoYnmMMXEdrl
        5+BFKL2OluoEBIQE8LIgU2tN5Eq/crQ=
X-Google-Smtp-Source: AH8x227EInsxstMZsZCriwvqxeXuzhV9q8R3x9mtvaijOh1nLvwrpOT6WBFDcD/eCQ170tGsFWCTMQ==
X-Received: by 10.98.237.6 with SMTP id u6mr501401pfh.190.1517875146222;
        Mon, 05 Feb 2018 15:59:06 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w70sm7347111pfa.187.2018.02.05.15.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:59:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 027/194] pack: allow install_packed_git to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:48 -0800
Message-Id: <20180205235735.216710-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 6 +++---
 packfile.h | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6a1c8107ed..05b4505b2c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -671,13 +671,13 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	return p;
 }
 
-void install_packed_git_the_repository(struct packed_git *pack)
+void install_packed_git(struct repository *r, struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = the_repository->objects.packed_git;
-	the_repository->objects.packed_git = pack;
+	pack->next = r->objects.packed_git;
+	r->objects.packed_git = pack;
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
diff --git a/packfile.h b/packfile.h
index 74f293c439..ba6f08be99 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,8 +36,7 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 extern void prepare_packed_git_the_repository(void);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
-#define install_packed_git(r, p) install_packed_git_##r(p)
-extern void install_packed_git_the_repository(struct packed_git *pack);
+extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
-- 
2.15.1.433.g936d1b9894.dirty

