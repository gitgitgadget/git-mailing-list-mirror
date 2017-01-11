Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B4A205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdAKVG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 16:06:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64127 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753276AbdAKVG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 16:06:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 034945F970;
        Wed, 11 Jan 2017 16:06:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rwEEGtXWNflhq/P3UZguhp2hnlk=; b=Tqk0Ku
        0n327VYHvmFBO3isttDN9M0vg4I5WjFo1J13FImmAqzM6AAaqCLXtsK8DR2ojVVu
        /0OJrbQ1XNlNHkiCYUUHE+Cgh6U72KlAVUcGzLrCkRYu46DVRmztT+MNm3t/3Xz0
        MxV/oTTofUKChe6FrI1dfc9SnjzP4r39+tavM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YcxXnYf4g3LqCi7tzZAdx8mz3zdaVXhI
        Mxt+D4yDZA5ql/XSgrQ4dK/zF3TcZoR9wE+VswheBZEsvupb6z6SKlG932hxnavI
        PNbfAHpnEoKmjetTop447k+IyAp22NYPvlVkFTAh6jwi118HxMllqFprDoTS995j
        sW9FBjqhPPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEC0C5F96F;
        Wed, 11 Jan 2017 16:06:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A8135F96E;
        Wed, 11 Jan 2017 16:06:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: document the pattern format for diff.orderFile
References: <20170110004031.57985-1-hansenr@google.com>
        <20170110004031.57985-3-hansenr@google.com>
        <xmqq8tqismdx.fsf@gitster.mtv.corp.google.com>
        <17d48ccd-fd19-3922-8ee8-af6558d22632@google.com>
        <xmqq60lmpb4j.fsf@gitster.mtv.corp.google.com>
        <21b416ae-8bf6-4f82-25d3-e51a574e7746@google.com>
        <xmqqwpe1o43k.fsf@gitster.mtv.corp.google.com>
        <2fb4296d-f084-4a76-44f3-7dc7d7cca7b1@google.com>
Date:   Wed, 11 Jan 2017 13:06:53 -0800
In-Reply-To: <2fb4296d-f084-4a76-44f3-7dc7d7cca7b1@google.com> (Richard
        Hansen's message of "Wed, 11 Jan 2017 13:36:41 -0500")
Message-ID: <xmqq7f61nw5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E12F91BA-D841-11E6-9FEE-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Hansen <hansenr@google.com> writes:

>> Back then we didn't even have wildmatch(), and used fnmatch()
>> instead, so forcing FNM_PATHNAME would have meant that people
>> wouldn't be able to say "foo*bar" to match "foo/other/bar"; with
>> wildmatch, "foo**bar" lets you defeat WM_PATHNAME so having
>> WM_PATHNAME always in effect is less of an issue, but with
>> fnmatch(), having FNM_PATHNAME always in effect has a lot of
>> downside.
>
> Ah, that makes sense.
>>
>> I'd expect that orderfile people have today will be broken and
>> require tweaking if you switched WM_PATHNAME on.
>
> OK, so we don't want to turn on WM_PATHNAME unless we do it for a new
> major version.

I do agree with you that if we were starting Git from scratch, or at
least if we were adding diff.orderfile feature today, we would have
used wildmatch(WM_PATHNAME) for this matching.  We would also have
used the same parser as used to read the exclude files (and when we
see negative matching entries in the parsed result, either errored
out or ignored them with warning).  That kind of change unfortunately
would require a major version bump, I am afraid.
