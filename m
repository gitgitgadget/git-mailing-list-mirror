Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F5C142
	for <git@vger.kernel.org>; Sun, 12 May 2024 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715486990; cv=none; b=PXOXIOc76qBSmxRlwR6J6zqb93aenYN9eeqKEzs6VYtijJPdOdqeZ0/BakOhJ36/cEXOL/pD1NERXjvzyyBK2DMbLY16ltwalmu4CzJUZDUZCqiBckxdnaEtU+8t0PkoLSmGnDVFl3VqfCVzIoSksr/yq1HvqCU6z81ZnMXxirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715486990; c=relaxed/simple;
	bh=LABs4aKD9lksEpFNaU6AL4bVprJ5lR5rnFZdwC4CdzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HuB50TlzbnH/U2wx9WwqivTa7DvVnHYvlAvxKIh4sqLBlBg2I8n+xEv+p36TOZRKxYCqpjUJfklklWA/i/R9YfbLTLEEY27pxwFifXH5g4SgdNx7FYIXZylRQVWdLSWa670YYFuEVQ4h4e9ArYNz9SRlyF+s5Se5DdiruvhKVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pmS/pM33; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pmS/pM33"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 09E3124461;
	Sun, 12 May 2024 00:09:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LABs4aKD9lksEpFNaU6AL4bVprJ5lR5rnFZdwC
	4CdzI=; b=pmS/pM33q2RvKCUV2Kl/zMvvIMRD7agfLgPP741oHueRnBiO6IvAOA
	u22WFG/P9sTdX57q6u51WD6b+vHpu16iHmPo0vFt0SOKDLVx4dPY40a0vzuK0GGp
	XoZ2eK6pidb/wSPUu8iwGkb4gTQOp1yl0B9yp0IQtZpuqUGbwvr6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 02D0824460;
	Sun, 12 May 2024 00:09:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F1822445D;
	Sun, 12 May 2024 00:09:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Bo Anderson <mail@boanderson.me>,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2 1/2] osxkeychain: lock for exclusive execution
In-Reply-To: <309c17c78f35296dd47e8b203413860eb62b239e.1715428542.git.gitgitgadget@gmail.com>
	(Koji Nakamaru via GitGitGadget's message of "Sat, 11 May 2024
	11:55:41 +0000")
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
	<pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
	<309c17c78f35296dd47e8b203413860eb62b239e.1715428542.git.gitgitgadget@gmail.com>
Date: Sat, 11 May 2024 21:09:42 -0700
Message-ID: <xmqqseynisc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 762BECC4-1015-11EF-BE3B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> Resolves "failed to store: -25299" when "fetch.parallel 0" is configured
> and there are many submodules.

Use of third-person singular without subject for the "observation"
part is highly unusual the log messages in our codebase.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

> The error code -25299 (errSecDuplicateItem) may be returned by
> SecItemUpdate() in add_internet_password() if multiple instances of
> git-credential-osxkeychain run in parallel. This patch introduces an
> exclusive lock to serialize execution for avoiding this and other
> potential issues.

"This patch introduces" -> "Introduce"

Is this step still needed, though?

> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 6a40917b1ef..0884db48d0a 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -414,6 +414,9 @@ int main(int argc, const char **argv)
>  	if (!argv[1])
>  		die("%s", usage);
>  
> +	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)
> +		die("failed to lock %s", argv[0]);
> +
>  	read_credential();
>  
>  	if (!strcmp(argv[1], "get"))
