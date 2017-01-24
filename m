Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9020B1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 23:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbdAXX5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 18:57:03 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32799 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdAXX5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 18:57:02 -0500
Received: by mail-pf0-f174.google.com with SMTP id y143so53385310pfb.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Y6QlESkXbstdE2GUFjsjMMQOALBd8a9Zrnrp/LgmR4=;
        b=hSxdfwyaeOQnW3c1zjWOEIWFlQXLso4NJqKnqLaf2dvVVtL41d/Uc61NzxE4rEgMju
         lBar9Jnzquo0OH6VFSXiAkL5wUQ8Nw1Lo81FSxrqeY+9XaRtgBe6kprLDmQXDLc+j3pS
         cBUWKTso+Q+E4mGxA2qes4jxSyH+bvHA7S6kIYGXaMbE6/qmHvFFd0ypjV7TlIFKd+Hg
         J3ZAMSB67GT9sByid3s9JdrG1CkyQxkub11V8v+bqE/STbHvx0UccacsfaMiXIJxJMTC
         XZEa1fhErbTig5LlIsIvOSFthl2m9QiUwrKn1Y2dW81Xb5qQY/SrI7upo6w4z4uULvLS
         l+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Y6QlESkXbstdE2GUFjsjMMQOALBd8a9Zrnrp/LgmR4=;
        b=Pujcj52mbNmGyD8QYpxkYcYkROH0eemFKyZ4dA88LEZZV3DKje8/+xDH27a0WZoyP+
         kAiCGE5j5fPgW+6LrN8I+5eOqVxdEoMp7whiGtysURFrfPylsfzYZTR1A9vdh/8yW9fu
         Eb4FJl4Nb42zsUv4EXTYT8eL635HhBrIrMIT6FmhE/2q17au3AUy74qK65Upt/r7N+Zb
         soGwbIR3kwcs2avOdSr0w1VoHWaYSeDTyEXeqMQ0USa9cc1ZDXRbSH/F8vRheisHKt/h
         VchSvcmmgBjKi3UZplwKginhhS5wY3RrENlbJIDItdCqr4opmaOLCB8hKmaH1mFv3H2Y
         zOFA==
X-Gm-Message-State: AIkVDXLyrJa/q3WfX2/kV3GpHMQgqOb3thBEX1B6GUPv2kBp3tvJmGwodQIvwtzS1IKhOeHH
X-Received: by 10.98.90.196 with SMTP id o187mr42630062pfb.30.1485302221555;
        Tue, 24 Jan 2017 15:57:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6936:a216:cb1:3482])
        by smtp.gmail.com with ESMTPSA id j7sm47180196pfe.84.2017.01.24.15.57.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 15:57:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/3] Add gentle version of resolve_git_dir
Date:   Tue, 24 Jan 2017 15:56:49 -0800
Message-Id: <20170124235651.18749-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.495.g04f60290a0.dirty
In-Reply-To: <20170124235651.18749-1-sbeller@google.com>
References: <20170124221948.GB58021@google.com>
 <20170124235651.18749-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This follows a93bedada (setup: add gentle version of read_gitfile,
2015-06-09), and assumes the same reasoning. resolve_git_dir is unsuited
for speculative calls, so we want to use the gentle version to find out
about potential errors.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 4 +++-
 setup.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 00a029af36..cafa3d10ae 100644
--- a/cache.h
+++ b/cache.h
@@ -509,7 +509,9 @@ extern int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_TOO_LARGE 8
 extern const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-extern const char *resolve_gitdir(const char *suspect);
+extern const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
+#define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
+
 extern void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
diff --git a/setup.c b/setup.c
index 1b534a7508..4605fd3c3c 100644
--- a/setup.c
+++ b/setup.c
@@ -1017,11 +1017,11 @@ const char *setup_git_directory(void)
 	return setup_git_directory_gently(NULL);
 }
 
-const char *resolve_gitdir(const char *suspect)
+const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
 {
 	if (is_git_directory(suspect))
 		return suspect;
-	return read_gitfile(suspect);
+	return read_gitfile_gently(suspect, return_error_code);
 }
 
 /* if any standard file descriptor is missing open it to /dev/null */
-- 
2.11.0.495.g04f60290a0.dirty

