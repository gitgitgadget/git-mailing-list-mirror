Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C43920281
	for <e@80x24.org>; Thu, 28 Sep 2017 10:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdI1Kft (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 06:35:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55418 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752609AbdI1Kfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 06:35:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3011B3E03;
        Thu, 28 Sep 2017 06:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3aa5ce5MAmDnmfVccGf4Avyl1k0=; b=PC+lHq
        UtY6Jc2QnsrAoPQz7hjoOHnfRLPBmPC53rI96MbXMb9r5bv4WQ7Hf9U7xZzkok6Q
        gnTbXa9dByrRqZUopVCUkACKJ3l/wAFyr5bm9vr47/OlszV5a9Xgm7v6A/X4cdWy
        ChXr//WHoKVUSnwZ2f31Q1ihksfe3dcTj7nfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RCOCjWjk0kVHWOBwEPgPq0fViO4HGH8A
        ikeirxj0FFGXjA69bfZlbECEwpNM5gWvtn5vPVwW02NI65I8CXefBDYyzNcRwHoY
        dGjEgIXPzbYWnQosPbBoK+hrsNwHJxs2zUUHULXWUyWE1l/fEuThOvqAKwzqNnlV
        ZF6b87CtiFQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B309B3E02;
        Thu, 28 Sep 2017 06:35:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F150AB3E01;
        Thu, 28 Sep 2017 06:35:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
        <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
Date:   Thu, 28 Sep 2017 19:35:38 +0900
In-Reply-To: <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
        (Eric Rannaud's message of "Wed, 27 Sep 2017 22:07:41 -0700")
Message-ID: <xmqqo9pv156t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5B31722-A438-11E7-8B61-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> +# The commands in input_file should not produce any output on the file
> +# descriptor set with --cat-blob-fd (or stdout if unspecified).

Thanks for documenting this.  Swapping the order of starting
fast-import and feeding its input (which is one change in this
version relative to the previous one) alone would not help, because
in the updated order in this patch, nobody is reading from
fast-import until the parent process finishes feeding it.
