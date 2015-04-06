From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk drawing bug
Date: Mon, 6 Apr 2015 13:11:35 +1000
Message-ID: <20150406031134.GA26765@iris.ozlabs.ibm.com>
References: <CACZ2eqdm_DXfa0o9J3NXfxD0XG-iAbPNUhySg026qhkqZAYWJA@mail.gmail.com>
 <CAMMLpeQ3J_x5xee=V+Sn4=FTRNM-yQSm_yXSwFpiCNJz2AD7Gg@mail.gmail.com>
 <551F3E20.5010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Henrie <alexhenrie24@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Martin d'Anjou <martin.danjou14@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 05:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YexcP-0006Av-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 05:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbbDFDLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 23:11:41 -0400
Received: from ozlabs.org ([103.22.144.67]:54455 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbbDFDLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 23:11:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 78B57140218; Mon,  6 Apr 2015 13:11:38 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <551F3E20.5010306@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266829>

On Fri, Apr 03, 2015 at 09:28:00PM -0400, Martin d'Anjou wrote:
> On 15-04-03 07:05 PM, Alex Henrie wrote:
> >2015-02-18 12:27 GMT-07:00 Martin d'Anjou <martin.danjou14@gmail.com>:
> >>It appears I have uncovered inconsistent behaviour in gitk. Looks like
> >>a bug. I have a picture here:
> >>https://docs.google.com/document/d/19TTzGD94B9EEIrVU5mRMjfJFvF5Ar3MlPblRJfP5OdQ/edit?usp=sharing
> >>
> >>Essentially, when I hit shift-F5, it sometimes draw the history
> >>differently (still valid, but drawn differently). There is no change
> >>in the repository between the shift-F5 keystrokes.

That's not a bug, it's a consequence of the fact that gitk is designed
to be fast.  It only lays out as much of the graph is visible plus a
little more, not the whole graph, and it doesn't use any global
analysis.  The reason for that is speed.  Gitk is usable on a
repository with half a million commits, such as the linux kernel, and
to achieve that we can't afford to do wait until we have all the
commits read in and then do some computation over the whole topology;
it all has to be done incrementally.  Also, the underlying git log
sometimes gives gitk a parent commit before one of its children, and
when that happens the topology has to be modified and thus the graph
does too, if any topology that has already been drawn gets modified.

As long as the graph correctly shows the relationships between
commits, it has achieved its purpose.  If you (or anyone) can come up
with improvements that make it look nicer, that's great, and I'll
consider them as long as they don't slow down gitk on large
repositories to any noticeable extent.

Paul.
