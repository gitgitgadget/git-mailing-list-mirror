Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B320C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEE61163
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhHGHRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhHGHRO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D96C061798
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:16:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh14so20075079pjb.2
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=Kdt7HDsVpmS8nbeCSK5xzDIocFX5MWN1i9b0N0rHgH1oAE6/Z9M/V5h6TH+30zWCUO
         w/8g8st/D153LDOq0vWYfJJOMTFZp5+8Shqac+8DiTHhCtc1mPO/yCB//R4XP4VSd1nS
         fmaWZF9PVD40tqHIm0t3I+3Zq70ZtpbDOtwyGdHt8R65Cw5BzwV6i8zCX9dRaiFgUqIP
         45Ksn6LU5LZo/w4++xVC16Rsk8DkC60hiIV3k9OwC5As565GIuXqTolooa/N5eA68bye
         aL6sZsiGeccbPEqvpZrhtySWLhiOgIAvIyiFnFf2v6NX9QISf9ryktGr8Uv52jiY4u3p
         lu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=eYLavFfZxfv70loxOPbwwUvTyWRcgbqqxCaYvYgzi6V6OlOK0O3HBY1bDoRgMiEDlg
         m5lIsQ/v0Qy+Y8n9ERuIabGziJevpw/PCIf8wgcRhMUaa6z4P61y+LXFnKF3ji9b/Imw
         Dv1+fpOqVsEc8S53ChKCn8xAqA40RStOwlpH/ZYoH0SvA64QfBig4HIKCHtKrNus0cLj
         BZV8WzwzfPbij8fgnMFpmp63upu4TlRec8/1M3VdcyqzLD/AKAW5w0FygrBAB+7ZTaLG
         g3hE58T4RLcpCaJhrM9cOlz4CYm/h5zRi08ZTZEDvOxLokwed8RRMBpXo8Mf6NGX+0re
         GSaw==
X-Gm-Message-State: AOAM532N+YDoZikfZ7jZzzCE/1x+P5VO/wd6ZYXC71+vjJzE4nSmJmTi
        8tgJmWO//QQAWfNa8bYUtsc=
X-Google-Smtp-Source: ABdhPJzxZ7C4iFIt2zkTHT8JfA4QdafgzKmny+WsXxBi6MmvBVeoFGWRrdIWuUopEf0qQijx5XDDcA==
X-Received: by 2002:a63:bd41:: with SMTP id d1mr201072pgp.306.1628320617183;
        Sat, 07 Aug 2021 00:16:57 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:16:56 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 1/8] submodule--helper: add options for compute_submodule_clone_url()
Date:   Sat,  7 Aug 2021 12:46:06 +0530
Message-Id: <20210807071613.99610-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's modify the interface to `compute_submodule_clone_url()` function
by adding two more arguments, so that we can reuse this in various parts
of `submodule--helper.c` that follow a common pattern, which is--read
the remote url configuration of the superproject and then call
`relative_url()`.

This function is nearly identical to `resolve_relative_url()`, the only
difference being the extra warning message. We can add a quiet flag to
it, to suppress that warning when not needed, and then refactor
`resolve_relative_url()` by using this function, something we will do in
the next patch.

Having this functionality factored out will be useful for converting the
rest of `submodule add` in subsequent patches.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6891480013..2d2d8ac637 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,7 +590,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static char *compute_submodule_clone_url(const char *rel_url)
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *relurl;
 	char *remote = get_default_remote();
@@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (git_config_get_string(remotesb.buf, &remoteurl)) {
-		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
 		remoteurl = xgetcwd();
 	}
-	relurl = relative_url(remoteurl, rel_url, NULL);
+	relurl = relative_url(remoteurl, rel_url, up_path);
 
 	free(remote);
 	free(remoteurl);
@@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
-			url = compute_submodule_clone_url(oldurl);
+			url = compute_submodule_clone_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -2134,7 +2138,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
-			url = compute_submodule_clone_url(sub->url);
+			url = compute_submodule_clone_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
-- 
2.32.0

