Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF01C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2313D2075D
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 23:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a5JDIJMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbgFWXyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:54:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57748 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbgFWXyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 19:54:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91336D458E;
        Tue, 23 Jun 2020 19:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A76xjPqHp4k+WLjszOpSNTMUCAQ=; b=a5JDIJ
        MwKf0r2skyLWq/xDqQEPscP/IiYBGGyKU392XixwmlKP59zcffSDMqIkaYXVaHtx
        UuxmXNcSCMnVJM4v/dSqcTfO59danMPYUmT3urTyw1FeUki9+7wDB+I9Wq5av8+j
        lfCWaiBPeFyDVb7MlvaWONDuMNT9HxDRJv8N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jJ2wllhRzECCKaSxMjWAF98dBvuBulqz
        SuhwrraWpe2WLZpJXrA/u9k6iyi+BquRZXbQTYZc4c+QJjQdpHTVBOvCCOWS7b29
        YBus3QtBOYTZCB1WgHGW58Hj7BwIaO+035Nc34O4dm9RLXUWvWC1SydsDd6O0lca
        51eBidGZoiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8880FD458D;
        Tue, 23 Jun 2020 19:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0938D44B5;
        Tue, 23 Jun 2020 19:54:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5.1] lib-submodule-update: pass 'test_must_fail' as an argument
References: <cover.1592907663.git.liu.denton@gmail.com>
        <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
Date:   Tue, 23 Jun 2020 16:54:31 -0700
In-Reply-To: <7b9c19b3606f31b12a79591a41847dcb0a071751.1592942452.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 23 Jun 2020 16:21:20 -0400")
Message-ID: <xmqq4kr1bao8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E295EC4C-B5AC-11EA-B0EE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When $command is a helper function, the parent function calling
> test_submodule_switch_common() is test_submodule_switch_func(). For all
> test_submodule_switch_func() invocations, increase the granularity of
> the argument test helper function by prefixing the git invocation which is
> meant to fail with the second argument like this:
>
> 	$2 git checkout "$1"
>
> ...
> Finally, as an added bonus, `test_must_fail` will now only run on git
> commands.

> This patch replaces v5 4/4. Hopefully, this'll be the last iteration...

So three copies of v5.1 are identical replacement for 4/4, they seem.

> -			test_must_fail $command replace_sub1_with_directory &&
> +			$command replace_sub1_with_directory test_must_fail &&

> +# The following example uses `git some-command` as an example command to be
> +# tested. It updates the worktree and index to match a target, but not any
> +# submodule directories.
>  #
>  # my_func () {
> +#   ...prepare for `git some-command` to be run...
> +#   $2 git some-command "$1" &&
> +#   if test -n "$2"
> +#   then
> +#     return
> +#   fi &&

So, in practice $2 MUST BE either test_must_fail OR an empty
string.  Feeding the my_func anything other than these two values is
a BUG.  I wonder if we can somehow make sure to reduce mental burden
by readers.  Perhaps

> +git_test_func () {

	may_only_be_test_must_fail "$2"

> +	$2 git $gitcmd "$1"
> +}

where

	may_only_be_test_must_fail () {
		test -z "$1" || test "$1" = test_must_fail || die
	}

or something.  The idea is to make sure that this extra helper can
be named in such a way that it can serve as a documention to help
readers of "git_test_func ()" and others about "$2".

> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> index 788605ccc0..dd5daa53d3 100755
> --- a/t/t3426-rebase-submodule.sh
> +++ b/t/t3426-rebase-submodule.sh
> @@ -17,7 +17,7 @@ git_rebase () {
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&
> -	git rebase "$1"
> +	$2 git rebase "$1"

Likewise here.

Even without such a change this round reads much better than the
previous ones.

> An alternate design was considered where the global variable,
> $OVERWRITING_FAIL, is set from test_submodule_switch_common() and
> exposed to the helper function.  This would allow $command to be
> set to a more sensible value. However ...

By the way, I do not think this paragraph adds much value to the
message.  It wasn't clear how OVERWRITING_FAIL wanted to achieve its
goal back in its own commit, and without any actual code but with
only the four lines to go by, there is no chance that you can
convince anybody how $command could have been "more sensible value".

Thanks.

