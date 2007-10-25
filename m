From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 14:05:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710251351330.7345@iabervon.org>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025165633.GA24143@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il75L-0007lO-4V
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbXJYSFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXJYSFW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:05:22 -0400
Received: from iabervon.org ([66.92.72.58]:35806 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbXJYSFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:05:22 -0400
Received: (qmail 8444 invoked by uid 1000); 25 Oct 2007 18:05:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2007 18:05:20 -0000
In-Reply-To: <20071025165633.GA24143@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62341>

On Thu, 25 Oct 2007, Jeff King wrote:

> On Thu, Oct 25, 2007 at 07:32:36AM -0700, Randal L. Schwartz wrote:
> 
> > I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
> > so that my daily update script can go:
> > 
> >    git-fetch
> >    if [ repo is on master, and is not dirty ];
> >       git-merge upstream
> >    fi
> > 
> > Yesterday that worked.
> > 
> > Today I get a rash of:
> > 
> >   fatal: Couldn't find remote ref refs/remotes/origin/master
> > 
> > from my git-fetch.
> 
> Randal and I discussed this a bit on IRC, and it turns out not to be
> related to the 'upstream' symref. Instead, he had a broken
> branch.master.merge config that pointed to "refs/remotes/origin/master"
> (which you can see from his script above doesn't actually get used).
> 
> So presumably the old git-fetch didn't care that the contents of
> branch.*.master didn't exist (it's just that nothing got marked for
> merging), but the one just merged from the db/fetch-pack topic does.
> 
> Is this behavior change intentional?

It's not exactly intentional; it's just that nobody seems to have tested 
this particular misconfiguration. It should probably report an error 
(since the configuration is, in fact, broken and potentially misleading), 
but it probably shouldn't be fatal and certainly shouldn't be so 
uninformative.

I guess it's a new feature that you can use a branch.*.merge line to 
select a ref that otherwise wouldn't be fetched at all, cause it to be 
fetched, and have it marked for merging; previously, such a config line 
would just be ignored, as it didn't exactly match anything. It's a side 
effect that something that doesn't exist (by that name on the remote side) 
is now an issue.

	-Daniel
*This .sig left intentionally blank*
