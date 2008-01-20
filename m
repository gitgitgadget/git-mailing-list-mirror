From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 22:53:19 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801192250260.2957@woody.linux-foundation.org>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801192256480.5731@racer.site>
 <20080120061419.GL14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 07:54:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGU4O-0003s1-Dt
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 07:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYATGxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 01:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbYATGxg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 01:53:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57380 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752822AbYATGxf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 01:53:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K6rK60023910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 22:53:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K6rJlH007432;
	Sat, 19 Jan 2008 22:53:19 -0800
In-Reply-To: <20080120061419.GL14871@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71158>



On Sun, 20 Jan 2008, Dmitry Potapov wrote:
>
> On Sat, Jan 19, 2008 at 10:58:08PM +0000, Johannes Schindelin wrote:
> > 
> > I think a better approach would be to try to match the name to what we 
> > have in the index.  Then we could implement case-insensitivity and MacOSX 
> > workaround at the same time.
> 
> I thought about that, but the problem is that HFS+ _already_ mangled
> names from what the user entered (and what is used by anyone else)
> to some sub-standard form, which no one outside of Mac likes or uses.

Well, more importantly, most of the important cases actually don't have an 
index entry yet.

For example, what about "git add"? That's when it really matters that you 
add things in a sane format, and by definition, you don't have an index 
entry to try to match to. 

So once you aim for NFC in "git add", now the index will generally be in 
NFC anyway (since I agree that that's what you'd normally get on non-OSX 
systems), so there is little point in then matching the index.

But no, it won't fix all problems. I do suspect it would make them less 
obvious in practice, though.

		Linus
