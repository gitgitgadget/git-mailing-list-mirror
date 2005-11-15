From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Question] info/grafts file.
Date: Tue, 15 Nov 2005 09:16:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511150910230.3945@g5.osdl.org>
References: <20051114182019.GA19105@hpsvcnb.fc.hp.com>
 <7vhdafx81m.fsf@assigned-by-dhcp.cox.net> <20051115000349.GA32136@hpsvcnb.fc.hp.com>
 <200511150831.40463.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:19:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4Pq-0001oh-0D
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVKORQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVKORQP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:16:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55439 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751425AbVKORQO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 12:16:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAFHG1nO021189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 15 Nov 2005 09:16:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAFHG08d009449;
	Tue, 15 Nov 2005 09:16:00 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200511150831.40463.alan@chandlerfamily.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11920>



On Tue, 15 Nov 2005, Alan Chandler wrote:

> On Tuesday 15 Nov 2005 00:03, Carl Baldwin wrote:
> > This is fine, I just needed to know.
> >
> > How hard is it to, in a generic way, take a grafts file and reconstruct
> > commits to include the parents in the graft file in the actual tree?  I
> > am wondering because I couldn't, after much work, get git-svnimport to
> > find my merges correctly.  So, I am needing to hand-graft some merges in
> > to make things right.  Any suggestions?  I could try to figure something
> > out if I can find some time.  I'm good with graph traversals and such.
> >
> 
> I am interested in that question as well.  If you recall I was asking on this 
> list about a week ago how to lose history (because it was irrelevent).

I think you should be able to use "git-convert-objects" to do both history 
pruning and history adding.

It would need a bit of work: right now "convert_commit()" parses the 
commit 100% by hand, and doesn't care about the grafts file. But that is 
where such a conversion would be done.

Right now "convert_commit()" actually does the first conversion in-place 
(because the size of the head of the commit never changes), and then calls 
"convert_date()" which will allocate a new buffer and do the conversion 
there - that's for totally stupid hysterical raisins, and it should really 
have allocated the new buffer in convert_commit() - something you'd need 
to do if you end up editing the "parent" information at that point.

So it would take some work, but the infrastructure for doing these kinds 
of conversions is all there.

		Linus
