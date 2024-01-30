Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4E381AF
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593683; cv=none; b=OleYkI6ieREx8epjng8FTDLKVfoOfQLzJ5hCBmKvYlsaAOCX3p+BjdqGXyQCA0to92YqQqbEj4DCFGswOqDLcnpaODGQpM8egSYq5dLTD90Ms0+J0mdS/SLWyeE+JvcieLpKp/XZzmgMv+J+OIDT+JernbqXFSP0pHSbB2gixpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593683; c=relaxed/simple;
	bh=poYcSlCghXrjI3dsaEhJpNfHNYGlI6RpBPnpT82EtnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPcip+aaf60T3Edos84uyd36qWmLR/WLYLpezWXsAU4FOTWugXdC0VN+4c16YnA5vJwfL8R2HugUTOYr2kA9ubS2tRJ3PduZYB6TlMUtYkmozPFoRNDYFWErQKEsoUoleWxhR97jbNiOYyDn/yq34eZXoY+btxcedLm22ofRqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KV3caTy5; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KV3caTy5"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45E2D253DA;
	Tue, 30 Jan 2024 00:48:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=poYcSlCghXrjI3dsaEhJpNfHNYGlI6RpBPnpT8
	2EtnM=; b=KV3caTy53cgj9X/KBJkjEGEgEqmA5Y0/H+bgx1XzKUG9kWRVyXb+2A
	vsXWwhUhtpm/nJeZ64sFpNKtazebDvXg84FL5pUBNDtTv/x5gzOBqS6F7Sb8B1Q4
	GjBLh++ekN04AKzu7xsac3l4XXMtqmOT/L1ucWqhCunPcyyxFOrf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E2F7253D9;
	Tue, 30 Jan 2024 00:48:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4A6DE253D7;
	Tue, 30 Jan 2024 00:47:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 8/8] completion: add tests for git-bisect
In-Reply-To: <20240128223447.342493-9-britton.kerin@gmail.com> (Britton Leo
	Kerin's message of "Sun, 28 Jan 2024 13:34:47 -0900")
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
	<20240128223447.342493-1-britton.kerin@gmail.com>
	<20240128223447.342493-9-britton.kerin@gmail.com>
Date: Mon, 29 Jan 2024 21:47:55 -0800
Message-ID: <xmqq5xzbe5is.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1EA1871C-BF33-11EE-B2F2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Britton Leo Kerin <britton.kerin@gmail.com> writes:

> +test_expect_success 'git bisect - start subcommand arguments before double-dash are completed as revs' '
> +	(
> +		cd git-bisect &&
> +		test_completion "git bisect start " <<-\EOF
> +		HEAD Z
> +		final Z
> +		initial Z
> +		master Z
> +		EOF
> +	)
> +'

When GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is set to 'main' (can be
seen as a failure in linux-gcc job in GitHub CI), this piece breaks
the test, because 'master' would not appear there in the list.

You could detect what the initial default branch name currently is
and use that branch name to dynamically generate the above list
during the test.  I do not think it is worth it, and forcing the
fixed name should be sufficient.

Perhaps like this (not tested):

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 698e278450..26f616fcfe 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -5,6 +5,8 @@
 
 test_description='test bash completion'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./lib-bash.sh
 
 complete ()
