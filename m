From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 5 Sep 2005 11:37:05 -0400
Message-ID: <20050905153705.GD5335@mythryan2.michonline.com>
References: <11258971871874-git-send-email-ryan@michonline.com> <46a038f905090504166246dc0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 17:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJ27-00055T-4c
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 17:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVIEPhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 11:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIEPhJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 11:37:09 -0400
Received: from mail.autoweb.net ([198.172.237.26]:10156 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750971AbVIEPhH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 11:37:07 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1ECJ1u-0006Kr-L1; Mon, 05 Sep 2005 11:37:06 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1ECJ1u-0000VY-00; Mon, 05 Sep 2005 11:37:06 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1ECJ1t-0006lA-SV; Mon, 05 Sep 2005 11:37:05 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f905090504166246dc0a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8096>

On Mon, Sep 05, 2005 at 11:16:57PM +1200, Martin Langhoff wrote:
> Ryan,
> 
> is it possible to fix the git-send-email script to "just work" reading
> in the emails that `git-format-patch-script -o patchdir origin`
> generates? I have a very ugly local patch to git-send-email-script
> that
> 
>  - reads "from" from git-var, can be overridden by passing an explicit --from

git-send-email-script already reads the "From:" from git-var - but I
suppose I should only *prompt* for the from if something isn't
satisfactory with the output of git-var.  TODO #1

>  - reads "subject" from the first line of STDIN or file. If the line
> doesn't start with [PATCH it provides the [PATCH] prefix. I found it
> really confusing that it wants to get 'from' in the first line...
> that's not what git-format-patch produces!

Sorry about that - I always export using git-format-patch using --mbox,
and those work nicely.  I'm a bit reluctant to do the [PATCH] fixup, but
I think I will:

	1. Detect [PATCH] or [PATCH [0-9]+/[0-9]+] (Sorry for the horrid
	fake-regexp)
	2. Provide a --no-fixup-subject to turn that off.

(TODO #2)

>  - it never prompts for anything

I think I'm tending in that direction - I'll keep making the prompting a
fall-back by adding better default detection.

In this case, remember that this was an attempt to help users patch bomb
lists, getting all the subtle details correct.  The prompting is there
to help get the subtle details correct!

> I then invoke it with 
> 
>   git-send-email-script --to git@vger.kernel.org patches/0001-bad-uglypatch
> 
> and it "just works". I haven't sent them anywhere because I just
> wanted it to work locally for me, and it's just a bunch of hacks. And
> you are clearly using something other than git-format-patch to
> generate those patchfiles -- and my patches would break that.

Well, I'm not.  Try "git format-patch --mbox -o patchdir origin" and see
if that works better for you.

> OTOH, it'd be great if it did support the git-format-patch output. Let
> me know if you want bits and pieces of my hack - though it's trivial.

Sure, send it at me, and I'll see what I can incorporate.

I do apologize for not realizing that the default git format-patch
output doesn't match what git send-email script expects the "legacy"
mode - I'll sort that out one way or another as well. (TODO #3)

-- 

Ryan Anderson
  sometimes Pug Majere
