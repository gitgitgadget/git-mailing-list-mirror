From: jidanni@jidanni.org
Subject: git-diff should not fire up $PAGER, period!
Date: Thu, 18 Dec 2008 05:45:35 +0800
Message-ID: <8763lixyps.fsf_-_@jidanni.org>
References: <20081216005658.GB3679@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 22:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4Eq-0003qF-HF
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYLQVpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbYLQVpl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:45:41 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:51261 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751925AbYLQVpk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 16:45:40 -0500
Received: from jidanni2.jidanni.org (122-127-36-47.dynamic.hinet.net [122.127.36.47])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 9C65841489
	for <git@vger.kernel.org>; Wed, 17 Dec 2008 13:45:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103397>

Gentlemen, I have found the solution to your problem.

Unbundle git-diff and $PAGER.

Ask yourself, does diff(1) call $PAGER?

No. That's because the Unix designers were smart enough not to glue
everything together.

Now's your chance to repent, as you haven't even yet mentioned $PAGER
on the git-diff man page. Yes, do mention it: "EXAMPLES: git-diff|less"
I.e., the user can page the output if he feels inclined, just like any
other output. I mean one already has a wallet. The bank need not give
the user one every time they make a withdraw.

I mean here I am in emacs, and

-*- mode: compilation; default-directory: "...coreutils/" -*-
Compilation started at Thu Dec 18 03:15:14
git-diff
WARNING: terminal is not fully functional^M
^M-  (press RETURN)

"It's all emacs' fault for emulating a tty too well"... no, it's all
your fault for gumming things together. No I don't want my cookies
with obligatory milk. I'll using git-diff|cat for now instead of
complaining that emacs is all wrong. Even using git-diff|cat|less is
better than messing with the LESS=F bug. Repent, whippersnappers!

OK, doing test x$EMACS = xt && PAGER=cat in .bashrc. That will help
for emacs' shell buffers, but not compilation mode buffers... "then
just make a hook"... 13 hooks to combat one poor design choice.
And one notices git-show is gummed up too.

Hmm, looking in changelogs, we see

 * Error messages used to be sent to stderr, only to get hidden,
   when $PAGER was in use.  They now are sent to stdout along
   with the command output to be shown in the $PAGER.

Well, if you had left paging to the user, no one would have blamed you
for making error messages disappear, and you could have left stderr as
the elders intended.

Wait,
$ git-config --global core.pager ""
Cool. Bye.
