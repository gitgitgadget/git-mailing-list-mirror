From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 12:27:32 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-34F9C6.12273203022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 21:28:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclpU-0008AG-PR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819Ab0BCU16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:27:58 -0500
Received: from lo.gmane.org ([80.91.229.12]:41016 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757687Ab0BCU15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:27:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NclpK-000804-Ek
	for git@vger.kernel.org; Wed, 03 Feb 2010 21:27:54 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:27:54 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:27:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138884>

In article <alpine.LFD.2.00.1002031436490.1681@xanadu.home>,
 Nicolas Pitre <nico@fluxnic.net> wrote:

> On Wed, 3 Feb 2010, Ron Garret wrote:
> 
> > So... how *does* git decide when two blobs are different blobs and when 
> > they are the same blob with mods?  I asked this question before and was 
> > pointed to the diffcore docs, but that didn't really clear things up.  
> > That just describes all the different ways git can do diffs, not the 
> > actual heuristics that git uses to track content.
> 
> Yes, those same heuristics are used to make the decision.
> 
> |The second transformation in the chain is diffcore-break, and is
> |controlled by the -B option to the 'git diff-{asterisk}' commands.  
> |This is used to detect a filepair that represents "complete rewrite" 
> |and break such filepair into two filepairs that represent delete and
> |create.
> |[...]
> 
> |This transformation is used to detect renames and copies, and is
> |controlled by the -M option (to detect renames) and the -C option
> |(to detect copies as well) to the 'git diff-{asterisk}' commands.  
> |[...]
> 
> Note that you may use the -B, -C, -M and --find-copies-harder arguments 
> with log as well as diff commands even if there is no actual diff 
> output.  So the explanation is really in that document even if simple 
> rename detection is concerned only by a fraction of what is said there.
> 
> And Git can detect copied files too.
> 
> Those semantics are not stored in the repository so they can be improved 
> or even changed after the facts.

OK, on closer reading I see that the information is there, but it's well 
hidden :-)  (For example, the -M option takes an optional numerical 
argument so you can tweak how much similarity is needed to be considered 
a move.  But the docs for git log don't mention this.  It's buried deep 
in the git diffcore docs.  But yes, it's there.)

So I think I'm beginning to understand how this works, but that leads me 
to another question: it seems to me that there are potential screw cases 
for this purely content-based system of tracking files.  For example, 
suppose I have a directory full of sample config files, all of which are 
similar to each other.  Will that cause diffcore to get confused?

Feel free to treat that as a rhetorical question because obviously I can 
(and probably should) get the answer by trying it.

Thanks!
rg
