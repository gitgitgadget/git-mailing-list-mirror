Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9339F1FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 17:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbcLKRtt (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 12:49:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62441 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751797AbcLKRts (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 12:49:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77F3D53454;
        Sun, 11 Dec 2016 12:49:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MvFyUCY6h14sSeMvgsmL59mAStQ=; b=HPwHCJ
        Cvo/9HrFtoOAzghx19q3AeHpKQuoqWQtjiPQXRgtfum+CpVPrE+DwnC0PVNlZpA7
        64KWMd9OqnkQ8c0IdCm5tylWosxvXCVcDKGAGNiL7d03CuG8o/EE/drxTV5kRwcF
        0BXv+sx3jW7yNX5YNE8AEdj21WEdSE5PWpaR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T6IWfMana986wRFkZ/XHBreM9JvROAi7
        LAug8X+5Crh9XtP4vNWVvzhnWroJVgmFFgKIaN6HMVsFJ/l4gEN569keqmm7DIyP
        bi+BKN5jxq6TwtBLM7/WCtvqXS91OOIg0vpFfXSk7ticNHv39ko4+a9DBJTkOQE1
        ZL5NMKrkdWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E0F753452;
        Sun, 11 Dec 2016 12:49:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAC835344D;
        Sun, 11 Dec 2016 12:49:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/1] Fix a long-standing isatty() problem on Windows
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Dec 2016 09:49:45 -0800
In-Reply-To: <cover.1481454992.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sun, 11 Dec 2016 12:16:49 +0100 (CET)")
Message-ID: <xmqqmvg2nyo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 349E8EE0-BFCA-11E6-A220-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> I finally got a chance to debug the problems with the ever-timing-out
> test runs of `pu` on Windows. Turns out that pb/bisect uncovered a
> really old, really bad bug: on Windows, isatty() does not do what Git
> expects, at least not completely: it detects interactive terminals *and
> character devices*.

Sounds as if somebody who did Windows at Microsoft had a good sense
of humor to mimick the misnamed ENOTTY gotcha ;-) 

This is a great find, and a very impactful fix, as redirecting from
/dev/null is how we try to force a "go interactive if talking to
tty" program to realize that it is not talking to a tty.

Thanks.


