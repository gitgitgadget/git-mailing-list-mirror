From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 05 Sep 2005 11:46:25 -0700
Message-ID: <7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
References: <11258971871874-git-send-email-ryan@michonline.com>
	<46a038f905090504166246dc0a@mail.gmail.com>
	<20050905153705.GD5335@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 20:47:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLzE-00085I-IS
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVIESq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVIESq3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:46:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63180 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932390AbVIESq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 14:46:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905184626.WAGT20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 14:46:26 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050905153705.GD5335@mythryan2.michonline.com> (Ryan Anderson's
	message of "Mon, 5 Sep 2005 11:37:05 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8111>

Ryan Anderson <ryan@michonline.com> writes:

> On Mon, Sep 05, 2005 at 11:16:57PM +1200, Martin Langhoff wrote:
>> 
>>  - reads "subject" from the first line of STDIN or file. If the line
>> doesn't start with [PATCH it provides the [PATCH] prefix. I found it
>> really confusing that it wants to get 'from' in the first line...
>> that's not what git-format-patch produces!
>
> Sorry about that - I always export using git-format-patch using --mbox,
> and those work nicely.  I'm a bit reluctant to do the [PATCH] fixup, but
> I think I will:
>
> 	1. Detect [PATCH] or [PATCH [0-9]+/[0-9]+] (Sorry for the horrid
> 	fake-regexp)
> 	2. Provide a --no-fixup-subject to turn that off.
>
> (TODO #2)

To be consistent with the other tools in tools/ directory, the
above is probably 's/^/[PATCH] / unless (/^\[PATCH/])'

> In this case, remember that this was an attempt to help users patch bomb
> lists, getting all the subtle details correct.  The prompting is there
> to help get the subtle details correct!

You could error out without asking if that is what is happening.

> Well, I'm not.  Try "git format-patch --mbox -o patchdir origin" and see
> if that works better for you.

Martin, --mbox has the added benefit that it consistently
preserves the From: and Date: information even for your own
patches, because it implies --date and --author.  By default
without --author and --date these are not preserved from the
original commits for your own patches, primarily because
format-patch without --mbox was written for reorganizing and
reordering existing patches (i.e. export, concatenate some, edit
some hunks, and eventually feed it to applymbox to make commits;
you do not typically want to keep the original author date for
this kind of use).

> I do apologize for not realizing that the default git format-patch
> output doesn't match what git send-email script expects the "legacy"
> mode - I'll sort that out one way or another as well. (TODO #3)

I do apologize for not really saying what --mbox does and what
the format-patch output without --mbox is meant for.

Martin, is there a reason you do not want --mbox format
(e.g. format-patch --mbox spits out Subject: line undesirably
formatted while it does what you want without --mbox)?
