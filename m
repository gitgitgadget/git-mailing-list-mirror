Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F470C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20920828
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lc5Qmpgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL0WVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:21:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63954 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0WVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:21:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8731524146;
        Fri, 27 Dec 2019 17:21:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RhQwkQ7QJYGUAyjYeB4nK0tV3iQ=; b=Lc5Qmp
        gdZsaUvwyc2dwzYtnQAitnusxupCqsGgJsDLbJ9WPAXfta1QNyNdvPmysTAPmt9c
        FpvJN9iHkQNF4lS0lflJvfkZBcIZJ4JqtDb7c5cLpKGfXPEN7Xihs9mPjafovZdF
        0PKbBqOWB4gy4BCjyLYdanyyk1sZ0Pu868KqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cVMYRZOkKenS5ea/W8X+92GAPyQl5CUe
        uTkjA501qbMje7BvflWj+RZ9urLLlIz9Pj1pfQauSlorPLrVY8OkJ/gXjAtKqvI3
        +JeUIBhtDDlJZaC+1KGstfiOmL0ed55hgdm/VpQaY7cgJhRQvb1+Oe5AqqSrqwaX
        SY5iSYYsR3M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EE6624145;
        Fri, 27 Dec 2019 17:21:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAB3324144;
        Fri, 27 Dec 2019 17:21:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gpg-interface: add minTrustLevel as a configuration option
References: <20191219000140.9056-1-hji@dyntopia.com>
        <20191222003123.10555-1-hji@dyntopia.com>
        <20191222003123.10555-2-hji@dyntopia.com>
        <xmqqblrx5yxu.fsf@gitster-ct.c.googlers.com>
        <87r20pkhir.hji@dyntopia.com>
Date:   Fri, 27 Dec 2019 14:21:17 -0800
In-Reply-To: <87r20pkhir.hji@dyntopia.com> (Hans Jerry Illikainen's message of
        "Fri, 27 Dec 2019 13:46:52 +0000")
Message-ID: <xmqq7e2hjtpe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 346281F4-28F7-11EA-BAD7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

>> I wonder if the code becomes less misleading if we either (1)
>> renamed 'next' to a name that hints more strongly that it is not the
>> 'next' line but the end of the current token we are interested in,
>> or (2) get rid of the pointer and instead counted size of the
>> current token we are interested in, or perhaps both?  
>
> Yeah the name 'next' does seem a bit counter-intuitive when used in
> relation to 'line'.  Looking through the function it seems that both (1)
> and (2) would work.

Thanks for thinking the code a bit more than necessary for the
purpose of this topic.  Let's leave such a clean-up outside the
scope of this topic, but perhaps a #leftoverbits marker may help us
remember it as something we could do when we have nothing else
better to do ;-)

