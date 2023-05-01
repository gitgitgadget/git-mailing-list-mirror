Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F7C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjEATHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEATHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:07:42 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93510F8
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:07:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aafa03f541so11928035ad.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682968060; x=1685560060;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4Mz6B178EyzTgivd6eVLU/TsvioAu6+HN0BfaO10oM=;
        b=NOWD/Q7c7ZY3Em1pbwdx2iLrflzmP92lLx2BSIFYduQ1ZJVyFpmXuFhkGjELHaH2on
         1vWYnD7LpcMcBnyfpQkz58bkFNwYdEEpwUfsilpBG3QntD1mBmy5xiLGur+HeYe2ynfw
         EyPJJeatfU8AitexstgjdkfjNqbiHeW+wB/jTghYh5PAjasa9Gbf42eTuKb1Z6qQpIwP
         zHNMrVcOUIVRgzAtxkI/0AwUpVVsSW6dWYtgexH3zYgZFIE0AzGsaVOVJR6q7x/c2Tix
         WUFD9TP5t4dHDqYXxGn68++gBr70Vzjkd5fm17DvKU1OFeMFw6CJUU98AiyF3RFoUZS5
         EyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968060; x=1685560060;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4Mz6B178EyzTgivd6eVLU/TsvioAu6+HN0BfaO10oM=;
        b=f5YwrxpHWI/ZY7gK9cbWlvWOdZpoTKzqShVUouvc10X+G/yxuWX4VbkAHI3U9iekfv
         gg7SBzmU9sDs4OTeyoDaA05F45CSFOnyNxOheX7aspAZzD5XtfjNQH2obCHmpACGvKCB
         IvGFSmHHt9+OeckrCl9ZBzHYZLcjZA3qCp5TlUlmSb5xeGxOdBVKVT5Qiu6MNUo7WDp/
         mfxx/czxw0CirJtJPWTFjXVLtXO0unGr5AyUAeaM4MZ0D3NEvkizsdv3rNesbX2Azp4i
         UEmmykiPAVThXzIf9V+fT+aZUIGEiVKy9DvE9/nU5pAxv2quMiCSegL10mT/xCTUAOWB
         ef2w==
X-Gm-Message-State: AC+VfDwnGB1HgNzlhcnr9zlVaxnrDEwonVPrj7ZkdMphXC8P7/Aj0mvb
        XYrk6P3dJz6Frd+j2KZpX3CCxRqbVP8=
X-Google-Smtp-Source: ACHHUZ55IPUH6xWvg2+WzMIEm1Pzp9eFItEycVnCmdXq5MjpMhuFjLNfe0oamfzwgzND6cw3bQolng==
X-Received: by 2002:a17:903:244d:b0:1a8:1f41:59ba with SMTP id l13-20020a170903244d00b001a81f4159bamr18358031pls.38.1682968060145;
        Mon, 01 May 2023 12:07:40 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b001a6d4ffc760sm18351870plc.244.2023.05.01.12.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:07:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/2] fsck: verify checksums of all .bitmap files
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
        <d608d2faa8602df6a52117c8c57c0ca8e43beb4f.1682965295.git.gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 12:07:39 -0700
In-Reply-To: <d608d2faa8602df6a52117c8c57c0ca8e43beb4f.1682965295.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 01 May 2023
        18:21:34 +0000")
Message-ID: <xmqqv8hb50qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int verify_bitmap_file(const char *name)
> +{
> +	struct stat st;
> +	unsigned char *data;
> +	int fd = git_open(name);
> +	int res = 0;
> +
> +	/* A non-existent file is valid. */
> +	if (fstat(fd, &st)) {
> +		close(fd);
> +		return 0;
> +	}

git_open() may return a negative value to signal an error, and
fstat() would return negative to signal its own error, and feeding
the negative fd to close() would also be an error without molesting
other open file descriptors we would want to keep, and we do not
check the return value from close(), so all of the above may be
safe, but makes us feel a bit dirty.

	/* It is OK not to have the file */
	if (fd < 0 || fstat(fd, &st)) {
		if (0 <= fd)
			close(fd);
		return 0;
	}

is probably not overly too verbose and makes the result a bit more
palatable, perhaps.

> +	data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	close(fd);
> +	if (!hashfile_checksum_valid(data, st.st_size))
> +		res = error(_("bitmap file '%s' has invalid checksum"),
> +			    name);
> +
> +	munmap(data, st.st_size);
> +	return res;
> +}

OK.

> +int verify_bitmap_files(struct repository *r)
> +{
> +	int res = 0;
> +
> +	for (struct multi_pack_index *m = get_multi_pack_index(r);
> +	     m; m = m->next) {
> +		char *midx_bitmap_name = midx_bitmap_filename(m);
> +		res |= verify_bitmap_file(midx_bitmap_name);
> +		free(midx_bitmap_name);
> +	}
> +
> +	for (struct packed_git *p = get_all_packs(r);
> +	     p; p = p->next) {
> +		char *pack_bitmap_name = pack_bitmap_filename(p);
> +		res |= verify_bitmap_file(pack_bitmap_name);
> +		free(pack_bitmap_name);
> +	}
> +
> +	return res;
> +}

OK.

> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 0882cbb6e4a..d7353d8d443 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -434,4 +434,42 @@ test_expect_success 'tagged commits are selected for bitmapping' '
>  	)
>  '
>  
> +corrupt_file () {
> +	chmod a+w "$1" &&
> +	printf "bogus" | dd of="$1" bs=1 seek="12" conv=notrunc
> +}
> +
> +test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
> +	git init valid &&
> +	test_when_finished rm -rf valid &&
> +
> +	test_commit_bulk 20 &&
> +	git repack -adbf &&
> +
> +	# Move pack-bitmap aside so it is not deleted
> +	# in next repack.
> +	packbitmap=$(ls .git/objects/pack/pack-*.bitmap) &&
> +	mv "$packbitmap" "$packbitmap.bak" &&
> +
> +	test_commit_bulk 10 &&
> +	git repack -b --write-midx &&
> +	midxbitmap=$(ls .git/objects/pack/multi-pack-index-*.bitmap) &&
> +
> +	# Copy MIDX bitmap to backup. Copy pack bitmap from backup.
> +	cp "$midxbitmap" "$midxbitmap.bak" &&
> +	cp "$packbitmap.bak" "$packbitmap" &&

So, at this point, we have only one pack, and we could enable the
midx bitmap and/or pack bitmap from their .bak.  We first enable
only the pack bitmap while leaving midx bitmap disabled.

> +	# fsck works at first
> +	git fsck &&

OK.

> +	corrupt_file "$packbitmap" &&
> +	test_must_fail git fsck 2>err &&
> +	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&

And when the only thing enabled, i.e. pack bitmap, is broken, we
notice the breakage.  OK.

> +	cp "$packbitmap.bak" "$packbitmap" &&
> +	corrupt_file "$midxbitmap" &&

Now we repair the pack bitmap and break midx bitmap.  Both are
enabled in this case.

> +	test_must_fail git fsck 2>err &&
> +	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err

And we notice midx bitmap is corrupt.

Is it worth checking at this point if we detect breakages in both
bitmaps, if we have pack bitmap and midx bitmap, both broken?

Other than these tiny nits, looking very good.

Thanks.
