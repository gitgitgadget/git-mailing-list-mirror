Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D641C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbiDRR2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbiDRR1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169634650
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bv16so2149780wrb.9
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBTvGKhHNc3huvHcxWb4cjFp5BKNidrzksFvx8jJIKQ=;
        b=IzK4Xt8xIpTqJD1tRubyWFxKkpxpgo8E1MCZ97pLgriiFHHWmebO+busDWIq8FKleM
         RabM4owJjx311s2cX67piz721M46Y2IZVMgAu9Xrt3o/K62Xmdnuab2wcoGzanFDqi1p
         VI2X2rjOCqOHNU/k0MbFq/dB32e9qpOvvhn0JaPtuizeodDNB6xxwEVQz30i0TOzADaI
         UIS7nZLiuP584unS3fFiGh4n3aTI75MhiY1rnHV27CJovwF2HzCermgUj3krD/fYlULS
         Kei18rfm++3lS8M24ocqwBF9qeaGn+3zVwsHg76HIXBzMUGSq8ZNX76FByMhhbTav9Gh
         IvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBTvGKhHNc3huvHcxWb4cjFp5BKNidrzksFvx8jJIKQ=;
        b=iVnhTbXG6AYaL1ehSkoMM4aSEjxB+N+Ihq4riKgFS0K1OlU5pxfahLC3z234pMs5re
         ++3s1QF61z+4zuaWFkFjpZnSMEa8TbicQ08ylc2IaKsXVMTytUG/ajaxHWhaPTA9ibMr
         ZVHWDSJFGMrE1oauwZagsMO2Liet/drMZmU0aWH9u3wyCu1aKcanOt4CpyuWHGsxn292
         xquHlVZxY2Nx8TbD6BqLkcRs07aYz9jglzB90xAAQvEJP2dQgqMe2vILTMEmGK1AE0+Y
         rBN8xHhACT9g2DIfjSp+RlY6dH42/pvRCl42nv1FHtJ+mk8ac5UrFEztjI7i/XuaF9NF
         v2NA==
X-Gm-Message-State: AOAM533ozrIyF5quc7G3mGrnrJ/Et6YmD6bRRs+Ru6CRcbIrlBk63fEt
        QrTveWKkLZQwN+1o/IAy8QE3IA47IwIG4A==
X-Google-Smtp-Source: ABdhPJyvvQ3d9D0DtQrqP1AhzWCYJiIHU0DQgnaxBKRsQESKoce8WhbO0gJZtsfcL31DM/VZMusiuA==
X-Received: by 2002:adf:8123:0:b0:206:1759:f164 with SMTP id 32-20020adf8123000000b002061759f164mr8946788wrm.654.1650302664081;
        Mon, 18 Apr 2022 10:24:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 23/36] clone: add --bundle-uri option
Date:   Mon, 18 Apr 2022 19:23:40 +0200
Message-Id: <RFC-patch-v2-23.36-62623324d2f-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Cloning a remote repository is one of the most expensive operations in
Git. The server can spend a lot of CPU time generating a pack-file for
the client's request. The amount of data can clog the network for a long
time, and the Git protocol is not resumable. For users with poor network
connections or are located far away from the origin server, this can be
especially painful.

The 'git bundle fetch' command allows users to bootstrap a repository
using a set of bundles. However, this would require them to use 'git
init' first, followed by the 'git bundle fetch', and finally add a
remote, fetch, and checkout the branch they want.

Instead, integrate this workflow directly into 'git clone' with the
--bundle-uri' option. If the user is aware of a bundle server, then they
can tell Git to bootstrap the new repository with these bundles before
fetching the remaining objects from the origin server.

RFC-TODO: Document this option in git-clone.txt.

RFC-TODO: I added a comment about the location of this code being
necessary for the later step of auto-discovering the bundle URI from the
origin server. This is probably not actually a requirement, but rather a
pain point around how I implemented the feature. If a --bundle-uri
option is specified, but SSH is used for the clone, then the SSH
connection is left open while Git downloads bundles from another server.
This is sub-optimal and should be reconsidered when fully reviewed.

RFC-TODO: create tests for this option with a variety of URI types.

RFC-TODO: a simple end-to-end test is available at the end of the
series.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index e11f4019b87..51141c979fa 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -78,6 +78,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -161,6 +162,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri,
+		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
 };
 
@@ -1233,6 +1236,35 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
+	/*
+	 * NOTE: The bundle URI download takes place after transport_get_remote_refs()
+	 * because a later change will introduce a check for recommended features,
+	 * which might include a recommended bundle URI.
+	 */
+
+	/*
+	 * Before fetching from the remote, download and install bundle
+	 * data from the --bundle-uri option.
+	 */
+	if (bundle_uri) {
+		const char *filter = NULL;
+
+		if (filter_options.filter_spec.nr)
+			filter = expand_list_objects_filter_spec(&filter_options);
+		/*
+		 * Set the config for fetching from this bundle URI in the
+		 * future, but do it before fetch_bundle_uri() which might
+		 * un-set it (for instance, if there is no table of contents).
+		 */
+		git_config_set("fetch.bundleuri", bundle_uri);
+		if (filter)
+			git_config_set("fetch.bundlefilter", filter);
+
+		if (!fetch_bundle_uri(bundle_uri, filter))
+			warning(_("failed to fetch objects from bundle URI '%s'"),
+				bundle_uri);
+	}
+
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-- 
2.36.0.rc2.902.g60576bbc845

