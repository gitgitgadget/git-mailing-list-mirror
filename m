From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Do the fuzzy rename detection limits with the exact
 renames removed
Date: Fri, 26 Oct 2007 17:12:59 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710261708520.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710261646230.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710261654300.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 02:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlZJ9-00019W-PY
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbXJ0ANK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763904AbXJ0ANJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 20:13:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32897 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbXJ0ANI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2007 20:13:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9R0D0Wj009149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Oct 2007 17:13:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9R0CxlV021491;
	Fri, 26 Oct 2007 17:12:59 -0700
In-Reply-To: <alpine.LFD.0.999.0710261654300.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62458>


On Fri, 26 Oct 2007, Linus Torvalds wrote:
> 
> Works For Me(tm), although this isn't all that obviously testable (ie I 
> should find a test that is border-line, and triggers the rename detection 
> limits, but then has enough exact renames that the rename detection array 
> goes away).

Actually, I just tested it. I used that same 100,000 file thing, but added 
one more (larger) file, and did another commit that moved the 100,000 
files exactly, and the one larger file with a small change.

The code before this patch (but with my linear-time rename changes) would 
find the 100,000 exact renames, but would *not* find the one that had a 
small change, because it would hit the rename limit, and wouldn't even 
try.

With these two patches in place, it finds all the exact renames, and once 
it has done that, the resulting rename array is small enough (one single 
unknown target remaining, even if there are 100,001 possible source files) 
that it doesn't trigger the rename limit, and it now finds the remaining 
non-exact rename too.

So it not only looked obvious, it seems to work too.

		Linus
