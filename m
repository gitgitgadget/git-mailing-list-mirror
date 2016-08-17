Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DCF1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbcHQTS4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 15:18:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753053AbcHQTSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 15:18:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8812134CEC;
	Wed, 17 Aug 2016 15:18:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mViQNsc6GegecPEzVaCRkmkQ6A8=; b=nfW1t8
	L5jr3Mu7taNJjkUH9i9cM2V+WFtAJkI6JYqqxkAxEL0l1+oEY1xExG0z8mEMffio
	jSLw5VVjGUFRxOqSGOlRJlzt4urGESeZw6y2gSwPlx12do0IJt2ugxQJRCvUsJmY
	/AFEKBMBfMuLcvmAfrwhnOXamdp+xIxPIRBsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WLkJFpTJEynWeoc5781nBx4n4n56eHRI
	sMmm/eM5tbZ6nzuAhLMJbfkyaH9DGgX5+LChQa5HLXz5pCJTZ7Bc0/KAy9Y+zMuY
	PzGjKWqFEvKLkvRw1Zto/rtzn6n1QQ/maSL8bPzpNiM4XZ7tVsRwOpip41H9yT3M
	MAZLHfjF7V8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FBED34CEA;
	Wed, 17 Aug 2016 15:18:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45E9934CE9;
	Wed, 17 Aug 2016 15:18:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v2 2/3] diff-highlight: add failing test for handling --graph output.
References: <20160817153124.7770-1-henderson.bj@gmail.com>
	<20160810085635.GA1672@starla>
	<20160817153124.7770-3-henderson.bj@gmail.com>
Date:	Wed, 17 Aug 2016 12:18:01 -0700
In-Reply-To: <20160817153124.7770-3-henderson.bj@gmail.com> (Brian Henderson's
	message of "Wed, 17 Aug 2016 08:31:23 -0700")
Message-ID: <xmqqvayz8as6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51A18284-64AF-11E6-A65B-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
> ---
>  contrib/diff-highlight/t/t9400-diff-highlight.sh | 13 +++++++
>  contrib/diff-highlight/t/test-diff-highlight.sh  | 43 ++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> index 8eff178..39707c6 100755
> --- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -59,4 +59,17 @@ test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
>  
>  # TODO add multi-byte test
>  
> +test_expect_success 'diff-highlight highlights the beginning of a line' '
> +	dh_graph_test \
> +		"aaa\nbbb\nccc\n" \
> +		"aaa\n0bb\nccc\n" \
> +		"aaa\nb0b\nccc\n" \
> +"
> + aaa
> +-${CW}b${CR}bb
> ++${CW}0${CR}bb
> + ccc
> +"
> +'

Is this expected to pass after applying 1/3 and 2/3?  The title says
"add faililng test", so I am assuming this is expected to fail, in
which case the test should start out as "test_expect_failure".  A
later patch that makes it pass should turn "test_expect_failure"
into "test_expect_success".

>  test_done
> diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
> index 38323e8..67f742c 100644
> --- a/contrib/diff-highlight/t/test-diff-highlight.sh
> +++ b/contrib/diff-highlight/t/test-diff-highlight.sh
> @@ -64,6 +64,49 @@ dh_commit_test() {
>  	test_cmp commit.exp commit.act
>  }
>  
> +dh_graph_test() {
> +	a="$1" b="$2" c="$3"
> +
> +	{
> +		printf "$a" >file
> + ...
> +		git merge master
> +		git checkout master
> +		git merge branch --no-ff
> +	} >/dev/null 2>&1
> +
> +	git log -p --graph --no-merges >graph.raw

Hmph, when does it make sense to have "--no-merges" together with
"--graph".  Doesn't it result in a disconnected mess?  Is that an
interesting and most often used case?

> +
> +	# git log --graph orders the commits different than git log so we hack it by
> +	# using sed to remove the graph part.

Would it help if you knew "log --topo-order" to remove the "hack"?
