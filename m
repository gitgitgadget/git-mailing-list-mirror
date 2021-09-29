Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B0C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2E60EFD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbhI2B4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhI2B4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:46 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD1C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d18so1081423iof.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=33mnRJBc90bs/Pe9PpeTX4YZQHUfSNkoVR0bzvGx7X0=;
        b=KCN570zU+ATJO6b7x69sMBr/vx+UCQuLGaCZH8CYfW9/G65s5wW6KiLkKX4Kzh0NcK
         hPOq42j8J2lkSiCul5rj4sxoyF353U/bFHtXOHTx+7jlUox6kah6hiLsInBMohRk7F1r
         xi2z0fpKMxeX3wM6vnVtJCCPnnXwHRoerTNorhjSPduNL40buc+oWgWsaxrjAx7TJjaj
         Zkg24VhUcX9Fy1Ib3nNFLfpSSL9HYc3QDoVBZ169D/wTn7FIBxucMb5ITkIru93qvoFQ
         e9WxYRRskFoIz1il+fw07LNzlgWXHimR9Wk379beNZXxBMiC3Om1Bm+DEZfhiWTfruTf
         M4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33mnRJBc90bs/Pe9PpeTX4YZQHUfSNkoVR0bzvGx7X0=;
        b=Z2PwhwFpq2X5slCxSQmd2Qwp2ItjmOd7Sxp7UgSpbVmRSGklis/KsrdNZFk4iS8YcG
         l9VxPqzflG9Jj0Il8kiN6U3Z0J6uyXmcJRIUNH3VZ2m7iQwFkm9rsDRgfRcM9m5jwrQE
         WgNDBXpD88OcDRGxmU8wfRfn/jv76idLVNFJOoNl+opZGO9cvdIUD+5eNspdvKUpPvXu
         4iRT4nm6Uq/8wMwtWLoDl57gYtGbMsJW1YsowosMeHtc+ILU2uTaZ8i4zppp/n7aj8av
         Oxg3daOcFOSlOzrW2V6JE+1E7l82PSgAEEFbQgVmrO3KOX77x+DR74fxKEm4eoCQc2+j
         +ZSA==
X-Gm-Message-State: AOAM530zWrdstjOBVdZblLTYxBAEm3pcIApz4rxdD1odV465s9uuYXIT
        V0V0WbrJOdn89v4/if5xRf7vfrQPsiwtZA==
X-Google-Smtp-Source: ABdhPJy7gwEoxzEONyJ8JmdfXmCM2RkGYqbzF6JHGTmm28bO3VTHATtkI14v8DaAKvLgC8hUKQkURg==
X-Received: by 2002:a6b:d209:: with SMTP id q9mr6222375iob.206.1632880505804;
        Tue, 28 Sep 2021 18:55:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13sm521935iod.36.2021.09.28.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:05 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 2/9] builtin/multi-pack-index.c: support `--stdin-packs`
 mode
Message-ID: <986ef14f2af3b137b2a67806f3bf96585dbc27f3.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
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
index 66de6efd41..03aaf8e7fb 100644
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

