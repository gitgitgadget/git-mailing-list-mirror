X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git blame [was: git and bzr]
Date: Wed, 29 Nov 2006 08:39:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net>
 <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 16:40:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456D7A76.3080605@webdrake.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32651>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpST4-000294-Np for gcvg-git@gmane.org; Wed, 29 Nov
 2006 17:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967457AbWK2Qj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 11:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935852AbWK2Qj1
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 11:39:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30091 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S935847AbWK2Qj1 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 11:39:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kATGdOix007726
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 29
 Nov 2006 08:39:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kATGdNLD000800; Wed, 29 Nov
 2006 08:39:24 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
Sender: git-owner@vger.kernel.org



On Wed, 29 Nov 2006, Joseph Wakeling wrote:
>
> Linus Torvalds wrote:
> > Now, with small changes, "git blame -C" will just ignore copies entirely, 
> 
> Obvious when I think about it, otherwise every 'int i;' in the kernel
> would have a huge blame list ... :-O

Indeed. We didn't do that heuristic originally, and the most common 
sequence that was "blamed" on being copied from somewhere else was 
something like the string

	"<tab><tab><tab>}<nl><tab><tab>}<nl><tab>}<nl>"

which is obviously very common in C, especially when you have coding 
conventions and people follow them ;)

> > them in the second commit (but if I instead create the second file in the 
> > second commit, and do the movement in the third commit, git blame -C works 
> > again ;).
> 
> Actually my setup was like the latter situation you describe, so blame
> was probably working fine and just ignoring the small change.  But
> serendipity is a wonderful thing. :-)

Yeah. As it turns out, the bug was really that "git blame" ended up just 
not showing the filenames (that it had followed correctly), because it had 
decided (incorrectly) that they weren't interesting because it all came 
from the same commit, and it had already shown that commit (just not that 
_file_ in that commit).

So it's fixed now, and probably would never trigger except for the stupid 
special case that was "let's just show an example of this" ;)

