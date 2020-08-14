Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01854C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA91A207DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiWb+ZeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHNPSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHNPSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 11:18:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F24C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 08:18:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so8682036wra.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L8DaPd4EHnKdmo3YTCW3dZY0JL3pnnKZ84Ba1g7NfgM=;
        b=YiWb+ZeLia30UQT/zM9KCrU0W9BtBlyCWBaBnBTyrVnyZhCOcE/0xlXllkrfyZomJI
         DuvxJowTPw9ro7dle/SlMdD77Ca8Iy5brIseaEoSw4cwxKFvQemKRNyZn8HjlWvkyj3x
         UiUaNAJ148rtgKXOGlh1/HbYPpdPak1LzE5cWBshxU7juYCLp0iIN2U05Z8SKLo4kSjD
         56m/oFIRCyAVZt1jqD3+0kdclyj66rnEsSuqrp2erQxz2utOhClZaLor3sEw49MdZv7k
         nov45Xt6FRiecOW1GUkuwOwCtUTS75oxGpCsU8CmsCpS3qSYXYkag4hAjFEqsHDt3mcB
         /LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L8DaPd4EHnKdmo3YTCW3dZY0JL3pnnKZ84Ba1g7NfgM=;
        b=lTK20Vos5Wyj3elPu2eQW6d/aHlHNuslcvJLy2dKMYB9edSGb7diJkxbHUsqyXMHVZ
         OxlThQIjX94NOPldRhicgYQ7xanGYNHqGSTeOOLyC5cJDvZaO8lePJkyEI1Gmk17PY0b
         X21nzgfpyV4p/qmzclSR2XG0GZA8PWSlWqZdn39SBZHIxVUmll7wDxJ4Jhx0+4HMJ+tG
         AMo+aPfnq2oYSEGVRhkrK7bgrFlwYsNcckdsDraZDn+knlvJja6wBioLu3KI0zssRf25
         lqrfURgFAoiWowSKgrYLwOSLYAj7L2G023xF2FCBKNttDfp7eRYRbF+uJ5Ly3G02k1e8
         QlMw==
X-Gm-Message-State: AOAM532FrekE9W1pYrWbQE8p7P75Gpxopdp2PJUL6DrkYIRRE7kIdIiB
        B8OdaqOklRs3djmCqR869jFvl/KeP1w=
X-Google-Smtp-Source: ABdhPJwN6lDMHysVq6TmFHx/6xmGzBd7HLoH1fuqEetEktYlonUqKkhuf9Nel9jElJEP0nj3uMLvnA==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr3290546wrn.2.1597418301784;
        Fri, 14 Aug 2020 08:18:21 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id 31sm16671467wrp.87.2020.08.14.08.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 08:18:21 -0700 (PDT)
Date:   Fri, 14 Aug 2020 17:18:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's
 name
Message-ID: <20200814151815.GA29528@szeder.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597364493.git.congdanhqx@gmail.com>
 <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 07:23:10AM +0700, Đoàn Trần Công Danh wrote:
> A handful of Git's commands respect `--abbrev' for customizing length
> of abbreviation of object names.
> 
> For diff-family, Git supports 2 different options for 2 different
> purposes, `--full-index' for showing diff-patch object's name in full,
> and `--abbrev' to customize the length of object names in diff-raw and
> diff-tree header lines, without any options to customise the length of
> object names in diff-patch format. When working with diff-patch format,
> we only have two options, either full index, or default abbrev length.
> 
> Although, that consistent is documented, it doesn't stop users from
> trying to use `--abbrev' with the hope of customising diff-patch's
> objects' name's abbreviation.
> 
> Let's resolve that inconsistency.
> 
> To preserve backward compatibility with old script that specify both
> `--full-index' and `--abbrev', always shows full object id
> if `--full-index' is specified.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  Documentation/diff-options.txt                |  9 +++---
>  diff.c                                        |  5 +++-
>  t/t4013-diff-various.sh                       |  3 ++
>  ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++++++++++++
>  ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++++++++++++
>  ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++++++++++++
>  6 files changed, 99 insertions(+), 5 deletions(-)
>  create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
>  create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
>  create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 7987d72b02..c11efa7865 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -441,10 +441,11 @@ endif::git-format-patch[]
>  --abbrev[=<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
>  	name in diff-raw format output and diff-tree header
> -	lines, show only a partial prefix.  This is
> -	independent of the `--full-index` option above, which controls
> -	the diff-patch output format.  Non default number of
> -	digits can be specified with `--abbrev=<n>`.
> +	lines, show only a partial prefix.
> +	In diff-patch output format, `--full-index` takes higher
> +	precedent, i.e. if `--full-index` is specified, full blob
> +	names will be shown regardless of `--abbrev`.
> +	Non default number of digits can be specified with `--abbrev=<n>`.
>  
>  -B[<n>][/<m>]::
>  --break-rewrites[=[<n>][/<m>]]::
> diff --git a/diff.c b/diff.c
> index f9709de7b4..20dedfe2a9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4319,7 +4319,10 @@ static void fill_metainfo(struct strbuf *msg,
>  	}
>  	if (one && two && !oideq(&one->oid, &two->oid)) {
>  		const unsigned hexsz = the_hash_algo->hexsz;
> -		int abbrev = o->flags.full_index ? hexsz : DEFAULT_ABBREV;
> +		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
> +
> +		if (o->flags.full_index)
> +			abbrev = hexsz;
>  
>  		if (o->flags.binary) {
>  			mmfile_t mf;
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 3f60f7d96c..e6eb4dd4c7 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -221,6 +221,9 @@ diff-tree --root -r --abbrev=4 initial
>  :noellipses diff-tree --root -r --abbrev=4 initial
>  diff-tree -p initial
>  diff-tree --root -p initial
> +diff-tree --root -p --abbrev=10 initial
> +diff-tree --root -p --full-index initial
> +diff-tree --root -p --full-index --abbrev=10 initial
>  diff-tree --patch-with-stat initial
>  diff-tree --root --patch-with-stat initial
>  diff-tree --patch-with-raw initial
> diff --git a/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial b/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
> new file mode 100644
> index 0000000000..7518a9044e
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
> @@ -0,0 +1,29 @@
> +$ git diff-tree --root -p --abbrev=10 initial
> +444ac553ac7612cc88969031b02b3767fb8a353a
> +diff --git a/dir/sub b/dir/sub
> +new file mode 100644
> +index 0000000000..35d242ba79
> +--- /dev/null
> ++++ b/dir/sub
> +@@ -0,0 +1,2 @@
> ++A
> ++B
> +diff --git a/file0 b/file0
> +new file mode 100644
> +index 0000000000..01e79c32a8
> +--- /dev/null
> ++++ b/file0
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +diff --git a/file2 b/file2
> +new file mode 100644
> +index 0000000000..01e79c32a8
> +--- /dev/null
> ++++ b/file2
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +$
> diff --git a/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial b/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
> new file mode 100644
> index 0000000000..69f913fbe5
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
> @@ -0,0 +1,29 @@
> +$ git diff-tree --root -p --full-index --abbrev=10 initial
> +444ac553ac7612cc88969031b02b3767fb8a353a
> +diff --git a/dir/sub b/dir/sub
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..35d242ba79ae89ac695e26b3d4c27a8e6f028f9e
> +--- /dev/null
> ++++ b/dir/sub
> +@@ -0,0 +1,2 @@
> ++A
> ++B
> +diff --git a/file0 b/file0
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
> +--- /dev/null
> ++++ b/file0
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +diff --git a/file2 b/file2
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
> +--- /dev/null
> ++++ b/file2
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +$
> diff --git a/t/t4013/diff.diff-tree_--root_-p_--full-index_initial b/t/t4013/diff.diff-tree_--root_-p_--full-index_initial
> new file mode 100644
> index 0000000000..1b0b6717fa
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--root_-p_--full-index_initial
> @@ -0,0 +1,29 @@
> +$ git diff-tree --root -p --full-index initial
> +444ac553ac7612cc88969031b02b3767fb8a353a
> +diff --git a/dir/sub b/dir/sub
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..35d242ba79ae89ac695e26b3d4c27a8e6f028f9e
> +--- /dev/null
> ++++ b/dir/sub
> +@@ -0,0 +1,2 @@
> ++A
> ++B
> +diff --git a/file0 b/file0
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
> +--- /dev/null
> ++++ b/file0
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +diff --git a/file2 b/file2
> +new file mode 100644
> +index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
> +--- /dev/null
> ++++ b/file2
> +@@ -0,0 +1,3 @@
> ++1
> ++2
> ++3
> +$

All these new tests break when run with GIT_TEST_DEFAULT_HASH=sha256
with something like:

  + test_cmp expect actual
  --- expect	2020-08-14 15:05:12.209285397 +0000
  +++ actual	2020-08-14 15:05:12.205285279 +0000
  @@ -2,7 +2,7 @@
   0000000000000000000000000000000000000000000000000000000000000000
   diff --git a/dir/sub b/dir/sub
   new file mode ffff44
  -index ffffffffff..fffffffa79
  +index ffffffffff..fffffff895
   --- /dev/null
   +++ b/dir/sub
   @@ -0,0 +1,2 @@
  @@ -10,7 +10,7 @@
   +B
   diff --git a/file0 b/file0
   new file mode ffff44
  -index ffffffffff..fffffff2a8
  +index ffffffffff..fffffff5d7
   --- /dev/null
   +++ b/file0
   @@ -0,0 +1,3 @@
  @@ -19,7 +19,7 @@
   +3
   diff --git a/file2 b/file2
   new file mode ffff44
  -index ffffffffff..fffffff2a8
  +index ffffffffff..fffffff5d7
   --- /dev/null
   +++ b/file2
   @@ -0,0 +1,3 @@
  error: last command exited with $?=1


