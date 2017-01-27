Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC03A1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdA0ScI (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:32:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750897AbdA0Sbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:31:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA8E61B79;
        Fri, 27 Jan 2017 13:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BdYQbi8xDHdN2fbDdcCiiRawXso=; b=i7Znrg
        5BtpSM1P+MMylh8n6/+VlvBbDygVjdEPBQr5wNj/NDl9zocWh9lmTJybbuVsSnSO
        50nnvUf1y3q93WC7bvIqBwYddM59A1abFV1bsBstRyNi8Y1tO6+afgrwRhMRSv6U
        TE5ydkWfKTWLwRTaee1BVAwwdt1fL0zeceqhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ea80eS5uamhubwat1EAzGjdcj1VyiIqW
        5yYWELmwgz8+WIdNXuM3QTGlAf0oRnLk9fPdTfeOvBQ8hGrQ/ycwKrJzup7ly+B/
        BIkvTDj5BePB/ilPDdr+oDuYYvFc1YzL49EkHmlUBbr279Ty/0oVOfTUv3qM92uO
        8RhRn9nu4Es=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10F9561B78;
        Fri, 27 Jan 2017 13:30:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B39061B77;
        Fri, 27 Jan 2017 13:30:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/1] reset: support the --stdin option
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <cover.1485520718.git.johannes.schindelin@gmx.de>
        <3b0bad26045ed175f40f050e15b65cb6a8f2368c.1485520718.git.johannes.schindelin@gmx.de>
        <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
Date:   Fri, 27 Jan 2017 10:30:48 -0800
In-Reply-To: <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 12:04:22 -0500")
Message-ID: <xmqqh94kz76v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9E695AC-E4BE-11E6-82C6-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A few minor suggestions:
>
>> +--stdin::
>> +	Instead of taking list of paths from the command line,
>> +	read list of paths from the standard input.  Paths are
>> +	separated by LF (i.e. one path per line) by default.
>> +
>> +-z::
>> +	Only meaningful with `--stdin`; paths are separated with
>> +	NUL character instead of LF.
>
> Is it worth clarifying that these are paths, not pathspecs? The word
> "paths" is used to refer to the pathspecs on the command-line elsewhere
> in the document.

If the code forces literal pathspecs, then what the user feeds to
the command is no longer pathspecs from the user's point of view,
and I agree that the distinction is important.  

If the remainder of the documentation is loose in terminology and
the reason why we were able to get away with it was because we
consistently used "paths" when we meant "pathspec", these existing
mention of "paths" have to be tightened, either in this patch or a
preparatory step patch before this one, because the addition of
"this thing reads paths not pathspecs" is what makes them ambiguous.

Thanks.  I re-read the part of the code that reads and unquotes as
necessary in the patch and they looked correct.




