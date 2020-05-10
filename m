Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBDDC54E8D
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AEB2080C
	for <git@archiver.kernel.org>; Sun, 10 May 2020 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lflQPqai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgEJQiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 12:38:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58511 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgEJQiB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 12:38:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D8F1C9B1F;
        Sun, 10 May 2020 12:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7G1qI+wsCNF7
        vnoTdfbAAoEEKA4=; b=lflQPqaiM/+eUtOW29+tupSWxxL1l0xjCWI21jEbHZIT
        vuh9RA6zgBzM2ZpYwoCDyC8joul6qXTEJxSEmW6DzHqX6t5iZDT2BL1d10x71vUM
        6rt/s1tERX+XAJTPZ78h7Pvif/vZ4RYAvJevlwbVsr/slCmPUEZXr6gLkHqkOLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kXNG4i
        +MZTjg/zOSfWDJ5JcVEdz7CQoh9K+kkdg9DL0MLhg7m5QNxALR22EWamevIa4ohd
        zUonfJGR1CyB9sqzCLpGpFNWZ3JFsAkgSBJjFvxoJn072rp421VRa3U0qP6ZUY1S
        3XAjg33c/00aWblVl8Xd2F3pjPEeD/r1F74Yo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 137F5C9B1E;
        Sun, 10 May 2020 12:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B7BFC9B1D;
        Sun, 10 May 2020 12:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: invalid tree and commit object
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
        <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
        <xmqqpnbduiec.fsf@gitster.c.googlers.com>
        <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
        <xmqqh7wovoop.fsf@gitster.c.googlers.com>
        <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
Date:   Sun, 10 May 2020 09:37:54 -0700
In-Reply-To: <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 10 May 2020 11:07:25 +0200")
Message-ID: <xmqq1rnrvj8d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A1729C4-92DC-11EA-9A82-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Would a stack work?  When we see a candidate non-directory, we put
> it on the stack.  When we see a candidate directory, we compare it
> to the entry at the top of the stack using strcmp().  Equality
> indicates a duplicate and we are done.  If the directory name is
> less then we can pop the entry from the stack and check again, as
> we're past the point where a duplicate would be.  Makes sense?

Perfectly and quite excited ;-)  I wonder if we can do the same in
the unpack-trees side.


