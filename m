Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9F8205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbdAIBiG (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 20:38:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61112 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751836AbdAIBiF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 20:38:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A13F85E961;
        Sun,  8 Jan 2017 20:38:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lyi1qTGJ4zXNpsAqDtZ8zamI9yk=; b=h1/8ga
        4a5DeXvRQpgNxet8ztw4bIB2l+JunfgvTkSuGGlHjizJAiI/speClcNr+zkvVmLx
        mCJfLkJEOiPSFBFgn5/nd+TASN1YLLlVqJexrv3fDpWguu0+So0zd/Ql+U81PMJ3
        OaHY+a8oU+hJe+FO6+G6gyCSHDhgzc7DtZtFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QjxL/ksujoqR0HZ6+sAnoB4LtPVUvDYa
        bSmDXnhvrLNlH83R1cNb2H0BV52zVvh8c3sD9dYGr9/B8J4M/yrK467oyCEdYgfO
        JvIPMS7wBqXsvOKZiLfvsku9LfhoHhMKAEHVDkTLHD5H3Zp3KnyKsb2UxSKIV0c3
        J5CNj0GxlkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 998F75E960;
        Sun,  8 Jan 2017 20:38:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 044585E95F;
        Sun,  8 Jan 2017 20:38:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 4/4] t7800: run both builtin and scripted difftool, for now
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
        <cover.1483373635.git.johannes.schindelin@gmx.de>
        <0ae4a950a4cd2c8c4f05a6b46c60f127611580cf.1483373635.git.johannes.schindelin@gmx.de>
Date:   Sun, 08 Jan 2017 17:38:01 -0800
In-Reply-To: <0ae4a950a4cd2c8c4f05a6b46c60f127611580cf.1483373635.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 17:24:20 +0100
        (CET)")
Message-ID: <xmqqtw99ypvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42D11412-D60C-11E6-A486-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is uglier than a simple
>
> 	touch "$GIT_EXEC_PATH/use-builtin-difftool"
>
> of course. But oh well.

That is totally irrelevant.  

The more important point is that we do the same set of tests so
instead of running just one, we run BOTH.  If we did a bit more
work, we could even say "even when there is no Perl installed, we
run tests with only the new built-in one".  This does not go that
far yet, but that should not be too hard, I would think.  See below.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index e94910c563..273ab55723 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -23,6 +23,20 @@ prompt_given ()
>  	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
>  }
>  
> +for use_builtin_difftool in false true
> +do

Instead of the above, I'd suggest to make the loop like so:

	for use_builtin_difftool in $TESTED_VARIANTS
	do

and before the loop begins, set TESTED_VARIANTS to either "false
true" or "true" by checking the PERL prerequisite.

> +test_expect_success 'verify we are running the correct difftool' '
> +	if test true = '$use_builtin_difftool'
> +	then
> +		test_must_fail ok=129 git difftool -h >help &&
> +		grep "g, --gui" help
> +	else
> +		git difftool -h >help &&
> +		grep "g|--gui" help
> +	fi
> +'
> +
>  # NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.

And then we can lose this comment.  As all existing tests have PERL
prereq that can go away with the above suggested change, we'd need
to touch quite a many lines with "s/_success PERL /_success /".

It may be a good time to indent these existing tests to make it
clear that they are inside the new "for use_builtin_difftool" loop.


> +test true != $use_builtin_difftool || break
> +
> +test_expect_success 'tear down for re-run' '
> +	rm -rf * .[a-z]* &&
> +	git init
> +'
> +
> +# run as builtin difftool now
> +GIT_CONFIG_PARAMETERS="'difftool.usebuiltin=true'"
> +export GIT_CONFIG_PARAMETERS

... and indentation would extend to these newly added lines, of
course.

> +done
> +
>  test_done
