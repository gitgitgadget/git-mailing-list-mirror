Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418E51F461
	for <e@80x24.org>; Mon, 19 Aug 2019 20:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfHSUQB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 16:16:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52116 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSUQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 16:16:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F126515A7A4;
        Mon, 19 Aug 2019 16:15:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+g7NMYegaLFKqkPN+jOL2EVMwwM=; b=F/GL6v
        hPnexcx4KOvJ5MKsZFNMYE7mnRZ5a60uAt1DexXfosZK5s7vHQ/mvssfZSybsRrF
        ifCnhNt52g08tkmRJAX0WtgvQPYob2tlrP8tgb12QmTP8fBIPxttUdX53Wm0MGKQ
        8gv6gvo5DBG4cTQdIlZqy/k/iF6wfTRllpbIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c4drdBpeTi8AzT/2T0l9qCIq5Y0JQfC2
        mDT0iRRYVSnjOt8OnCDPt3J70zTZ42RNTo/oL10CVirw/iJED0WnZDNtBNRmQ4E+
        rGYh8mgNQZcZQN2rnDooaycMoHcZuZ9MK0h+J73R/2LNUN9/cYC+bQ1XFak/6oAx
        5NkDN+2ca3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9ABC15A7A3;
        Mon, 19 Aug 2019 16:15:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5767F15A7A2;
        Mon, 19 Aug 2019 16:15:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] diff-lib.c: handle empty deleted ita files
References: <20190712150235.12633-1-vcnaik94@gmail.com>
        <20190801161558.12838-1-vcnaik94@gmail.com>
        <xmqqv9uy2qpj.fsf@gitster-ct.c.googlers.com>
        <CAK_rgsH0Yb=CAsCgD20xx==RaDzchtEua=q6K=7R-cfURFGHuQ@mail.gmail.com>
Date:   Mon, 19 Aug 2019 13:15:57 -0700
In-Reply-To: <CAK_rgsH0Yb=CAsCgD20xx==RaDzchtEua=q6K=7R-cfURFGHuQ@mail.gmail.com>
        (Varun Naik's message of "Mon, 19 Aug 2019 08:42:08 -0700")
Message-ID: <xmqqwof8x66a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28181930-C2BE-11E9-A927-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> This function is probably not the place where we want to make changes.
> It would be better to change diff-lib.c:show_modified() and
> diff.c:diff_change() to consider the intent-to-add bit when performing a
> diff.

I do agree that diff-lib.c::show_modified(), which is about "git
diff-cache" (and hence "git diff <tree-ish>", i.e. comparison
between a tree-ish and the index), is the right layer for this
change.

I am not offhand sure about the diff.c::diff_change(), though, and
cannot say much without first thinking about it a bit more.

Thanks.
