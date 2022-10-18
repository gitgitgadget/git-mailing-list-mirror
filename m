Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550D7C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 02:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRCpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRCp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 22:45:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F73E895F7
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:45:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 187so10716898iov.10
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xt+MuwpV2Qe6ubWHYY2VE02jT9QKOYENPA0Di7DhIrA=;
        b=AAS7QDIsJCvcI3X13ZDl6HFpCd3d7N36xPGsHFZAhf4qrnGYngcmQsmwlzvvS9LTr3
         dJwE1Y4TBCOgzk7Ti2QRy+WefgRTFhkorNoZYonGJnjaTAPtZGn22YGCVW32N51QL8Xw
         xfRaKrlRkFOy9GLuF0MpPd8ab3QFbIMnvG7CeN0ka0sJsJDmDMHjF6gBe081eJUzWizb
         eF+NR+8SwBDY7zPLYgOsdfiLi92xXoSawCQh3o19RcFW+6iTAlkaZDL2ulY3au4BNPki
         CvZAQV8njamyTk1x6/GlVGit3HPg1vZ4wuH449b2qJHxSah47y1et+Pcxu/7bf5xABCX
         Du6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt+MuwpV2Qe6ubWHYY2VE02jT9QKOYENPA0Di7DhIrA=;
        b=oSzQjmHATmmT1RqBkXdmW+45p2/duPSR5OoRJDQfx53kGj7qVCMCQ+DZ+ApqF5lyAU
         QmAorKsX4YwfkoLdph3h3vYj+eW9x931PoJiDVkZWG5VSlfGykVXug8WdePu4JenfyHE
         rmNNmNJat1GRHg90Y+VqZguLOQdAvGgtnD68n9WQIi8noDIxpmAliAS5li8e7jfZUH8C
         I4I2hIos0Cdp9ELvZPkAf7+SN+3dkKbt3FZifHBJ4orZ0518bF4dhn8WlHdKsltbldB+
         BwZJO9xVVjpiW6R7jzGKuyA9tAbsQnXkSnsJXwF+z5jLRupdbgaCoddvh5JhzzAbKIEH
         fdAw==
X-Gm-Message-State: ACrzQf3mSKkeX/7JiH5hf7ZuWzxVlnKFM1XI9f16ZpcqSlLApCo9xijT
        5KRyYQfWWP/pgFzrtGnMWSQ179HHJY10uSF7
X-Google-Smtp-Source: AMsMyM7qNbQkrFsiedM3EoCsZC4sZzTxfqfTMtuRFCfP7odTIBrCZ47KDVqxJkhfqoqXcJD5xjCNuw==
X-Received: by 2002:a05:6602:2b92:b0:6a8:bdb5:a5d5 with SMTP id r18-20020a0566022b9200b006a8bdb5a5d5mr732938iov.85.1666061113952;
        Mon, 17 Oct 2022 19:45:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13-20020a02b10d000000b0036358f41ebdsm571435jah.132.2022.10.17.19.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:45:13 -0700 (PDT)
Date:   Mon, 17 Oct 2022 22:45:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, peff@peff.net,
        avarab@gmail.com
Subject: [PATCH v2] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <1e0ef7ee7ff5feb323c77e594cd65433fb1d99f7.1666061096.git.me@ttaylorr.com>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write a MIDX bitmap after repacking, it is possible that the
repository would be left in a state with both pack- and multi-pack
reachability bitmaps.

This can occur, for instance, if a pack that was kept (either by having
a .keep file, or during a geometric repack in which it is not rolled up)
has a bitmap file, and the repack wrote a multi-pack index and bitmap.

When loading a reachability bitmap for the repository, the multi-pack
one is always preferred, so the pack-based one is redundant. Let's
remove it unconditionally, even if '-d' isn't passed, since there is no
practical reason to keep both around. The patch below does just that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
A small reroll to address a pair of comments from Peff.

Range-diff against v1:
1:  393fd4c6db ! 1:  1e0ef7ee7f builtin/repack.c: remove redundant pack-based bitmaps
    @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *inclu
     +		strbuf_addstr(&path, ".bitmap");
     +
     +		if (unlink(path.buf) && errno != ENOENT)
    -+			die_errno(_("could not remove stale bitmap: %s"),
    -+				  path.buf);
    ++			warning_errno(_("could not remove stale bitmap: %s"),
    ++				      path.buf);
     +
     +		strbuf_setlen(&path, packdir_len);
     +	}
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
      						show_progress, write_bitmaps > 0);

    -+		if (ret) {
    -+			string_list_clear(&include, 0);
    -+			return ret;
    -+		}
    -+
    -+		if (write_bitmaps)
    ++		if (!ret && write_bitmaps)
     +			remove_redundant_bitmaps(&include, packdir);
     +
      		string_list_clear(&include, 0);
    --
    --		if (ret)
    --			return ret;
    - 	}

    - 	reprepare_packed_git(the_repository);
    + 		if (ret)

      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success '--write-midx -b packs non-kept objects' '

 builtin/repack.c  | 32 ++++++++++++++++++++++++++++++++
 t/t7700-repack.sh | 21 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..c2d2e52bd4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -661,6 +661,35 @@ static int write_midx_included_packs(struct string_list *include,
 	return finish_command(&cmd);
 }

+static void remove_redundant_bitmaps(struct string_list *include,
+				     const char *packdir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list_item *item;
+	size_t packdir_len;
+
+	strbuf_addstr(&path, packdir);
+	strbuf_addch(&path, '/');
+	packdir_len = path.len;
+
+	/*
+	 * Remove any pack bitmaps corresponding to packs which are now
+	 * included in the MIDX.
+	 */
+	for_each_string_list_item(item, include) {
+		strbuf_addstr(&path, item->string);
+		strbuf_strip_suffix(&path, ".idx");
+		strbuf_addstr(&path, ".bitmap");
+
+		if (unlink(path.buf) && errno != ENOENT)
+			warning_errno(_("could not remove stale bitmap: %s"),
+				      path.buf);
+
+		strbuf_setlen(&path, packdir_len);
+	}
+	strbuf_release(&path);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *pack_prefix,
 			    struct string_list *names,
@@ -1059,6 +1088,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
 						show_progress, write_bitmaps > 0);

+		if (!ret && write_bitmaps)
+			remove_redundant_bitmaps(&include, packdir);
+
 		string_list_clear(&include, 0);

 		if (ret)
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..2d0e9448dd 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -426,6 +426,27 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 	)
 '

+test_expect_success '--write-midx removes stale pack-based bitmaps' '
+       rm -fr repo &&
+       git init repo &&
+       test_when_finished "rm -fr repo" &&
+       (
+		cd repo &&
+		test_commit base &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Ab &&
+
+		pack_bitmap=$(ls $objdir/pack/pack-*.bitmap) &&
+		test_path_is_file "$pack_bitmap" &&
+
+		test_commit tip &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -bm &&
+
+		test_path_is_file $midx &&
+		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
+		test_path_is_missing $pack_bitmap
+       )
+'
+
 test_expect_success TTY '--quiet disables progress' '
 	test_terminal env GIT_PROGRESS_DELAY=0 \
 		git -C midx repack -ad --quiet --write-midx 2>stderr &&
--
2.38.0.16.g393fd4c6db
