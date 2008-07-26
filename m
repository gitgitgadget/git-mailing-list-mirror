From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Sat, 26 Jul 2008 05:12:38 +0200
Message-ID: <200807260512.40088.zippel@linux-m68k.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 05:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMaLw-0001Vi-JS
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbYGZDUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 23:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752777AbYGZDUw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 23:20:52 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3710 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbYGZDUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 23:20:51 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jul 2008 23:20:51 EDT
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6Q3Cinx058668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Jul 2008 05:12:50 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90164>

Hi,

On Monday 21. July 2008, Linus Torvalds wrote:

> Read up on '--full-history'.
>
> By default, git simplifies the history for logs that have path
> simplification: only walking down the side of a merge that all the data
> came from (ie the unchanged side). So it only leaves merges around if
> there was changes from _all_ parents.
>
> So without --full-history, if any parent matches the state, it just
> removes the merge and picks that parent that contained all the state.
> Obviously, any changes to that file can be sufficiently explained by
> walking just that limited history, because they must have changed in
> _that_ history too!

Is that really a good default behaviour? Is there a way to change that 
default?

I'm currently looking into converting the m68k CVS repository and I'd like to 
properly regenerate it as two separate lines of development. The problem is 
if I look at the file history, I often only see one side of the changes when 
things got merged because of this default.
What makes this worse is that graphical front ends may inherit this behaviour. 
I tested this with qgit and it only shows half of the history. giggle 
retrieves the history like --full-history, but it lacks empty merges, so it 
makes it harder to see what got merged when.
For example a history that actually looks this:

linux -+-----import----+-----------import----+------...
m68k   \-commit-commit-\-merge-commit-commit-\-merge...

Without the merges it looks like this:

linux -+-----import----------------import--------------+...
m68k   \-commit-commit---------commit-commit           \...

And without --full-history these "loose ends" aren't visible as in qgit.

When researching historical changes one wants to know when something was 
introduced and when it was merged, but this simplification makes it harder 
than it really has to be.
IMO the default should be to show the complete history, so one doesn't miss 
something by accident that might be important or as the original example 
shows it might be confusing if one sees a change with "git log --stat id.." 
and the change disappears when one looks at "git log path".

bye, Roman
