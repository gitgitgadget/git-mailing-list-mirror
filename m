Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77830C4346E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7EF20BED
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf29ruYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgI2GSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 02:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2GSf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 02:18:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC911C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:18:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so3494900pfc.7
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=dwWFbJ/fjWc1XzjcT0yfJzh1vugEy5U4nsURKGABdI0=;
        b=Gf29ruYK+kiqq/c1YZtld5Fzv+62Hp62AZSF0ti20r9liXzFTINosYWBTuNXLF4Pwd
         xfCoMDf2gpKkbX7Jr0fq06wDffytnugbDz7i2/Kh17oCF69cDGdeUYAF96aJgrtsneeS
         0bNCG5VucZIysPiM0y35S+wgb2GbykXIYN6NqL8n8acyrd4xv6/WZUckNtW1lPBQNUJR
         pEEbzjl+KZODKTmAyz1qiun0zQp2axfhelO5UPaY9n3H79VAmN/bQPcCa3YonrqeUX5Q
         DOjvcFiiI3YZvzJD/qHDEe05pnk/QrTaA7TVdByFBpa2rKEUYmLC/V9iJSQHPKvyAZKI
         XZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=dwWFbJ/fjWc1XzjcT0yfJzh1vugEy5U4nsURKGABdI0=;
        b=Ho+WG2N1LL0qYSf159tWRvqQzkch9ZzNAQ2cVbaYYU5/KvX6Udv9s5d3rmRwvSpGM0
         MbVuMWRulH/LOa4sPssBobEddQUQi5TWjFgdI1dR0HbUo5iZHzbkT9HUCJ16aPvzAniE
         kqFFJQj8tkL1ASqciWNgxB3FihiCn0CaxKCAjHnbaYGlBQvzbEnSuXa2hyb++lMreior
         Q912FovdQopdkh29R3Ey7ZZCKZDKdYwmAMrIU4HX0+LEVFB6UmaKWW/BurZlyl3AGBqJ
         jj5fhm3FIQ074BF4VmkuZ9cW8seHeikx030tWhwlIzKysBV0aHttHTYYRbVnP2l//twa
         gSzw==
X-Gm-Message-State: AOAM533dlhHOHDSDRYvogYUnRNttuiuSAmAsZ3uGUJFh3D8gyZ9F3qzG
        40LRbyJC0Pm1HeFwGfASimyFuLf6+3I=
X-Google-Smtp-Source: ABdhPJx1Ed5m99BXEAo24kl+9xWVANjR34vbKlN0pTzH/XDCjYBkBF92GyhG0aIhr0J9sC8EVWHg8w==
X-Received: by 2002:a17:902:aa8c:b029:d2:11a4:8612 with SMTP id d12-20020a170902aa8cb02900d211a48612mr3013807plr.3.1601360313369;
        Mon, 28 Sep 2020 23:18:33 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id f19sm4089049pfd.45.2020.09.28.23.18.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:18:32 -0700 (PDT)
Date:   Mon, 28 Sep 2020 23:18:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] git checkout -p HEAD...
Message-ID: <20200929061830.GA40759@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

git checkout -p <commit>... is broken:

	$ git checkout HEAD... -p
	usage: git diff-index [-m] [--cached] [<common-diff-options>] <tree-ish> [<path>...]
	common diff options:
	  -z            output diff-raw with lines terminated with NUL.
	  -p            output patch format.
	  -u            synonym for -p.
	  --patch-with-raw
			output both a patch and the diff-raw format.
	  --stat        show diffstat instead of patch.
	  --numstat     show numeric diffstat instead of patch.
	  --patch-with-stat
			output a patch and prepend its diffstat.
	  --name-only   show only names of changed files.
	  --name-status show names and status of changed files.
	  --full-index  show full object name on index lines.
	  --abbrev=<n>  abbreviate object names in diff-tree header and diff-raw.
	  -R            swap input file pairs.
	  -B            detect complete rewrites.
	  -M            detect renames.
	  -C            detect copies.
	  --find-copies-harder
			try unchanged files as candidate for copy detection.
	  -l<n>         limit rename attempts up to <n> paths.
	  -O<file>      reorder diffs according to the <file>.
	  -S<string>    find filepair whose only one side contains the string.
	  --pickaxe-all
			show all files diff when -S is used and hit is found.
	  -a  --text    treat all files as text.

	Cannot close git diff-index --cached --numstat --summary HEAD... -- () at /home/denton/.local/libexec/git-core/git-add--interactive line 183.

The issue is simple: `HEAD...` is passed literally to `git diff-index`
which does not know how to handle it. The fix is simple: figure out the
OID and pass that instead.

One thing I'm not quite sure about is that in the documentation, the
restore-related checkout options accept <tree-ish> and it's an
implementation detail that the `<commit>...` form happens to work in the
non-patch case. In fact, `git restore --source=HEAD...` works too
(unless -p is given as well).

So I lean on the side of fully supporting the `...` form for `git
restore/checkout`. However, I understand if someone wishes to suggest
"that was never valid to begin with; we should prohibit `...` from
being used with restore-modes`.

Any opposition to fully supporting the `...` form?

Thanks,
Denton
