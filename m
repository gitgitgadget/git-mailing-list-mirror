From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the
 revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 11:09:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081058210.2458@g5.osdl.org>
References: <11394103753694-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 20:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6uh4-0003Q4-1x
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 20:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWBHTJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 14:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWBHTJb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 14:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbWBHTJa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 14:09:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18J9IDZ006382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 11:09:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18J9G9G006523;
	Wed, 8 Feb 2006 11:09:17 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11394103753694-git-send-email-ryan@michonline.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15746>



On Wed, 8 Feb 2006, Ryan Anderson wrote:
> 
> I think this version is mostly ready to go.

Hmm.. I get

   [torvalds@g5 git]$ ./git-annotate Makefile
   fatal: 'e83c5163316f89bfbde7d9ab23ca2e25604af290^1..e83c5163316f89bfbde7d9ab23ca2e25604af290': No such file or directory
   Undefined subroutine &main::all_lines_claimed called at ./git-annotate line 124.

where that fatal error is because e83c51.. doesn't _have_ a parent, it's 
the root (so doing ^1 on it doesn't work).

After fixing the "all_lines_claimed" problem as outlined by Dscho, I get a 
lot of

	Skipping diff-parse - i = filelines)

and no actual output.

Doing it on a file that didn't exist in the root commit still have those 
"Skipping" messages, but at least it did actually output something. 

However, what it output was clearly not correct, so there's still some 
tweaking to do.

For example, doing

	./git-annotate apply.c

annotates most of that file to Junio's commit 1c15afb9, which is totally 
incorrect, that commit actually only changed a few lines.

So it looks like there's still some work to be done on this..

			Linus
