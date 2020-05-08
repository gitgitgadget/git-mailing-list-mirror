Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB9C47257
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F8216FD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W7B+z5a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEHRxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 13:53:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50769 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHRxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 13:53:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 787E5B8BC4;
        Fri,  8 May 2020 13:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5WvAfc7eMkL3EEOcS5GKC3UTCXM=; b=W7B+z5
        a7jpLcYRF1ChR/x7GON1+iPoom5dgPVYgIh01MMMgNHrT1SHfDA6iw7oFWdy74Qo
        1ton2HphHfir2QBQSBg42Kh2LdznVo2EnuajPXLVjkSitePDSsL43zLNW0YjLeB6
        uePytw2LSvu2WlANxQoK01iQuQa/FysDEhyxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A5n/4+Pg6uo6P3WP9lEto5rSw1rzwMgH
        pqXrDhcgsWw0c5slsPbVMEEp9qWfQowq88gbTLRcyWTtRzPztG2cTnrX33WrHyio
        DGNzWf5woEE+nRl+g8m/xnzE4Cy/pqQW2aoWWe4pwHg+DIClwP4cMr/Hbm9NjxbV
        ovBt1l4kMbo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70A17B8BC2;
        Fri,  8 May 2020 13:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1FDDB8BBF;
        Fri,  8 May 2020 13:53:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
        <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
        <xmqq8si2z8zb.fsf@gitster.c.googlers.com>
        <20200508171232.GA637136@coredump.intra.peff.net>
Date:   Fri, 08 May 2020 10:53:48 -0700
In-Reply-To: <20200508171232.GA637136@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 8 May 2020 13:12:32 -0400")
Message-ID: <xmqqv9l6xqhf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF4673BC-9154-11EA-A42F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +	oIFS="$IFS" IFS="$IFS:$(printf '\015')"
>
> There's no ":" separator in IFS, so here you're treating colon as
> end-of-line. I think you just want:
>
>   IFS="$IFS$(printf '\015')"

Yup.  Thanks for spotting ;-)
