Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5BC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4EE207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mf+A/PHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLQoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:44:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58508 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLQoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:44:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70587D4ED5;
        Wed, 12 Aug 2020 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eQ9vKx/GfYR3xmnE6lPJ1KuApTs=; b=Mf+A/P
        HbCLpqR3WWm4Af2pJAJLDJQf7l28SGljAdoc5IAN+kDAIAcP7WVbriiZNR25t/Oz
        eM7JkNnB5wm92hrmzoUSpeCQ2el2NuecRXhtNiTtwzGb3gsrqYRkj1rMaYeRR7nK
        eVBcvZXDNVUIJT7QgkxEOSQBed0Sr3IEuVTAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J3rA6Dp+wOEVszkXrVRrnDIipUOeqhuS
        VDbKfMnAVvywBcCDLr8Ab4kH5r4I9wYWS6/dwoeEi0Q5fj2vnIwE180aDedym0rF
        4kJPpI4/L3YsTJuN4HXPuLrHa+cADZSYYY/nbxab0IXDZESKEAqmfwZmpYB7i53m
        XWqla+ea5m0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 692CED4ED4;
        Wed, 12 Aug 2020 12:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2B9FD4ED1;
        Wed, 12 Aug 2020 12:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/7] negotiator/null: add null fetch negotiator
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597184948.git.jonathantanmy@google.com>
        <35bdd372ae3691f54775dd616576e8ed6d68f1d3.1597184949.git.jonathantanmy@google.com>
        <2f6b3e7e-8f83-bfde-ab63-1eed08ff32b5@gmail.com>
Date:   Wed, 12 Aug 2020 09:44:02 -0700
In-Reply-To: <2f6b3e7e-8f83-bfde-ab63-1eed08ff32b5@gmail.com> (Derrick
        Stolee's message of "Wed, 12 Aug 2020 08:55:14 -0400")
Message-ID: <xmqqsgcr7r1p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 087AD3AC-DCBB-11EA-BEC9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/11/2020 6:52 PM, Jonathan Tan wrote:
>> Add a null fetch negotiator. 
>
> I understand the value of this negotiator. I'm concerned about using
> "null" as the name, since it has a clear relationship to zero-valued
> pointers and that's not what is happening. (My gut feeling starting the
> patch was that some function pointers would be NULL or something.)
>
> Instead, might I recommend "noop" or "no_op" in place of "null" here?

Personally I am OK with null [*], but noop is also fine.

	Side note.  I actually would find it good to establish the
	pattern that something that does not use NULL pointer as its
	implementation detail can be called null if "null-ness" of
	its behaviour is its defining characteristics.

Thanks.

