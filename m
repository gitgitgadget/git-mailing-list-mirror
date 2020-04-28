Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE6AC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281DE2070B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NLyryHdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgD1TQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:16:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53857 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgD1TQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 15:16:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89D104C6CD;
        Tue, 28 Apr 2020 15:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=83G7RdlfYUoH3/H28bKDsrnCXz8=; b=NLyryH
        dAdBFeKeD9K6ZyxjARCLNJnB9Hdzz2hubR+g+IRKgaq9ziaUJg37h3zYSFlQNE9w
        zRgSApNSduRRp+1bdPD7zUVgABRG75IYodwPx+7ugD9GxFTv34kE3iLFC1yHSYWs
        AFHn3RwaI2DygrTrntmvI9hKcIBksAnyR/zXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vZV0goSM1EttgGiwtRVSVCjjdbW7WiAu
        cmscCYLKEf9DiJvgiFcM5r3DA1Xaqu37XWS8zMKTIhCLQDbNi0G1dcwwFl18QWkf
        WyCGapoEGATY52WL3iwPJXtIetM/FyhlhQT/rSKRV0GEWSKZADc5DhXbY7vQ8aqN
        g5dMO3uJEWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80E4A4C6CC;
        Tue, 28 Apr 2020 15:16:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3BAC4C6CB;
        Tue, 28 Apr 2020 15:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
        <20200425022045.1089291-6-jacob.e.keller@intel.com>
        <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
        <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
        <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
        <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
        <xmqqsggn32i7.fsf@gitster.c.googlers.com>
        <CA+P7+xoSdDjbSAKeCsPz97Rc=ykpuTb2pNKazsCNcau2SBquMA@mail.gmail.com>
Date:   Tue, 28 Apr 2020 12:16:40 -0700
In-Reply-To: <CA+P7+xoSdDjbSAKeCsPz97Rc=ykpuTb2pNKazsCNcau2SBquMA@mail.gmail.com>
        (Jacob Keller's message of "Tue, 28 Apr 2020 11:45:58 -0700")
Message-ID: <xmqq8sif2zfr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA40FDAC-8984-11EA-B897-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> On the other hand, I am OK if "checkout -b", "switch -c" and
>> "--orphan" offered either:
>>
>>  (1) nothing, as your patch does, or
>>
>>  (2) all branches, except for the currently checked out one.
>
> Why reject the currently checked out one? If the premise is: "use a
> current branch to build a new branch name", I don't see a reason to
> restrict including the current branch here as well.

Yeah, "(3) all branches, without any exception" makes sense too.

>> It would be preferrable if they did the same thing.
>>
>> Thanks.

> The problem I see, is that regardless, I would like to see the following:
>
> git switch -c new-branch-name <SPACE><TAB>
>
> complete all references for the starting point.

Makes sense.  The starting point could be any branch or even a tag.

> With this series, that's handled by just checking for "-c/-C" on the
> command line and enabling all references. There's no positional checks
> done, so every word can complete to a reference.
>
> I don't know offhand how to add completion which depends on the
> position of the word we're completing, so I'd have to investigate how
> to make that happen.

I see.  Even though I say "(3) all branches" is a reasonable
behaviour, too, if the starting point has to be more (i.e. including
tags), that would not help the issue you have here.  It may not be
too bad if we offered all refs (including tags, which may not be a
good idea) in that case.  I dunno.

Thanks.


