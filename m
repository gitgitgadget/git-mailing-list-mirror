Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0784DC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiHCU5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiHCU5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 16:57:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C664201AC
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 13:57:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s186-20020a255ec3000000b0067162ed1bd3so14186795ybb.8
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=7izbWjn+uPW+NFfolN43cdTPVVisHDTVwliVcGQdWcA=;
        b=HEDdt2B7PrPe8XK+RqsBC3kHN9bjkYVQZNy1B9yaOryrDozNbWgpaRR1uBaPlPi6Ix
         KfrPr649BYE5J7hj+jKCMB+0LWINYQkYkSOJWvv2BI7ntAY56cFx621Qo+UY2ZnEoA+O
         66ul193byWlg9l8b0S/yseWang1FIMwv+mn22GUUuaEjQNY/2liGifIosZWexB8y2xjc
         SA9PiX20c/3wnKfI93lzyeke/n7aPO1l37Pho5rkqOBBNDeZ30B5JpzVxlxrswa+l8bZ
         qtXS+DweFNxNXjOhQXg7GAI6PPRtDMdENoGGtCuaElISg6PoTvdK5cMIgEr3Dmptssut
         PLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=7izbWjn+uPW+NFfolN43cdTPVVisHDTVwliVcGQdWcA=;
        b=PREGg7yF5UH7+HTqZU7W1lFE8Od8++M/kMNADB3ReSxxaGnEQX9Q0JyxF3irbGE3kW
         H6qsBdy/6v5xlSWmAuDUtf4slk/zhBiF87vLjKA3kxGHhncRYRp7fF/ItkQYv+5GD13Y
         pMFhYvFE7pxY5d7DDKbvW7Y1bLQlscxesOva/giQgIPR5W3GQKMI3lLbiIXwxArh2NuU
         Q7hJnZ+MDrIpEamh+I+4n5qxSRFKoYVNPM6I1sLPyBVqlPMTtAtkk20jATeB+dlJvMCg
         nncgbPVvrDgA5uK5QcvhiVhBaAQNnLv+h8rdsc/Y89PiLWm3Snfmez618GTqE3s494wU
         GYAg==
X-Gm-Message-State: ACgBeo1htawx5AfBDX55386zC+OAXTz9oz6CNrY40YpZIBacdkLZMyvb
        WYwal/rgohBDIPLAhB1WyV7LFzjM5Sxbg9bPouvdwXBTV+qXXIkwq/9Ixvk/KqnH8niWHqxxM+F
        G4X+6bT3+DBtXxSX1KitVk5NiP1KrSrvutRBKa8Zm8RpsxDDeC8lzEl+eZFa2JUMZiRzNIH6hig
        ==
X-Google-Smtp-Source: AA6agR6MlMJLKs8jk7JBObbY88kS7c8rBjljc5LU67kuMie70/Ov2Aa/iL+LpCdQ6GMCjB656GfzZX89XU03Itvhr4U=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:b3d5:c5f6:e39a:a9e2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:e212:0:b0:670:80bb:ce9e with SMTP
 id h18-20020a25e212000000b0067080bbce9emr19661967ybe.603.1659560254876; Wed,
 03 Aug 2022 13:57:34 -0700 (PDT)
Date:   Wed,  3 Aug 2022 13:57:21 -0700
In-Reply-To: <20220803205721.3686361-1-emilyshaffer@google.com>
Message-Id: <20220803205721.3686361-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220803205721.3686361-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 2/2] config: let feature.experimental imply gc.cruftPacks=true
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are interested in exploring whether gc.cruftPacks=true should become
the default value; to determine whether it is safe to do so, let's
encourage more users to try it out. Users who have set
feature.experimental=true have already volunteered to try new and
possibly-breaking config changes, so let's try this new default with
that set of users.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/feature.txt |  2 ++
 builtin/gc.c                     |  6 ++++++
 t/t6500-gc.sh                    | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index cdecd04e5b..f029c422be 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,6 +14,8 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
+* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
+garbage collection.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..919cc508c5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -136,6 +136,7 @@ static int gc_config_is_timestamp_never(const char *var)
 static void gc_config(void)
 {
 	const char *value;
+	int experimental = 0;
 
 	if (!git_config_get_value("gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
@@ -148,6 +149,11 @@ static void gc_config(void)
 	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
 		prune_reflogs = 0;
 
+	/* feature.experimental implies gc.cruftPacks=true */
+	git_config_get_bool("feature.experimental", &experimental);
+	if (experimental)
+		cruft_packs = 1;
+
 	git_config_get_int("gc.aggressivewindow", &aggressive_window);
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index e4c2c3583d..4ab6750111 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -238,6 +238,41 @@ test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
 	)
 '
 
+test_expect_success 'feature.experimental=true generates a cruft pack' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+		test_commit base &&
+
+		test_commit --no-tag foo &&
+		test_commit --no-tag bar &&
+		git reset HEAD^^ &&
+
+		git -c feature.experimental=true gc &&
+
+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
+		test_path_is_file .git/objects/pack/$cruft.pack
+	)
+'
+
+test_expect_success 'feature.experimental=false allows explicit cruft packs' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+		test_commit base &&
+
+		test_commit --no-tag foo &&
+		test_commit --no-tag bar &&
+		git reset HEAD^^ &&
+
+		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
+		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
+		test_path_is_file .git/objects/pack/$cruft.pack
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.37.1.455.g008518b4e5-goog

