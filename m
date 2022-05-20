Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B05C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiETSmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353041AbiETSlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D913E5D0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k26so4985109wms.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OB47nvBfn10GC/3wzBItSawBlUfHGeW6WiLWeNJnb/w=;
        b=jC3Xw6k69Dm+Pppot01ftsrfggYFIpbi0nRdAu606HkTPP2M7/Ex1IXAxesWoF8tJq
         w+1HBCetL5Mr++sFxrkfzbbPUzndBf1gyvo+8OVXUGlhruWZ9UElwRELdzlJeivxOZ5Q
         faHqSKjvL0c3iWJRwLw3pMdr41p0ovoaiMKzOiAuDwElx0HrHp1R/595WMrSDIP70fSi
         j89QnBLLBqCbIW0rAA51r26DHSuZ/bZ4MohHrNI6qPjbnyYqB+f2CHOuQAuNMYrC4gNx
         2lb2kG1vimApzkQ674ibjTK5pge1+Dn+iMJabNxqmAV5SxillrJjXOOVvg92INZZ1jQj
         gvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OB47nvBfn10GC/3wzBItSawBlUfHGeW6WiLWeNJnb/w=;
        b=VFLK4Jgrpzd9GeWFIMn0rD74a+7tZz8KuePtOQEl3r7kxqJwGjTztkSb2W/L5Q3j96
         cQmoH9palYpu6vmuqryosmXGaVyKC88XzpIIwdh9jrC6+kztAmao6fQQmWQtQi3kTFGG
         YHCniOZe8rZEyzl/ziil8hycbnAae0BAZLVmIqVMgtxORZUMHtWIr5F1UFYTRQMSS+i+
         MOKtvmmqvopP0Z8Y9DxQ9IYt8hNiOgDeRU1UyXsEXxLWF0Oh9wVDZ41dyYbEfNL/QmNo
         P2wBiZgV+cXd4KLjWbeJM5WQivp4IWNZC5rQ1M9+XAL+BSGnh7lwsqNmBXw1Vkq3WhjY
         gTuA==
X-Gm-Message-State: AOAM532HGIjEcV4rT45YuIITfPAhhr6cSETBGAciCWYSjdQh5q62Xizg
        /u0amMMXZVdjK3OQYlmNIcTFudy7fO4=
X-Google-Smtp-Source: ABdhPJzVmf6qK8ocPqvL5adSpC8JVSF4louhPryL43N3K3Uell4xRMJrmHLVMB1qwZXwTAHUJ96FSQ==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr9340576wmj.138.1653072070295;
        Fri, 20 May 2022 11:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a7bc7cd000000b0039456fb80b3sm2511755wmk.43.2022.05.20.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:09 -0700 (PDT)
Message-Id: <a0cf2c0977b8a73d518cd5c04e3b1e765b4ecc89.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:41 +0000
Subject: [PATCH 23/24] clone: unbundle the advertised bundles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change introduced the transport methods to acquire a bundle
list from the 'bundle-uri' protocol v2 verb, when advertised _and_ when
the client has chosen to enable the feature.

Teach Git to download and unbundle the data advertised by those bundles
during 'git clone'.

Also, since the --bundle-uri option exists, we do not want to mix the
advertised bundles with the user-specified bundles.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ca2291552f7..cbe392cf60f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1263,11 +1263,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
-	/*
-	 * Populate transport->got_remote_bundle_uri and
-	 * transport->bundle_uri. We might get nothing.
-	 */
-	transport_get_remote_bundle_uri(transport, 1);
+	if (!bundle_uri) {
+		/*
+		* Populate transport->got_remote_bundle_uri and
+		* transport->bundle_uri. We might get nothing.
+		*/
+		transport_get_remote_bundle_uri(transport, 1);
+
+		if (transport->bundles) {
+			/* At this point, we need the_repository to match the cloned repo. */
+			repo_init(the_repository, git_dir, work_tree);
+			if (fetch_bundle_list(the_repository,
+					      remote->url[0],
+					      transport->bundles))
+				warning(_("failed to fetch advertised bundles"));
+		}
+	}
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
-- 
gitgitgadget

