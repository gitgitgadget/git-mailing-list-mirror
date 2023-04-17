Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5552C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDQWYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDQWYi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:24:38 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEE421A
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:24:37 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fb615ac3dso222088047b3.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681770276; x=1684362276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wp1sCPWz3rFcYAgWLK5Dojtjg8HHDImrSHerMR8srcE=;
        b=XDcRwq6I4DzcTWZRoCsFcUKKyA7qrybCASKL9flwc0/+AGxtl+4BiVSyyyAjIat9RE
         BZjDtCY4XFt605Aw9LmLTNg47xcpwpWTR2P+ehHZjrvPwMBtCldJsQ+P2zQy1CMO7TMF
         DpLIJmpkukn8IjIyNfhbrbxQnMmQIXSSVMausztnNnZUV6gjpzzuNHs/Jr3mrTPyV/wN
         Gch6X4fEVhdQj2BAIV2dM6CAXC8xyF9ba1g3E5sd5WwAKXWSW8IdRRxQF6Gtto+ZrA0Q
         B7/V496A0zTgLbik5Kry8VFEmaQBubcnJiJRUkK+XzQq210P45xMevw29bnjdmbQ9+mm
         dkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681770276; x=1684362276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp1sCPWz3rFcYAgWLK5Dojtjg8HHDImrSHerMR8srcE=;
        b=Nek+sAl228/u4GRbEqhopICfa/hVyaeo7LNR3HP98uvMkiG0c2f86jQo1wE4Cmurnw
         vRc/nU+TLyIFwW1NAg3YgI0rS9Sft0QpbydCVo3f3/eSZDRufcMl3k+EQ7g5Ijfhc0Fl
         HjD/qxf/in/FeyFySTnWSt6aOHeMWpqVOflTHzTP4Qu8IpbF4wrzo749isVy0qK/ToaQ
         JDEdA0Twp9IaZTzY8KPDAKtZCAQUua4ERruMDSZ9A+dlhUFiaFq0TOkcKWr8khGpPDzX
         cYgSHxruRs0qnvZ1MEl6NAeLWIad7dABac/y0WRsPAn7KBCPuvCT+qdZbmERYRgR88Bk
         Ywtg==
X-Gm-Message-State: AAQBX9ecIQa2Tc3Opdqfs0Pbqlp+UZBU3rWOiFmCnig11eF0/P6c7TkS
        lJW6hhOkO+biFAnvkb/qiRBPFA==
X-Google-Smtp-Source: AKy350aJN/pgpBp2aLrcj+Y3d74blMMqRODkNkSr6eQVXGyAt32/ZrkylASW9mO/HWDPJGU1r2VZqQ==
X-Received: by 2002:a81:5a08:0:b0:54f:7971:4f87 with SMTP id o8-20020a815a08000000b0054f79714f87mr14864857ywb.36.1681770276543;
        Mon, 17 Apr 2023 15:24:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id em14-20020a05690c2b0e00b00552e32354f8sm966765ywb.32.2023.04.17.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:24:36 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:24:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Message-ID: <ZD3HI/LIXVv6Pacn@nand.local>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:21:39PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -309,6 +310,15 @@ int load_pack_revindex(struct repository *r, struct packed_git *p)
>   */
>  int verify_pack_revindex(struct packed_git *p)
>  {
> +	/* Do not bother checking if not initialized. */

Yep, makes sense; if we don't have an on-disk reverse index (which is
mmap'd into `revindex_map` we don't have anything to verify), so we can
bail here.

> +	if (!p->revindex_map)
> +		return 0;
> +
> +	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
> +		error(_("invalid checksum"));
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>
> diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
> index 206c412f50b..6b7c709a1f6 100755
> --- a/t/t5325-reverse-index.sh
> +++ b/t/t5325-reverse-index.sh
> @@ -145,4 +145,44 @@ test_expect_success 'fsck succeeds on good rev-index' '
>  	)
>  '
>
> +test_expect_success 'set up rev-index corruption tests' '

s/set up/setup for easy `--run`-ing (e.g., ./t5325-*.sh --run=setup,fsck).

> +	git init corrupt &&
> +	(
> +		cd corrupt &&
> +
> +		test_commit commit &&
> +		git -c pack.writeReverseIndex=true repack -ad &&
> +
> +		revfile=$(ls .git/objects/pack/pack-*.rev) &&
> +		chmod a+w $revfile &&
> +		cp $revfile $revfile.bak
> +	)
> +'
> +
> +corrupt_rev_and_verify () {
> +	(
> +		pos="$1" &&
> +		value="$2" &&
> +		error="$3" &&
> +
> +		cd corrupt &&
> +		revfile=$(ls .git/objects/pack/pack-*.rev) &&
> +
> +		# Reset to original rev-file.
> +		cp $revfile.bak $revfile &&
> +
> +		printf "$value" | dd of=$revfile bs=1 seek="$pos" conv=notrunc &&
> +		test_must_fail git fsck 2>err &&
> +		grep "$error" err
> +	)
> +}
> +
> +test_expect_success 'fsck catches invalid checksum' '
> +	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&

Would this test be tighter if we introduced a sub-shell and cd'd into
"corrupt" here?

> +	orig_size=$(wc -c <$revfile) &&

I'm nitpicking, but we may want to use `test_file_size` here instead of
`wc -c`. The latter outnumbers the former in terms of number of uses,
but I think we consider `test_file_size` to be canonical these days.

> +	hashpos=$((orig_size - 10)) &&
> +	corrupt_rev_and_verify $hashpos bogus \
> +		"invalid checksum"
> +'

This looks good.

Thanks,
Taylor
