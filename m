Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5345C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 15:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbiFGPvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbiFGPvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 11:51:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F6EAD31
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 08:51:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d14so15766722wra.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8V4twYBhbhTkrwQrLdadzwTvSaU8JMoplmgQEXcCAE=;
        b=ZCGqo2g3Ex4MNiIYw2w6wkmYCjLa9YDCRJSdDB5vAReNvZV3TmO6F4J5wFq2ATvKkj
         LfYUrqeDzt9vzk3zsqXOXxPh+V/LJMCmhaKktX3ZVGiWkff0DizqLvSTfpmkAPji6orB
         I1s7VI6Fs6Igxs0MjaFX3H5OH9LjT+YQrOGMaPHGLMX4gfj1tvEEnKIiNCVdpy3as7+J
         NZOLnOsF9p9yKA9ktTXh1t2MPnjwiv2tKIQYiPRBmfMzpPQfS+uTysAZrUbxAdNcI+p6
         rl+jIgVKb7QgOBpVz57VAFi60ycPKn5hP7XK9ELHflqsLTQhf6MuvqQIJNQhuTgsfYkJ
         71Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8V4twYBhbhTkrwQrLdadzwTvSaU8JMoplmgQEXcCAE=;
        b=OnAjp462K8JsJoDENTZlat2XNE+Cny1p2Avmb+y8gQYKCqktf3hFUem/0sJT0XYn3R
         /ooT25aLsbnNL5jz2yfttP8j8qTRQ6ePo1466HtSFq9hPK3lqB3GheVRzTGjKdnfFlYd
         98JOyjWeMJ447gsSTcXq47pLg6U00ZxxyIkh6Iznfw3/+4JGgwHJjYtVhds/uTnQIaLe
         8sCDGrzJmJ1E48JvYmPBm8EfneZGuk+XJaBZo7b4nPYGSlzSjNpCHXIkAQuQXig4uG+j
         lPXZOOFqmBPuYgXnX/kXOtn2Qc2DPbDwIQMEygQowFun0ws8hkAvRcJuYTrL48Au513H
         TOHg==
X-Gm-Message-State: AOAM533lzoqjLrTbzIzFPJNbDvprKm7qp1Ju7103pjbb+ju0LlfTnt73
        RMdHOxO3qdoXIlxOkM85JistqP9NtaKWxQ==
X-Google-Smtp-Source: ABdhPJw1Wb2dJQd4I3Td1YmUrD43Invuv3gaWiiJ+xFUbRZYWFRZhVjWEROtGTk9EZcGVIUKUnmDgw==
X-Received: by 2002:adf:df8e:0:b0:210:2e5c:695d with SMTP id z14-20020adfdf8e000000b002102e5c695dmr28823373wrl.423.1654617066882;
        Tue, 07 Jun 2022 08:51:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6-20020adfbc06000000b0020fe4c5e94csm18790056wrg.19.2022.06.07.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:51:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] remote API: don't buggily FREE_AND_NULL(), free() instead
Date:   Tue,  7 Jun 2022 17:50:05 +0200
Message-Id: <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.g0c3594a0ba5
In-Reply-To: <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com> <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the buggy "remote_clear()" function to stop pretending to to be
able to zero out a "struct remote". Setting "url" and "pushurl" to
NULL results in an invalid state unless the corresponding "url_nr" and
"pushurl_nr" are also set to zero.

In this case however we do not use the "struct remote", so the
FREE_AND_NULL() pattern added in fd3cb0501e1 (remote: move static
variables into per-repository struct, 2021-11-17) can be replaced with
free().

The API was also odd in that remote_state_new() would xmalloc() for us,
but the user had to free() it themselves, let's instead change the
behavior to have the destructor free() what we malloc() in the
constructer.

In this case this appears to have been done for consistency with
repo_clear(), let's instead have repo_clear() handle the NULL-ing of
its "remote_state", and not attempt to reset the structure in remote.c

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c     | 14 +++++++-------
 remote.h     | 10 +++++++++-
 repository.c |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index 0b243b090d9..c6ce04dacb7 100644
--- a/remote.c
+++ b/remote.c
@@ -147,15 +147,15 @@ static void remote_clear(struct remote *remote)
 
 	for (i = 0; i < remote->url_nr; i++)
 		free((char *)remote->url[i]);
-	FREE_AND_NULL(remote->url);
+	free(remote->url);
 
 	for (i = 0; i < remote->pushurl_nr; i++)
 		free((char *)remote->pushurl[i]);
-	FREE_AND_NULL(remote->pushurl);
+	free(remote->pushurl);
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
-	FREE_AND_NULL(remote->http_proxy);
-	FREE_AND_NULL(remote->http_proxy_authmethod);
+	free(remote->http_proxy);
+	free(remote->http_proxy_authmethod);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -2720,12 +2720,12 @@ void remote_state_clear(struct remote_state *remote_state)
 
 	for (i = 0; i < remote_state->remotes_nr; i++)
 		remote_clear(remote_state->remotes[i]);
-	FREE_AND_NULL(remote_state->remotes);
-	remote_state->remotes_alloc = 0;
-	remote_state->remotes_nr = 0;
+	free(remote_state->remotes);
 
 	hashmap_clear_and_free(&remote_state->remotes_hash, struct remote, ent);
 	hashmap_clear_and_free(&remote_state->branches_hash, struct remote, ent);
+
+	free(remote_state);
 }
 
 /*
diff --git a/remote.h b/remote.h
index dd4402436f1..d91b2b29373 100644
--- a/remote.h
+++ b/remote.h
@@ -54,9 +54,17 @@ struct remote_state {
 	int initialized;
 };
 
-void remote_state_clear(struct remote_state *remote_state);
+/**
+ * xmalloc() a "struct remote_state" and initialize it. The resulting
+ * data should be free'd with remote_state_clear().
+ */
 struct remote_state *remote_state_new(void);
 
+/**
+ * free() the structure returned by remote_state_new().
+ */
+void remote_state_clear(struct remote_state *remote_state);
+
 struct remote {
 	struct hashmap_entry ent;
 
diff --git a/repository.c b/repository.c
index 5d166b692c8..0a6df6937e4 100644
--- a/repository.c
+++ b/repository.c
@@ -292,7 +292,7 @@ void repo_clear(struct repository *repo)
 
 	if (repo->remote_state) {
 		remote_state_clear(repo->remote_state);
-		FREE_AND_NULL(repo->remote_state);
+		repo->remote_state = NULL;
 	}
 
 	repo_clear_path_cache(&repo->cached_paths);
-- 
2.36.1.1178.g0c3594a0ba5

