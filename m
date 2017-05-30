Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD492027C
	for <e@80x24.org>; Tue, 30 May 2017 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdE3Rc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:58 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34475 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdE3Rbe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id 9so78321380pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0KUyeFnaaYLdHEBRyw5Bj9T841EEjp/dkWTy456djto=;
        b=sKdiUZhDD367OXrrhca+srUVYwe3bfj0T7evzMeI9j7jRUd6FQ7F9h53wx101asJB3
         qD3p3usFRfd/SJG1+PZh1ie7RD6nEbOgZI2Cxxywlwb5sKS3xJMOp7K+90IrBC9evU8n
         IOXDrfFOQZWm/IRpAk21+8UgoRFj6ndTFHOt3NHyD1uvcB3604yxxFJ0jdwAhEsDQy2m
         xOeT4oBs0PA2ZI52nmuIatlICVwaAoCSJ5kiUbYK/0+Ere2DrprIuWYPEsfsazUXHhb+
         lZj6V3+i0SUs4Q5qMQG6CbhKd4nMkh7daFsWgv+ZIrY6xBURQhqrGu7jFrRSUmZhOKPv
         lsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0KUyeFnaaYLdHEBRyw5Bj9T841EEjp/dkWTy456djto=;
        b=pmKi/wgmj+JUl5T7QOtp6qCpX/U5ndgJ4WZeCn5VaIZRsAILrgMn1PHH8FIieIjnWV
         1Zk9xsOh/DpV9alt4AwLbV++P1VC2/oWenw58/MwHeofHsqW9VMhmtEdAZ4O0VFWeGSb
         frlsBwi4XtlhfG2tAjd7dXE94xF0FbS3QilBgfkMxIfjH+pXQeesqNweiStHeMX9HTF5
         +FxafiEBFnT24+2RGG66DsOFjehn2WKBZnj2qIdRBiXTKXLMzSUGyR8vdnRjN+DwzGCV
         2r6tw5LGujMJa9+7/d/p09NTcEK3uXOhTUolHUJPG3Urb+EkLB6g++gNTGnAGHKozDSk
         1Jnw==
X-Gm-Message-State: AODbwcAShReVVpktZcAnlscIyQCCCaZr7Mkm+u/kU39PkOkFtS+XVZdo
        lgqXN017dSEMGsaehkopVQ==
X-Received: by 10.98.5.130 with SMTP id 124mr24720909pff.209.1496165492779;
        Tue, 30 May 2017 10:31:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/33] diff: convert run_diff_files to struct object_id
Date:   Tue, 30 May 2017 10:30:48 -0700
Message-Id: <20170530173109.54904-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 7984ff962..c82b07dc1 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -101,7 +101,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 		unsigned dirty_submodule = 0;
-		const unsigned char *old_sha1, *new_sha1;
+		const struct object_id *old_oid, *new_oid;
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
@@ -233,12 +233,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 		oldmode = ce->ce_mode;
-		old_sha1 = ce->oid.hash;
-		new_sha1 = changed ? null_sha1 : ce->oid.hash;
+		old_oid = &ce->oid;
+		new_oid = changed ? &null_oid : &ce->oid;
 		diff_change(&revs->diffopt, oldmode, newmode,
-			    old_sha1, new_sha1,
-			    !is_null_sha1(old_sha1),
-			    !is_null_sha1(new_sha1),
+			    old_oid->hash, new_oid->hash,
+			    !is_null_oid(old_oid),
+			    !is_null_oid(new_oid),
 			    ce->name, 0, dirty_submodule);
 
 	}
-- 
2.13.0.219.gdb65acc882-goog

