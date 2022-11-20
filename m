Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D4C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 07:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTHtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 02:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKTHtG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 02:49:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CBEA3400
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so8283023pjb.0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQXm5Md7ujJ8bMPOZ9+GufUc+TjEAau0XpEsGeA5GlI=;
        b=NJ3TM0cSXj2UueGRoqwL/T3TtoIb9eHEyARt4WAlcMRk7yFxrPJD58IL7dl1jipKl5
         OhnIgKX28NzlxV53ry17xK2XZGl6j81rBFa0FW32UFgCK5TPJmR+J0448kdSFnMnH+tw
         wpkIBFGgY+HZE3+VR0vWQKIxlUC3uAeCZJreM+b8qhrStgFtJ4z/T++dt8fWWA5myFFv
         D2GQCq03cyv4EG80S2xxIzz3GG7YRA+u9EGPXlSXCp7NFpGS69egzZjbWlLOb3EMyOEB
         9N6ajpn3QrCeM9BgIJci3ILeifFTxvWK415h+2Cx5WwcRJCmPOMFIi9XbD73tdJ+GKoK
         2NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQXm5Md7ujJ8bMPOZ9+GufUc+TjEAau0XpEsGeA5GlI=;
        b=0rYPncIbQ7X5jdfYnT1R57s9bfCRbIalOAxeId/Vq52829DUNp76sVMfK7BpGf6u1h
         T6/dIBkhTWqlo7PDSKTjpzFW2kqnLtmQ8Bbs/V3UFIkabUVPpCWkqWOB6e2L2+IoOHBq
         HNBnYSBD32yte7C3EGXLAq/yLo+RnUcGXyZkWDt+6Wr2G/jPazwiDBfTx7puahNdv1uz
         yUwFRb/wOcdy5Z+zuTsdjb/kcnom5G0A0HGdWhrAM3TdVD5eeDNb5ucH5ZMZYeU7fOpr
         wda3ku61VJtpqH/ToSj4pWgf22XY5DIgfDIF6IqrbJFlm9AFlAt/co+vsXmNOoLyOMjp
         0Gfw==
X-Gm-Message-State: ANoB5pnSez/aXaD5J/t8Mgw3AvYQTocJB5bb4Z9tbqlOTxV/uxyOxOny
        uBcibWQW+oQhEm0Lo5Oahpj/HyV9/mrRvJ9+
X-Google-Smtp-Source: AA0mqf7f9qwrkfRlVByiw/moztUSJzGfvuDDOd0p75jkynuHj0MiOa28yZHasfJLrB4OVMemrj/kCQ==
X-Received: by 2002:a17:902:b685:b0:186:5e2f:44b4 with SMTP id c5-20020a170902b68500b001865e2f44b4mr2160678pls.29.1668930544447;
        Sat, 19 Nov 2022 23:49:04 -0800 (PST)
Received: from HB2.. ([2409:4081:9e01:f9e1:b435:9ad:e08d:a7fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001871461688esm6988645plg.175.2022.11.19.23.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 23:49:03 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 0/2] Add mailmap mechanism in cat-file options
Date:   Sun, 20 Nov 2022 13:18:50 +0530
Message-Id: <20221120074852.121346-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.438.gd2340c8913
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Christian, Taylor and Junio for review :) I have made the
suggested in this patch series.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used by `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.

= Changes in v5

- The patch series which improves the documentation for `-s`, `--batch`,
  `--batch-check` and `--batch-command` is again part of this patch
  series with patch 3/3 squashed into patches 1/3 and 2/3 as suggested
  by Junio, Taylor and Christian. The doc patch series was perviously
  sent independently for improving the documentation of git cat-file
  options:
  https://lore.kernel.org/git/20221029092513.73982-1-siddharthasthana31@gmail.com/

- Improve the tests according to run under SHA-256 mode.

Siddharth Asthana (2):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt | 53 ++++++++++++++++++++++---------
 builtin/cat-file.c             | 27 ++++++++++++++++
 t/t4203-mailmap.sh             | 57 ++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 14 deletions(-)

Range-diff against v4:
1:  4ae3af37d2 ! 1:  0db3583535 cat-file: add mailmap support to -s option
    @@ Commit message
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
    + ## Documentation/git-cat-file.txt ##
    +@@ Documentation/git-cat-file.txt: OPTIONS
    + 
    + -s::
    + 	Instead of the content, show the object size identified by
    +-	`<object>`.
    ++	`<object>`. If used with `--use-mailmap` option, will show
    ++	the size of updated object after replacing idents using the
    ++	mailmap mechanism.
    + 
    + -e::
    + 	Exit with zero status if `<object>` exists and is a valid
    +
      ## builtin/cat-file.c ##
     @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
      
    @@ t/t4203-mailmap.sh: test_expect_success '--mailmap enables mailmap in cat-file f
     +	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	cat >expect <<-\EOF &&
    -+	209
    -+	220
    -+	EOF
    ++	git cat-file commit HEAD | wc -c >expect &&
    ++	git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
     +	git cat-file -s HEAD >actual &&
     +	git cat-file --use-mailmap -s HEAD >>actual &&
     +	test_cmp expect actual
    @@ t/t4203-mailmap.sh: test_expect_success '--mailmap enables mailmap in cat-file f
     +	Orig <orig@example.com> C O Mitter <committer@example.com>
     +	EOF
     +	git tag -a -m "annotated tag" v3 &&
    -+	cat >expect <<-\EOF &&
    -+	141
    -+	130
    -+	EOF
    ++	git cat-file tag v3 | wc -c >expect &&
    ++	git cat-file --use-mailmap tag v3 | wc -c >>expect &&
     +	git cat-file -s v3 >actual &&
     +	git cat-file --use-mailmap -s v3 >>actual &&
     +	test_cmp expect actual
2:  a692646228 < -:  ---------- cat-file: add mailmap support to --batch-check option
3:  41b4650b24 ! 2:  b8205ede7d doc/cat-file: allow --use-mailmap for --batch options
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
    -    doc/cat-file: allow --use-mailmap for --batch options
    +    cat-file: add mailmap support to --batch-check option
    +
    +    Even though the cat-file command with `--batch-check` option does not
    +    complain when `--use-mailmap` option is given, the latter option is
    +    ignored. Compute the size of the object after replacing the idents and
    +    report it instead.
    +
    +    In order to make `--batch-check` option honour the mailmap mechanism we
    +    have to read the contents of the commit/tag object.
    +
    +    There were two ways to do it:
    +
    +    1. Make two calls to `oid_object_info_extended()`. If `--use-mailmap`
    +       option is given, the first call will get us the type of the object
    +       and second call will only be made if the object type is either a
    +       commit or tag to get the contents of the object.
    +
    +    2. Make one call to `oid_object_info_extended()` to get the type of the
    +       object. Then, if the object type is either of commit or tag, make a
    +       call to `read_object_file()` to read the contents of the object.
    +
    +    I benchmarked the following command with both the above approaches and
    +    compared against the current implementation where `--use-mailmap`
    +    option is ignored:
    +
    +    `git cat-file --use-mailmap --batch-all-objects --batch-check --buffer
    +    --unordered`
    +
    +    The results can be summarized as follows:
    +                           Time (mean ± σ)
    +    default               827.7 ms ± 104.8 ms
    +    first approach        6.197 s ± 0.093 s
    +    second approach       1.975 s ± 0.217 s
    +
    +    Since, the second approach is faster than the first one, I implemented
    +    it in this patch.
     
         The command git cat-file can now use the mailmap mechanism to replace
    -    idents with their canonical versions for commit and tag objects. There
    -    are several options like `-s`, `--batch`, `--batch-check` and
    -    `--batch-command` that can be combined with `--use-mailmap`. But the
    -    documentation for `-s`, `--batch`, `--batch-check` and `--batch-command`
    -    doesn't say so. This patch fixes that documentation.
    +    idents with canonical versions for commit and tag objects. There are
    +    several options like `--batch`, `--batch-check` and `--batch-command`
    +    that can be combined with `--use-mailmap`. But the documentation for
    +    `--batch`, `--batch-check` and `--batch-command` doesn't say so. This
    +    patch fixes that documentation.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
         Helped-by: Taylor Blau <me@ttaylorr.com>
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-cat-file.txt ##
     @@ Documentation/git-cat-file.txt: OPTIONS
    - 
    - -s::
    - 	Instead of the content, show the object size identified by
    --	`<object>`.
    -+	`<object>`. If used with `--use-mailmap` option, will show
    -+	the size of updated object after replacing idents using the
    -+	mailmap mechanism.
    - 
    - -e::
    - 	Exit with zero status if `<object>` exists and is a valid
    -@@ Documentation/git-cat-file.txt: OPTIONS
      --batch::
      --batch=<format>::
      	Print object information and contents for each object provided
    @@ Documentation/git-cat-file.txt: OPTIONS
      +
      `--batch-command` recognizes the following commands:
      +
    +
    + ## builtin/cat-file.c ##
    +@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    + 	if (!data->skip_object_info) {
    + 		int ret;
    + 
    ++		if (use_mailmap)
    ++			data->info.typep = &data->type;
    ++
    + 		if (pack)
    + 			ret = packed_object_info(the_repository, pack, offset,
    + 						 &data->info);
    +@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
    + 			fflush(stdout);
    + 			return;
    + 		}
    ++
    ++		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
    ++			size_t s = data->size;
    ++			char *buf = NULL;
    ++
    ++			buf = read_object_file(&data->oid, &data->type, &data->size);
    ++			buf = replace_idents_using_mailmap(buf, &s);
    ++			data->size = cast_size_t_to_ulong(s);
    ++
    ++			free(buf);
    ++		}
    + 	}
    + 
    + 	strbuf_reset(scratch);
    +
    + ## t/t4203-mailmap.sh ##
    +@@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
    ++	test_when_finished "rm .mailmap" &&
    ++	cat >.mailmap <<-\EOF &&
    ++	C O Mitter <committer@example.com> Orig <orig@example.com>
    ++	EOF
    ++	commit_size=`git cat-file commit HEAD | wc -c` &&
    ++	commit_sha=`git log --pretty=format:'%H' -n 1` &&
    ++	echo "$commit_sha commit $commit_size" >expect &&
    ++	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
    ++	echo "$commit_sha commit $commit_size" >>expect &&
    ++	echo "HEAD" >in &&
    ++	git cat-file --batch-check <in >actual &&
    ++	git cat-file --use-mailmap --batch-check <in >>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
    ++	test_when_finished "rm .mailmap" &&
    ++	cat >.mailmap <<-\EOF &&
    ++	C O Mitter <committer@example.com> Orig <orig@example.com>
    ++	EOF
    ++	commit_size=`git cat-file commit HEAD | wc -c` &&
    ++	commit_sha=`git log --pretty=format:'%H' -n 1` &&
    ++	echo "$commit_sha commit $commit_size" >expect &&
    ++	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
    ++	echo "$commit_sha commit $commit_size" >>expect &&
    ++	echo "info HEAD" >in &&
    ++	git cat-file --batch-command <in >actual &&
    ++	git cat-file --use-mailmap --batch-command <in >>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
-- 
2.38.1.438.gd2340c8913

