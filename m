Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C7C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9696113E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 03:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhIKDds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 23:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIKDdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 23:33:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC55C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so4951997iox.0
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nkb7fgnuRqEbS9laTpFPUA/upPT5bq5QrdPBIZQDpqM=;
        b=STb2l4Y/GVrqpwJ8181Ox5fBnGy7vbU3o0TRevJhJMZtTzrDVlA3Td40TAto7e7OZS
         R2hl4ZJOgNV8eBEm8glE2pDp8uncHfJvpLB1CB1intiyhxUfTF/vgVARY0+RxNekP9i+
         7JdnCUhZOuVFkmHfsQm1N0boikfUU5/ZcvQD5wxz04nVP7gFVQmQ4kVQ8UvRZGfbTT3K
         Ww23LZY5+CVOlZyqUIwguxr97ogxid3v11foNuiVwd67T0alRCwmYqqmtnPpWPk2534I
         DKIeoeiR3Mz7C4Sfs7rFW4oOhpKjdNJBAbdMpVaVOv+EiEiPQhefzPUBq+IqjfRrHSaM
         2OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nkb7fgnuRqEbS9laTpFPUA/upPT5bq5QrdPBIZQDpqM=;
        b=ZE+vGVvnLBhp+A6SSx9tV9YcIIVW4FisL3JWDvK3awRG7E2HPTABaVBu3UqOw/IhdR
         S64C0hFo60tVKWyRBba6dai4PR+L3QkKy9UG18I+7r5wezlxqN03poJJt9BQSJKFgPW+
         Szesvz2KCbh9likPI5rEqesR6wDH/vhdCYZ2PjY/HHGkguvhbn0lRmtfUZ9BB5UV4gmZ
         TgVakzQZFHf2ZBRmODj33I/O4hLVGZmGIQ3hT8nB9FyrE9tn8X2upeSk9pD+u1/r8vVn
         9Hl6yvX+fof7t6Y7+oUi8ff0+67jq5dUpVQ0X0dOhdF6dYmwSSOn8CNb/87exwPLL5p8
         gVKQ==
X-Gm-Message-State: AOAM531dnD6gg25itFbBtXjEF3LXYfU7RhzYXSaTZl9SvZ2geIKrGaec
        CgnjvzcPf+9wqmZ8kRpfEf7VaVlJU/tgeH52
X-Google-Smtp-Source: ABdhPJzkop/xs62Is5IRnVrzjXL5n9+/wDNc2CYwxm2mCFQWp0SZVmIOT5vQ6LJogPH+2zlkONi9jg==
X-Received: by 2002:a02:3b15:: with SMTP id c21mr811313jaa.54.1631331152724;
        Fri, 10 Sep 2021 20:32:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10sm298280ilj.71.2021.09.10.20.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 20:32:32 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:32:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
Message-ID: <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To power a new `--write-midx` mode, `git repack` will want to write a
multi-pack index containing a certain set of packs in the repository.

This new option will be used by `git repack` to write a MIDX which
contains only the packs which will survive after the repack (that is, it
will exclude any packs which are about to be deleted).

This patch effectively exposes the function implemented in the previous
commit via the `git multi-pack-index` builtin. An alternative approach
would have been to call that function from the `git repack` builtin
directly, but this introduces awkward problems around closing and
reopening the object store, so the MIDX will be written out-of-process.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  4 ++++
 builtin/multi-pack-index.c             | 26 ++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh            | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index a9df3dbd32..009c989ef8 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -45,6 +45,10 @@ write::
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
+
+	--stdin-packs::
+		Write a multi-pack index containing only the set of
+		line-delimited pack index basenames provided over stdin.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 73c0113b48..77488b6b7b 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -47,6 +47,7 @@ static struct opts_multi_pack_index {
 	const char *preferred_pack;
 	unsigned long batch_size;
 	unsigned flags;
+	int stdin_packs;
 } opts;
 
 static struct option common_opts[] = {
@@ -61,6 +62,15 @@ static struct option *add_common_options(struct option *prev)
 	return parse_options_concat(common_opts, prev);
 }
 
+static void read_packs_from_stdin(struct string_list *to)
+{
+	struct strbuf buf = STRBUF_INIT;
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		string_list_append(to, strbuf_detach(&buf, NULL));
+	}
+	string_list_sort(to);
+}
+
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options;
@@ -70,6 +80,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
+			 N_("write multi-pack index containing only given indexes")),
 		OPT_END(),
 	};
 
@@ -86,6 +98,20 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	if (opts.stdin_packs) {
+		struct string_list packs = STRING_LIST_INIT_NODUP;
+		int ret;
+
+		read_packs_from_stdin(&packs);
+
+		ret = write_midx_file_only(opts.object_dir, &packs,
+					   opts.preferred_pack, opts.flags);
+
+		string_list_clear(&packs, 0);
+
+		return ret;
+
+	}
 	return write_midx_file(opts.object_dir, opts.preferred_pack,
 			       opts.flags);
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bb04f0f23b..385f0a3efd 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -168,6 +168,21 @@ test_expect_success 'write midx with two packs' '
 
 compare_results_with_midx "two packs"
 
+test_expect_success 'write midx with --stdin-packs' '
+	rm -fr $objdir/pack/multi-pack-index &&
+
+	idx="$(find $objdir/pack -name "test-2-*.idx")" &&
+	basename "$idx" >in &&
+
+	git multi-pack-index write --stdin-packs <in &&
+
+	test-tool read-midx $objdir | grep "\.idx$" >packs &&
+
+	test_cmp packs in
+'
+
+compare_results_with_midx "mixed mode (one pack + extra)"
+
 test_expect_success 'write progress off for redirected stderr' '
 	git multi-pack-index --object-dir=$objdir write 2>err &&
 	test_line_count = 0 err
-- 
2.33.0.96.g73915697e6

