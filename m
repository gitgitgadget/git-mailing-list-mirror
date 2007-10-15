From: Brian Dessent <brian@dessent.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 12:07:53 -0700
Organization: My own little world...
Message-ID: <4713BA89.633B86F2@dessent.net>
References: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
	 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
	 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
	 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
	 <Pine.LNX.4.64.0710150039120.25221@racer.site> <4712B616.165BBF8D@dessent.net>
	 <Pine.LNX.4.64.0710150217120.25221@racer.site> <20071015175606.GE2966@steel.home>
	 <4713B367.52CEC7E2@dessent.net> <Pine.LNX.4.64.0710151938300.25221@racer.site>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Eli Zaretskii <eliz@gnu.org>, ae@op5.se, tsuna@lrde.epita.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVIQ-0007nj-01
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 21:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbXJOTH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 15:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756810AbXJOTH7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 15:07:59 -0400
Received: from dessent.net ([69.60.119.225]:43785 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbXJOTH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 15:07:58 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1IhVIC-00011w-JQ; Mon, 15 Oct 2007 19:07:56 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61029>

Johannes Schindelin wrote:

> No, it is not equivalent.  For example, you can still see the file.  For
> example, you cannot reuse the filename for another file.  And -- the
> killer -- you cannot remove the directory which contains the file.

Fair enough.  You can move it to another directory in order to delete
the containing directory -- this is what Cygwin does to placate posix
apps that expect this to work.

> But really, we have workarounds in place to make this a non-issue.

Ok.

> My bigger concerns are the performance and stability.  For example, I had
> a very annoying problem on one of the machines I am testing msysGit on.
> The problem was _only_ fixable by deactivating component of Logitech's
> WebCam driver!  Now, if a user-installable 3rd party program can make my
> regular git crash, I am scared what more it can do.

That is because the MSYS runtime is based on an old version of Cygwin,
and it uses the same dirty tricks to emulate fork.  These tricks rely on
having a repeatably consistent memory layout for a process each time it
is started, and when third party tools add hooks that affect the load
order or otherwise screw with the layout, the fork emulation fails. 
This is also why it is sometimes necessary to assign unique base
addresses to all libraries (rebaseall) in order to get fork emulation
working again.

So yes, it is unfortunate that some system tools can drastically affect
the ability of Cygwin and MSYS to function, but it's what we live with
to have fork/exec emulation.  I see that there is work afoot to abstract
process creation so that hopefully this won't be as much a concern in
the near future.

Brian
