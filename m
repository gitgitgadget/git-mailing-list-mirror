From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 18:08:54 -0400
Message-ID: <20080824220854.GA27299@coredump.intra.peff.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 00:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXNmv-0003CA-Lr
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 00:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbYHXWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 18:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYHXWI5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 18:08:57 -0400
Received: from peff.net ([208.65.91.99]:4862 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbYHXWI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 18:08:57 -0400
Received: (qmail 14716 invoked by uid 111); 24 Aug 2008 22:08:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 18:08:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 18:08:54 -0400
Content-Disposition: inline
In-Reply-To: <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93570>

On Sun, Aug 24, 2008 at 11:11:14AM -0700, Junio C Hamano wrote:

> Consistency and usefulness are different things.  Suppose you want as the
> upstream of your project maintain and distribute a mail-alias list in-tree
> (say, the file is at the root level, CONTRIBUTORS), and you suggest
> contributors to use it when using "commit --author".
> 
> Which one do you want to write in your README:
> 
> 	[user]
>         	nicknamelistfile = ../CONTRIBUTORS
> 
> or
> 
> 	[user]
>         	nicknamelistfile = CONTRIBUTORS
> 
> You have to say the former if it is relative to .git/config.

Couldn't the exact opposite argument be made for "suppose you want to
put the mail-alias file in a repo-specific directory that was not
tracked?" I.e., you are trading off "CONTRIBUTORS" against
".git/CONTRIBUTORS". So which one inconveniences the smallest number of
people is really a question of what people want to do with such pointers
(and since we don't support any yet, we don't really know...).

But more worrisome to me is that the working directory and git directory
do not necessarily follow a "../" and ".git/" relationship. How would
you resolve "../foo" with:

  GIT_DIR=/path/to/other/place git ...

or

  git --work-tree=/path/to/other/place

?

If you want to be able to point to either, I suspect we are better off
simply introducing some basic substitutions like $GIT_DIR and
$GIT_WORK_TREE. Maybe even just allow environment variable expansion,
and then promise to set those variables, which takes care of $HOME
automagically.

-Peff
