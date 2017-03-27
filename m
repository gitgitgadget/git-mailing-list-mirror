Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685661FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdC0RGc (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 13:06:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751294AbdC0RGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 13:06:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A1977BAFB;
        Mon, 27 Mar 2017 13:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brdmIyWQX8624H9dJWByjPhPcgY=; b=yh0LsG
        etizYQBWlnT/VB4nsH5Gb7ge8sRT3wcu/THIKPb5orPm7ixvAWVlVMed0VbJcAR9
        +WsGuLXGR+7vXWk5x602odLianjydMzpxnQL71zRyX81ZSIEPMCVAzu2V4RLgkH6
        EpmnWz/aSiZz2395gFAfRNYwJajgrXKcwERaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vaccxkj5gqLxMKBptFYk0PihHjnvIZNQ
        ++nWgzXdTZo1i9w+9vr7C7vxJEAJbZkTS+HTIGRsJz082aZ5TVbYiXZPHg5AMugO
        Id8vzGdRQRGo7q7K5BVOUQQH00M8AkhppsOOPIaQI4WWe+NCE0r8wIT0JbVsRMMZ
        i8TMhrDFYP0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 630847BAFA;
        Mon, 27 Mar 2017 13:05:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA8087BAF5;
        Mon, 27 Mar 2017 13:05:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1dc: safeguard against outside definitions of BIGENDIAN
References: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de>
        <xmqqr31l6ggf.fsf@gitster.mtv.corp.google.com>
        <xmqqwpbd46gd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703271739210.14958@virtualbox>
Date:   Mon, 27 Mar 2017 10:05:49 -0700
In-Reply-To: <alpine.DEB.2.20.1703271739210.14958@virtualbox> (Johannes
        Schindelin's message of "Mon, 27 Mar 2017 17:39:43 +0200 (CEST)")
Message-ID: <xmqq37dy3b0y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A12F75AE-130F-11E7-8177-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> So here is what I came up with as a replacement (this time as a
>> proper patch not a comment on a patch).
>> 
>> Dscho, could you see if this fixes your build?
>
> The Continuous Testing is back to normal, thanks.

Thanks for a quick response.

I wished if we can reuse the endianness detection we already have in
"compat/bswap.h", which is included by git-compat-util.h hence also
here.  It would have been very nice if we could say

    #if GIT_BYTE_ORDER == GIT_BIG_ENDIAN
        ... do big endian thing ...
    #else
        ... do little endian thing ...
    #endif

when necessary, without having to reinvent the cheks on __BYTE_ORDER
and friends.  It however needs a bit of rework in "compat/bswap.h",
which is way beyond the scope of making a quick fix-up to unblock us.





