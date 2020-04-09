Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ADBC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BFB2083E
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HB+zOKRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDIW5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:57:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61257 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDIW5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:57:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24485BD14D;
        Thu,  9 Apr 2020 18:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k5sT7dITZ88DRoC22OKr3nF1mK8=; b=HB+zOK
        RU3XZMK63XYKwatRo85KzoRP8MzdqTrMu/SiuZ7K/T00TXi19Oi5VxdIREISWYUG
        fSjKnI6GxDLHDlp1Qey/lNpKK6vcu1ys7SEoU8xFYBSldFngY+1Hx/h0l1VrOE99
        kFJTAChXpoO52BKOv5eJPNyT2bVDV8jr67ODM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UUq8gwuTQrtasfGNG4MCchGY3QzoD8So
        b1EICLH+hmHa8OgIG15wtS2mp+vcN8v4ESBjnMzZFLx0JfewdOX/DTVAa/I0IqDw
        oOjG8wxhOhwyzgnGpf+nzCZVmJI0NITIQy6k91NVNdFzTD6f8uHXMTZPpF2JcmCL
        ww3OA9bFpEE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C6BDBD14C;
        Thu,  9 Apr 2020 18:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62265BD147;
        Thu,  9 Apr 2020 18:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
        <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
Date:   Thu, 09 Apr 2020 15:57:00 -0700
In-Reply-To: <xmqqd08gmg3s.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Apr 2020 15:47:19 -0700")
Message-ID: <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CF9562C-7AB5-11EA-9ED4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> This is 'next' running for me:
>
> Scratch all that---sorry, but I did see the note about trailing
> slash, but somehow managed to forget adding it when I tried it.


$ git checkout v2.22.0 && make && ./git-rev-parse :/any/path/

segfaults, while

$ git checkout v2.21.0 && make && ./git-rev-parse :/any/path/

is OK.  We should be able to bisect this fairly straightforward
between these two.


