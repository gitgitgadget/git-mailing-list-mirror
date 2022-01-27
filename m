Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E366C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 06:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiA0GPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 01:15:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60614 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiA0GPq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 01:15:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C616F101971;
        Thu, 27 Jan 2022 01:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KBdg25URYh/X0NlW/hIn8ebVqGl3bVp70Ybvzx
        J2yLY=; b=I7DGbhZ05qSsellpjwpgopqJwD1Kq9CFxwx7Gm0++tq1QeJ8wu2q6B
        rqM/ePG2N4RVFWESngoWAzjgqtouODZn61D7xMM1R1+JthpjM7xRGArfEGjG/1hi
        fNaTx0AStlEQ9+Aj8VhcuuWsLW7a0LBKtHYOR+1FG/auVtTFX09lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC03A101970;
        Thu, 27 Jan 2022 01:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 24EA310196F;
        Thu, 27 Jan 2022 01:15:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: WARNING: terminal is not fully functional
References: <CAH8yC8kYP2Sth+vUZMzHujKQZC6r1kFf+Lz=6_WRs4GFR65B9g@mail.gmail.com>
Date:   Wed, 26 Jan 2022 22:15:43 -0800
In-Reply-To: <CAH8yC8kYP2Sth+vUZMzHujKQZC6r1kFf+Lz=6_WRs4GFR65B9g@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 27 Jan 2022 01:00:06 -0500")
Message-ID: <xmqqr18t4sc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FF3F8A6-7F38-11EC-918D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I needed to install Git on Ubuntu 8. Git seems to work Ok for most
> task, but this is unusual:
>
>     $ git diff
>     WARNING: terminal is not fully functional
>     -  (press RETURN)
>
> Here's the terminal:
>
>     $ echo $TERM
>     xterm-256color

A short answer.  You are using "less" as the pager, but it is not
working with your terminal.  Likely reason is perhaps you are
missing terminfo/termcap database entry for that terminal.

I have working xterm-256color, so

	$ TERM=xterm-256color less README.md

works as expected, but using a (bogus) terminal that no system would
have ever heard of, e.g.

	$ TERM=no-such-terminal-exists less README.md

results in exactly the symptom you are observing.

Something to try quickly would be:

$ export TERM=vt100; less README.md

As the termcap/terminfo entry for vt100 is usually more widely
available, this may unblock you.

> It seems like loss of colors on an old platform is not that important.
> However, the message being printed creates an actionable item that
> needs attention. I think no message would be a better option.

You would want to redirect it to folks who work on "less" ;-)
