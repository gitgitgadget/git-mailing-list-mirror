Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5CC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B7A22247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ry3Ua8bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438490AbgJTUdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:33:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61082 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438479AbgJTUdt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:33:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61CF074451;
        Tue, 20 Oct 2020 16:33:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JeS0u2fNvyhzq2HuW0dqo+WMlSE=; b=ry3Ua8
        bvt+LYGBGO/UKjjHv7H+ancKnzQTf9eS4Ks3sxWptUw/XZEjFgZRTSL9m1H0GnGL
        vCFPY3Pl65KB/vNIk20OU+BRSUxjYKeVu51q287vocCxao6e8qqGeLx6QBLTJ0Ja
        MkUDothYR0kAh6e38gPD/vZD2X1xKG6qG9oxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i9XSCxpkSISxbFerkisk3DGPepSLAFaH
        06Y21wjvm6n5idzkH0XLH2K8ih+vZiOEKkTWbsL1xjt0wS3LGT3LgLjpawIHXRIb
        16Vya7kSd3EdfTrscl+41K/j1mqogRKPI3hXQcJEQLGpTi1oZOuxt6BrtBpCYxl6
        DYLjrh93jiY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 585A874450;
        Tue, 20 Oct 2020 16:33:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D32C17444E;
        Tue, 20 Oct 2020 16:33:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] sideband: avoid reporting incomplete sideband
 messages
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603136143.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:33:46 -0700
In-Reply-To: <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603136143.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:35:40 +0000")
Message-ID: <xmqqwnzkab85.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DC6980A-1313-11EB-B1EF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 2b695ecd74d (t5500: count objects through stderr, not trace,
> 2020-05-06) we tried to ensure that the "Total 3" message could be
> grepped in Git's output, even if it sometimes got chopped up into
> multiple lines in the trace machinery.
> ...
> The correct way to fix this is to return from `demultiplex_sideband()`
> early. The caller will then write out the contents of the primary packet
> and continue looping. The `scratch` buffer for incomplete sideband
> messages is owned by that caller, and will continue to accumulate the
> remainder(s) of those messages. The loop will only end once
> `demultiplex_sideband()` returned non-zero _and_ did not indicate a
> primary packet, which is the case only when we hit the `cleanup:` path,
> in which we take care of flushing any unfinished sideband messages and
> release the `scratch` buffer.
>
> To ensure that this does not get broken again, we introduce a pair of
> subcommands of the `pkt-line` test helper that specifically chop up the
> sideband message and squeeze a primary packet into the middle.
>
> Final note: The other test case touched by 2b695ecd74d (t5500: count
> objects through stderr, not trace, 2020-05-06) is not affected by this
> issue because the sideband machinery is not involved there.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Nicely explained.  Do we want to also give credit to Peff for the
single-liner fix here, perhaps with a suggested/helped-by trailer?

>  sideband.c               |  2 +-
>  t/helper/test-pkt-line.c | 23 +++++++++++++++++++++++
>  t/t0070-fundamental.sh   |  6 ++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/sideband.c b/sideband.c
> index 0a60662fa6..a5405b9aaa 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -190,7 +190,7 @@ int demultiplex_sideband(const char *me, char *buf, int len,
>  		return 0;
>  	case 1:
>  		*sideband_type = SIDEBAND_PRIMARY;
> -		break;
> +		return 1;
>  	default:
>  		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
>  			    scratch->len ? "\n" : "", me, band);

> diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
> index 69152958e5..0bf20642be 100644
> --- a/t/helper/test-pkt-line.c
> +++ b/t/helper/test-pkt-line.c
> @@ -84,6 +84,25 @@ static void unpack_sideband(void)
>  	}
>  }
>  
> +static int send_split_sideband(void)
> +{
> +	const char *part1 = "Hello,";
> +	const char *primary = "\001primary: regular output\n";
> +	const char *part2 = " world!\n";
> +
> +	send_sideband(1, 2, part1, strlen(part1), LARGE_PACKET_MAX);
> +	packet_write(1, primary, strlen(primary));
> +	send_sideband(1, 2, part2, strlen(part2), LARGE_PACKET_MAX);
> +	packet_response_end(1);
> +
> +	return 0;
> +}

OK.

> +static int receive_sideband(void)
> +{
> +	return recv_sideband("sideband: ", 0, 1);
> +}
> +
>  int cmd__pkt_line(int argc, const char **argv)
>  {
>  	if (argc < 2)
> @@ -95,6 +114,10 @@ int cmd__pkt_line(int argc, const char **argv)
>  		unpack();
>  	else if (!strcmp(argv[1], "unpack-sideband"))
>  		unpack_sideband();
> +	else if (!strcmp(argv[1], "send-split-sideband"))
> +		send_split_sideband();
> +	else if (!strcmp(argv[1], "receive-sideband"))
> +		receive_sideband();
>  	else
>  		die("invalid argument '%s'", argv[1]);
>  
> diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
> index 7b111a56fd..357201640a 100755
> --- a/t/t0070-fundamental.sh
> +++ b/t/t0070-fundamental.sh
> @@ -34,4 +34,10 @@ test_expect_success 'check for a bug in the regex routines' '
>  	test-tool regex --bug
>  '
>  
> +test_expect_success 'incomplete sideband messages are reassembled' '
> +	test-tool pkt-line send-split-sideband >split-sideband &&
> +	test-tool pkt-line receive-sideband <split-sideband 2>err &&
> +	grep "Hello, world" err
> +'
> +
>  test_done
