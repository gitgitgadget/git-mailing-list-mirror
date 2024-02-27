Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5C4F1EB
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059236; cv=none; b=LI9hNyolutWz7uGYw/dSz5b+mzokk2hgPn0TAeg/7g4m7tt6v8wgVzVuaKwl0teboZGeeV5H/HN1bvLBFvbneEPcNSodFlytXoiXBZIbarzfurngO3gIs6v28etTVcTPNlUqIv3qvONC82RjrDOcMYuhgKtRfp/cEXZkeQkBkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059236; c=relaxed/simple;
	bh=9o1vJJMh0afwsn0pxwNA+HII8+f5VTnHEhnxduJHRug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smlBG4RfAisRYqzN4I+J5Q5c1PQnFERb9spheXhvjCDQ4T4cNf+E1bat8quhxY1gv0ae3VB/np3zmaKbSZ6FNwy3y/lo42jm8slhc4wqvSLSXalAQ3HVtn0+iVf623qC4XZPycqMlxUK7vRp3c5ppKuSwnNpLWQomQ8TQ1+7XL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FSd2tOM1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FSd2tOM1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38C231DD341;
	Tue, 27 Feb 2024 13:40:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9o1vJJMh0afwsn0pxwNA+HII8+f5VTnHEhnxdu
	JHRug=; b=FSd2tOM17+jpSeVi6MYZkJ5/rdAkL/U9WyG6AAMnW8S16892ilC+qc
	fS8fAjiY8iWcL4IfYRiTFac6DFXjUmrVmCW59D2Y1XG6IhM8KGVkN2/q2rJbsakY
	0KclnqdmTzi+Rw4r28N9sq9g9bMOWttTgqtpRitTG8cIYgd6ETHPQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 319751DD340;
	Tue, 27 Feb 2024 13:40:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D3421DD33E;
	Tue, 27 Feb 2024 13:40:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: adapt to the Git Standard Library
In-Reply-To: <pull.1677.git.1709045045235.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 27 Feb 2024 14:44:04
	+0000")
References: <pull.1677.git.1709045045235.gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 10:40:32 -0800
Message-ID: <xmqqcyshsqcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0BA7CEE-D59F-11EE-8A0F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the commit "git-std-lib: introduce Git Standard Library" of the
> `cw/git-std-lib` topic, the Makefile was restructured in a manner that
> requires the CMake definition to follow suit to be able to build Git.
>
> This commit adjusts the CMake definition accordingly.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: adapt to the Git Standard Library
>     
>     The usual CMake adjustments. This is based on cw/git-std-lib.

Thanks for a fix.

std-lib folks, can you fold this patch (with authorship credits
intact) into your series when it gets rerolled from here on?

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1677%2Fdscho%2Fcmake-vs-git-std-lib-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1677/dscho/cmake-vs-git-std-lib-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1677
>
>  contrib/buildsystems/CMakeLists.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 804629c525b..6f46f8f9070 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -676,10 +676,12 @@ include_directories(${CMAKE_BINARY_DIR})
>  #build
>  #libgit
>  parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
> +parse_makefile_for_sources(std_lib_SOURCES "STD_LIB_OBJS")
>  
>  list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
> +list(TRANSFORM std_lib_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
>  list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
> -add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
> +add_library(libgit ${libgit_SOURCES} ${std_lib_SOURCES} ${compat_SOURCES})
>  
>  #libxdiff
>  parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
>
> base-commit: c9e04a1e1f954dd60b1373f75b710f64d34e502b
