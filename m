Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F5C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E493560F93
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 08:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhITIEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhITIE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 04:04:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2CC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 01:03:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so57961842edt.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FIUwekUD7SsSF2sOsxHkBm/7loie7N3E0S+dUpQnHFQ=;
        b=B+77xAU+oP6J+YxOo6ccj1bitzyuO9d2/Fjddv+vJznHFD1zVMSu2SgPfs0nbPyg92
         stXXMkwKPD3dKEj8+vj77nwExcwA2cRKvAEijySYmBP+4PVOTDYrcr4HYylLodkh+NC1
         DlMFTIgleZXYH+x6jXNOtEDPFZjQdl3x/uUBHe4ObLaBbG97LNhfF9f+c+lzPD4D0eQ3
         SzQxj6MwxEd46FqShBboXnoEtoUnBrHWGcnAYEcgBCE9Ti1lCLrPyQQpMEyRE3W2B3Ma
         fArXWiuQV/ubg+55Fd+JNnXSSMEcnKf+sIvKwJ6sxD4DLVT7a/vki4QEms8QzfaHSfUz
         JFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FIUwekUD7SsSF2sOsxHkBm/7loie7N3E0S+dUpQnHFQ=;
        b=g3tJS+mvVBfbpeM3layHTPGuxRZRZYhGLwcSI86gkZxfhl1anih2x5fsFdBqPMLz7h
         EPJ6IkKu/kB/21KjSAOCCRIiVJ3kz2C7Fo/WlVTx054VePu/ZXw865rDSOi2w4BCZxD+
         Nr8wG62CqyCUu+Zl/bJDiD2fbUDnSwWrqdJV4qu22IzbATKITgIzkc7CNG9vIcLk3xKW
         /YVCHuFJEPPhYxfAZ2hVIfzzO0G7q08Lt4Q7lUyxZ+x+sQfFauUsvkWenmr3KTKI30QH
         UBCJ161Lf5WbsEr68bNip6xzfEZfpX3Su8FdGWwM9Mp+BH53hWEIj+3WSn6kBKjXZvO6
         todA==
X-Gm-Message-State: AOAM532z82USbJzOh8KL0D7xmWXpzS9iwCnLDQLCbkAwXQeU5Se/Es01
        Xbr63fQRFqPE2F0OP6/UNVQ=
X-Google-Smtp-Source: ABdhPJxxXyULUNCfRRQ7mZJ63tFjjjb2pc1/U5ktS8WCv4El6jCJbRFRIuMstF8QY1nDetlHnAsfPQ==
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr28045317edv.386.1632124979931;
        Mon, 20 Sep 2021 01:02:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f4sm736999ejf.61.2021.09.20.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:02:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/3] difftool: fix symlink-file writing in dir-diff mode
Date:   Mon, 20 Sep 2021 09:59:51 +0200
References: <20210919203832.91207-1-davvid@gmail.com>
 <20210919203832.91207-2-davvid@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210919203832.91207-2-davvid@gmail.com>
Message-ID: <87bl4nbrnx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 19 2021, David Aguilar wrote:

> The difftool dir-diff mode handles symlinks by replacing them with their
> readlink(2) values. This allows diff tools to see changes to symlinks
> as if they were regular text diffs with the old and new path values.
> This is analogous to what "git diff" displays when symlinks change.
>
> The temporary diff directories that are created initially contain
> symlinks because they get checked-out using a temporary index that
> retains the original symlinks as checked-in to the repository.
>
> A bug was introduced when difftool was rewritten in C that made
> difftool write the readlink(2) contents into the pointed-to file rather
> than the symlink itself. The write was going through the symlink and
> writing to its target rather than writing to the symlink path itself.
>
> Replace symlinks with raw text files by unlinking the symlink path
> before writing the readlink(2) content into them.
>
> When 18ec800512eb0634a0bf5e86b36ed156fbee73f3 added handling for

Nit: Please format commits like this: 18ec800512e (difftool: handle
modified symlinks in dir-diff mode, 2017-03-15)

See "git show -s --pretty=3Dreference" in Documentation/SubmittingPatches.

> modified symlinks this bug got recorded in the test suite. The tests
> included the pointed-to symlink target paths. These paths were being
> reported because difftool was erroneously writing to them, but they
> should have never been reported nor written.
>
> Correct the modified-symlinks test cases by removing the target files
> from the expected output.
>
> Add a test to ensure that symlinks are written with the readlink(2)
> values and that the target files contain their original content.
>
> Reported-by: Alan Blotz <work@blotz.org>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.c=
om>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c  |  2 ++
>  t/t7800-difftool.sh | 68 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index bb9fe7245a..21e055d13a 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -557,11 +557,13 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
>  		if (*entry->left) {
>  			add_path(&ldir, ldir_len, entry->path);
>  			ensure_leading_directories(ldir.buf);
> +			unlink(ldir.buf);
>  			write_file(ldir.buf, "%s", entry->left);
>  		}
>  		if (*entry->right) {
>  			add_path(&rdir, rdir_len, entry->path);
>  			ensure_leading_directories(rdir.buf);
> +			unlink(rdir.buf);
>  			write_file(rdir.buf, "%s", entry->right);
>  		}
>  	}
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index a173f564bc..07a52fb8e1 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -674,7 +674,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff han=
dles modified symlinks' '
>  	rm c &&
>  	ln -s d c &&
>  	cat >expect <<-EOF &&
> -		b
>  		c
>=20=20
>  		c
> @@ -710,7 +709,6 @@ test_expect_success SYMLINKS 'difftool --dir-diff han=
dles modified symlinks' '
>  	# Deleted symlinks
>  	rm -f c &&
>  	cat >expect <<-EOF &&
> -		b
>  		c
>=20=20
>  	EOF
> @@ -723,6 +721,72 @@ test_expect_success SYMLINKS 'difftool --dir-diff ha=
ndles modified symlinks' '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success SYMLINKS 'difftool --dir-diff writes symlinks as raw=
 text' '
> +	# Start out on a branch called "branch-init".
> +	git init -b branch-init symlink-files &&
> +	(
> +		cd ./symlink-files &&

The "./" isn't needed

Neither of those small comments needs a re-roll I think, just reading
through & noting things I spotted...

I've omitted things that Eric mentioned in
<CAPig+cTBfP5_czsPiALcF3tODJmNfXvNkTjqVFRbHCS535d-ng@mail.gmail.com>.
