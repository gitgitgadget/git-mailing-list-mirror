Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D9C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799FF2070A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="giArKtdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOSGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:06:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63982 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:06:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F70ED6040;
        Fri, 15 May 2020 14:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgSJ4XWpFfGBTgKt2FsehrfBNoY=; b=giArKt
        dhZyLTTvdoIjbfESlBwRpHdXRrUOFy8Rb9l15u3ch1+d/1Rk4fYqZ3HCW0hMPg/r
        iL4qu7yAUHLE6Nkcru7RB3FXxJM37NOcoQbpggLRnwJE9+g0JmQMD/2QHh7zX+c6
        tCXuyJ68wO9FtspIMlJG2h+7if0yA/+tJUZlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UxrbW2Jo1wl5L17+8+QyEBy895s5BVsj
        lUukz7bS98ns5oXiESHe5vkJNa4wdEVf1NU4W39t2Bl1Zq0lsKdm0nyftPuOPCa/
        4JbK0pSahZobSxQY+rlxvLCgohH1Xlyoucb+kvYitHk3ehy2cyy8fPDGp2dvCjmD
        z1lXpqj9eiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27981D603F;
        Fri, 15 May 2020 14:06:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ECCFD602D;
        Fri, 15 May 2020 14:06:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2020, #05; Thu, 14)
References: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
        <CABPp-BF2Nh8LntDfw7-zSry00QKWg68qKOFW9QHvtqrSvU=Utw@mail.gmail.com>
Date:   Fri, 15 May 2020 11:06:25 -0700
In-Reply-To: <CABPp-BF2Nh8LntDfw7-zSry00QKWg68qKOFW9QHvtqrSvU=Utw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 15 May 2020 08:25:41 -0700")
Message-ID: <xmqqr1vlkr8e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBCE5D68-96D6-11EA-917D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This summary feels misleading; it's not simple rename + content merge,
> it's double rename + content merge.  Perhaps:
>
> When a binary file gets modified and renamed on both sides of history
> to different locations, both files would be written to the working
> tree but both would have the contents from "ours".  This has been
> corrected so that the path from each side gets their original content.

Thanks.
