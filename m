From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] log --graph: draw '>' and '<' with --left-right
Date: Sat, 24 May 2008 23:43:25 -0700
Message-ID: <20080525064324.GA16827@adamsimpkins.net>
References: <alpine.DEB.1.00.0805221235430.30431@racer> <alpine.DEB.1.00.0805221344360.30431@racer> <7v63t3j6mn.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 08:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K09yM-00047m-8r
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 08:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYEYGn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbYEYGn3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 02:43:29 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:46618 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYEYGn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 02:43:28 -0400
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id ACA9854B961;
	Sun, 25 May 2008 02:43:27 -0400 (EDT)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 6E1F854B960;
	Sun, 25 May 2008 02:43:27 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id D027514100C8; Sat, 24 May 2008 23:43:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v63t3j6mn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82854>

On Sat, May 24, 2008 at 10:27:12PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When calling "git log --left-right <branch1>...<branch2>", a single "<" or 
> > ">" is shown in front of the commit line, to indicate which branch1 this 
> > commit comes from, branch1 or branch2.
> >
> > However, it is easy to miss in the output of "git log --graph ...", since 
> > the graph still has "*" for regular commits and "M" for merge commits.  So 
> > imitate gitk, and show the "<" and ">" characters in the graph, too, 
> > instead of "*" (or "M").
> 
> This certainly makes it more visible which one is left and which one is
> right:
>
> ...
> 
> But is it just me who now finds the original marker redundant and ugly?
> IOW, I wonder if it is better to show this:
> 
>     < commit 205ffa9...
>     | Author: Gustaf Hendeby <hendeby@isy.liu.se>
>     |
>     |     Make git add -n and git -u -n output consistent
>     |
>     < commit 38ed1d8...
>     | Author: Junio C Hamano <gitster@pobox.com>
>     |
>     |     "git-add -n -u" should not add but just report
>     ...
> 
> This is with --pretty=short, --pretty=oneline makes the issue even more
> obvious.

Yes, I agree that the original marker is now redundant, and it looks
better without it.

My recent patch to fix the "log --graph --boundary" behavior also
changes the graph code to print boundary commits as 'o' instead of
'*'.  We could probably also remove the original '-' prefix for
boundary commits when the graph output is enabled.

I was looking at the code, and noticed that it also outputs a '^'
prefix for non-boundary commits that are marked UNINTERESTING.  In
what situations will get_revision() return a commit that is
UNINTERESTING but not BOUNDARY?  I'm asking since the graph code
currently treats these commits as uninteresting, and won't print
branch lines for them.  If there are situations where these commits
are included in the log output, the graph code probably needs to be
updated to handle it.

-- 
Adam Simpkins
adam@adamsimpkins.net
