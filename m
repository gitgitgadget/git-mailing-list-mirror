From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Thu, 29 May 2008 21:10:00 +0200
Message-ID: <200805292110.02151.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <alpine.DEB.1.00.0805291708500.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 21:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1nWH-0000Or-Ua
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 21:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYE2TJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 15:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYE2TJp
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 15:09:45 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:29334 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbYE2TJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 15:09:44 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 May 2008 21:09:43 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 May 2008 21:09:43 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <alpine.DEB.1.00.0805291708500.13507@racer.site.net>
Content-Disposition: inline
X-OriginalArrivalTime: 29 May 2008 19:09:43.0241 (UTC) FILETIME=[8D3ABB90:01C8C1BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83238>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 29 May 2008, Thomas Rast wrote:
> 
> > You wrote:
> 
> Who "You"?  You did not say a name.
> 
> > > Adds a new option 'e' to the 'add -p' command loop that lets you 
> > > discard or keep one hunk line at a time.  This is useful if there are 
> > > no unchanged lines in the middle of the hunk, so 's' will not work, 
> > > but you would still like to split it.
> > 
> 
> The splitting (even without common lines at the borders) is something I 
> needed myself, but the concept got rebuked in
> 
> http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68108

Aha, thanks for the pointer.  I'm not sure I'm in a position to
restart that discussion, but let's try anyway:

Note that what Junio said in

http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68108
> That is, , if you want to do finer grained hunk splitting than what "git
> add -p" lets you do, you do _not_ let user specify "I want to split the
> hunk into two, before this point and after this point".  Instead, let
> the user pick zero or more '-' line and zero or more '+' line, and
> adjust the context around it.  An unpicked '-' line becomes the common
> context, and an unpicked '+' line disappears.  After that, you recount
> the diff.  That way, you do not have to do any "unidiff zero" cop-out.

is precisely what my patch implements.  I did not implement the
stashing he recommends in the same message, but I believe the fact
that 'add -p' stages the end result should be enough (and works at
least for my use case).

Johannes Sixt replied:

http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68108
> In this case I would expect two adjacent hunks: one that covers the selected
> changes, another one with the remaining changes, but each against the original:

I didn't do this because there is no way to ensure that the "other
half" can be applied cleanly to the unpatched state, thus requiring
extra tracking of "hunk dependencies", so to speak.  It could be done
of course, if anyone really needs it.

You also mention

http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=68108
> I thought about [the line-wise picking], but the UI is not trivial.

The y/n loop with count prefix works well for me.  It would be nice to
have it in an actual GUI of course, but I don't know enough Tcl/Tk to
implement that.

- Thomas

-- 
Thomas Rast
trast@student.ethz.ch
