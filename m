From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 02:18:19 +0200
Organization: At home
Message-ID: <ed59rk$hk0$1@sea.gmane.org>
References: <200608310043.12606.jnareb@gmail.com> <ed55nu$62k$1@sea.gmane.org> <7vfyfdg4fw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 02:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIaGQ-0008Fy-AD
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWHaASb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 20:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWHaASb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 20:18:31 -0400
Received: from main.gmane.org ([80.91.229.2]:57577 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932242AbWHaASa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 20:18:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIaG3-0008BB-8F
	for git@vger.kernel.org; Thu, 31 Aug 2006 02:18:11 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 02:18:11 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 02:18:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26240>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> At the below URL (links of course _won't_ work)
>>   http://front.fuw.edu.pl/jnareb/tree_blame.html
>> is output of  "tree_blame" view. One can sort by Date (age), Author, Mode
>> and Filename. The date view was modelled after 'ls -l' view; the order of
>> columns probably should be changed to match it more closely.
> 
> Just a quick impression.
> 
>  - "Mode" looks too wide for the information it conveys.  Path
>    being a link already tells whether it is a tree, so the only
>    information you would need is a bit and half (regular file,
>    executable regular file, or symbolic link).
> 
>  - Spelling out Date in human readable form is fine but I suspect
>    it would be nicer if it used YYYY-MM-DD / MM-DD HH:MM

Good idea.

>  - I personally do not like blaming the last person who touched
>    the file, but that is probably just me so it is fine.

I was going for something similar to the 'ls -l' look, with symbolic mode,
user ("blame" i.e. last person who touched the file for gitweb), date in
'ls -l' format but in UTC and in C locale, file name. Preceded by commit,
followed by related links (tree/blob, blame, history, raw).

>  - "Commit" column does not seem to convey much useful
>    information; I would suggest perhaps making Date and/or
>    Author clickable to take the browser to the commit, but I do
>    not understand what the strike-through is about...

Ooops, I forgot to explain this. Strike-through, which actually should be
using different color like red for example means that the file has 1-commit
long history, i.e. it just appeared in given commit.

BTW. commit link should show commit title on mouseover.

>  - Since the rightmost links have quite a lot of information
>    these days, it _might_ be reasonable to make the main part
>    2 lines, like so:
> 
>       date    author   mode    path
>         short-commit-log-message
> 
>       date    author   mode    path
>         short-commit-log-message
> 
>         ...

I'd rather have 1 line per entry, especially considering that one of key
features is ability to sort the "tree_blame" table by date.

>  - I wonder how expensive it is to generate this.

Quite expensive, especially for directories (trees) containing larger number
of files, but if I remember correctly not much longer than for example
summary or tags page. Speed is constrained by the forking, one per
file/tree in given directory, at least for now.

There are three implementations in git_tree_blame...

Of course the engine should be rewritten in C, made into git-blame-tree
(similar to git-blame).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
