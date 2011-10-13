From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 15:44:32 -0400
Message-ID: <20111013194432.GA20082@sigill.intra.peff.net>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
 <7vbotk6aae.fsf@alter.siamese.dyndns.org>
 <20111013183709.GB17573@sigill.intra.peff.net>
 <7v62js4sop.fsf@alter.siamese.dyndns.org>
 <20111013191457.GA18460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 21:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RERCr-0001dI-LO
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 21:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab1JMTog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 15:44:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59867
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab1JMTof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 15:44:35 -0400
Received: (qmail 28632 invoked by uid 107); 13 Oct 2011 19:44:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 15:44:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 15:44:32 -0400
Content-Disposition: inline
In-Reply-To: <20111013191457.GA18460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183519>

On Thu, Oct 13, 2011 at 03:14:57PM -0400, Jeff King wrote:

> On Thu, Oct 13, 2011 at 12:06:46PM -0700, Junio C Hamano wrote:
> 
> > It is not as simple as that I am afraid. We could introduce cd_to_top with
> > the new semantics and use it in pull and rebase, but a case that would
> > break is for a script (let's call that hypothetical operation "git svn
> > dcommit", even though I do not know if dcommit uses the real working tree
> > or a temporary one) that prepares a temporary working tree inside .git/svn/
> > and run "git rebase" there without setting GIT_WORKING_TREE to point at
> > the temporary directory.
> 
> I didn't think that could happen now, because you would not be in the
> working tree, and therefore require_work_tree would fail. E.g., with
> current git I get:
> 
>   $ mkdir .git/tmp
>   $ cd .git/tmp
>   $ git rebase
>   fatal: fatal: /home/peff/local/git/private/libexec/git-core/git-rebase
>   cannot be used without a working tree.
> 
> So that case is already broken. The only change this would make is that
> what used to fail would not actually take them to the top-level of the
> working tree[1].

Ugh. It does work if you do:

  mkdir .git/tmp
  cd .git/tmp
  GIT_DIR=$PWD/.. git rebase

What a god-awful mess our initialization rules are.

-Peff
