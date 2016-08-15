Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041751F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbcHOUV0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:21:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750842AbcHOUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:21:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E7DF3436C;
	Mon, 15 Aug 2016 16:21:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfZagFfYZ20kU2na6tfKfime4tA=; b=xHM29X
	MI4O3doh39dcejA/HKCM9RIIOggEDuF8zWIb5cBG865x/zIyG58sM0jbcK2VpCLO
	9DBppWK+G/rNKuZnN1M/FvgZZ4njWsxSIYaPh8SuOp/aHHWeyQAUF5UqIGN6PQXm
	7vGEVzeyuX6FsIQIyEqVPnEdzCSPrup5uv8fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjTV/02rj3lOMyCt1GbTOLXJhkb/fORa
	rEIgiN/GhsW0FjxFCePv+KR1/y5l2y/7BFmUNwGzGIqBHcELzrUCH0+eRq5SS4eC
	hrisc7XxZtCKZBCfcwN5rq71YYwO/c2HlZyRASjWZlODRL+qLYDiDFxRzN8UJa9V
	fGuqYVQ4CIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 866693436B;
	Mon, 15 Aug 2016 16:21:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 112103436A;
	Mon, 15 Aug 2016 16:21:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Tom Tanner \(BLOOMBERG\/ LONDON\)" <ttanner2@bloomberg.net>
Cc:	john@keeping.me.uk, davvid@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] difftool: always honor "command not found" exit code
References: <57B19B9F0205070000390238_0_29566@p057>
Date:	Mon, 15 Aug 2016 13:21:22 -0700
In-Reply-To: <57B19B9F0205070000390238_0_29566@p057> (Tom Tanner's message of
	"Mon, 15 Aug 2016 10:38:23 -0000")
Message-ID: <xmqqa8gdhjgd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D63FA43E-6325-11E6-84B6-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Tom Tanner (BLOOMBERG/ LONDON)" <ttanner2@bloomberg.net> writes:

> From: gitster@pobox.com
> To: john@keeping.me.uk
> Cc: Tom Tanner (BLOOMBERG/ LONDON), davvid@gmail.com, git@vger.kernel.org
> At: 08/14/16 04:21:18
>
> John Keeping <john@keeping.me.uk> writes:
> ...
>> POSIX specifies 127 as the exit status for "command not found" and 126
>> for "command found but is not executable" [1] and at least bash and dash
>> follow this specification, while diff utilities generally use "1" for
>> the exit status we want to ignore.
>>
>> Handle 126 and 127 as special values, assuming that they always mean
>> that the command could not be executed.
>
> Sounds like a reasonable thing to do.  Will queue; thanks.

> Would it be possible to also treat signals (128 and above) as
> 'special' values as well (as I've seen some merge tools self
> destruct like that from time to time)

Certainly, it feels safer to notice an unusual exit status code and
error out to force the user to take notice, but that reasoning
assumes that "128 and above" are noteworthy exceptions.

I do not have a strong opinion on that part.
