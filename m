From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sat, 26 Nov 2005 09:36:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511260932080.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 18:37:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg3yV-0005WU-Qv
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKZRg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 12:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVKZRg2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 12:36:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbVKZRg1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 12:36:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAQHaMnO027309
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Nov 2005 09:36:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAQHaLV5015032;
	Sat, 26 Nov 2005 09:36:21 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viruf68bz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12781>



On Sat, 26 Nov 2005, Junio C Hamano wrote:
>
> This adds three things:
> 
>  - prefix_filename() is like prefix_path() but can be used to
>    name any file on the filesystem, not the files that might go
>    into the index file.
> 
>  - git-apply uses setup_git_directory() to find out the GIT_DIR
>    and reads configuration file.  Later this would allow us to
>    affect the behaviour of the command from the configuration.
> 
>  - When git-apply is run from a subdirectory, it applies the
>    given patch only to the files under the current directory and
>    below.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

This breaks git-apply when used to just do a "diffstat", or when used on a 
non-git repository.

For "git-apply --stat", we definitely don't want to force it inside a git 
directory. In fact, even _trying_ to find a git directory would be wrong.

The only case where we care about a git directory is the "--index" case. 
In all other cases we should happily apply it (or stat it).

		Linus
