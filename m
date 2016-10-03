Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5721207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbcJCWN1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:13:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60180 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751623AbcJCWN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:13:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF0494228C;
        Mon,  3 Oct 2016 18:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B5gwMPASRdusVyjYwgRnG75YglY=; b=xc5QTf
        A78ydR83GwYRSpCrQeYXqzoEU6uAEyHdXOPzVbpjdk9q36H0dT3+GSRDPq8uItc1
        /gqUxk+AZ7/gi7PV1nkUcjmTlZNQHmrocsS7vKBEgmX+vl1JYuIHq6GSMjHKdVXZ
        tR1XrBG0ClEy6zATLE7WXWi+hwmZYNxfVkyyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X/Lma97x5ptW1+STQS/TbpJTH5t13t+f
        aYQFR18ve67nTdmt0Po38KVGvw7/olpGwO8iIMs8mJfrvdUkjws5EE4KrlxESW44
        AK6fhR5Yx76xi2iF3mcfK5jMSjTonEXM+iChDNR0cal4ZXQF7W/wO/4uCm98ImxW
        PaS4HcND6ow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E22204228A;
        Mon,  3 Oct 2016 18:13:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61F3642289;
        Mon,  3 Oct 2016 18:13:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
        <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
        <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
Date:   Mon, 03 Oct 2016 15:13:22 -0700
In-Reply-To: <d3df0636-1975-1d08-2f34-384984c72e5d@google.com> (Jonathan Tan's
        message of "Mon, 3 Oct 2016 14:28:14 -0700")
Message-ID: <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A1F14D2-89B6-11E6-BC47-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There are other options like checking for indentation or checking for
> balanced parentheses/brackets, but I think that these would lead to
> surprising behavior for the user (this would mean that whitespace or
> certain characters could turn a valid trailer into an invalid one or
> vice versa, or change the behavior of trailer.ifexists, especially
> "replace").

Yes, that is exactly why I said that it may be necessary for the
code to analize the lines in a block identified as "likely to be a
trailing block" more carefully.  We can afford to be loose as long
as the only allowed operation is to append one at the end, but once
we start removing/replacing an existing entry, etc., the definition
of what an entry is becomes very much relevant.

