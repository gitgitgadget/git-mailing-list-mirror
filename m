Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EA2C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D3B610C8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhDIF1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:27:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55289 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIF1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 01:27:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70819B6F6E;
        Fri,  9 Apr 2021 01:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=haV12EP7Eo3XokYfCyEffE8jkSQ=; b=KM2fAd
        mDCcd6OKhShPo48iklMoye/S5qO49W3ms+MqUPX3yg7Dp4JKF+Hz8cRL3vk7b55Z
        fNRUNI2dhwq4QD7k7T9bcrJAzszkIG/VHm8+dfTEOW3OzoHdk9Xd7ZNAivFf5bXU
        34CjLgUatt+pVyq6GrC7tInhgJpdEYSwEq8CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBAgy2uyO5L17yhmOVuNP7qLpM+rcM36
        yYQ0FkFPi9vVu3rJQNTeVy/osV25DNqo1O/toIJe9vN0Zohs/x86XZ6QFe4bdy3Z
        jOpxU9sNSL0gU3lmBHSFLm9G2ZbybvSIfSUBOQ01JIybjwyNjL8ODsVm02bkldmV
        8HMlJ2vrW6c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68C1DB6F6D;
        Fri,  9 Apr 2021 01:27:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0BEEB6F6C;
        Fri,  9 Apr 2021 01:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] fetch-pack: refactor command and capability write
References: <cover.1617929278.git.jonathantanmy@google.com>
        <7988c106873332ac6e5c2f9dd143cfa1f50e067c.1617929278.git.jonathantanmy@google.com>
Date:   Thu, 08 Apr 2021 22:27:25 -0700
In-Reply-To: <7988c106873332ac6e5c2f9dd143cfa1f50e067c.1617929278.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 8 Apr 2021 18:10:01 -0700")
Message-ID: <xmqqh7kgni2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44E20E46-98F4-11EB-81B2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A subsequent commit will need this functionality independent of the rest
> of send_fetch_request(), so put this into its own function.

OK.  send_fetch_request() used to do the "command=fetch", capability
response, and concluded them with a delim packet, which is now done
with the new helper write_fetch_command_and_capabilities().

Mostly code movement, without any behaviour change.

Makes sense.
