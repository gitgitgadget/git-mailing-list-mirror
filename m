Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47BAC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB560C3E
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhDOTrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:47:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhDOTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 15:46:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 137271233FB;
        Thu, 15 Apr 2021 15:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZipsR0whaMe4zIdWjDSdsbZYirI=; b=lJteQD
        Gfsm/Gma9Tv8BDT85fO0/ILTjZnpWCmyoqoiPjDn+zkS+aXRJB1Xs2lI7jftxI1L
        taGGKIPs/nuctY5JkVnEk/AwUVH/8eZvl6+9wmBz1CK/ASwqEWeV0NSTKrXgA8r/
        YceugGxns/SXycXKF2kzfPlQuooWlQW6v/JHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PdyWt9DwCX24ulORaSnMornGSb/PzVbI
        FylJuvux7i0b+dOgVdJeEjVxq61oyQIttRnkYmG+5CN9ZparHvRQJ4L7Sf1YbhET
        bovCkt2mB/woFDyyZ5UTtE+WWJzaKsgy0/wOGri1UrHB1Wpu6Ww6XQWsEXa1fBcN
        FgW5LYo2u80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D03C1233FA;
        Thu, 15 Apr 2021 15:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 475011233F8;
        Thu, 15 Apr 2021 15:46:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why isn't 'jch' based on 'next'?
References: <YHgDYl3cMx9+Hqa7@generichostname> <xmqqlf9jqucm.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 12:46:30 -0700
In-Reply-To: <xmqqlf9jqucm.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Apr 2021 11:24:25 -0700")
Message-ID: <xmqq35vrqqjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 475A2BF2-9E23-11EB-AB57-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So if we reset 'seen' at 'master' and merge the tip of these topics
> into it, the tree of the empty commit that is marked with "### match
> next" marker should match the tree of 'next', or something is still
> wrong (most likely, a mismerge).  Also, the order topics are merged
> into 'next' may not be necessarily the order they appear in 'seen'.
> Every time I rebuild 'seen' from 'master', I have a chance to reorder
> these topics so that the ones that are expected to graduate sooner
> come near the bottom.

This is so that I can "git checkout seen~40" (or whereever point
that has all the topics scheduled to be in 'master' and nothing
else) and run tests, to simulate what happens if these topics
graduate to 'master'.

> By ensuring "### match next" and 'next' matches, even though they
> came to their trees in different route, I can spot a mismerge that
> is waiting to happen soon when a topic graduates to 'master'.
