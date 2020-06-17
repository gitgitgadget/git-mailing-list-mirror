Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4FC433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7233F20720
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FZWxjSHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQUam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:30:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54214 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:30:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56C4CE3434;
        Wed, 17 Jun 2020 16:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YI3rWdMF6nWjZ9zZq0TS4NVHtrI=; b=FZWxjS
        HnRBOn1Ika2fcxmhYuWsrswmmff6abFgmH1UpkxxB7SsZAFXGCJMVsUR9GR2RZ7U
        TNtKyr60OMKMhVh6W+TGbSWReftSHUq4KAlFZtE6SoA28ChTaZs+N4g0VoN8jIEA
        rc8ish/GXmaFkRsku68AoLz6niXb1lfRyT/ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J1BsYwJ4aMWRTO2tMyMH2O/aGwHj0YJs
        m9gTIOD/8uwSeuKA0l688ecPdLlelpdYe0aLhFrk0oZYlNFAaLRVJMM7wIfrWG+9
        4oh4GaExu4tXV7P+mUQIrCNIfskK/lfQget+lJfE64M1+uupzhKrvA7zOMIqhwp6
        V6hGJjwnoyU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F8AFE3433;
        Wed, 17 Jun 2020 16:30:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99B95E3432;
        Wed, 17 Jun 2020 16:30:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Avis <ed.avis@qmaw.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git switch error message tweak
References: <BL0PR11MB34603334FD8AF4B662A74C3A9D9D0@BL0PR11MB3460.namprd11.prod.outlook.com>
Date:   Wed, 17 Jun 2020 13:30:36 -0700
In-Reply-To: <BL0PR11MB34603334FD8AF4B662A74C3A9D9D0@BL0PR11MB3460.namprd11.prod.outlook.com>
        (Ed Avis's message of "Tue, 16 Jun 2020 06:47:03 +0000")
Message-ID: <xmqq8sgltoyb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 675832A6-B0D9-11EA-9A87-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Avis <ed.avis@qmaw.com> writes:

> To help those migrating from 'git checkout' to the newer 'git switch'
> and 'git restore', this error message could be improved:
>
> % git switch baa022666d26a5d40e86c0b6349eb7435033e80a
> fatal: a branch is expected, got commit 'baa022666d26a5d40e86c0b6349eb7435033e80a'
>
> It could print additionally
>
> To switch to this commit in 'detached HEAD' mode, use --detach.
>
> as long as it was indeed a commit that was given.

Excellent.

> I note also that while git checkout prints a spiel about "You are in
> 'detached HEAD' state", git switch --detach does not. Was this
> deliberate, on the assumption that if you pass --detach you know what
> you are doing?

I'd say you are correct---one who passes "--detach" knows enough to
want to be in the detached HEAD state and knows enough that the
state is nothing to be worried about.
