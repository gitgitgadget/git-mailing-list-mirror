Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2E20B14
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292224; cv=none; b=SQUmX3r9TXUBJBT4ZoMtw6DCxvi8n+KEzpl/aNFZREYI/K1qq8Rr9OX9SBqEWkjn/ituFfhG7gqM8wXiiNL423Ed6KN4Nnf3t1XNllXZozWm3v6F2PzCX4IrMdtBut8Sn9LUfK+ttv8a5B7kWuzFA1/dGI8HGsOAqQ0iujItLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292224; c=relaxed/simple;
	bh=GRImtDeGXrcuxSrtD3AhMjNUSRqYpF5VfHKL4YzuxPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oe8GUgaUntv/Fup7qxmAKP+huj/gqFF0N0MHQYgqkcT0RaSnvDeJH3rwbuL9WsNudALy+Y0L7he+It66jR7Cu3KC8FRaHvB1Wi90T8rygC8/CQWUWiwXfA+DBscH6922LovwtqKLU9B3tMC5j2ClbexyPumSlV8YdQTkuE3Y9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NDCMXVgE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NDCMXVgE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B4EBA2C92D;
	Fri, 26 Jan 2024 13:03:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GRImtDeGXrcuxSrtD3AhMjNUSRqYpF5VfHKL4Y
	zuxPA=; b=NDCMXVgEiD9Q92yVwkw2l4ypXaBdL5aqzBwfI6tqc202Qp9dP2VOMk
	SBvfEeq1lDG5sizs7rrLoRgnQT1nUZvOpMt8VDO7mbEuXGnMpQ/Ps1mjG4HQdA4k
	Lw6HSLVriKWk/Nfdl5cW/d+nUNTjWzX+uNkEbj6RSaLogfWnR5H1A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ADBAF2C92C;
	Fri, 26 Jan 2024 13:03:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59A982C92B;
	Fri, 26 Jan 2024 13:03:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] index-pack: test and document --strict=<msg>
In-Reply-To: <b3b3e8bd0bf2c83b57debef81edc39970beaf05b.1706289180.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Fri, 26 Jan 2024 17:12:59
	+0000")
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
	<pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<b3b3e8bd0bf2c83b57debef81edc39970beaf05b.1706289180.git.gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 10:03:37 -0800
Message-ID: <xmqq1qa4nf9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BB27F52-BC75-11EE-8BA7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> 5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
> 2015-06-22) allowed a list of fsck msg to downgrade to be passed to
> --strict. However this is a hidden argument that was not documented nor
> tested. Though it is true that most users would not call this option
> directly, (nor use index-pack for that matter) it is still useful to
> document and test this feature.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/git-index-pack.txt |  9 +++++++--
>  builtin/index-pack.c             |  2 +-
>  t/t5300-pack-object.sh           | 22 ++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 6486620c3d8..f7a98bbf9c8 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -79,8 +79,13 @@ OPTIONS
>  	to force the version for the generated pack index, and to force
>  	64-bit index entries on objects located above the given offset.
>  
> ---strict::
> -	Die, if the pack contains broken objects or links.
> +--strict[=<msg-id>=<severity>...]::
> +	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
> +	it should be a comma-separated list of `<msg-id>=<severity>` elements where
> +	`<msg-id>` and `<severity>` are used to change the severity of some possible
> +	issues, e.g., `--strict="missingEmail=ignore,badTagName=error"`. See the entry

There no longer is <msg-ids>, so I'll tweak the text perhaps like so:

	An optional value that is a comma-separated list of '<msg-id>=<severity>'
	can be passed to change the severity of some possible issues, ...

while queueing.  Will probably do the same for the --fsck-objects
side in the next patch.

Other than that, thanks for a pleasant read.

> +	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
> +	more information on the possible values of `<msg-id>` and `<severity>`.
>  
>  --progress-title::
>  	For internal use only.
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 1ea87e01f29..1e53ca23775 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -24,7 +24,7 @@
>  #include "setup.h"
>  
>  static const char index_pack_usage[] =
> -"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
> +"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
>  
>  struct object_entry {
>  	struct pack_idx_entry idx;
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index d402ec18b79..496fffa0f8a 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -441,6 +441,28 @@ test_expect_success 'index-pack with --strict' '
>  	)
>  '
>  
> +test_expect_success 'index-pack with --strict downgrading fsck msgs' '
> +	test_when_finished rm -rf strict &&
> +	git init strict &&
> +	(
> +		cd strict &&
> +		test_commit first hello &&
> +		cat >commit <<-EOF &&
> +		tree $(git rev-parse HEAD^{tree})
> +		parent $(git rev-parse HEAD)
> +		author A U Thor
> +		committer A U Thor
> +
> +		commit: this is a commit with bad emails
> +
> +		EOF
> +		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
> +		PACK=$(git pack-objects test <commit_list) &&
> +		test_must_fail git index-pack --strict "test-$PACK.pack" &&
> +		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
> +	)
> +'
> +
>  test_expect_success 'honor pack.packSizeLimit' '
>  	git config pack.packSizeLimit 3m &&
>  	packname_10=$(git pack-objects test-10 <obj-list) &&
