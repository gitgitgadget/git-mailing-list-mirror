Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525E420229
	for <e@80x24.org>; Thu, 10 Nov 2016 19:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935257AbcKJTU5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 14:20:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935024AbcKJTUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 14:20:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BF634DCFE;
        Thu, 10 Nov 2016 14:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jkKcYJBVvOQMiPhM/IhXAsRsUpM=; b=B7EKe6
        pcGB0Y7kyRDBnoZYo8W8FihaCa3WwQuT8rEVHCRBoOc+49dlWkX80dJIojXdy/ax
        Mr4sSGVVhGmuTfH4r+pyw2NrxHPiUavDbM3b93PuDxFFxg3U231VsfQt0MtlvK8p
        ZzBkoMlp286Ipk8jSZzpg9h8ntKu04PrEqrkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tG8teAqmgcQblhf4j0RFGqMeUbRf+Km+
        W76th9pHlW57oz09cohsCgFqiixeQOUtpiQgDpTyZmyNnXpItzD35jrQMpzpPxUJ
        QLIiZ9KVI03pi20GzNrNErKv4Sexe2HG55SEgl6t6LhpCynSXUgM2qKb7TR8e+Cv
        8Jqp+xWGB7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 937304DCFD;
        Thu, 10 Nov 2016 14:20:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9B734DCFB;
        Thu, 10 Nov 2016 14:20:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
        <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611091437280.72596@virtualbox>
        <mvmzil8btzb.fsf@hawking.suse.de>
        <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
        <mvm8tsrbusp.fsf_-_@hawking.suse.de>
Date:   Thu, 10 Nov 2016 11:20:42 -0800
In-Reply-To: <mvm8tsrbusp.fsf_-_@hawking.suse.de> (Andreas Schwab's message of
        "Thu, 10 Nov 2016 09:31:18 +0100")
Message-ID: <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C66F7414-A77A-11E6-9E74-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
> of test case") added a kill command to clean up after the test, but this
> can fail if the sleep command exits before the cleanup is executed.
> Ignore the error from the kill command.
>
> Explicitly check for the existence of the pid file to test that the merge
> driver was actually called.
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---

OK.  sleep.pid is a reasonable easy-to-access side effect we can
observe to make sure that the sleep-one-second merge driver was
indeed invoked, which was missing from the earlier round.

Thanks, will apply.

>  t/t6026-merge-attr.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 7a6e33e673..03d13d00b5 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -187,13 +187,14 @@ test_expect_success 'custom merge does not lock index' '
>  		sleep 1 &
>  		echo $! >sleep.pid
>  	EOF
> -	test_when_finished "kill \$(cat sleep.pid)" &&
> +	test_when_finished "kill \$(cat sleep.pid) || :" &&
>  
>  	test_write_lines >.gitattributes \
>  		"* merge=ours" "text merge=sleep-one-second" &&
>  	test_config merge.ours.driver true &&
>  	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
> -	git merge master
> +	git merge master &&
> +	test -f sleep.pid
>  '
>  
>  test_done
> -- 
> 2.10.2
