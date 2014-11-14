From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 12:04:05 -0800
Message-ID: <CAO2U3QhZrkmmCfFxKAcp+ojAso=ns6gA2g2TN5MZGdqCw0Y72A@mail.gmail.com>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
 <546656C8.3070009@kdbg.org> <CAO2U3QgmuwatfDDO8f461cwq2SctPx+owL8gDMBpNyDcaxaWGQ@mail.gmail.com>
 <20141114200239.GA11581@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:04:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpN6d-0003Z2-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161802AbaKNUE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:04:26 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56345 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161783AbaKNUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:04:26 -0500
Received: by mail-ob0-f170.google.com with SMTP id nt9so14304405obb.29
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GVb+GNf7rCpzK9GcVvosY7tczeiLCFAHM02sgp1kmcQ=;
        b=oilD8FsUf4pYDVJQ1/qCDmqPVivQN6bf80C4TVGR/tTfrnRj3toDl4UGMiZxJE4oie
         Y/zFhstQVN+2P+Y2Lc5BLG3xzFbQcpMqDZ7/NLDIgpUrxw3NXFPt9vnjA6mdaaU47k3m
         XihlkGKXnwDuox/Ai81RG3mKdjgy/JK0/GHAxtr9Uz8o0h/gZXPDAsnAzbokG4QSODFv
         BsGWehRC5dyqS5T2gWlSFV4zfvQNefbOIiFYf13W7b4PXL5/8mTmV2s4CMMvkh0YjU9W
         YmNjWEUGXey9xK9gCj0z4QX9U8A3zjEYQt6+UUXBTPgb5PaR3yti6HyhsZwt5nPsyWfB
         1pcw==
X-Received: by 10.60.52.177 with SMTP id u17mr9466821oeo.14.1415995465554;
 Fri, 14 Nov 2014 12:04:25 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Fri, 14 Nov 2014 12:04:05 -0800 (PST)
In-Reply-To: <20141114200239.GA11581@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right, I missed that there was more going on above, thanks =)

On Fri, Nov 14, 2014 at 12:02 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 14, 2014 at 11:48:36AM -0800, Michael Blume wrote:
>
>> My understanding is that && and || have equal precedence, and this
>> seems to be borne out in testing at my shell. If the if/then method is
>> clearer I'm happy to go with that.
>
> I think the problem is that there are earlier parts of the chain. It
> currently looks like:
>
>   foo &&
>   bar &&
>   do_something
>
> but you are making it:
>
>   foo &&
>   bar || baz &&
>   do_something
>
> which will do_something whether or not "foo" is true. You need to put
> your "||" at a lower precedence than the rest of the chain. The "if"
> that Johannes mentioned works, though I think
>
>   test_have_prereq PERL &&
>   {
>     test "$(uname -s)" != Darwin ||
>     test "$(uname -r | cut -d. -f1)" -ge 13
>   } &&
>   ...
>
> is more obvious to read (but that's subjective, of course).
>
> -Peff
