Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743CE1DA4C
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736745; cv=none; b=k6+WCwheg0rKCcN6ua1TV1RioRmWTz57A37qSyQWNl7cGa0cfFDtRDpH58AT3XgvIsSAToStlw9MBu+lg7PZ2YpptwYpGMuWTBXxicxWw4Qu60qdClAcfQcUtwlIDfsM6UObpiXFwINAahFsCf73X7CQY6da1pyDhH2AkNmXYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736745; c=relaxed/simple;
	bh=gnD9T4XyJvp9tExg5eLtNMRepus4R5rIqY3zyUw4+0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPePZIy0YnXpxLSScw//1kmXFX8OsKI9ND2LKB5krFFLh+7tefW8uqv7yzRt4KRr8z1G34zSopXAb+5YKwfq9FSV0RhyJat6PswepLV7AdUeBW+ncPP7OI+y5AstNSEwJmNjw0vGLST9cz+oWRjCCqa+ksqBuVzjogu9T828LHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0o3dqjN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0o3dqjN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F6103092C;
	Fri, 29 Mar 2024 14:25:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gnD9T4XyJvp9tExg5eLtNMRepus4R5rIqY3zyU
	w4+0s=; b=o0o3dqjNeFvqYu0aD26ao/UdviPZ6jCskj8jeSJMNh6A3oR0BQNKdG
	QBU2y3XSyw65+1bOl4AWGITN1qc5i5uLI4d81BKjiCTivfc6JdDg1napPVwzygFo
	eEahpExVbQ2N/DLoir6eOTMQpSUbGXNFWxyPFFO/h4udX8VXRvlDA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0768E3092B;
	Fri, 29 Mar 2024 14:25:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8998D3092A;
	Fri, 29 Mar 2024 14:25:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/3] reftable/stack: add env to disable autocompaction
In-Reply-To: <2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
	(Justin Tobler via GitGitGadget's message of "Fri, 29 Mar 2024
	04:16:47 +0000")
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
	<pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<2fdd8ea11331da13ec56d511fe4cadd47544419f.1711685809.git.gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:25:38 -0700
Message-ID: <xmqqzfugyjx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF37AF0E-EDF9-11EE-B0FD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Justin Tobler <jltobler@gmail.com>
>
> In future tests it will be neccesary to create repositories with a set
> number of tables. To make this easier, introduce the
> `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
> set, disables autocompaction of reftables.

"when set" -> "when set to true"?

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  reftable/stack.c           |  2 +-
>  reftable/system.h          |  1 +
>  t/t0610-reftable-basics.sh | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1ecf1b9751c..07262beaaf7 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -681,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition *add)
>  	if (err)
>  		goto done;
>  
> -	if (!add->stack->disable_auto_compact)
> +	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))
>  		err = reftable_stack_auto_compact(add->stack);
>  
>  done:
> diff --git a/reftable/system.h b/reftable/system.h
> index 5d8b6dede50..05b7c8554af 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -17,6 +17,7 @@ license that can be found in the LICENSE file or at
>  #include "tempfile.h"
>  #include "hash-ll.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> +#include "parse.h"
>  
>  int hash_size(uint32_t id);
>  
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 686781192eb..434044078ed 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -299,6 +299,21 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
>  	test_line_count = 1 repo/.git/reftable/tables.list
>  '
>  
> +test_expect_success 'ref transaction: environment variable disables auto-compaction' '
> +	test_when_finished "rm -rf repo" &&
> +
> +	git init repo &&
> +	test_commit -C repo A &&
> +	for i in $(test_seq 20)
> +	do
> +		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=true git -C repo update-ref branch-$i HEAD || return 1
> +	done &&
> +	test_line_count = 23 repo/.git/reftable/tables.list &&

I am not sure if it is a sensible assumption that init + test_commit
(which itself is opaque) will create exactly 3 tables forever, even
if it may happen to be true right now.  Shouldn't you be counting
the lines before entering the for loop and adding 20 to that number
to set the expectation?

> +	git -C repo update-ref foo HEAD &&
> +	test_line_count = 1 repo/.git/reftable/tables.list
> +'
> +
>  check_fsync_events () {
>  	local trace="$1" &&
>  	shift &&
