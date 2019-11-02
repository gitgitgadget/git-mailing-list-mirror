Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3152E1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 07:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKBHsY (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 03:48:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56638 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKBHsY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 03:48:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 801C9A7F21;
        Sat,  2 Nov 2019 03:48:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=if0IKFajmRCFv+GfnjPYGbyKNME=; b=qiaPjS
        tbnIvGLq+BInVFyypGPY3Zs1hUCES04bAETx4mhLlsNKhM3/kASSBm2WPZYzD1Qe
        eqdL/vY23teCHgbZLxJ7gRookegjV5XDdmO/ZQsFFilq/ttj2mpF9ZpFzMWZR2jT
        9TYAVwbb/0Z/mnDQ+OtZfBPiRyslqV01TBcO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aDAEU1im3FKQmLD45U00e5YyOfckkh2R
        1G7dTbslfeYPCgf7T3kmvBry6AMmSwMrt+2OoBtZwbK+z/mCWh7Azt4Mmfmri4cQ
        zxELB1C5hHshiPYi3OH/xgGXmALRwLqPUT6fFXXYHWhW02+Ki/YSU1C0tt8uPFR5
        wLMRf292qa4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BAD7A7F1F;
        Sat,  2 Nov 2019 03:48:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 757D3A7F14;
        Sat,  2 Nov 2019 03:48:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v5 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-6-rohit.ashiwal265@gmail.com>
        <xmqqa79e3f8v.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 02 Nov 2019 16:48:18 +0900
In-Reply-To: <xmqqa79e3f8v.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 02 Nov 2019 16:32:32 +0900")
Message-ID: <xmqqy2wy1zy5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23B240CA-FD45-11E9-A5BF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
>
>>  --ignore-date::
>> +	Instead of using the given author date, reset it to the
>> +	current time. This implies --force-rebase.
>
> The first sentence is unclear and puzzles me with "for what?".  IOW,
> you are saying that by default the command uses the given (I presume
> that you meant what is recorded in the original commits being
> rebased---but we should find a way to explain it more clearly)
> author date, but with this option what is used is reset to the
> current time.  It is left unspecified what the command is using that
> time for.
>
> Perhaps (I am writing this paragraph after writing the rest of the
> message, i.e. after reading the patch through):

Oops, too much re-editing without final proofreading.  Sorry.

> 	By default, the author date recorded in the commit being
> 	rebased as the author date is used as the author date of the
> 	rebased commits.  The option tells Git to use the current
> 	timestamp as the author date of the rebased commits instead.
> 	This implies `--force-rebase`.

	By default, the author date of the original commit is used
	as the author date for the resulting commit.  This option
	tells Git to use the current timestamp instead and implies
	`--force-rebase`.

would be much less redundant without losing clarity.
