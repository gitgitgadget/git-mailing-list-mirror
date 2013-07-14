From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 14:28:00 -0700
Message-ID: <20130714212800.GA11009@google.com>
References: <7vli5bllsd.fsf@alter.siamese.dyndns.org>
 <51E0605E.9020902@kdbg.org>
 <7vy59biih4.fsf@alter.siamese.dyndns.org>
 <51E0F93A.8050201@kdbg.org>
 <7vwqougwec.fsf@alter.siamese.dyndns.org>
 <51E1B5DB.9080904@kdbg.org>
 <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
 <51E3084D.2040504@kdbg.org>
 <20130714203403.GE8564@google.com>
 <51E31131.3070005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 14 23:28:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTqI-00059K-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab3GNV2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:28:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47934 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab3GNV2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:28:07 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so10565537pab.13
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4Xni5qqmUPTCkmGNNmh+3YyvBMJzWzsT4mJz0KLWuyg=;
        b=AUctBHEC/dJZ0R1msjf3v3YPoorEwSS9YpPbY19itBNK1OE6XyAQBPV3m50ivj0dDT
         lhJll4/h1IWnAe0RHsgC2jURKvVqi6MzMHKnyQjkdWf+LKUzLPMqHY9UW0IwEEK+KbeQ
         Dk0LpP1Y0sN611lTGqBdBQnbjZ0MPmNd+/Yf6RY+8nNEEynpaLCT62zz3T3nDwZr/dB+
         X34fgKyXhTMrfvULRxUtXdKSWImc7IZM+igSAbe8rmR217HXsAqn26ncYQBbK4Arn+lQ
         GLTSphkzMdfHM234H9QRnHOJeFB7BI3z3XKRKsuY+5+2jaXxil1TT1xcEjsdShHcmZpg
         /QkA==
X-Received: by 10.68.255.1 with SMTP id am1mr50577437pbd.68.1373837287341;
        Sun, 14 Jul 2013 14:28:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 4sm57080469pbw.32.2013.07.14.14.28.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:28:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E31131.3070005@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230392>

Johannes Sixt wrote:
> Am 14.07.2013 22:34, schrieb Jonathan Nieder:

>> Would a '*' that acts like --lockref on a per ref basis address your
>> concerns?
>
> No, because I think that new syntax is not necessary.
>
> But admittedly, I haven't spent any time to think about push.default
> modes other than 'matching'. In particular, I wonder how Junio's last
> example with push.default=simple can work today:
>
>    $ git pull --rebase  # not a merge
>    $ git push
>
> because it is not a fast-forward.

Right, let's examine this example more closely.

If I run:

	(1) git pull --rebase
	(2) git push

then normally that push will be a fast-forward.  My changes are
on top of the new upstream changes, just as though I used format-patch
and send-email to submit the changes to a maintainer who would then
apply them.

However, someone else might have pushed to the same branch between
step (1) and (2), causing the fast-forward-only push to fail.

Usually that means other person made a valuable change and I can
simply repeat steps (1), and (2) and they will succeed.

But maybe that intervening push was a mistake.  To distinguish that
possibility I might do something like

	(3) git fetch origin
	(4) gitk @{u}@{1}..@{u}; # Is the change good?

	(5a) git pull --rebase; git push; # Yes, put my change on top of it
	(5b) git push --force; # No, my change is better!

So far so good.  But what if yet another change is made upstream
between step (3) and (5)?

If following approach (5a), that's fine.  We notice the new
intervening change and react accordingly, again.  There is a
possibility of starvation, but no other harm done.

In case (5b), it may be a serious problem.  I don't know about the
intervening change until I read the "git push" output, and in the
usual case I just won't notice.  The new lockref UI is meant to
address this problem.  So in the new world order, in case (5b) it
sounds like I should have instead used

	(5b') git push --allow-non-ff

Suppose I am writing a script that is meant to set the remote
repository to a known state.  Other contributors are only using
fast-forward updates so once my change goes in they will act
appropriately.  I just need to get my ref update in, without being
blocked by other ref updates.

Then I will use

	(5c) git push --force

which means not to use this new lockref trick that looks at my
remote-tracking branch and instead to just force the ref update.  This
would for example be the right semantics when pushing to a mirror from
a relay that also fetches from a canonical repository.  It avoids
needing to fetch from the target repo before every push.

Of course if ref updates are highly contended, even the current "git
push --force" will sometimes fail, since it internally *does* use a
compare-and-swap against the result of an ls-remote.  That's a (minor)
bug, imho.  Fixing it will require tweaking the protocol to make the
compare-and-swap optional.
