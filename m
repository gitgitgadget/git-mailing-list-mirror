Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F4A1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 05:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfG2FJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 01:09:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54436 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfG2FJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 01:09:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D9F8165DE1;
        Mon, 29 Jul 2019 01:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H82BTxiSOZeZ8gclxSVvP1nDd7Q=; b=Vv0eRX
        9pHnUodgQU1xbw1PDzsgG4jszses8UfhEOluAnl+ODwrEcCGSo7pRGOq1vl4I+LL
        XkCsXTHyrKVfNl1WLeVyJ3pIYNjioQgLBLs8fe52ZbHBExEqagPZ/DUPZLfJ48YZ
        humRhcBSwZy6t7hZ3cIaEbHzwRIuKcd4peepU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMTnU7CF5FoE7eypbMUr4IiZIVEw7hps
        zPXQ/HnQHaJbLw5EhlRCGBZbEAhOtJAukqV4CyqH+Kqlh8Me1wPuSOpjRe+p3w0N
        f/P/JTkMSSZBnvn3ysuvIUHgp9mADhGix7JaeYJvtF/9pki6K2dKkbT7Nkk+Un6D
        E4qjmoAVATg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05BF5165DE0;
        Mon, 29 Jul 2019 01:09:25 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D4E5165DDF;
        Mon, 29 Jul 2019 01:09:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
References: <20190728151726.9188-1-me@yadavpratyush.com>
        <20190728213634.GB162590@genre.crustytoothpaste.net>
        <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
        <20190728224943.GC162590@genre.crustytoothpaste.net>
Date:   Sun, 28 Jul 2019 22:09:23 -0700
In-Reply-To: <20190728224943.GC162590@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 28 Jul 2019 22:49:44 +0000")
Message-ID: <xmqqef29l94s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 081F90FA-B1BF-11E9-B73F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> These are probably pretty cheap on all but the largest repositories. I
> was worried we were enumerating all refs or all history or something
> like that.
>
>> ui_do_rescan changes the focus to the first diff. It is executed when you
>> press F5 or choose Rescan from the menu. do_rescan does not do that.
>> 
>> Resetting to first diff on focus change will get annoying when you are in
>> the middle of looking at some other file. do_rescan just updates the
>> software state without changing what file you are looking at or where in
>> that file you are looking at.
>
> Yeah, this definitely seems like the right move.

"Right move" in the sense that it would try not to change what is
being shown too much.  Rescan will still not be without cost, so it
will be annoying if it happens when the user did not make any
change.

And it is annoying even more, if the user did make change in another
window.  You may make a change perhaps from the command line, write
a short e-mail about it to let others know in your MUA, and then
switch the focus back to git-gui to continue working.  Refreshing
upon git-gui getting focus is no better than manually pressing F5 or
whatever at that point.  It is too late at that point for spending
extra cycles without being asked without getting annoying to the user.

The right time to spend cycles (in the background) in the above
sample sequence is immediately after you made a change and switch to
your MUA---while you are typing a few paragraphs, you would not mind
git-gui spending seconds to repaint.

So probably a more productive use of our time, if we were to futz
with git-gui, would be to figure out how git-gui can have an
background idle process that notices a change in the repository and
refreshes but only when you are *not* interacting with it (if it
does things while you are interacting with it, it would become
annoying and distracting), I would guess.  Just when you come back
is the worst, and the most annoying, time to auto-refresh.

