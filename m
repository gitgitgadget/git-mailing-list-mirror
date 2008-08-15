From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git-filter-branch behavior
Date: Fri, 15 Aug 2008 17:32:21 +0200
Message-ID: <g847i6$cd4$1@ger.gmane.org>
References: <e0b44a890808130914oced739cy2aaf54aebfcfcbce@mail.gmail.com> <Pine.GSO.4.62.0808131533320.10800@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 17:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1J2-00062B-Fy
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734AbYHOPcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756532AbYHOPcc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:32:32 -0400
Received: from main.gmane.org ([80.91.229.2]:50057 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756201AbYHOPcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:32:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KU1Hy-0006DU-DP
	for git@vger.kernel.org; Fri, 15 Aug 2008 15:32:30 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:32:30 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 15:32:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <Pine.GSO.4.62.0808131533320.10800@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92487>

Jonathan Nieder venit, vidit, dixit 13.08.2008 22:41:
> Hello,
> 
> David Neu wrote:
> 
>> Running
>>
>> git-filter-branch --tree-filter 'rm -rf subdir/' -- --all
>>
>> as shown below seems to leave empty commits
>> corresponding to subdir/ in the tree.  Is this the expected
>> behavior?  If so is there a command to remove the empty
>> commits?
> 
> The following is probably overkill, but it is what I would do.
> It's completely untested.  If you'd prefer to do things by hand
> instead, my only advice is that using grafts with filter-branch
> might be easier than rebase -i.
> 
> -- snipsnip --
> # prune-empty-commits - filter-branch filter to avoid boring commits
> #
> # Usage: git-filter-branch --tree-filter <something> \
> # 		--commit-filter 'prune-empty-commits "$@"' -- <refs>
> # Public domain.
> 
> interesting=
> 
> test "$#" -eq 1 && interesting=t
> 
> committree=$1
> shift
> 
> for sha1 in "$@"
> do
> 	test z"$sha1" = z-p && continue
> 	map "$sha1" | while read parent
> 	do
> 		parenttree=$(git log -1 --pretty=format:%T "$parent")
> 		test "$committree" != "$parenttree" &&
> 			interesting=t
> 		test -n "$interesting" && break
> 	done
> 	test "-n interesting" && break
> done
> 
> test -n "$interesting" && git commit-tree "$@" || skip_commit "$@"

You may want to pass the tree to be committed here ;)
I.e.:
git commit-tree $committree "$@"
etc.

Michael
