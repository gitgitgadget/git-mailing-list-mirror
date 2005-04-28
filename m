From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] add a diff-files command
Date: Wed, 27 Apr 2005 21:02:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504272031330.14033@localhost.localdomain>
References: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain>
 <7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxLw-0002eB-9B
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVD1BD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVD1BD3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:03:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25973 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262140AbVD1BDU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 21:03:20 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFM00C53TKOR4@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Apr 2005 21:02:49 -0400 (EDT)
In-reply-to: <7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Junio C Hamano wrote:

> >>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:
> 
> NP> It also has the ability to accept exclude file patterns with -x and even 
> NP> a file containing a list of patterns to exclude with -X.  This is 
> NP> especially useful to use the famous dontdiff file when looking for 
> NP> uncommitted files in a compiled kernel tree.
> 
> I think show-diff with path restriction (if restriction is
> simple), or piping its output to grep or filterdiff (otherwise),
> would be enough to do what you do here, so personally I doubt
> this new command is even useful that much.

First, show-diff doesn't handle files in the work tree which are not 
listed in the cache.

Have you ever looked at the dontdiff file?  You can get a sample of it 
from http://www.moses.uklinux.net/patches/dontdiff to give you an idea.  
Using grep or filterdiff is really backward in that case since out of 
all the junk that might appear in the output about 98% will be filtered 
away in most useful cases, which is rather inefficient.

Path restriction is inclusive, while the exclude list is, well, 
exclusive.  They serves separate purposes.  So trust me it _is_ pretty 
damn useful, unless you always run "make clean" on your kernel tree 
before checking for potentially uncommitted files then recompile 
everything afterwards which is a hassle.

> That said, I have a couple of comments.  Other than these I do
> not see anything majorly wrong (although I haven't even compiled
> it yet ;-).
> 
> NP> +static const char *diff_files_usage = "diff-files [-a] [-c] [-d] [-o] [-p | -z]"
> NP> +				      " [-x <pattern>] [-X <file>] [paths...]";
> NP> +
> 
> If you are trying to do something similar to show-files by these
> -[acdo] flags, matching these flags in both commands would be
> less confusing to the users and script writers.  Either make
> diff-files take fully spelled --others etc. that show-files
> takes, or submit a patch for show-files to match these shorter
> ones as well.  I personally prefer the latter.

Agreed.

> NP> +/*
> NP> + * Read a directory tree. We currently ignore anything but
> NP> + * directories and regular files. That's because git doesn't
> NP> + * handle them at all yet. Maybe that will change some day.
> NP> + *
> NP> + * Also, we currently ignore all names starting with a dot.
> NP> + * That likely will not change.
> NP> + */
> 
> For that logic, instead of doing de->d_name[0] == '.' and things
> yourself, I'd rather see you lift verify_path() function from
> update-cache.c into common library and call it.

Sure, but actually I'd prefer for that to be a separate patch since it's 
a tangential issue that might affect show-files as well.


Nicolas
