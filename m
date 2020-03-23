Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6702C43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCE320719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bU6oOx5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCWUah (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:30:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWUah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:30:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4741FBCA6C;
        Mon, 23 Mar 2020 16:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q+IqMUG/ClZooZ13s2udFxjGO60=; b=bU6oOx
        5GPAiXyASZtqXLoW2ywZBuvMGAg1VJ4Og+gcIKWXcwX/pofRh4toglwk0efrnfST
        UTGIe7YNZDT54RNlO6yL99kurUA3nenfDIDyX0Tfzscr5lnqi+h9TxjhXEMeUhhz
        qRucpsgzciJ8FRBAsYAiULk2uTAGfMytVIssE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wws4aH7FQpe0McwM+jN6OTMA9/rUoLGG
        UVFDfuRMUrl/TRfOvHJAyLR3F2ocTjEPO4jAK6nad3Tu6f8l8sb6TGZsH3nF+7l3
        pTPB5NLcVxxquM3du8SD+eE43eTgQesToRm88fkkI7Dow8e1iu7+pwmAZlbaz+cs
        gEaRWNtklnw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F7B5BCA6A;
        Mon, 23 Mar 2020 16:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8499FBCA68;
        Mon, 23 Mar 2020 16:30:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231509150.46@tvgsbejvaqbjf.bet>
        <20200323151149.GD11801@danh.dev>
Date:   Mon, 23 Mar 2020 13:30:30 -0700
In-Reply-To: <20200323151149.GD11801@danh.dev> (Danh Doan's message of "Mon,
        23 Mar 2020 22:11:49 +0700")
Message-ID: <xmqqd0924xw9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24C97846-6D45-11EA-BDBE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> Can we just change back to what Duy proposed time ago:
>
> 	find . -type d -exec ls -ld {} \;

Yup, that sounds just as conservative as it can get.  On platforms
that are not FreeBSD, anything done in this helper function is an
expensive noop, but provided that the working tree is small enough
and the overhead would not matter, something very simple like the
above sounds like the way to go.  If the overhead is too much, on
the other hand, then we can do it only conditionally on certain
filesystems where the issue exists.

> I'd find some time (later) to setup a Travis build with Alpine and VoidLinux,
> mainly for musl check.

Thanks.
