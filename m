From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list in parse_rev_list
Date: Wed, 06 Sep 2006 23:18:26 +0200
Organization: At home
Message-ID: <edndud$csb$1@sea.gmane.org>
References: <11575480921132-git-send-email-jnareb@gmail.com> <11575761821830-git-send-email-jnareb@gmail.com> <Pine.LNX.4.64.0609061404490.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 23:18:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL4nE-00085q-58
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWIFVSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWIFVSl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:18:41 -0400
Received: from main.gmane.org ([80.91.229.2]:11649 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751556AbWIFVSk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 17:18:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL4n0-00083O-4h
	for git@vger.kernel.org; Wed, 06 Sep 2006 23:18:30 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 23:18:30 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 23:18:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26561>

Linus Torvalds wrote:

> On Wed, 6 Sep 2006, Jakub Narebski wrote:
>>
>> Benchmarks (7 means patch before, 8 means this patch):
> 
> Btw, you should possibly look at cold-cache numbers, and numbers for 
> projects that aren't fully packed. They can often be _dramatically_ 
> different.

By the way I forgot that the case 8 is for the repository with 1 commit
more, although that shouldn't matter much for paginated output. Still, it
is one commit more unpacked. Benchmark for 7 was also for partially packed
repository.
 
> That said, the dramatic change would probably be if there were some way to 
> avoid using "--full-history" (rather than "--parents", which doesn't add 
> _that_ much overhead), since that "follow all parents" behaviour of 
> full-history is usually what really makes a big deal.
> 
> But I guess for gitweb, you do want to use --full-history in this case ;(

It is now easy with patch 3/7 "Use @hist_opts as git-rev-list parameters in
git_history" to remove '--full-history' from git-rev-list parameters in
git_history subroutine. Or add '--remove-empty' which matters only for the
last page of file/directory history output.

I had some simple benchmark that shown that the earlier version with
filtering via piping git-rev-list to git-diff-tree --stdin -- <filename>
was slightly faster than git-rev-list --full-history -- <filename>
(current version). If I remember correctly of course. And this version can
be easily extended to include renames (but not file to directory changes).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
