Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE7EC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3B8206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dA2OFSrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgC3FMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:12:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51830 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgC3FMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 01:12:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 096A8CF0DD;
        Mon, 30 Mar 2020 01:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TUy7gqsjNMZXwtm0uSncHXbzuhQ=; b=dA2OFS
        rHi5jWMoOhNrZtCJr1h8l9YeeGkMwyDQfw+d9CWMp2t1C5ituOTIbRZieU2Vzw0w
        Hov+KOjC+T2Pb5U0lI25BOJqNCOWddyJ9MOZa9aL0O5ZbKAww99zu5MoqoILNaQm
        SUxdFr/zkONbo5PASmlMNlIsb6Fpi8vCrsMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=buXzuVgLq+MVvNN5xp09kYkpVp5hC2LH
        mvp6GoJgMDiTRPgVcemH8UZrRj5KdEHjFgbmdPDuE71AlRXDLzaUOE/VFAR4UkPM
        hrhuhbpnXurIfWslBoZIUpf7gDzi7mD6VMEN2jfnrwO1s8Ulcn5jrZPdEcPKmupl
        mdA+WH5GsZM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 01EF8CF0DC;
        Mon, 30 Mar 2020 01:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A770CF0DB;
        Mon, 30 Mar 2020 01:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, steadmon@google.com, git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
References: <xmqqeetbawlx.fsf@gitster.c.googlers.com>
        <20200330033247.27880-1-jonathantanmy@google.com>
Date:   Sun, 29 Mar 2020 22:12:27 -0700
In-Reply-To: <20200330033247.27880-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Sun, 29 Mar 2020 20:32:47 -0700")
Message-ID: <xmqqd08ua0jo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D837CC2-7245-11EA-9E64-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Sounds good.  Jonathan?  I've squashed Josh'es Reviewed-by, but I
>> will refrain from merging it to 'next' just yet to see if you too
>> like the proposed code structure.
>
> I think that this is a local enough concern that going either way won't
> paint us into a corner, so if what's in
> jt/connectivity-check-optim-in-partial-clone is OK, I prefer using that
> to reduce churn.

If you do not think their improvement is not much of improvement,
then please say so.  On the other hand, if you also believe that the
resulting code is better, adopting the improvement (in other words,
help from other people) and get a better version of the code queued
before it hits 'next' is not a "churn".  Leaving a chance to make
the code into a shape that you think better is a waste and risking
the chance to forget improving it with a follow-up patch.

Thanks.


