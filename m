From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Is my repository broken?
Date: Wed, 9 Apr 2008 00:21:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0804090003480.10813@kaos.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
 <20080408225522.GD10274@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 01:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjN8v-0002tb-RV
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 01:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYDHXVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYDHXVi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 19:21:38 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49847 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632AbYDHXVi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 19:21:38 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AD14F68D24
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 00:21:36 +0100 (BST)
Received: (qmail 22021 invoked by uid 103); 9 Apr 2008 00:22:40 +0100
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.031593 secs); 08 Apr 2008 23:22:40 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 9 Apr 2008 00:22:40 +0100
X-X-Sender: jp3@kaos.quantumfyre.co.uk
In-Reply-To: <20080408225522.GD10274@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79054>

On Tue, 8 Apr 2008, Shawn O. Pearce wrote:

> Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> [...] In particular I had a number of commits with an empty ident [...]
> ...
>> Also, shouldn't fast-import be imposing the same restrictions on what you
>> are allowed to commit that the main git tools do?  If not, are such
>> restrictions documented so that I can apply them in my conversion script?
>
> Hmm, no.  fast-import allows what the generalized data model permits
> in the object store, its really plumbing.  If you are feeding it
> an input stream that creates data that isn't compliant with what
> the higher level VCS porcelain wants, well, all I can say is "don't
> do that".

Well, the 16 parent limit is enforced in builtin-commit-tree.c, and the 
commit-tree command is listed as plumbingmanipulators in command-list.txt 
- and the #define line actually blames all the way back to Linus' original 
commit.  So that's not really a porcelain thing ;), but ... *shrugs*

> The fast-import manual specifically warns in the "merge" command
> documentation that you may not want to use more than 15 merge
> commands, as it can create a commit that other tools based around
> git won't like.  But we still let you do it.

Ok, so the answer is "read the manpage" ... that's what I get for spending 
so long playing with fast-import that I don't read the manpage anymore 
(I found the syntax description in fast-import.c a more useful 
reference) ... ho hum.

> We also still let you create a commit with duplicate parents.

Well - that certainly shouldn't be happening - I remebered to check for 
that one.

> Some tools (gitk) have had issues with that in the past, but many of
> them have been fixed after a fast-import result was used with them.
>> From a VCS point of view its silly to list the same ancestor twice.
> But from an object model point of view, it may make sense if you
> were building something else on top of the core plumbing.

Would it make sense perhaps for fast-import to warn about (or even error 
out on) such things unless you tell it not to?  Most people would probably 
want to know if they were creating a repository that wasn't going to play 
nice with git's main tool suite?  (I didn't realise that I _was_ creating 
>16 way merges until filter-branch told me).

> The same holds true for the empty ident.

Ok - but I can't even find a note in the manpage for this one ...

-- 
Julian

  ---
I thought there was chocolate inside ... Well, why was it wrapped in foil?

 		-- Homer Simpson
 		   Mr. Plow
