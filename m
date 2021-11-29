Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5EEC433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 12:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbhK2MIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 07:08:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:63418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236237AbhK2MGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 07:06:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="223179093"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223179093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 04:03:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511658562"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO localhost) ([10.252.11.182])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 04:03:19 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
In-Reply-To: <xmqqtufx5p19.fsf@gitster.g>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
 <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr> <xmqqtufx5p19.fsf@gitster.g>
Date:   Mon, 29 Nov 2021 14:03:09 +0200
Message-ID: <87mtlnjhj6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 27 Nov 2021, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
>
>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>> Just to be sure I'll do what you expect to be done: I assume you want to see
>>> it changed like this?
>>> 
>>> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
>> ...
>> The entire match should be case-insensitive[1], so I'd add `i'
>> at the end:
>>
>> 	perl -pi -e 's|^Message-ID:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|gi;' "$1"
>>
>> Fwiw, every mail and HTTP/1.x header parser I've looked at works
>> case-insensitively.  Also, I'm not sure if `g' is needed, actually...
>
> It is left anchored with "^" so it would be hard to match more than
> once on the same line ;-)
>
> I agree that it is the right solution to make the whole thing
> case-insensitive by adding 'i' at the end.
>
> FWIW, the RFC first says this:
>
>     1.2.2. Syntactic notation
>
>        This standard uses the Augmented Backus-Naur Form (ABNF) notation
>        specified in [RFC2234] for the formal definitions of the syntax of
>        messages.  Characters will be specified either by a decimal value
>        (e.g., the value %d65 for uppercase A and %d97 for lowercase A) or by
>        a case-insensitive literal value enclosed in quotation marks (e.g.,
>        "A" for either uppercase or lowercase A).
>
> and then goes on to define how message-id should look like.
>
>     3.6.4. Identification fields
>
>     message-id      =       "Message-ID:" msg-id CRLF
>
>
> But if you go the "add /i at the end" route, you do not have to
> upcase "d" to "D" and that may reduce the patch noise (it only
> matters if the patch viewer highlights letter-by-letter changes for
> your recipients).

From the RFC nitpicking department, msg-id is allowed to contain CFWS
(comments and folding white space) outside the angle brackets, which
means you could have RFC compliant Message-ID header field:

Message-ID: 
  <message-id@example.com>

or

Message-ID: (comment) 
  <message-id@example.com>

or even worse, really.

The moral of the story is that you should always offload the header
parsing to some tool or library designed to do that.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
