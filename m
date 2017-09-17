Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E12E20A26
	for <e@80x24.org>; Sun, 17 Sep 2017 00:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdIQAqj (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 20:46:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50133 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751198AbdIQAqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 20:46:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5A85980E7;
        Sat, 16 Sep 2017 20:46:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=06z7eaCYzVZ+hddJefRf7SLVTCc=; b=CqkMO0
        oKwm4I6OWeu9SQJ+S/XoH8EQ/ZZs2/GtCQ5x6BeYOJQxCqdsT+hSitXmgI2JnA27
        kCcuUhyhNwbiDfJSVPAx0qxI9Av6uf0hnOcenrPFMWVGdtHpfpyUOp8gs72QG1Eh
        Yrck4S7z1bsgvbsl0pfc6V6lDPzb6cI3u8QTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MBeOb4xHHnVBnz4Z6jYsfD6N3tg7dXj7
        2YKC6boeUWfXVhpf6hpzer6dtw1g/92mdvR77lRmr0sS3B9ywDLf8DY6n0iiY44a
        7mGbdT9vgV5wkP5h229ekSFTPGyxaKujDCmHic2J1aJbXMdyx9yBQ8t71lKZypxc
        emLUuCyAjOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBEC4980E6;
        Sat, 16 Sep 2017 20:46:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29DD3980E5;
        Sat, 16 Sep 2017 20:46:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] add test for bug in git-mv for recursive submodules
References: <20170817103413.GA52233@book.hvoigt.net>
        <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
        <20170818160603.GA69414@book.hvoigt.net>
        <CAGZ79kYNLo_3PfLTOE5wusTs6wgFXZLVH+qNZ-ovxGguhinHLg@mail.gmail.com>
        <20170915115021.GB76244@book.hvoigt.net>
Date:   Sun, 17 Sep 2017 09:46:35 +0900
In-Reply-To: <20170915115021.GB76244@book.hvoigt.net> (Heiko Voigt's message
        of "Fri, 15 Sep 2017 13:50:21 +0200")
Message-ID: <xmqqlgleup78.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A931E27C-9B41-11E7-AFC3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> When using git-mv with a submodule it will detect that and update the
> paths for its configurations (.gitmodules, worktree and gitfile). This
> does not work for recursive submodules where a user renames the root
> submodule.
>
> We discovered this fact when working on on-demand fetch for renamed
> submodules. Lets add a test to document.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> On Fri, Aug 18, 2017 at 12:04:03PM -0700, Stefan Beller wrote:
>> > I just copied the shortcut that they were adding themselfes as submodule
>> > in 'setup submodule'. The whole setup of submodules in this test is like
>> > this. This way we already had a nested submodule structure which I could
>> > just add.
>> >
>> > I agree that this is unrealistic so I can change that in the test I am
>> > adding. But from what I have seen, this shortcut is taken in quite some
>> > places when dealing with submodules.
>> 
>> Please do not make it worse.
>> Once upon a time (late '16 IIRC) I had a series floating on the
>> list removing all occurrences, but there were issues with the
>> series and it did not land.
>
> Took a little while but here is a more clean patch creating individual
> submodules for the nesting.
>
> Cheers Heiko

Thanks.  Stefan, does this look good to you now?

It is not quite clear which step is expected to fail with the
current code by reading the test or the proposed log message.  Does
"mv" refuse to work and we do not get to run "status", or does
"status" report a failure, or do we fail well before that?

The log message that only says "This does not work when ..." is not
helpful in figuring it out, either.  Something like "This does not
work and fails to update the paths for its configurations" or
whatever that describes "what actually happens" (in contrast to
"what ought to happen", which you described clearly) should be
there.  

Description on how you happened to have discovered the issue feels a
lot less relevant compared to that, and it is totally useless if it
is unclear what the issue is in the first place.

>  t/t7001-mv.sh | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index e365d1ff77..cbc5fb37fe 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -491,4 +491,29 @@ test_expect_success 'moving a submodule in nested directories' '
>  	test_cmp actual expect
>  '
>  
> +test_expect_failure 'moving nested submodules' '
> +	git commit -am "cleanup commit" &&
> +	mkdir sub_nested_nested &&
> +	(cd sub_nested_nested &&
> +		touch nested_level2 &&
> +		git init &&
> +		git add . &&
> +		git commit -m "nested level 2"
> +	) &&
> +	mkdir sub_nested &&
> +	(cd sub_nested &&
> +		touch nested_level1 &&
> +		git init &&
> +		git add . &&
> +		git commit -m "nested level 1"
> +		git submodule add ../sub_nested_nested &&
> +		git commit -m "add nested level 2"
> +	) &&
> +	git submodule add ./sub_nested nested_move &&
> +	git commit -m "add nested_move" &&
> +	git submodule update --init --recursive &&
> +	git mv nested_move sub_nested_moved &&
> +	git status
> +'
> +
>  test_done
