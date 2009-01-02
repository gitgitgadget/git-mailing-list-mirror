From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 11:03:07 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost>
 <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpLK-0003br-5r
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbZABTD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbZABTD4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:03:56 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42894 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758716AbZABTDz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 14:03:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02J38qn028014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Jan 2009 11:03:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n02J37Sb017097;
	Fri, 2 Jan 2009 11:03:08 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.93 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104406>



On Fri, 2 Jan 2009, Johannes Schindelin wrote:
> 
> FWIW it's the test case in the commit introducing the --patience option.

Well, it's also the test-case in the very first hit on google for 
"patience diff" (with the quotes).

In fact, it's the _only_ one I ever found ;)

> And the worst part: one can only _guess_ what motivated patience diff.  I 
> imagine it came from the observation that function headers are unique, and 
> that you usually want to preserve as much context around them.

Well, I do like the notion of giving more weight to unique lines - I think 
it makes sense. That said, I suspect it would make almost as much sense to 
give more weight simply to _longer_ lines, and I suspect the standard 
Myers' algorithm could possibly be simply extended to take line size into 
account when calculating the weights.

Because the problem with diffs for C doesn't really tend to be as much 
about non-unique lines as about just _trivial_ lines that are mostly empty 
or contain just braces etc. Those are quite arguably almost totally 
worthless for equality testing.

And btw, don't get me wrong - I don't think there is anything wrong with 
the patience diff. I think it's a worthy thing to try, and I'm not at all 
arguing against it. However, I do think that the people arguing for it 
often do so based on less-than-very-logical arguments, and it's entirely 
possible that other approaches are better (eg the "weight by size" thing 
rather than "weight by uniqueness").

The thing about unique lines is that there are no guarantees at all that 
they even exist, so a uniqueness-based thing will always have to fall back 
on anything else. That, to me, implies that the whole notion is somewhat 
mis-designed: it's clearly not a generic concept.

(In contrast, taking the length of the matching lines into account would 
not have that kind of bad special case)

			Linus
