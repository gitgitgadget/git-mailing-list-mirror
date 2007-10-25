From: Jeff King <peff@peff.net>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 12:56:33 -0400
Message-ID: <20071025165633.GA24143@coredump.intra.peff.net>
References: <86oden6z97.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:56:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il60q-0005rU-JP
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 18:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbXJYQ4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761AbXJYQ4h
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 12:56:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2274 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbXJYQ4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 12:56:36 -0400
Received: (qmail 22596 invoked by uid 111); 25 Oct 2007 16:56:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 25 Oct 2007 12:56:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2007 12:56:33 -0400
Content-Disposition: inline
In-Reply-To: <86oden6z97.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62335>

On Thu, Oct 25, 2007 at 07:32:36AM -0700, Randal L. Schwartz wrote:

> I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
> so that my daily update script can go:
> 
>    git-fetch
>    if [ repo is on master, and is not dirty ];
>       git-merge upstream
>    fi
> 
> Yesterday that worked.
> 
> Today I get a rash of:
> 
>   fatal: Couldn't find remote ref refs/remotes/origin/master
> 
> from my git-fetch.

Randal and I discussed this a bit on IRC, and it turns out not to be
related to the 'upstream' symref. Instead, he had a broken
branch.master.merge config that pointed to "refs/remotes/origin/master"
(which you can see from his script above doesn't actually get used).

So presumably the old git-fetch didn't care that the contents of
branch.*.master didn't exist (it's just that nothing got marked for
merging), but the one just merged from the db/fetch-pack topic does.

Is this behavior change intentional?

-Peff
