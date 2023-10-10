Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03797CD98C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343935AbjJJU5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjJJU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:57:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB4D9E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:57:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4884C28B15;
        Tue, 10 Oct 2023 16:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Zd/F8mpJtQJg9LJwVtUrxC6a3Z4hRuvXHVRBx2
        QTwWM=; b=HHSbU4/uNZ1lNc9YbZz9nALQZAW4ZI9WYNxofh+Y4wdNjcyf0oxNo5
        clubWSokqTsTG22xWfUPXEr47m94obO1cLlFqnXgvQEL/mOLAXvnRz0JV9yr310B
        6f8gQI0vLU0zU8v7Fj2RVzvjD3oXSPI3RsoITnXMmgB5dECsmSk8Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40F5928B14;
        Tue, 10 Oct 2023 16:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD70328B13;
        Tue, 10 Oct 2023 16:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v4 4/4] parse: separate out parsing functions from config.h
In-Reply-To: <87c16c09-784f-4818-9231-8023fc2c5a02@gmail.com> (Phillip Wood's
        message of "Tue, 10 Oct 2023 18:58:43 +0100")
References: <20231010174348.2150150-1-jonathantanmy@google.com>
        <87c16c09-784f-4818-9231-8023fc2c5a02@gmail.com>
Date:   Tue, 10 Oct 2023 13:57:25 -0700
Message-ID: <xmqqpm1mrya2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E57C218-67AF-11EE-AA9A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I'm open to changing
>> git_config_get_expiry_date_in_days() too, though...we probably don't
>> need so many days.
>
> Indeed, the existing code passes maximum_signed_value_of_type(int) as
> the third argument to limit it to INT_MAX already.

Yeah, in other words, the current implementation does not allow us
to express the days more than an int can, so it is no brainer to
switch to use git_parse_int().  Allowing longer expiration period
is obviously outside the scope of this series.

Thanks.
