Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AC31F731
	for <e@80x24.org>; Wed,  7 Aug 2019 05:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHGFiR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 01:38:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfHGFiR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 01:38:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1E6C188336;
        Wed,  7 Aug 2019 01:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A6IxrFy6CQ9NbnVrHE5kTLVRYDo=; b=RoTH0S
        u1MTmOEVdAmfCvxW1qtcLGVpqOKLr6ycrvQ95Lbka8AjJPXsWqBzx49+xmz43WMt
        VlkpXv0VU36ZKAVocr55Qobl4MlvmVAIEJGHVsVuyqz0cbWA8nbs/X8Gd6j3VkEG
        Lg1UkGk3M7RA+xbb+w5Kz0mXXGmeN8SZRv1rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u/53IhqCnJqHJQQzq1uBE6Nku1HcgiYA
        lcfVdp6BVwOajlPER/nCgpQllWZoKRoMrQcJUcDKk7pqCScednKuM+o2ySrJqU80
        Tln5TSXQM9Xx+iLF72IanoLAPIhL7GcqGhC8wfyrjwYqXGxieG+YVtvQKHbwaJze
        TdQ8kjdTqMg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16DC688335;
        Wed,  7 Aug 2019 01:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4359788334;
        Wed,  7 Aug 2019 01:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
Subject: Re: [GSoC][PATCHl 1/6] rebase -i: add --ignore-whitespace flag
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190806173638.17510-2-rohit.ashiwal265@gmail.com>
Date:   Tue, 06 Aug 2019 22:38:09 -0700
In-Reply-To: <20190806173638.17510-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 6 Aug 2019 23:06:33 +0530")
Message-ID: <xmqqimr9ilha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BB48E08-B8D5-11E9-97A2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index db6ca9bd7d..3c195ddc73 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> ...
> @@ -511,6 +523,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, NULL, options,
>  			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);

Curious.  Did you rebase onto an older codebase?  I think the round
currently queued in my tree already has c0e78f7e46 which merged the
jk/unused-params-final-batch topic that updated this call to
parse_options() to pass prefix.  Perhaps you want to fetch from me
what has been on 'pu' (it should be "log master..10827432") and
compare what you had?  Unless there is no compelling reason not to,
it would be a good idea to base the reroll on the same commit as
the commit on which the previous version has been queued, which in
this case is 9c9b961d ("The sixth batch", 2019-07-19).

> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> new file mode 100755
> index 0000000000..e617d3150e
> --- /dev/null
> +++ b/t/t3433-rebase-options-compatibility.sh
> @@ -0,0 +1,65 @@
> ...
> +
> +	git checkout --orphan master &&
> +	cat >file <<-EOF &&
> +	line 1
> +	        line 2
> +	line 3
> +	EOF

The second line triggers "indent with spaces" whitespace error; you
can protect these spaces in the leading indent like so:

	sed -e "s/^|//" <<-\EOF &&
	|line 1
	|        line 2
	|line 3
	EOF

Also make it a habit to always quote the EOF token that begins the
here document (i.e. <<-\EOF) when the here document does not need
variable interpolation.  I suspect (but I did not read all of the
tests) that there may be many other instances of here document in
this patch that can use the same improvement.

Thanks.
