From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 15:59:49 -0700
Message-ID: <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXOcQ-0006ua-7Q
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 01:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYHXW77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYHXW77
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 18:59:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYHXW76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 18:59:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 217636E30B;
	Sun, 24 Aug 2008 18:59:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F4B96E30A; Sun, 24 Aug 2008 18:59:51 -0400 (EDT)
In-Reply-To: <20080824220854.GA27299@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 24 Aug 2008 18:08:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E87472E-7230-11DD-A408-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93573>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 24, 2008 at 11:11:14AM -0700, Junio C Hamano wrote:
>
>> Consistency and usefulness are different things.  Suppose you want as the
>> upstream of your project maintain and distribute a mail-alias list in-tree
>> (say, the file is at the root level, CONTRIBUTORS), and you suggest
>> contributors to use it when using "commit --author".
>> 
>> Which one do you want to write in your README:
>> 
>> 	[user]
>>         	nicknamelistfile = ../CONTRIBUTORS
>> 
>> or
>> 
>> 	[user]
>>         	nicknamelistfile = CONTRIBUTORS
>> 
>> You have to say the former if it is relative to .git/config.
>
> Couldn't the exact opposite argument be made for "suppose you want to
> put the mail-alias file in a repo-specific directory that was not
> tracked?" I.e., you are trading off "CONTRIBUTORS" against
> ".git/CONTRIBUTORS".

No, I couldn't ;-)

Why would you write what you wrote in README?

Anything you store in .git is not propagated, so the instruction would not
likely to be "store it in .git/CONTRIBUTORS and point at it".  There is no
merit in forcing users to standardize on "in .git".  The instruction would
be to "store it anywhere you want, and point at it".

The example I gave is very different.  It points at an in-tree thing, and
anybody who has worktree checked out will have it _at the location I as
the README writer expect it to be_.  That is the difference that makes the
exact opposite argument much weaker.

That's why I suggested "relative to work tree if in .git/config, or gitdir
if in config of a bare repository", although honestly speaking I do not
have very strong preference either way.

> If you want to be able to point to either, I suspect we are better off
> simply introducing some basic substitutions like $GIT_DIR and
> $GIT_WORK_TREE. Maybe even just allow environment variable expansion,
> and then promise to set those variables, which takes care of $HOME
> automagically.

Because we haven't deprecated core.worktree (or $GIT_WORK_TREE) yet, your
suggestion has an obvious chicken-and-egg problem, even though otherwise I
think it makes perfect sense and very much like it.

Perhaps we should rid of the worktree that is separate and floats
unrelated to where $GIT_DIR is.
