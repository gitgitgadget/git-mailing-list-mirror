From: Jeff King <peff@peff.net>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 11:53:03 -0500
Message-ID: <20091218165302.GA1746@sigill.intra.peff.net>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 17:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLg4r-00089U-2E
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 17:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbZLRQxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZLRQxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 11:53:09 -0500
Received: from peff.net ([208.65.91.99]:54508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbZLRQxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 11:53:07 -0500
Received: (qmail 3809 invoked by uid 107); 18 Dec 2009 16:57:41 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Dec 2009 11:57:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Dec 2009 11:53:03 -0500
Content-Disposition: inline
In-Reply-To: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135419>

On Fri, Dec 18, 2009 at 11:25:54AM -0500, Eugene Sajine wrote:

> i have a repo cloned from the server with two branches master and qa.
> 
> $git remote show origin
> 
> tells me that the HEAD branch is master.
> 
> When i try to execute
> 
> $ git remote set-head origin qa
> 
> It prints nothing and "git remote show origin" still prints that HEAD
> branch is master.
> 
> Could you, please, advise if I am i missing something.

Hmm. It probably worked, but what you are being shown is a bit
confusing.

"git remote show" will actually query the remote server to find where
its HEAD is pointing. But "git remote set-head" is about changing your
_local_ idea of where the remote head is pointing (in general, "git
remote" does not change anything on the remote side. It is about
managing the local configuration of your remotes).

AFAICT, there is no way to use "git remote" to query the result of your
set-head. And the "show" output makes no distinction between the two.

Perhaps we should print both in "git remote show" if they differ.
Something like:

   HEAD branch: qa (remote points to "master")

or

   HEAD branch (local): qa
   HEAD branch (remote): master

That would clear up the confusion of what is happening. Whether that is
what you actually wanted, I don't know. If you want to be able to refer
to "origin/qa" as "origin", then you're fine. But if you wanted to
actually change the remote repository's idea of HEAD so that further
clones will clone "qa" by default, then you can't do that with "git
remote". You would have to go to the remote repository and run "git
symbolic-ref", I think.

-Peff
