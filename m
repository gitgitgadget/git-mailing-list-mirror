From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Mon, 11 Sep 2006 13:29:19 +0200
Organization: At home
Message-ID: <ee3hac$n57$1@sea.gmane.org>
References: <7vk64bnnxl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 11 13:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMjzC-0002mm-KW
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 13:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWIKL3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 07:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIKL3r
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 07:29:47 -0400
Received: from main.gmane.org ([80.91.229.2]:10955 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932205AbWIKL3q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 07:29:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMjym-0002hL-5x
	for git@vger.kernel.org; Mon, 11 Sep 2006 13:29:32 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 13:29:32 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 13:29:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26849>

Junio C Hamano wrote:

>  - Andy Whitcroft taught send-pack to use git-rev-list --stdin
>    so that we do not have to be limited by the number of refs
>    exec() command-line can hold.
[...]
>  - Pack-objects learned to run rev-list logic internally when
>    given --revs parameter; the refs arguments you would normally
>    give the upstream rev-list can be fed from its standard
>    input, instead of usual list of objects.
BTW. could you please document the above?

Perhaps those two options, --stdin to feed arguments from standard input,
and -revs to run rev-list logic internally should be used whenever possible
in all the git commands? This would allow to avoid forks and/or command
line length limit.
 
In 'next' currently the following commands have --stdin implemented:
 * git-update-index: --stdin to feed list of paths, one per line
 * git-diff-tree: --stdin to loop over <tree-ish>, or pairs of
   <tree-ish>[*1*]
 * git-hash-object: --stdin is equivalent of '-' special file
 * git-http-fetch and git-local-fetch have some strange --stdin
 * git-name-rev with --stdin functions as filter
 * git-rev-list: --stdin to feed list of <commits>; it is not clear from 
   the manpage if one can use ^<commit>, and commit related options
   and shortcuts like --not, <commit>..<commit>, <commit>...<commit>
And the following have --revs implemented
 * git-pack-objects: --revs to provide arguments to rev-list from stdin,
   instead of list of objects. UNDOCUMENTED.

It would be nice if the following commands had --stdin or had it's --stdin
usage extended:
 * git-diff-tree: --stdin to allow to provide path limits, separated 
   by ' -- ' from <tree-ish> or pair of <tree-ish> (does git-diff-tree allow
   for diff3-like behavior? then perhaps also three <tree-ish>)
 * git-ls-tree: --stdin to loop over <tree-ish>, one tree per line.
 * git-cat-object: --stdin to loop over objects, plus -z to change separator
   between records to NULL (or have it turned on by default).
For all "loop" --stdin, the output should begin with the line which was
arguments, like git-diff-tree outputs first <tree-ish> used for diff.

I think it is quite often to use git-rev-list ...| git-diff-tree ...
pipeline, so it might be worth to add --revs option to git-diff-tree.
Or it might not.

P.S. does git-merge take -F <file> option?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
