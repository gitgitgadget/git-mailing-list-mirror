Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB9CDB468
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjJKQkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJKQkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 12:40:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AB8F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 09:40:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 522F72FB89;
        Wed, 11 Oct 2023 12:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VjGnZ1fs1ovf
        cYFKtcT/En8lXvW0TFA+/giWNJ6SFw0=; b=XsnkXga7//Ja+gouxhVNlA7dfuqV
        Y+YOUz/u1Yg8d42VMvEB+Fxc8wEFc+jDDNqXK8yv+qpArH7rkUsFVcweYWAk4i2e
        98xhhu+CFKWKbeeRCO1uwcfrPyj0zIbyYsBHxhoTvEOywbE/JTFWk8XqpuqpQltc
        iOOf+0oTg0xzE8Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 463E62FB88;
        Wed, 11 Oct 2023 12:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D11CD2FB83;
        Wed, 11 Oct 2023 12:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH] revision: Don't queue uninteresting commits
In-Reply-To: <20231011123534.119994-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Wed, 11 Oct 2023 14:35:34 +0200")
References: <20231011123534.119994-1-oystwa@gmail.com>
Date:   Wed, 11 Oct 2023 09:40:03 -0700
Message-ID: <xmqqpm1lnme4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D5369408-6854-11EE-B1E9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Currently all given commits are added to the topo_queue during
> init_topo_walk(). Later on in get_revision_1() the uninteresting ones
> are skipped because simplify_commit() tells it to.
>
> Let's not add them to the topo_queue in the first place.

What is not described here is what benefit we are expecting to gain
by making this change.  Is anything leaking?  Are we showing wrong
output?  Is the effect something we can demonstrate, and more
importantly we can protect from future breakages, with a test or
two?

