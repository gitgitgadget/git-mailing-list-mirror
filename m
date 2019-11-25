Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B52C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345CD20748
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+EhUAwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKYCDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:03:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62527 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKYCDX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 21:03:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7D412B736;
        Sun, 24 Nov 2019 21:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W+zSrl2l8ljf9eaoyQoWLguVBGM=; b=c+EhUA
        wqfP3/GY2B85kPlAUUCn2tHSkj6fRjrYu/lskIDIEqC723cvdPWy+KEvRhkdXwnb
        Ksf8SZIaWifRNFFh9+t+jL6NK3TkqqwvsJeRY5GhvZ/FHv+EMcNlEzccnihhiX2J
        i7dpfYC21idX8/Itt0wDddSZg3JIpZBPcKq0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qvbQSVzeW2MZODB/lLcoAbav6B2HppwU
        fm6WY8cdmTm1lMGDALP+wLUuRka5BNVTTMLvKlANWJg1jVFwEP0zigHypBlaGx4G
        0upK+ODmRpfKK4ufYWImxdtr9StYA8tyyNVSqSpBlxlGuqw80EGdwzGY0UG6UYGF
        PDr/jFIk4ZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFC562B735;
        Sun, 24 Nov 2019 21:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CE222B734;
        Sun, 24 Nov 2019 21:03:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH v2 1/1] reset: parse rev as tree-ish in patch mode
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
        <pull.474.v2.git.1574627149.gitgitgadget@gmail.com>
        <a608dc8368c6fc738393dac46618f12e25d40eaf.1574627149.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 11:03:16 +0900
In-Reply-To: <a608dc8368c6fc738393dac46618f12e25d40eaf.1574627149.git.gitgitgadget@gmail.com>
        (Nika Layzell via GitGitGadget's message of "Sun, 24 Nov 2019 20:25:49
        +0000")
Message-ID: <xmqq7e3ozp97.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF260BB0-0F27-11EA-B75F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nika Layzell <nika@thelayzells.com>
>
> Since 2f328c3d ("reset $sha1 $pathspec: require $sha1 only to be
> treeish", 2013-01-14), we allowed "git reset $object -- $path" to reset
> individual paths that match the pathspec to take the blob from a tree
> object, not necessarily a commit, while the form to reset the tip of the
> current branch to some other commit still must be given a commit.
>
> Like resetting with paths, "git reset --patch" does not update HEAD, and
> need not require a commit. The path-filtered form, "git reset --patch
> $object -- $pathspec", has accepted a tree-ish since 2f328c3d.
>
> "git reset --patch" is documented as accepting a <tree-ish> since
> bf44142f ("reset: update documentation to require only tree-ish with
> paths", 2013-01-16). Documentation changes are not required.
>
> Loosen the restriction that requires a commit for the unfiltered "git
> reset --patch $object".
>
> Signed-off-by: Nika Layzell <nika@thelayzells.com>
> ---

Nicely explained.

> diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
> index bd10a96727..fc2a6cf5c7 100755
> --- a/t/t7105-reset-patch.sh
> +++ b/t/t7105-reset-patch.sh
> @@ -38,6 +38,27 @@ test_expect_success PERL 'git reset -p HEAD^' '
>  	test_i18ngrep "Apply" output
>  '
>  
> +test_expect_success PERL 'git reset -p HEAD^^{tree}' '
> +	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
> +	verify_state dir/foo work parent &&
> +	verify_saved_state bar &&
> +	test_i18ngrep "Apply" output
> +'
> +
> +test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
> +	set_and_save_state dir/foo work work &&
> +	test_must_fail git reset -p HEAD^:dir/foo &&
> +	verify_saved_state dir/foo &&
> +	verify_saved_state bar
> +'
> +
> +test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
> +	set_and_save_state dir/foo work work &&
> +	test_must_fail git reset -p aaaaaaaa &&
> +	verify_saved_state dir/foo &&
> +	verify_saved_state bar
> +'

Thanks, will queue.
