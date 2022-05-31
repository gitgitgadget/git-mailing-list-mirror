Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6992EC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 14:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbiEaOGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiEaOGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 10:06:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A35EDD1
        for <git@vger.kernel.org>; Tue, 31 May 2022 07:06:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B38A612EEF3;
        Tue, 31 May 2022 10:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IN9KQSeurXKDBxpAL8p/0jdSkmYgXraaQ2pLi36IPWs=; b=GHtA
        Ha6ZKo1wEIBKfVjCrj/8Dc47ahhOMQRphVjEOG8/ZYmnEvk5hjeJM54qIjs3Fda8
        q8FCJ/D0FS0AfPFDl8eL0bbcVEWj3xZZ2Nu/vSdx1dvSsgnoqIvOgKlwdOXrbuXd
        SrhcqDQh58UGBdmt1wUjbJIGk7QDCaGT9DVIi3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9696D12EEF2;
        Tue, 31 May 2022 10:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 883D612EEF1;
        Tue, 31 May 2022 10:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Ed Maste <emaste@freebsd.org>,
        Git mailing list <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: Investigating Cirrus CI FreeBSD failures
References: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
        <CAPyFy2AETzTCJUtbxS+RmygajrUS5XUkZvF-1FVbJ67t61bJtg@mail.gmail.com>
        <e31d26ad-3b0b-15c0-262f-4eee83220949@gmail.com>
Date:   Tue, 31 May 2022 07:05:59 -0700
Message-ID: <xmqqczftx0e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCDFC7F4-E0EA-11EC-8DF9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Ah, what happened here is that this is picking up the perl package
>> built on 12.3 (i.e., the earliest supported FreeBSD 12.x) which added
>> strerror_l.
>> https://cgit.freebsd.org/src/commit/?id=d3912bec58d0b82509a0973cae02f156986d88fa
>
> OK, so it is expected that the Cirrus 12.2 image would install this newer
> version of the perl package which if I understand correctly is not compatible
> with this version ?
>
> Is there a way to tell pkg not to update packages to incompatible versions,
> or is the FreeBSD policy that as soon as a release is marked as unsupported, 
> then no guarantee is made that things (like installing packages) continue working 
> on that version ?

Sorry for a noise, but I would also be curious to know, as it is
quite unexpected for a packaging system to miss such a compatibility
issue and for a distro to not care.

>> I expect this could have been addressed also by updating to 12.3.
>> Cirrus also supports "matrix" so both could be tested.
>
> For now we opted to just update to 12.3, see [1].

Indeed we did.  Let's make sure we fast-track the topic down to
'master' and possibly to 'maint'.  I do not think it is worth
letting it sit in 'next' for a week, like we do for usual topics.

Thanks.

P.S. I'll be offline today (like every other Tuesday).
