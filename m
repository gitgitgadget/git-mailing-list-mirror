Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1ADEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 22:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHUW0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHUW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 18:26:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB47E4
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 15:26:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB2E01BCD4A;
        Mon, 21 Aug 2023 18:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ralSGGW6lMsBuda5XYTT1P5sIHqz+2NC1D/bCE
        g9VgU=; b=ro1ifCmftu16s1od3626Ypq9WCl9n8fTtvpMpGq/yWJsbDFI9xqU+j
        eCj1ZKwPP3NM4qyJanUnizptbUvsxdl/JjqiDgVpmRPu0rbKtI7/b4duMsQKAAtH
        tMcNgBMkmszQ3jyNc1pBuPh07KTkw20gYJMacMzYIwFiN17ezSodU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1CB01BCD49;
        Mon, 21 Aug 2023 18:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 206251BCD48;
        Mon, 21 Aug 2023 18:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] diff: the -w option breaks --exit-code for --raw
 and other output modes
References: <20230817222949.3835424-1-gitster@pobox.com>
        <20230818235932.3253552-1-gitster@pobox.com>
        <20230818235932.3253552-6-gitster@pobox.com>
        <20230821210058.GD1800481@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 15:26:37 -0700
In-Reply-To: <20230821210058.GD1800481@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 17:00:58 -0400")
Message-ID: <xmqqcyzgniaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBE75942-4071-11EE-8896-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> ...
>> about it is that it is not like we recompute the hash of the blob
>> after removing all whitespaces to show "git diff --raw -w" output).
>> 
>> But that is not an excuse for "git diff --exit-code --raw" to fail
>> to report differences with its exit status, when used with options
>> like "-w".  Make sure the command exits with 1 when these options
>> report paths that are different.
>
> I think s/with options like/without options like/ in the final
> paragraph?

Sorry, I am confused.  "diff --raw --exit-code" without "-w" reports
with its exit status that it found differences just fine.  When "-w"
is given, without this patch, it always reports 0.

What I wanted to convey was ...

    "--raw" and friends deliberately ignore "-w" and other "look at
    contents" options.

    The fact they do ignore the "look at contents" options is not a
    good excuse for "diff --raw -w --exit-code" to also ignore the
    request to report the differences with its exit status.  "diff
    --raw --exit-code" does report the differences as requested, and
    we should do the same when given "-w".

I guess the two have no logical connection so the latter sentence is
not making sense, with its "with" kept as-is or changed to "without".

