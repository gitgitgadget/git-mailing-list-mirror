Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52951C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E87A2065C
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q8abhH5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgENVT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:19:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61014 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgENVT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:19:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D0B9CF34F;
        Thu, 14 May 2020 17:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ifGH16hzYdmphZxxNmD58U72hFk=; b=q8abhH
        5YSu9XnKsfNhkHSfpvHDn3ryaIjBJclKMa3NQgMKu4eeEBWUt1i6dwVL3V7MhIbx
        ZI7G5VWnNA4ROdW3gdVQpgox8NEdvYh2yk+GpPsv4EQ+/93bEKxxeUrRXj5iwJ8X
        X8MX+aV6w41Yxdn0I5QjvTjUENRxjTyMe06QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J0Y3j0Kg8Ol3bCyS63YQY8s22AQsoLGB
        /QTFxBwJl/rej5C+JyJNdVHTHMF85OGXHWdgbBAbjy/m+h43H17oxCYemLjVmWOt
        stpTvLAbKvsD9a60BdlM18n0CFtRTR6m3MamJdQakdRH3QFJLOrjN/ai8vqfUazR
        TCCKug28O0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 259F6CF34D;
        Thu, 14 May 2020 17:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6F5E5CF34C;
        Thu, 14 May 2020 17:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Caleb Gray <hey@calebgray.com>, git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
        <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
Date:   Thu, 14 May 2020 14:19:22 -0700
In-Reply-To: <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Thu, 14 May 2020 16:33:26 -0400")
Message-ID: <xmqqv9kyp63p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D2FAE2-9628-11EA-9FF5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Thu, May 14, 2020 at 07:34:08AM -0700, Caleb Gray wrote:
>> ...
>> To subsequent clones (until cache invalidated) using the "flattened
>> cache" version (presumably built while fulfilling the first clone
>> request above):
>> 
>>  Cloning into 'linux'...
>>  Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
>
> I don't think it's a common workflow for someone to repeatedly clone 
> linux.git. Automated processes like CI would be doing it, but they tend 
> to blow away the local disk between jobs, so they are unlikely to 
> benefit from any native git local cache for something like this (in 
> fact, we recommend that people use clone.bundle files for their CI 
> needs, as described here: 
> https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).

I have a feeling that the use case you are talking about is
different from what the original message assumes what use case needs
to be helped (even though the original message lacks substance and
it is hard to guess what idea is being proposed).  

Given the phrase like "while fulfilling the first clone request", I
took it to mean that a cache would sit on the source side, not on
the client side.  You seem to be talking about keeping a copy of
what you earlier cloned to save incoming bandwidth on the client
side.

