From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 15:05:23 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171412420.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <87odbkyuvq.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFdoz-00014Q-Eh
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 00:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbYAQXGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 18:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbYAQXGE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 18:06:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52767 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757169AbYAQXGB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 18:06:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HN5OLO002165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 15:05:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HN5Nsm018471;
	Thu, 17 Jan 2008 15:05:23 -0800
In-Reply-To: <87odbkyuvq.fsf@adler.orangeandbronze.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70936>



On Fri, 18 Jan 2008, JM Ibanez wrote:
>
> With the exception of Unicode. If you check the standard, two Unicode
> codepoints (i.e. the numeric value that gets stored on disk) *can* map
> to the same character, hence they are the same.

But if you want to make it clear, you can use "encoded character" or yes, 
"code point". 

But the thing is, even the unicode standard tends to just say "character", 
and a unicode string (for example) is defined to be a sequence of "code 
units" which in turn is about those *encoded* characters, which is all 
about the code points.

So you'll find that they are very careful in some technical definition 
parts to talk about "code points", but then in other sequences they talk 
about "character" even though they are referring to the actual code point 
(ie the figure literally has the unicode number in it!)

In fact, they sometimes even talk about "characters" in the totally 
non-encoding meaning of "glyph".

So yes, "character" is often ambiguous. It would be good to never use the 
word at all, and only talk about "code point" and "glyph" and one of the 
well-defined special terms like "combining character" or "replacement 
character".

But to take a representative example from The Unicode Standard, Chapter 2: 
"Unicode Design Principles":

  Characters are represented by code points that reside only in a memory 
  representation, as strings in memory, on disk, or in data transmission. 
  The Unicode Standard deals only with character codes.

(any speling mistakes mine). In other words, from the very beginning of 
the standard, very basic design principles chapter, it starts talking 
about characters being represented by code points and explicitly says that 
it really only deals with CHARACTER CODES.

Yes, I'm sure you can argue ad infinitum that all the "equivalences" and 
other crap means that a "character" can sometimes mean just about 
anything, but I'd say that it's pretty damn reasonable to equate "unicode 
character" with "code point" or "character code".

			Linus
