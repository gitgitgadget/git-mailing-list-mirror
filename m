Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2698120229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbcKAU4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:56:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750979AbcKAU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:56:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2965A4B172;
        Tue,  1 Nov 2016 16:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qg1bkt9+GPLbc/rZDzf3SsvxTGk=; b=sZErmK
        FaxOT3PB8sQmDq4Nq5P6efhMe02b21jNgIMLRU+V76LKXmm9rLc8mdN5ciUTr3t+
        F5iCZi94i1Aqfwf4VTxEKuWKgM558+d8N3owVhAd7a8/e57TWZdqypxKti+QZrIK
        OPbnCO5A3mtf/74Ac5lyCYcP9syHxQIOs6SgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A3BRywZsQeYyjP6Ho8iFEACp5j7VlB3g
        4Ha+fqlNV/hKT778SKL6vDURtam1MVKKwbWy7HF5luvXFyrVmEUqLQuTGGHX+Cda
        VUpESuYBv7kTifarWIks8qUsRCLoA8GZ3OadOcP4ljuyxFSXiSAc2as67oXWyH2Z
        gcxohxYTMZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2136A4B171;
        Tue,  1 Nov 2016 16:56:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 910BD4B170;
        Tue,  1 Nov 2016 16:56:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
        <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
Date:   Tue, 01 Nov 2016 13:56:34 -0700
In-Reply-To: <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 1 Nov 2016 16:36:37 -0400")
Message-ID: <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD0A49CE-A075-11E6-BB90-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 31, 2016 at 02:49:42PM -0700, Junio C Hamano wrote:
>
>>  * Output from "git diff" can be made easier to read by selecting
>>    which lines are common and which lines are added/deleted
>>    intelligently when the lines before and after the changed section
>>    are the same.  A command line option is added to help with the
>>    experiment to find a good heuristics.
>
> I'm not sure we ever resolved all the discussion around options and
> defaults here.
>
> As of -rc0, we have both --indent-heuristic and --compaction-heuristic
> (along with matching config), and they are mutually exclusive.
>
> In [1], Stefan suggested just replacing the compaction heuristic
> entirely with the new one (and you seemed to agree). If we're going to
> do that, it makes sense to do so before the release, so that we don't
> get stuck supporting --indent-heuristic forever.

You meant "compaction" in the last part?  I think it is probably a
good idea.

I'd vote for just removing compaction-heuristic while keeping the
indent-heuristic with experimental label and knobs and keeping it
off by default for a while.

Thanks for bringing it up.
