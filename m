Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F79C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0FE229C6
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbhARVKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:10:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64478 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbhARVCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:02:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7F3611D58D;
        Mon, 18 Jan 2021 16:01:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=042eeLOIaAGnUUPxCu6io7XpRBs=; b=LlCpAv
        d2tC91bwsWO7+svbBjjF+Fy72+FsPofM5BgVA4Aw0jN17T5lYo66suF7GdEb0tA4
        fZXhsTjVX4GsWJCpa9jyQ4TI9z8WGMq6pjW/3Jf282eoFe5oJEjelqcjvhLyIMpa
        99zP6704PJK9P6Pg9RYzsIrY+mJIIoSOC9Gug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XVlbbXRi6P4jfZkb6g3Y84wQtTtqnIxe
        hW8chxu6qYQbjoTcOWp6iWPwraU8mrNNrL+0dqELdZVu1lnVXlRKIwXOn+hBPwtX
        AhhEo27YPmnJiDiE+Z5FNfYNblNFIrBRkAx62GWsZKEjap8la91AVE1D3Kyr30tO
        O44ittAvoOk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0A3711D58C;
        Mon, 18 Jan 2021 16:01:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24D0111D58A;
        Mon, 18 Jan 2021 16:01:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] revision: implement --show-linear-break for --graph
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-3-kmarek@pdinc.us>
        <xmqqsg6zkwa8.fsf@gitster.c.googlers.com>
        <xmqq35yzknbr.fsf@gitster.c.googlers.com>
        <04c81462-3181-37d7-0109-4292040b84e9@pdinc.us>
Date:   Mon, 18 Jan 2021 13:01:54 -0800
In-Reply-To: <04c81462-3181-37d7-0109-4292040b84e9@pdinc.us> (Kyle Marek's
        message of "Mon, 18 Jan 2021 02:56:24 -0500")
Message-ID: <xmqqmtx6j6wt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65D7BAE6-59D0-11EB-8E9E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> Me too, but I think a user-defined mark needs to be a string to
> support Unicode characters.

Ahh, I didn't even consider making it user-defined.

As it seems a lot safer to make this an optional feature, it does
sort-of make sense to let the letters used for root & left-root be
customizable, and it does make sense to take a multi-byte character,
but I am not sure what implications it has if we allowed any string
without ensuring that it occupies one display column.

