Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E719B1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbcHOW0v (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 18:26:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752985AbcHOW0m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 18:26:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 548E136FAC;
	Mon, 15 Aug 2016 18:26:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gcfroIpcMmsNdso9iNcXjOoqqP8=; b=W3PEip
	nXOglZRDtIvrFb5+q5z6aK7M8rVHv5kTOKOFw5vczYmI3UcqNtO5T5YOd2sEfwLJ
	8AKmLrpcQLe7PWkiuxWpZA1MzSCDZju4YLP1+kEqvN9pcBmTlf3JegZ79MqN/yXK
	ZT3P+JILQKg19yVP0ZDcNDZ+CUrVDdYogKzaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3HNzJfedYx2nB8t0ubF5M56RuvQnxXI
	h0TZVQdFr4IpicqC2dR2FIQ9axuvkLHg24OtgwjMT01JBGvBE4HpWfi/KpfgGPYq
	VBki2ZBaUil8ARlcGloCN6pUBT+CtLv4A6VkKKsYv2c8qHBoS8jn2/mvjnUqJF9s
	HZHgzpe7cEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B9E336FAB;
	Mon, 15 Aug 2016 18:26:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA05836FA9;
	Mon, 15 Aug 2016 18:26:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	"Tom Tanner \(BLOOMBERG\/ LONDON\)" <ttanner2@bloomberg.net>,
	davvid@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] difftool: always honor fatal error exit codes
References: <57B19B9F0205070000390238_0_29566@p057>
	<xmqqa8gdhjgd.fsf@gitster.mtv.corp.google.com>
	<20160815213526.6m7gu2v3fhtmx6wj@john.keeping.me.uk>
	<20160815215439.kwt4jmjrtcufjmih@john.keeping.me.uk>
Date:	Mon, 15 Aug 2016 15:26:38 -0700
In-Reply-To: <20160815215439.kwt4jmjrtcufjmih@john.keeping.me.uk> (John
	Keeping's message of "Mon, 15 Aug 2016 22:54:39 +0100")
Message-ID: <xmqq4m6lfz35.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 569606EE-6337-11E6-A174-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> Here's what that looks like.

Sounds good.  It feels a bit funny to see that new mentions of
$status are unquoted (which is totally valid because we know it has
$? that cannot be anything other than a short decimal integer),
while the one in the post-context quotes it, but that's not a huge
issue.

Will queue.  Thanks.

>  git-difftool--helper.sh | 7 +++++++
>  t/t7800-difftool.sh     | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 84d6cc0..7bfb673 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -86,6 +86,13 @@ else
>  	do
>  		launch_merge_tool "$1" "$2" "$5"
>  		status=$?
> +		if test $status -ge 126
> +		then
> +			# Command not found (127), not executable (126) or
> +			# exited via a signal (>= 128).
> +			exit $status
> +		fi
> +
>  		if test "$status" != 0 &&
>  			test "$GIT_DIFFTOOL_TRUST_EXIT_CODE" = true
>  		then
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 2974900..70a2de4 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -124,6 +124,12 @@ test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success PERL 'difftool honors exit status if command not found' '
> +	test_config difftool.nonexistent.cmd i-dont-exist &&
> +	test_config difftool.trustExitCode false &&
> +	test_must_fail git difftool -y -t nonexistent branch
> +'
> +
>  test_expect_success PERL 'difftool honors --gui' '
>  	difftool_test_setup &&
>  	test_config merge.tool bogus-tool &&
