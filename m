Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E84C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A53B2075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuZuO6Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgEFWkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 18:40:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58713 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbgEFWkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 18:40:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD7C149B5D;
        Wed,  6 May 2020 18:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=feY+RyZTwv0o84pXWITsNq3bF8M=; b=FuZuO6
        IaNKWygjYLMAqwJ8kEYQ1a9dtN8GVlo4SBYzyKUkHPtJ9YfzWXEVVZi5eaxW6g8a
        gzigjK1fQSArwtY8xp/jkvUOsxwMRDT4JxrV9g1ZN5vBdzxrDt2+BWiCRJgwmWbB
        gNonbUsDPCB3UIBXYAzTEAA8s3pRDZUmoq2O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aNcmN1+ZaxJnc3Q8/sfe7NeVE7Aq/6ts
        D63QP5QBI4tcwkUsW3t1tOvE9n2GZbALpAf1cwLkzinJkzDsIBC9iMeo+IW9cCj1
        /SwHMQFaOLu1nrlBTJeq5+miIFwwwDQr+Fysrwp8YjAXunZRcNd9VYFw8to3RQqL
        PWLb/OjSr+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2B3C49B5C;
        Wed,  6 May 2020 18:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 229BF49B59;
        Wed,  6 May 2020 18:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] t5500: count objects through stderr, not trace
References: <nycvar.QRO.7.76.6.2005062304410.56@tvgsbejvaqbjf.bet>
        <20200506220741.71021-1-jonathantanmy@google.com>
        <xmqqd07g66l1.fsf@gitster.c.googlers.com>
Date:   Wed, 06 May 2020 15:40:39 -0700
In-Reply-To: <xmqqd07g66l1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 May 2020 15:28:58 -0700")
Message-ID: <xmqq8si4661k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CA79B50-8FEA-11EA-A0FB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks, Dscho. The commits introducing the flakiness have made it to
>> master, so this commit is on master.

I'll queue directly on top of jt/v2-fetch-neg-fix as that topic was
designed to be later mergeable down to 'maint' so that the 2.26
track can (1) revert the default flip so protocol v0 is restored as
the default, and (2) breakage of negotiataion in protocol v2 is
fixed.

Thanks.
