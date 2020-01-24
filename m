Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A4C35243
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDED2081E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVD/fCNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgAXVTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52818 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAXVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so817170wmc.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=gVD/fCNJxOsJ0IBPwchJLsTB3HRiAUcUptXt+1Py+yk8I1zBehgUrYJZqV938qPKms
         lcvyNABAEY/bqL/+ZajmNFGp+vyr9+RnxSvnUCOsdVEV7orXb8ml9IwEo6euAo0A7gYM
         mxYXPJDPXbkv8kBoJ0gawnOjWIRsaCZqGZjiLI9QksTauL/cnNWkx04CvdXdkfNf7R/z
         9TbDzx8T1du+anciNYHGNQnvEhhzbOHkR61jv5iJ54ukAwG29ltFIBLvwsHW3vugrdW7
         VRZPuAVTbyMEnVo/jFd6Cu0EKIq9PbeKb4usOH74ak+MY1/qSkb1iBY7rjlmLgubLliM
         c3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=PQXjNj00j11KeMq8hifZ13yenZsfpUw+1SYpjrErgx/oXwfxie3McfyH9L/CnAyrMa
         9cTQg8Dp4tbmXlHjxb6TIkxpWYAFDsmU+z63gA5y9Pk/zRuh2+2LZlL2HgikYwDFm3w9
         UxRl8urflU43Zj00ci1AQlxwwDFEnqbGZgpgDvU5NM6jTlpGdRPmJRk/W6Uitc+MnvVA
         xOGWkSuGyMUrxaU60b4uyANAKWJ1DEhnO0hMdRiun2dQR4iNeThxlln7C2aMDrYuP90+
         EaR8TQ4OJhenOh7+y2yp7uVZX44oYlfM248FIms+HOMEzDwQSQ35CUS/TyJCsrEL14L6
         Jahw==
X-Gm-Message-State: APjAAAVlcW/4wLEUHbVdFzgabasAryf7PiAsE7YpAJJ4ggmXyu7K8Dyd
        iiWvqNm9cV8FxX2zI7YoTNP6J/ll
X-Google-Smtp-Source: APXvYqymAEvHfEjRc1NPc3TK764+pK/Py0NkjBjC5vaY8psNR8SQe4/E86NxpWHItNjChMpo9yRnbw==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr941753wme.113.1579900786681;
        Fri, 24 Jan 2020 13:19:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm7866264wmj.38.2020.01.24.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:46 -0800 (PST)
Message-Id: <4991a51f6d5d840eaa3bb830e68f1530c2ee08e4.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:34 +0000
Subject: [PATCH v2 04/12] clone: fix --sparse option with URLs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The --sparse option was added to the clone builtin in d89f09c (clone:
add --sparse mode, 2019-11-21) and was tested with a local path clone
in t1091-sparse-checkout-builtin.sh. However, due to a difference in
how local paths are handled versus URLs, this mechanism does not work
with URLs.

Modify the test to use a "file://" URL, which would output this error
before the code change:

  Cloning into 'clone'...
  fatal: cannot change to 'file://.../repo': No such file or directory
  error: failed to initialize sparse-checkout

These errors are due to using a "-C <path>" option to call 'git -C
<path> sparse-checkout init' but the URL is being given instead of
the target directory.

Update that target directory to evaluate this correctly. I have also
manually tested that https:// URLs are handled correctly as well.

Acked-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/clone.c                    | 2 +-
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4348d962c9..2caefc44fb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,7 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
 	remote = remote_get(option_origin);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 43d1f7520c..cf4a595c86 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -90,7 +90,7 @@ test_expect_success 'init with existing sparse-checkout' '
 '
 
 test_expect_success 'clone --sparse' '
-	git clone --sparse repo clone &&
+	git clone --sparse "file://$(pwd)/repo" clone &&
 	git -C clone sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
 	/*
-- 
gitgitgadget

