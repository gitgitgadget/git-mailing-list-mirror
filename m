Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572971F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 07:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfJBHCz (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 03:02:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51432 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJBHCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 03:02:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 057023616C;
        Wed,  2 Oct 2019 03:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7x1zZUaHEP39CVDLK9Nt3tdu6o=; b=Qk414z
        JR4Tw/qd63F+oH4dsyNcVFxodPpdqR6vliYBirmY1emsj/bE3WpKmLlZhxv/hJYH
        uqdImczPmxnBMt7l1vQmjORWpywl/pGaOBdVcptZGuPP4/MpRglrxvMdPVPU7eDO
        v4/786kJqbtsedIAE5LVYqUkW861Dh63AH+0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A73a7fc83J+adwKNV3K66+GZsjZ1avyR
        FYc8lorNlFWidP1qYmOuqPCpkDalA74Yd9MvmApFggBjvH9nD4vrwNGCaZSrvmna
        bOZdkyqunH4z7d7Vapc2GCJurc3Aqto+wERNb3VpxsL0r1YuWnAKaTZMpC+Sdxur
        4jpe3XeIUVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F03113616B;
        Wed,  2 Oct 2019 03:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56A2E3616A;
        Wed,  2 Oct 2019 03:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Zehner <cbzehner@gmail.com>
Subject: Re: [PATCH 1/1] gitignore: ignore comments on the same line as a pattern
References: <pull.370.git.gitgitgadget@gmail.com>
        <e448214e87b46dc649781b10727043bc390d9aab.1569985991.git.gitgitgadget@gmail.com>
Date:   Wed, 02 Oct 2019 16:02:51 +0900
In-Reply-To: <e448214e87b46dc649781b10727043bc390d9aab.1569985991.git.gitgitgadget@gmail.com>
        (Chris Zehner via GitGitGadget's message of "Tue, 01 Oct 2019 20:13:13
        -0700 (PDT)")
Message-ID: <xmqqpnjfeijo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6CCED78-E4E2-11E9-86A8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Zehner via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -   that begin with a hash.
> +   Put a backslash ("`\`") in front of each hash for patterns
> +   containing a hash.
> +
> + - A # after a pattern will be treated as the start of a comment.
> +   Put a backslash ("`\`") in front of each hash for patterns
> +   containing a hash.

Besides being backward incompatible, this looks somewhat misdesigned
by lacking a way to escape a backslash (i.e. what should a project
do if they want a patttern with backslash followed by a hash
literally in there?).

> diff --git a/dir.c b/dir.c
> index cab9c2a458..aeefe142bc 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -658,6 +658,38 @@ void clear_pattern_list(struct pattern_list *pl)
>  	memset(pl, 0, sizeof(*pl));
>  }
>  
> +static void trim_trailing_comments(char *buf)
> +{
> +	char *p, *last_hash = NULL;
> +	int escape_seq = 0;
> +
> +	for (p = buf; *p; p++)
> +	{

Style (see Documentation/CodingGuidelines).  The opening parenthesis
of a control structure like if/for/switch are placed on the same
line, i.e.

	for (p = buf; *p; p++) {

Do we even need a separate 'p', instead of scanning with 'buf' itself?

> +		if (!*p)
> +			return;

What happens when an entry ends with '\' followed by an EOL?  IOW,
what if escape_seq is true here?

> +		switch (*p) {
> +		case '#':
> +			if (escape_seq)
> +			{
> +				escape_seq = 0;
> +				p++;
> +				break;
> +			}
> +			if (!last_hash)
> +				last_hash = p;
> +			break;
> +		case '\\':
> +			escape_seq = 1;
> +			break;
