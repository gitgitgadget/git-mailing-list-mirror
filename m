Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB05C2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EBD2076A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpYr3Fki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391214AbgDOPIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:08:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbgDOPIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:08:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35D0C6180F;
        Wed, 15 Apr 2020 11:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ryhXjUEW+LnS2C/Z2Xx9pUc9jNI=; b=LpYr3F
        kiRwXqE3B9UoHOzsE2B07ijLKGfPHcWzCihW69AQvuA35xa2ZFcLmdJum+jC3Ael
        4bxVPKBSNIY4wzWtcfio7ACqj4MKwNp3YK7cKB4rYSyeqVdOyqkci9+HBsmclcyZ
        gI40hibNGjVJ7Hj87k9f2W/irKYHVH0/qeMoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R1iZ7fMj0r+tTcX1pNGQJmhkGacxwsDy
        1ibEuB2Kxmhn3kZCQjq2y1eYt+Ch7a+RsNB1pUyn3bx/mJ9VBLDkU9KtO3kikk5z
        CVa1GWw893memJfgB8xKetsBjI3d76SnN074s6NpLDFME/QcI3Hsr9npgU8EiCpt
        7yvCi829qyo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C7F06180E;
        Wed, 15 Apr 2020 11:08:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ADF66180D;
        Wed, 15 Apr 2020 11:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Fetching 24 Linux commits = 1.2 GiB
References: <b7f5bfb9-61fb-2552-4399-b744428728e4@suse.cz>
        <20200415135627.vx75hsphbpmgrquv@chatter.i7.local>
Date:   Wed, 15 Apr 2020 08:08:17 -0700
In-Reply-To: <20200415135627.vx75hsphbpmgrquv@chatter.i7.local> (Konstantin
        Ryabitsev's message of "Wed, 15 Apr 2020 09:56:27 -0400")
Message-ID: <xmqq1roo947y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFC94B88-7F2A-11EA-9115-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do these (and I think we saw other reports) make us rethink the
status of protocol v2 as the default?  Are all of these fallouts 
we saw so far easy-to-fix bugs, or are there more fundamental issues
in the v2 protocol design?

Thanks.

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Wed, Apr 15, 2020 at 10:01:46AM +0200, Jiri Slaby wrote:
>> Hi,
>> 
>> I was at 8f3d9f354286 of:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> 
>> I did git remote update today and it fetched:
>> Receiving objects: 100% (7330823/7330823), 1.20 GiB
>> It updated master: 8f3d9f354286..8632e9b5645b, that is 24 small commits.
>> 
>> One colleague of mine fetched 1324 commits:
>> Receiving objects: 100% (6820/6820), 4.21 MiB | 6.70 MiB/s, done.
>> Resolving deltas: 100% (5114/5114), completed with 1035 local objects.
>> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>>    7e63420847ae..8632e9b5645b  master     -> origin/master
>> 
>> Another colleague fetched the same what I and:
>>   Receiving objects: 100% (7330823/7330823), 1.20 GiB
>> too.
>> 
>> I did git gc --prune && git prune now and I am at 1.7G back from 3.5 G.
>> 
>> Is that a bug? What info should I provide?
>
> I've helped sfr troubleshoot the same issue last week -- it's most 
> likely due to 2.26 turning on protocol version=2 by default.  
> Unfortunately, reproducing this has been tricky, so if you can reliably 
> make this happen again, then providing a full copy of your local tree as 
> well as the remote you're trying to fetch may greatly help narrow it 
> down.
>
> With sfr (for whom fetching 1.2G from .au is a bit of a big deal), we 
> solved it by forcing protocol.version=1.
>
> -K
