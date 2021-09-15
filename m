Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8FC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEC061209
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhIOS0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhIOSZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:25:58 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3BC061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:39 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v16so3972734ilg.3
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XXELCdZzhg7TKGQPJIN/V2bGRaDH7o8P6ZESVXlj4Uk=;
        b=vqvhkOIYx6r2fqfJnCJqWPMqLbnBsCxMU3sZtwjDnfijO3hb701odUqnfTqVJ1Mwjv
         jc+f18cyrnCgSXyZPZtTy1WsqQ+R/H5lCWots0GNq1jg1m7q0lvN4x3tUPwrHduuPb35
         K6BHI9wMhO0PHWP6h9zr9/5aeVrKqlzPOoVVX6LUNceXQtLlCFNY7tUkLIqDFv/xnjU4
         mnfxKWkpldmiqxUF7vADl81JWEqMPUwQ5KPFXpezUT2jDmGqMOzbUU+jFxnO73mNcPfF
         RYvIyEWBl6HICmY/WoDb9vsXwtgxj1SqYDli/LdT6oGilLRAsydvaDzMPZXfP+FQf+T+
         nveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXELCdZzhg7TKGQPJIN/V2bGRaDH7o8P6ZESVXlj4Uk=;
        b=4MTNjlbnoH6jXfk8Jqzd6stQpcwd/keBokQcMtm5KfG96pckQxDWS1/G2MnaxkODch
         T2GKPk+FnkYMONxh60hE43+K2Tm8E9/gy5Eomv45PmkR6O9Oo2J1j1xEnnyr+XNQUlYk
         O9/sDxTNvFfKGatQEK6FOCstYW3Rs+PFmK36qOclTENvpfYCbTE6CHP8ZMW/1PCEiXDF
         DeS/BRoQVHqYpHonOXuJai3Xmmol2rxsAEO1Mok6+qDpAXJjNPCYE2G3toU08Px+9hF4
         73tdhvPkP3nnGIwE4+VBiM4wwfks/J5+K3q897+EcpA0GJNp34MEry29PQD9NMpxDDOr
         u/PA==
X-Gm-Message-State: AOAM533N0yVHSdg4zXThnpc/MSqyugnyz8AX2oztsAohY2zP7iv4bY2Y
        scyYjhZvJG14kwJOS0DomJHlLE7He6fwAMMw
X-Google-Smtp-Source: ABdhPJyZGFxeCgK6cn+oWNWMqFHDHuKgu+WP72IT5KAS8bu2hy4+v+pqhaNnOaCzuSvf6Szn+7WtTg==
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr1012310ilt.289.1631730279034;
        Wed, 15 Sep 2021 11:24:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b1sm210906ilf.43.2021.09.15.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:38 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 2/8] builtin/multi-pack-index.c: support `--stdin-packs`
 mode
Message-ID: <59556e554565120929549239f1aee5a76d80ac8d.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
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
 builtin/multi-pack-index.c             | 27 ++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh            | 15 ++++++++++++++
 3 files changed, 46 insertions(+)

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
index 73c0113b48..047647b5f2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -47,6 +47,7 @@ static struct opts_multi_pack_index {
 	const char *preferred_pack;
 	unsigned long batch_size;
 	unsigned flags;
+	int stdin_packs;
 } opts;
 
 static struct option common_opts[] = {
@@ -61,6 +62,16 @@ static struct option *add_common_options(struct option *prev)
 	return parse_options_concat(common_opts, prev);
 }
 
+static void read_packs_from_stdin(struct string_list *to)
+{
+	struct strbuf buf = STRBUF_INIT;
+	while (strbuf_getline(&buf, stdin) != EOF)
+		string_list_append(to, buf.buf);
+	string_list_sort(to);
+
+	strbuf_release(&buf);
+}
+
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options;
@@ -70,6 +81,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
+			 N_("write multi-pack index containing only given indexes")),
 		OPT_END(),
 	};
 
@@ -86,6 +99,20 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 
 	FREE_AND_NULL(options);
 
+	if (opts.stdin_packs) {
+		struct string_list packs = STRING_LIST_INIT_DUP;
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

