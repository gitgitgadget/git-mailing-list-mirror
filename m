From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add a diff-files command
Date: Wed, 27 Apr 2005 14:49:32 -0700
Message-ID: <7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:47:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQuLE-0000Ds-2G
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 23:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVD0VuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVD0VuP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:50:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50312 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262069AbVD0Vtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 17:49:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427214934.MDEI7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 17:49:34 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 27 Apr 2005 17:13:23 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> It also has the ability to accept exclude file patterns with -x and even 
NP> a file containing a list of patterns to exclude with -X.  This is 
NP> especially useful to use the famous dontdiff file when looking for 
NP> uncommitted files in a compiled kernel tree.

I think show-diff with path restriction (if restriction is
simple), or piping its output to grep or filterdiff (otherwise),
would be enough to do what you do here, so personally I doubt
this new command is even useful that much.

That said, I have a couple of comments.  Other than these I do
not see anything majorly wrong (although I haven't even compiled
it yet ;-).

NP> +static const char *diff_files_usage = "diff-files [-a] [-c] [-d] [-o] [-p | -z]"
NP> +				      " [-x <pattern>] [-X <file>] [paths...]";
NP> +

If you are trying to do something similar to show-files by these
-[acdo] flags, matching these flags in both commands would be
less confusing to the users and script writers.  Either make
diff-files take fully spelled --others etc. that show-files
takes, or submit a patch for show-files to match these shorter
ones as well.  I personally prefer the latter.

NP> +/*
NP> + * Read a directory tree. We currently ignore anything but
NP> + * directories and regular files. That's because git doesn't
NP> + * handle them at all yet. Maybe that will change some day.
NP> + *
NP> + * Also, we currently ignore all names starting with a dot.
NP> + * That likely will not change.
NP> + */

For that logic, instead of doing de->d_name[0] == '.' and things
yourself, I'd rather see you lift verify_path() function from
update-cache.c into common library and call it.  Then if the
"likely will not change" part needs to be updated, you do not
have to worry about it; updates to verify_path() would take care
of it for you.


