From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [Question] info/grafts file.
Date: Tue, 15 Nov 2005 08:31:40 +0000
Message-ID: <200511150831.40463.alan@chandlerfamily.org.uk>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com> <7vhdafx81m.fsf@assigned-by-dhcp.cox.net> <20051115000349.GA32136@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 09:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbwEC-00006Z-SC
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVKOIbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVKOIbm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:31:42 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:34944
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751271AbVKOIbl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 03:31:41 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EbwE8-0000o4-Rl; Tue, 15 Nov 2005 08:31:40 +0000
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051115000349.GA32136@hpsvcnb.fc.hp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11889>

On Tuesday 15 Nov 2005 00:03, Carl Baldwin wrote:
> This is fine, I just needed to know.
>
> How hard is it to, in a generic way, take a grafts file and reconstruct
> commits to include the parents in the graft file in the actual tree?  I
> am wondering because I couldn't, after much work, get git-svnimport to
> find my merges correctly.  So, I am needing to hand-graft some merges in
> to make things right.  Any suggestions?  I could try to figure something
> out if I can find some time.  I'm good with graph traversals and such.
>

I am interested in that question as well.  If you recall I was asking on this 
list about a week ago how to lose history (because it was irrelevent).

I at first attemtped to use a graft to bypass all the changes I wanted to 
loose, but as many of the tools ignored it I gave up.  When I looked at 
whether I could change the history by making a commit that looked like the 
graft, I came to the conclusion that I would have to do a number of things

a) Recreate the commits all the way to the head - because the commits where 
all stored in a content addressable file store, as soon as the parent link 
changes it becomes a new commit with a new sha1, so changing a commit in the 
middle of a stream of branches effectively required you to walk up to the 
head (difficult because the linkages are the other way) re-creating new 
commits.

b) Understand the topology of all the interlinking commits, and make sure that 
the two commits I were trying to squash together didn't have any intermediate 
commits that effectively pointed outside of this space (and when I say 
"pointed" I mean either via a parent link, OR via a reverse virtual link when 
some other commits parent link pointed at the commit in question).

Because of all of this complexity I gave up and used cg-merge -squash to 
create the first stage squashed branch and then manually used git-cherry-pick 
to pick one by one the commits from on top of the old branch and move it to 
the new one (not so hard there were only about 20 commits in all to move that 
way).

So I am interested to see if my logic for why the complexity was high was 
correct. 


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
