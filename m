From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 12:04:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001111149150.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
 <alpine.LFD.2.00.1001102055070.10143@xanadu.home>
 <ee2a733e1001110822t1b04c1ccg9b6eb5489b69783d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUNgu-0000vD-Ke
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab0AKRE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834Ab0AKRE1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 12:04:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38883 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0AKRE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 12:04:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KW3009YGE3DNJ60@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jan 2010 12:04:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ee2a733e1001110822t1b04c1ccg9b6eb5489b69783d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136644>

On Mon, 11 Jan 2010, Leo Razoumov wrote:

> On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > You still don't answer my question though.  Again, _why_ do you need to
> >  know about remote commit availability without fetching them?
> >
> 
> I use git to track almost all my data (code and otherwise) and spread
> it between several computers. I end up with several local repos having
> the same local branches. It happens once in a while that I fetch into
> a given remote/foo from several local foo branches from different
> machines and the operation fails. It happens because the commits have
> not been yet consistently distributed among the repos. To do the
> forensics and figure out who should update whom first I need a quick
> and non-destructive way to fetch dry-run.

There is probably something awkward about your setup then.

Normally you should have a remote description for any of the remote 
repositories you fetch from.  So if you have, say, remote machine_a with 
repo foo, machine_b with repo bar, and machine_c with repo baz, then 
fetching any of those will _only_ mirror locally the state of those 
remote repositories.  There is no ordering required as there can't be 
any conflicts in the mere fact of mirroring what the other guys have.  
That's what remote tracking branches are for: they follow the state of a 
remote repository and are never altered by local changes.  And you can 
have as many of those as you wish and they will never conflict with each 
other as each remote description is independent. And this is true 
whether or not the remote repository lives on the same machine (that 
would be a remote directory in that case).

And even if most if not all those remotes are actually copies of each 
others, then the first fetch to occur will transfer the new objects 
while fetching the other ones will simply notice that the required 
objects are already available locally and only the ref will be updated.

The ordering comes into play when it is time to _merge_ those remote 
branches into, say, the local master branch.  That's why it is probably 
a good thing to use fetch+merge instead of pull in this case.  But this 
is then a local matter and nothing that depends on the fetch ordering.


Nicolas
