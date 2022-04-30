Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A889C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbiD3NXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiD3NXW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 09:23:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A13BA8895
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 06:20:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso6161837wms.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1l3NyiCRdKfXubg1c8rqAXmITynAZwBmwYfMEZ7z1jg=;
        b=hPqXC9JQnnaSu3qSz3aDJgZAlv5VRgJbEDuLEjpuD6gYeNEpB7VaDU8PntU+gOGvHM
         yGtkCzjQlqEWh3o12hn0UY0b1LnyI5l8Syza+QqeOCCsPAGMVt3eZDJWt1D010qmkZhJ
         NO4u/OU0D9UA/FwxI9h5r5FA+Wl+kiiAjbmJ3DWEARVZWzlaMivAwWBnnfMvVWx/JKyH
         dV3SeJWi6BKwHgvudd+b0KPLUOiKcEzo4ZmqwsxayBjrN/QXHFTOFzsPcMxGNcf4mZYw
         0tnjglBhBMbwG4iDWQMQTixQD0t9zJ0Xz4rg9jNwdZqO21M91784DkyUng/mNcDp+9Q5
         IVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1l3NyiCRdKfXubg1c8rqAXmITynAZwBmwYfMEZ7z1jg=;
        b=WhL6EmsI6IyN1XJ1+3kTGQeX7ifnZIur0jWoY2bGuLit78NLplM3G7++YxLwO+nIKX
         sxGsuftPQ+Yh0BbMV4Kf5WSujs/DHtG+sGeRZ4TMWxqXiTQ/OlCJR07/SZPpqqQu0ZuH
         uY89DRHDbFsJnXnrWam1N7tBikjmzIVTWQKp8YKdQN0iZ85JLs0vaZtnua/ay54vK63n
         6RWX05Mkt6kLjbOUXz2uNXjRJGNV6Oq5DISp8bbBnU3YkZqEjleQLoR4Bx2kP/U5ZN6b
         qM56ubTxq2n4QaVK5wOct2Skuc9pX6hYTxjuiOdf4MtF26F11aFnSk+BnbTaxMeiEHSh
         RMeg==
X-Gm-Message-State: AOAM532s8YCUo7T0KqIdhRIXkN+pb6h3QT3ugDVdJP8pg8YJuawASZA8
        /hCfk5m3PYITh2Ia6xhrtT2w06PxZpU=
X-Google-Smtp-Source: ABdhPJyBR0Gj7T1Ak1G3olwNSVjM3MNCaQV25AM8yCKojUmuM63KZUsSr8Clzqr+xHqjrLDzUBcPcQ==
X-Received: by 2002:a7b:ce0a:0:b0:394:41e:2517 with SMTP id m10-20020a7bce0a000000b00394041e2517mr7585973wmc.135.1651324799259;
        Sat, 30 Apr 2022 06:19:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020adfca08000000b0020c5253d911sm2078085wrh.93.2022.04.30.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:19:57 -0700 (PDT)
Message-Id: <pull.1227.git.1651324796892.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 Apr 2022 13:19:56 +0000
Subject: [PATCH] builtin/remote.c: teach `-v` to list filters for promisor
 remotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

`git remote -v` (`--verbose`) lists down the names of remotes along with
their urls. It would be beneficial for users to also specify the filter
types for promisor remotes. Something like this -

	origin	remote-url (fetch) [blob:none]
	origin	remote-url (push)

Teach `git remote -v` to also specify the filters for promisor remotes.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    builtin/remote.c: teach -v to list filters for promisor remotes
    
    Fixes #1211 [1]
    
    [1] https://github.com/gitgitgadget/git/issues/1211

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1227%2FAbhra303%2Fpromisor_remote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1227/Abhra303/promisor_remote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1227

 builtin/remote.c         |  8 ++++++++
 t/t5616-partial-clone.sh | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5f4cde9d784..95e28b534f4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1190,7 +1190,15 @@ static int get_one_entry(struct remote *remote, void *priv)
 	int i, url_nr;
 
 	if (remote->url_nr > 0) {
+		struct strbuf promisor_config = STRBUF_INIT;
+		const char *partial_clone_filter = NULL;
+
+		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
 		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
+			strbuf_addf(&url_buf, " [%s]", partial_clone_filter);
+
+		strbuf_release(&promisor_config);
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	} else
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 4a3778d04a8..bf8f3644d3c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,6 +49,17 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local remote.origin.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'filters for promisor remotes is listed by git remote -v' '
+	git clone --filter=blob:none "file://$(pwd)/srv.bare" pc2 &&
+	git -C pc2 remote -v >out &&
+	grep "[blob:none]" out &&
+
+	git -C pc2 config remote.origin.partialCloneFilter object:type=commit &&
+	git -C pc2 remote -v >out &&
+	grep "[object:type=commit]" out &&
+	rm -rf pc2
+'
+
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
