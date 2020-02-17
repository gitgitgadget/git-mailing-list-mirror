Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE2C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7971D2070B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ivt2L2YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgBQVD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:03:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54486 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgBQVD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 16:03:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14653552A9;
        Mon, 17 Feb 2020 16:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XcD/7bLioQZd8Eddl537ouG0LBA=; b=Ivt2L2
        YEOx0yxxYKvQHsKPcalSBCaBLcRu1hjsXxDQfOdj6Or8GdYYUbf/naVUOjk+B6rK
        YjtiNHwudsAe2crSnw337WelYpF+hC8uEeyOeE5yCuKowEF9F71hW0dBh5xrE3g6
        3oyMCn4r79LMuFiFCe2LWhBZcEv2NtwZIL50Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qKoy6DcODzXUcZo/6Scst5hB5ca0dGXK
        eYmvO9fcC4Aa7QbKzh1oNbWiYolaCYQ2/Bv5USZyBBEAWrkAQf+20kKbSf1Wd/ea
        /pcDjC2srP8LSs7P2SqUi1xWOi3XQj5i09kQWVBMmNsBqnyqRttkQo4zeG6M0XbG
        uMVSZ13cdr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B79F552A8;
        Mon, 17 Feb 2020 16:03:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 657EF552A7;
        Mon, 17 Feb 2020 16:03:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 2/8] rm: support the --pathspec-from-file option
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <7ccbab52e51423a9ba74c0cab77448ceabb9dcdc.1581345948.git.gitgitgadget@gmail.com>
        <xmqq4kvyyy5d.fsf@gitster-ct.c.googlers.com>
        <994b082b-cd86-a7cb-f70c-1753ad988abb@syntevo.com>
        <xmqqmu9hksby.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 17 Feb 2020 13:03:54 -0800
In-Reply-To: <xmqqmu9hksby.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 17 Feb 2020 09:59:45 -0800")
Message-ID: <xmqqa75hkjt1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0222CE10-51C9-11EA-A099-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I may not have time to read it over at least in a few days, but lack
> if v3 in the title will make it cumbersome to come back ...

Oops, please disregard.  I must have been looking at some wrong
thread.
