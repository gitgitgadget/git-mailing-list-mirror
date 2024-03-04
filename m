Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087062140
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576191; cv=none; b=mkit8LIixp+mEkdX/7rMz25Oi1bWKtgBvNkSvLeNhrq/kBZpmRzMLDR+eq41ji+K9GDyMDrzkLKmUm7YTNaw3kg0QJdhniyPjSUXkKiipy6p4sGei/914KO3eweWF0wqWB74dut15aTnJrd8DDADpE/nIWOxhf/5lL+jatppEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576191; c=relaxed/simple;
	bh=fBIW325emPYmNerowLGkdFquNxE+UIV01oEi2YGsYIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gClmvggOcJmRQ2VDWD5nL8xTy00MZCOWeGnIBST548PC9/ksDl43SBV2/hW3NHffCI/4HzlWFsQnIWxV//RgKMvdFCsbJ5ltu3OjffClHRpbvwc+Cc3c+yJkcc/Z52s0+mNoj1W07onSwebYoaaq2JN/vUnrBXA8ojyH0nlbgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sfWvol+b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sfWvol+b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5259537ABA;
	Mon,  4 Mar 2024 13:16:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fBIW325emPYmNerowLGkdFquNxE+UIV01oEi2Y
	GsYIU=; b=sfWvol+bGt+6EtWJQranEcNBG9Y5JmkhBqKRRh43GB7CXghDEx/3Bd
	cOgBW3SXAmG1V0Wi68hf8sezfUpIqql191UmTf3GW45i5QXBPoRN4a/gLiVS2+X4
	vxvIpKSxOvMSSABNZfcyvVeSNN5vFXlwbBBsIUvJaEghU0ouAkUMg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F8B37AB9;
	Mon,  4 Mar 2024 13:16:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7E6937AB8;
	Mon,  4 Mar 2024 13:16:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  newren@gmail.com
Subject: Re: [PATCH v2] setup: remove unnecessary variable
In-Reply-To: <20240304151811.511780-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Mon, 4 Mar 2024 20:48:11 +0530")
References: <20240229134114.285393-2-shyamthakkar001@gmail.com>
	<20240304151811.511780-1-shyamthakkar001@gmail.com>
Date: Mon, 04 Mar 2024 10:16:24 -0800
Message-ID: <xmqqjzmhq2vb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5046B9E6-DA53-11EE-BD54-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> The TODO comment suggested to heed core.bare from template config file
> if no command line override given. And the prev_bare_repository
> variable seems to have been placed for this sole purpose as it is not
> used anywhere else.

OK.

> However, it was clarified by Junio [1] that such values (including
> core.bare) are ignored intentionally and does not make sense to
> propagate them from template config to repository config. Also, the
> directories for the worktree and repository are already created, and
> therefore the bare/non-bare decision has already been made, by the
> point we reach the codepath where the TODO comment is placed.

Correct.  Who said it is much less interesting than what was said,
so I would have written the first part of the paragraph more like

	Values including core.bare from the template file are
	ignored on purpose because they may not make sense for the
	repository being created [1].  Also, the directories for ...

but I'll let it pass.

> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index b1eb5c01b8..29cf8a9661 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -52,7 +52,7 @@ test_expect_success 'shared=all' '
>  	test 2 = $(git config core.sharedrepository)
>  '
>  
> -test_expect_failure 'template can set core.bare' '
> +test_expect_success 'template cannot set core.bare' '
>  	test_when_finished "rm -rf subdir" &&
>  	test_when_finished "rm -rf templates" &&
>  	test_config core.bare true &&
> @@ -60,18 +60,7 @@ test_expect_failure 'template can set core.bare' '
>  	mkdir -p templates/ &&
>  	cp .git/config templates/config &&
>  	git init --template=templates subdir &&
> -	test_path_exists subdir/HEAD
> +	test_path_is_missing subdir/HEAD
>  '

So we used to say "subdir should be created as a bare repository but
we fail to do so", but now "subdir should become a non-bare repository
because 'git init' is run without the --bare option".  OK.

> -
> -test_expect_success 'template can set core.bare but overridden by command line' '
> -	test_when_finished "rm -rf subdir" &&
> -	test_when_finished "rm -rf templates" &&
> -	test_config core.bare true &&
> -	umask 0022 &&
> -	mkdir -p templates/ &&
> -	cp .git/config templates/config &&
> -	git init --no-bare --template=templates subdir &&
> -	test_path_exists subdir/.git/HEAD
> -'

This removal is a bit unexpected.  Is it because we established with
the previous test that core.bare in the template should not affect
the outcome, so this is not worth testing?

> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index a400bcca62..e93e0d0cc3 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -120,14 +120,14 @@ test_expect_success 'prefers -c config over --template config' '
>  
>  '
>  
> -test_expect_failure 'prefers --template config even for core.bare' '
> +test_expect_success 'ignore --template config for core.bare' '
>  
>  	template="$TRASH_DIRECTORY/template-with-bare-config" &&
>  	mkdir "$template" &&
>  	git config --file "$template/config" core.bare true &&
>  	git clone "--template=$template" parent clone-bare-config &&
> -	test "$(git -C clone-bare-config config --local core.bare)" = "true" &&
> -	test_path_is_file clone-bare-config/HEAD
> +	test "$(git -C clone-bare-config config --local core.bare)" = "false" &&
> +	test_path_is_missing clone-bare-config/HEAD
>  '

This is in the same spirit as the first change in t1301, which seems
OK.

Thanks.
