From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 21:09:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604142104140.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org> <7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org> <7vacanmxhe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 06:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUc6W-0006Mi-9O
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 06:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWDOEJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 00:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWDOEJi
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 00:09:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030221AbWDOEJi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 00:09:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F49XtH017936
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 21:09:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F49VGc023582;
	Fri, 14 Apr 2006 21:09:32 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacanmxhe.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18724>



On Fri, 14 Apr 2006, Junio C Hamano wrote:
> 
> Another thing is that some revision.c users are not interested
> in taking diff options at all.

Well, it's easy enough to do something like

	if (rev->diff)
		usage(no_diff_cmd_usage);

for something like that.

> I was going to suggest a new structure that captures struct
> rev_info, struct log_tree_opt and miscellaneous bits cmd_log
> uses such as do_diff, full_diff, etc., and move the option
> parser out of cmd_log() to a separate function, and have that
> shared across cmd_log(), cmd_show(), cmd_whatchanged(), and
> cmd_diff() without affecting any of the existing revision.c
> users.  That way, "rev-list --cc HEAD" will remain nonsense.

Well, I actually was going to make git-rev-list just take the diff 
options, and it ends up doing the same thing as "git log" with them. 
There's no real downside.

> One nice property your approach has is that it makes
> "git diff-tree a..b" magically starts working, unlike what
> I suggested above.

Yeah. It just fell out automatically from using the rev-list parsing.

Although, the thing is, once we have a built-in "git diff", there's 
actually little enough reason to ever use the old "git-diff-tree" vs 
"git-diff-index" vs "git-diff-files" at all. 

It might actually be nice to prune some of the tons of git commands. At 
some point, the fact that

	echo bin/git-* | wc -w

returns 122 just makes you go "Hmm..".

		Linus
