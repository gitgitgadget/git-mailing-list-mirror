Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F23320899
	for <e@80x24.org>; Wed,  9 Aug 2017 06:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdHIGEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 02:04:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750798AbdHIGEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 02:04:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DCE9A0C76;
        Wed,  9 Aug 2017 02:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SqFxElk8ff9MZccZZ5nceIgNaag=; b=ASFwLY
        s39XjT5tufnAHoIGpPz7QbyL4tgo+xsHfnTU2HBBWJe++7EASiY64rAa9knZXkNN
        AGA7syIDpUkFOKKbKYGJALDo8IS2YFdeKlXq3+I/l//P0IfGcczK6US2Y4dv2f0k
        V/748qDBgngUV+pdxvLg0/ITLhY63EeVKCA0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kBQhY0BGYMscIb0kOGMDveF3NKKP8kqv
        V51k65mofb600rf4b1rvKpMpUmzYq5hoX3jq/9j4exDuEDM0F9sqaIZWAjVqYiHe
        J6pF3wXXzl3I6Bsc9c2x4M242YzikHTQZYWrie8JNCJfFmVB8ohJIOFqQNmrZ57q
        bUhR6YBLRIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 868BDA0C75;
        Wed,  9 Aug 2017 02:04:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC092A0C74;
        Wed,  9 Aug 2017 02:04:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Convert size datatype to size_t
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
Date:   Tue, 08 Aug 2017 23:04:20 -0700
In-Reply-To: <1502222450-20815-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Tue, 8 Aug 2017 22:00:50 +0200")
Message-ID: <xmqq8tit8efv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 968C0716-7CC8-11E7-8882-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>
>
> It changes the signature of the core object access function
> including any other functions to assure a clean compile if
> sizeof(size_t) != sizeof(unsigned long).

As https://travis-ci.org/git/git/jobs/262463159 shows, unfortunately
it turns out that things are not so simple X-<.  On Linux32, size_t
is uint, which is the same size as ulong, but "%lu" is not appropriate
for showing a size_t value.

So you are correct to say in the comment under three-dashes that
there is much more to change in the codebase.


