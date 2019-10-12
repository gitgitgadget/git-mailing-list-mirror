Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D161F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 01:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfJLBqn (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:46:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61134 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfJLBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:46:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD6C8234D;
        Fri, 11 Oct 2019 21:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=igp1waEdS8PY7xtokg0pK0+0osM=; b=Iy7iJS
        jL/6R7oKfdQ0Xu74y+a65vtREJntxpw6dAYpgaNYt6KPsiRcx79N7ah386YEZs+B
        y2Bf+5OmJgPK7PeG12tSD6EQFmEsUE7dYCBg0TEh1eAYoP7rrkwRAbQ46E4ERw7c
        Mw+3MBhYEISSeECjj/BuCj89hcpNbQ1hW40z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GeH8tRYv8kneXisGPHQxe/UK7ZkxSXGz
        4SKGJoHsmDJ72QhmQescHye9LaBU0THtzg4Zx19EH1yKDIewB68RbI9lQlztCJT/
        0xQV/SZbN1KCT4tBYSqKur+8+/PGyng30DFGNfGOnl3nUwVJ8Cp1PRGftR5OCM+8
        0Cxvz9FRlOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58A528234C;
        Fri, 11 Oct 2019 21:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 860EE8234B;
        Fri, 11 Oct 2019 21:46:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakob Jarmar <jakob.j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] stash: avoid recursive hard reset on submodules
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
        <20191011001114.GB640501@OJAN-PAAVO.localdomain>
        <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
        <20191011222448.GA650182@OJAN-PAAVO.localdomain>
Date:   Sat, 12 Oct 2019 10:46:36 +0900
In-Reply-To: <20191011222448.GA650182@OJAN-PAAVO.localdomain> (Jakob Jarmar's
        message of "Sat, 12 Oct 2019 00:24:48 +0200")
Message-ID: <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21A96CB8-EC92-11E9-9B98-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakob Jarmar <jakob.j@gmail.com> writes:

> diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
> index d7219d6f8f..83106fa958 100755
> --- a/t/t3906-stash-submodule.sh
> +++ b/t/t3906-stash-submodule.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='stash apply can handle submodules'
> +test_description='stash can handle submodules'

Good attention to the detail ;-)

> +setup_basic() {

Style.  SP on both sides of () in our shell scripts (as seen in the
existing shell function in the same file).

> +	git init sub &&
> +	(
> +		cd sub &&
> +		test_commit sub_file
> +	) &&
> +	git init main &&
> +	(
> +		cd main &&
> +		git submodule add ../sub &&
> +		test_commit main_file
> +	) &&
> +	test_when_finished "rm -rf main sub"

Have test_when_finished that removes main and sub _before_ you start
creating sub and main.  

When the &&-cascade breaks anywhere, the control may not even reach
your test_when_finished that registers the clean-up procedure.
Imagine "git init sub" succeeds but "git init main" somehow
fails---you still want to clean up "sub".

Other than that, looks reasonably well done.  

Thanks for working on this.


> +}
> +
> +test_expect_success 'stash push with submodule.recurse=true preserves dirty submodule worktree' '
> +	setup_basic &&
> +	(
> +		cd main &&
> +		git config submodule.recurse true &&
> +		echo "x" >main_file.t &&
> +		echo "y" >sub/sub_file.t &&
> +		git stash push &&
> +		test_must_fail git -C sub diff --quiet
> +	)
> +'
> +
> +test_expect_success 'stash push and pop with submodule.recurse=true preserves dirty submodule worktree' '
> +	setup_basic &&
> +	(
> +		cd main &&
> +		git config submodule.recurse true &&
> +		echo "x" >main_file.t &&
> +		echo "y" >sub/sub_file.t &&
> +		git stash push &&
> +		git stash pop &&
> +		test_must_fail git -C sub diff --quiet
> +	)
> +'
> +
>  test_done
