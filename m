Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82591F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754390AbeAGSPM (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:12 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46347 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeAGSPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:08 -0500
Received: by mail-qk0-f195.google.com with SMTP id l12so11378785qke.13
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLv8bobdHE8MXjf2/QcpAoCGh+xIgXa1Uw1WbjB0Uvc=;
        b=MxcDg+I120X4/dEYuhFyKaOMZHd7p/oySyHZpkhwxPWpJDf/5GTambbH/D0KIxw/Tn
         Q4JtXlJIEoWhDcOBzH06sG1ye1tBrb0D04Fe1IQ6TPT+Wp4JwAISfDRHjo4ldql5ejxj
         mmtfXfjhg1lNRc6iV5/6B/VgSL9fdubn5FI+LRim0BYbaq2spXj1r1/s5iYDL6ZtHmGt
         0vfrOIM1wiWkk1dtKLIRdtHClq9qev89fi0CJ+6+P2Fqf/h1TDY+LJMz+JmJQaFb5LnQ
         2jU72eeyMW+SCAibsJ/l5FNH/0B6W6Rg7+q1FEvjBPQYGda52FqrcMn390wI3VmimudV
         v6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLv8bobdHE8MXjf2/QcpAoCGh+xIgXa1Uw1WbjB0Uvc=;
        b=k2pJ+eP49hw2B1OrdNJ1v3mOty8QjjlHb+b64LeAwloS7VrKtl1wo4AyJTFVqkOKa/
         4fg9m6N+ZUX6/jDvFIg8m0fJ1r+DCkS+9cT2BYk9v9BId+AUErxkrTXpznV2LIEdCPQ2
         Ruo+8vETDwrdhD1qVVLxkfN1j6yBeh1lITRW4OpZdT+4qSugB1iGGveeryhr/57P9vj6
         eggJ7Cna82c+Y4iat54eEXFoO5Yu26JxrNMagTe+gtZiu5d7gT40VYa1+4KPW8IOjKkE
         Clork3QfrtICQ539iqotg4fzf3kxOPzh8dblYqUQZz4USt++vJZu8Pp0Bl0CIN2bufw6
         Uw9g==
X-Gm-Message-State: AKwxytemHM7X+eTpdgmtb7TcSOGi0JAMIEKtL9vBze7ZaS7Wv5x+Cyf5
        J1e4MQArutBcNOLll+54I/WyEjIFQ80=
X-Google-Smtp-Source: ACJfBotl4hQ4hXGWw0nATfPnLazpUZJuQSHx1m1J92mzoDl6lQyd/1vKTnRN88mVhM6LbhSAWAM6zQ==
X-Received: by 10.55.180.197 with SMTP id d188mr13023409qkf.323.1515348908006;
        Sun, 07 Jan 2018 10:15:08 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:07 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 03/18] midx: create core.midx config setting
Date:   Sun,  7 Jan 2018 13:14:44 -0500
Message-Id: <20180107181459.222909-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the multi-pack-index feature is being developed, we use a config
setting 'core.midx' to enable all use of MIDX files.

Since MIDX files are designed as a way to augment the existing data
stores in Git, turning this setting off will revert to previous
behavior without needing to downgrade. This can also be a repo-
specific setting if the MIDX is misbehaving in only one repo.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt | 3 +++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 64c1dbba94..dc7cb4b900 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -896,6 +896,9 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.midx::
+	Enable "multi-pack-index" feature. Set to true to read and write MIDX files.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index a2ec8c0b55..f4943d3136 100644
--- a/cache.h
+++ b/cache.h
@@ -820,6 +820,7 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
+extern int core_midx;
 
 /*
  * Include broken refs in all ref iterations, which will
diff --git a/config.c b/config.c
index e617c2018d..17f560ddc4 100644
--- a/config.c
+++ b/config.c
@@ -1223,6 +1223,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.midx")) {
+		core_midx = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 63ac38a46f..57a3943849 100644
--- a/environment.c
+++ b/environment.c
@@ -78,6 +78,8 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
 int protect_ntfs = PROTECT_NTFS_DEFAULT;
 const char *core_fsmonitor;
 
+int core_midx;
+
 /*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
-- 
2.15.0

