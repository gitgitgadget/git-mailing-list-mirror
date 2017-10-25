Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808161FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 01:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbdJYB0r (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 21:26:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59768 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751861AbdJYB0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 21:26:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C300A9F28;
        Tue, 24 Oct 2017 21:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l9SJJ03DPOJ3Aj4FD57GNcicKBo=; b=ilBBSU
        2ehpbvDX8nbYIMwRYVEyHJrideXXIbukkA5/v2GdXNi8jsjgR7HsByBPiUX1CJEr
        yHVgeQ6bAj11onjzuq5qTAsKH3Ylw1UiCjdJjtMU7jjexyeZpFhWWj/UPiCeO3wL
        d0n00kzBLgaqQ+k+Tz2YBxzSU3VYG7TK8K2Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X2ocNlY36heFlKt9j5hS9x01Rpy3Vgrs
        KXTjEFZq+17UFtmqCu3gzl1riAXwfGa4nGF4J9RI6WzCVR/mAU+zn5jNDNLQk5gB
        AekdOjM4w/gxZoJatFCnj83Y7nths5Fs5X23I3/7NVcqMR19/jCtOpu0Mq/I840e
        9A7NxXg8shg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81BD6A9F27;
        Tue, 24 Oct 2017 21:26:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA82CA9F26;
        Tue, 24 Oct 2017 21:26:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, bturner@atlassian.com,
        git@jeffhostetler.com, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        wyan@google.com
Subject: Re: [WIP PATCH] diff: add option to ignore whitespaces for move detection only
References: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
        <20171024000931.14814-1-sbeller@google.com>
        <20171024184809.GC79163@google.com>
        <xmqqshe8j9we.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 25 Oct 2017 10:26:44 +0900
In-Reply-To: <xmqqshe8j9we.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 25 Oct 2017 10:25:53 +0900")
Message-ID: <xmqqo9owj9uz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90ADB85C-B923-11E7-A95A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> One simple idea would be to convert the single 'flag' into various bit
>> fields themselves, that way if you need to add a new flag you would just
>> make a new bit field.  I'm unaware of any downsides of doing so (though
>> i may be missing something) but doing so would probably cause a bit of
>> code churn.
>
> The reason why people want to have their own bit in the flags word
> is because they want to use DIFF_OPT_{SET,CLR,TST,TOUCHED} but they
> do not want to do the work to extend them beyond a single word.  
>
> I think it is doable by making everything a 1-bit wide bitfield
> without affecting existing users.

... but the "touched" thing may be harder---I haven't thought it
through.
