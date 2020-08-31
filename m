Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08647C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC0920866
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vQSZs1QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgHaTHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:07:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52596 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgHaTHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 15:07:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6918EE82FA;
        Mon, 31 Aug 2020 15:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MDDSKC1non+LdpazFFI4tPbbohA=; b=vQSZs1
        QHkGgrNY3HT/bCs6MCfhQ+yIUZrsz+P3oyhIEDy/70g3qAbSUWvBm9zK5wHtin4B
        BjtHUZEJsAsao64xr8/+vYIIFCyZLCKgXPXxCYu0iZygM1v1tn+YqhYg1J2EDqPQ
        TMObC6dq3f1xrNJwx8OznWR9DeAY+PEPQTjAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xcizM01aKKcfEczl+3aUz19gDGDn0zDX
        I0pI+lpkcXacs7A46n7KEOlIq3DYqbOIeP1J3v+pb57KTKzYjgujWCl/iemTPh0N
        CglHXGzK4gnVlZbui0zoEwLRN/SZP1F3Ud7aa6GxYE0wvXt2U9EKk1aks/nl0A6G
        MR412NK2suo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61F26E82F9;
        Mon, 31 Aug 2020 15:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E60FE82F8;
        Mon, 31 Aug 2020 15:07:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Henr=C3=A9?= Botha <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to worktrees
References: <20200827082129.56149-1-sunshine@sunshineco.com>
        <20200827082129.56149-4-sunshine@sunshineco.com>
        <xmqqh7soqady.fsf@gitster.c.googlers.com>
        <CAPig+cT-w6LV490MGNyG_ihWkSzdgfnEBrjQCsafjndTRmMgFA@mail.gmail.com>
Date:   Mon, 31 Aug 2020 12:07:04 -0700
In-Reply-To: <CAPig+cT-w6LV490MGNyG_ihWkSzdgfnEBrjQCsafjndTRmMgFA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 30 Aug 2020 03:36:38 -0400")
Message-ID: <xmqq7dtefxd3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28F3C61E-EBBD-11EA-AD0C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> No. For this repair to work, the gitfile in the linked worktree must
> be intact; it must be pointing back at the .git/worktrees/<id>
> directory so that "git worktree repair" can repair the corresponding
> .git/worktrees/<id>/gitdir file.

OK, I missed the fact that we can learn <id> quite easily if we have
the gitfile.  Thanks.

