From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 09:40:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704040935350.6730@woody.linux-foundation.org>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
 <200704041540.59977.andyparkins@gmail.com> <4613C97C.9050600@dawes.za.net>
 <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:40:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8XR-0005ij-UV
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992988AbXDDQk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993003AbXDDQkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:40:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47411 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992988AbXDDQkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:40:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l34GeEPD022879
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Apr 2007 09:40:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l34GeDJT025137;
	Wed, 4 Apr 2007 09:40:13 -0700
In-Reply-To: <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.453 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43755>



On Wed, 4 Apr 2007, Johannes Schindelin wrote:
> 
> The subtle difference: your approach is _expensive_ in terms of CPU time, 
> while the byte change approach is _dirt cheap_.

Well, you could do a combination (still dirt cheap):
 - show the size before/after (and yes, new/delete should be separate from 
   "zero size before/after")
 - show the size of the binary patch.

No "X added bytes" vs "Y bytes deleted", just "size of binary patch". It 
could be really small, even if 10k was deleted, or the file was totally 
re-organized by moving chunks around.

It would still be a meaningful thing to know - if only because it tells 
you how much space the delta takes. So even if it's a .jpg, and the actual 
*picture* didn't change a lot (ie you did some new version with color 
correction or something: it looks similar to the old one, but the *diff* 
is basically "rewrite it all"), knowing the size of the delta at least has 
the meaning of "this is how basically much space it will take when you 
send the binary diff in an email".

That's fairly close to what "5 new lines, 1 deleted line" message means. 
It's another way to give you an approximate idea of how big the changes 
were.

		Linus
