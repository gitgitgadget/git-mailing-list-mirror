Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D8C35246
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D140F214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW8I0OcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAaUQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37991 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so10150739wrh.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=SW8I0OcFZ/dg2WiYFfAyNraCKFLOBRBwKD7k7DIRwpAby8/DeqUk1+muB1Ox25mHjq
         Qf/pB/GGxoAMRgZXgGmJAs3v53UcLg7a76frjk83AIAyVLIz9ujNAZUN95/jxpzvlv5n
         6hjNVdpqup7x9kUKc2KRVKnrRO5qwXnbI0Z7JjXLB1yAytRliDLTZbkJBkvxVlpe9fqa
         Rzazyi2tATFDyYhfb/TRM/LWecVf9A+wSOrovul8Gxtfn1S6IEaz5K6yOk8v5GWOd0im
         h8ZVPAz7WOsDbRxomFaG3RABDwusy/CGAxIhFWTzBj5cml5ySFl9CoH7AfWCtDZbWa8q
         uVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=HTV3iOP+AbfPLpV0GWNi/qTuNNnj+FgxzZeGt/O9BqHDPUhZ3jfKPBzoEdb/v4o6J4
         Ag9x84BEC83LSwvXnLCU1w0kisZfW4eM5WwC+dKtPUVTzbNqLaiMcuzv/2/irMIwrKpN
         +e39ZkDljfWcxLFogRJCxLgxQUz5F824ZovIWVteXPoRMk1dp8FcTYCT1EPdW4zBhiPp
         mBXQCKaep2pn9DMZ559Lo0d7DnGLUhJHFDRbzhe4nxEVPc5F8Ef5nC67Z+nttK8fQFoh
         qebBESaUcGjEvVDXMZwynx7rU6a6SPJoPW7c97EDHWkrf6KsWlwEysoV1xS2PBsiRoBb
         b5Yw==
X-Gm-Message-State: APjAAAWnsVB0Cy59BPb7tJjsklpB3fz4uSKS9+wbhMTMctFJpRUUv+yJ
        4CfyLa5RFlr4ABz1qdpB8huCXLwM
X-Google-Smtp-Source: APXvYqx2xjEFdtC4yaqWoWgy5g7aM8nAkxkD5yK8VFbSaC4XiIW9/oAnpP3MDGI32FIjm+TA2oNhSQ==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr104091wro.421.1580501779443;
        Fri, 31 Jan 2020 12:16:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm13349879wru.6.2020.01.31.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:18 -0800 (PST)
Message-Id: <4991a51f6d5d840eaa3bb830e68f1530c2ee08e4.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:04 +0000
Subject: [PATCH v4 04/15] clone: fix --sparse option with URLs
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

