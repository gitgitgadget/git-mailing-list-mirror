Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE96EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 23:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGQX4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGQX4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 19:56:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E809D
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 16:56:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E25E42038C;
        Mon, 17 Jul 2023 19:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HRGkjUtttQUzaWLWeDVTMwRC5QvbX887OTHAzx
        Unscc=; b=Zhqi+oeQn/2t3XJkIdRiVETiRBYRSoCfegBQJRIms4K0sSww1CoAEw
        YMMl+WV6hBcIlUAertxRlw8+hYqwNTxBvFHpQI9PR6zra6Ib7Gv7JeyVg9PKDwB6
        XuSY6pzqNdP4gJkz74TAquM9ix06Zb7AYr1xDRTyj4Zo1lE9aBnX4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD4DF2038B;
        Mon, 17 Jul 2023 19:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CE422038A;
        Mon, 17 Jul 2023 19:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org
Subject: Re: Teach git-fetch(1) to use a quarantine directory
References: <87edl6bx7o.fsf@iotcl.com>
Date:   Mon, 17 Jul 2023 16:56:05 -0700
In-Reply-To: <87edl6bx7o.fsf@iotcl.com> (Toon Claes's message of "Mon, 17 Jul
        2023 12:48:17 +0200")
Message-ID: <xmqqcz0qdre2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E9CDB56-24FD-11EE-ABCD-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> 1) Does it even make sense to make use git-fetch(1) use a quarantine
>    directory?

What's the goal here?  If the push gets rejected, remove the
incoming packfile data together with quarantine repository?  Who
will be doing such a rejection and how?  Does something run in the
quarantine repository as its main repository while using the final
one as an alternate (presumably some form of hooks) to make that
decision?  If these goals do not make sense, then no, it does not
make sense to teach "fetch" to use a quarantine directory.
Otherwise, teaching "fetch" would be a reasonable way to go forward.

It is a separate issue if the mechanisms added (if any) when we
tought receive-pack to use a quarantine repository are directly
applicable, if if they need some twaking, in order to reuse them in
the context of "git fetch".  But their needing some tweaking does
not mean that it does not make sense to try teaching "fetch" to use
quarantine repository.

Thanks.
