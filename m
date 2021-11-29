Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF7C4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbhK2Rbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:31:38 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36032 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236413AbhK2R3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 12:29:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F0D1B1F953;
        Mon, 29 Nov 2021 17:26:18 +0000 (UTC)
Date:   Mon, 29 Nov 2021 17:26:18 +0000
From:   Eric Wong <e@80x24.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
Message-ID: <20211129172618.GA26651@dcvr>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr>
 <xmqqtufx5p19.fsf@gitster.g>
 <87mtlnjhj6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtlnjhj6.fsf@intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jani Nikula <jani.nikula@intel.com> wrote:
> From the RFC nitpicking department, msg-id is allowed to contain CFWS
> (comments and folding white space) outside the angle brackets, which
> means you could have RFC compliant Message-ID header field:
> 
> Message-ID: 
>   <message-id@example.com>
> 
> or
> 
> Message-ID: (comment) 
>   <message-id@example.com>
> 
> or even worse, really.
> 
> The moral of the story is that you should always offload the header
> parsing to some tool or library designed to do that.

It's a bit much for common cases with git-send-email and
reasonable MUAs, I think.  I don't know if formail is commonly
installed, nowadays...

Fwiw, the code running lore uses something like this:

	/^Message-ID:[ \t]*([^\n]*\r?\n # 1st line
			# continuation lines:
			(?:[^:\n]*?[ \t]+[^\n]*\r?\n)*)
			/ismx

I'm fine with this non-trivial regexp being included with
GPL-2.0 code; but it could be too big for a one-liner *shrug*

... And <([^>]+)>/s to extract Message-IDs, but ISTR the code
behind lore doesn't handle spaces inside <> properly, but I'm
not sure if there's enough valid, non-spam messages with them...
