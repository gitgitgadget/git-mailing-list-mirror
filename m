From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sat, 6 Oct 2007 18:31:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710061827010.23684@woody.linux-foundation.org>
References: 20071007011331.GC5642@mediacenter.austin.rr.com
 <1191719841666-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, frank@lichtenheld.de, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeL04-0000lW-1T
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 03:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXJGBb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 21:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbXJGBb7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 21:31:59 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44780 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752311AbXJGBb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2007 21:31:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l971Vcd9030171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Oct 2007 18:31:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l971Vasa018277;
	Sat, 6 Oct 2007 18:31:36 -0700
In-Reply-To: <1191719841666-git-send-email-shawn.bohrer@gmail.com>
X-Spam-Status: No, hits=-4.439 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_43,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60164>



On Sat, 6 Oct 2007, Shawn Bohrer wrote:
>
> This replaces git-clean.sh with builtin-clean.c, and moves git-clean.sh to the
> examples.

This looks better, but I think you'd be even better off actually using the 
"read_directory()" interface directly, instead of exec'ing off "git 
ls-files" and parsing the line output.

I also would still worry a bit about 'chdir(x)' and 'chdir("..")', because 
quite frankly, they are *not* mirrors of each other (think symlinks, but 
also error behaviour due to directories that might be non-executable). 
Now, admittedly, if a directory isn't executable, I can imagine other git 
things having problems (anybody want to test?), but that whole pattern is 
just very fragile and not very reliable.

		Linus
