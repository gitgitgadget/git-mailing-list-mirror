Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A17F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uk5Q0cYQ"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E12BA2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 21:59:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 983DC2A601;
	Wed,  1 Nov 2023 00:59:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4al+hV/T7jozhfBngD4vUdYctx26OR3+tok6lQ
	wjiaQ=; b=Uk5Q0cYQTEujSSAC6fqZ3L/Ad9hpNgAGrQLpq0IJgMxvaAOuAbO11u
	V0YE4b+/y8Nv4MBd30vxYpogbf7hXR9xPQQoydfuTaATAt1pAAnJpD6rd5g1+022
	RI24PPFRcgyqRDERuxWZSz5tPZFLNB6k6Ap24u1eZ1SYuTCXetlb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 90B012A600;
	Wed,  1 Nov 2023 00:59:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D78B2A5FF;
	Wed,  1 Nov 2023 00:59:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Tony Tung
 <tonytung@merly.org>
Subject: Re: [PATCH v2 1/2] sequencer: remove use of comment character
In-Reply-To: <10598a56d64f5c2b4d8d05d7e7b09a18ef254f88.1698728953.git.gitgitgadget@gmail.com>
	(Tony Tung via GitGitGadget's message of "Tue, 31 Oct 2023 05:09:11
	+0000")
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
	<10598a56d64f5c2b4d8d05d7e7b09a18ef254f88.1698728953.git.gitgitgadget@gmail.com>
Date: Wed, 01 Nov 2023 13:59:14 +0900
Message-ID: <xmqqlebit6fx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6854C27C-7873-11EE-9F4E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Tony Tung via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 1/2] sequencer: remove use of comment character

The patch does not seem to be doing that, though.  It may have
removed '#' in "# Ref", but still uses comment_line_char, so it does
not remove use at all (and we do not want to, of course).

"use the core.commentchar consistently"

> From: Tony Tung <tonytung@merly.org>
>
> Instead of using the hardcoded `# `, use the
> user-defined comment_line_char.  Adds a test
> to prevent regressions.

Overly short lines.

The readers cannot tell where in the output the hardcoded # appears
with the above description. I am guessing that it is in comments in
the sequencer/todo file that mark commits that are at the tip of
branches that are checked out, but there may be more specific
circumstances in which the comment is used, like "when rebase -i is
used with the --update-refs option", if so that also need to be told
to the readers.

Describe the condition well enough so that readers can easily see
the defect the patch attempts to fix.

> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
> -				    decoration->name, path);
> +			strbuf_commented_addf(ctx->buf, comment_line_char,
> +					      "Ref %s checked out at '%s'\n",
> +					      decoration->name, path);

OK.
