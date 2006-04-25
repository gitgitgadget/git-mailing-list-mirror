From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 09:43:33 +0200
Organization: At home
Message-ID: <e2kjul$ntq$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 09:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYIDz-0003SV-CO
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 09:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWDYHoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 03:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWDYHoh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 03:44:37 -0400
Received: from main.gmane.org ([80.91.229.2]:25577 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751367AbWDYHoh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 03:44:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYIDV-0003LN-7Y
	for git@vger.kernel.org; Tue, 25 Apr 2006 09:44:13 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 09:44:13 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 09:44:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19133>

Junio C Hamano wrote:

> Here is a related but not necessarily competing idle thought.
> 
> How about an ability to "attach" arbitrary objects to commit
> objects?  The commit object would look like:
> 
>     tree 0aaa3fecff73ab428999cb9156f8abc075516abe
>     parent 5a6a8c0e012137a3f0059be40ec7b2f4aa614355
>     parent e1cbc46d12a0524fd5e710cbfaf3f178fc3da504
>     related a0e7d36193b96f552073558acf5fcc1f10528917 key
>     related 0032d548db56eac9ea09b4ba05843365f6325b85 cherrypick
>     author Junio C Hamano <junkio@cox.net> 1145943079 -0700
>     committer Junio C Hamano <junkio@cox.net> 1145943079 -0700
> 
>     Merge branch 'pb/config' into next
> 
>     * pb/config:
>       Deprecate usage of git-var -l for getting config vars list
>       git-repo-config --list support
> 
> The format of "related" attribute is, keyword "related", SP, 40-byte
> hexadecimal object name, SP, and arbitrary sequence of bytes
> except LF and NUL.  Let's call this arbitrary sequence of bytes
> "the nature of relation".
> 
> The semantics I would attach to these "related" links are as
> follows:
> 
>  * To the "core" level git, they do not mean anything other than
>    "you must to have these objects, and objects reachable from
>    them, if you are going to have this commit and claim your
>    repository is without missing objects".
> 
> That means "git-rev-list --objects" needs to list these objects
> (and if they are tags, commits, and trees, then what are
> reachable from them), and "git-fsck" needs to consider these
> related objects and objects reachable from them are reachable
> from this commit.  NOTHING ELSE NEEDS TO BE DONE by the core
> (obviously, cat-file needs to show them, and commit-tree needs to
> record them, but that goes without saying).

Perhaps there should be an option to specify that the link is optional, and
the object pointed can be gone missing. For example for cherrypick the
original cherry-picked commit can either be removed completely, e.g. when
the original branch is deleted, or it can be modified breaking link when we
rewrite history up to original commit on original branch.

Also all other commands which show commit (commit messsage at least) should
be considered for including "related" links...

-- 
Jakub Narebski
Warsaw, Poland
