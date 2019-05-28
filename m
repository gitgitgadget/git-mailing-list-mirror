Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0C31F462
	for <e@80x24.org>; Tue, 28 May 2019 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1VJK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:09:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53020 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfE1VJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:09:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0237F14ADD2;
        Tue, 28 May 2019 17:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6yYUBfjVjkDNxSodi1NlVbDrv5o=; b=osPZJ/
        nzo4KYcj8wbIfn8+3KXKy7YtLJjvxj9KHrXyGzEuh88UrPscvrrjRL+OZLwIotUd
        sB0O+rnaAjp4f5FgjGQDiUxaU7xPNZYp8acSZ4JuzLPJFAbv+N0Ni4wEoCWSMi5A
        s3Fc59BkBUl1ySpodT4gGuL825IezW7KItdEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cTOVgvps9KjOEwK9921AH6IMFD7kR0Pp
        3zvzayZ/mVJY2sXLJH2tYU7qa2JR10Fidl30sEC5CJv38ZBIeNG3t50Rxw6gniLY
        MbrEND7XHhyJRrK5YJq9EqRgyyCdoSbNOfFZWLfD6h43Ht02h4MAGFEI5L6RYemq
        NGmUzVVxD3Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED27014ADD1;
        Tue, 28 May 2019 17:09:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61FCE14ADD0;
        Tue, 28 May 2019 17:09:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object database
References: <pull.226.git.gitgitgadget@gmail.com>
        <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
        <20190528015133.GA29724@sigill.intra.peff.net>
        <xmqqftoy1h4h.fsf@gitster-ct.c.googlers.com>
        <20190528210428.GE24650@sigill.intra.peff.net>
Date:   Tue, 28 May 2019 14:09:06 -0700
In-Reply-To: <20190528210428.GE24650@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 28 May 2019 17:04:28 -0400")
Message-ID: <xmqqy32qz3pp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D49FB816-818C-11E9-AA0E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I guess you are asking only about the part that I dismissed above as
> "not all that interesting". I.e., do people actually run:
>
>   git bundle verify foo.bundle &&
>   git clone foo.bundle
>
> That is not nonsense, per-se, but it is somewhat pointless since the
> clone will verify the bundle itself anyway. But then, I guess I do not
> see much point in anyone calling "bundle verify" in the first place.

Yeah, I tend to agree that 'bundle verify' is pointless before
trying to clone from it and seeing it fail (it still would be useful
if 'bundle verify' gives more info on the breakage than 'clone', but
it is not all that interesting at that point unless the user is
working on git itself).
