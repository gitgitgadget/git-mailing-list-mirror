From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] dir.c: Omit non-excluded directories with
 dir->show_ignored
Date: Sun, 6 May 2007 12:42:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705061239460.25245@woody.linux-foundation.org>
References: <463E1705.2090201@gmail.com> <463E19D4.4030400@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Spang <mspang@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun May 06 21:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkmci-0002md-PO
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXEFTmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbXEFTmQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:42:16 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:53102 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752864AbXEFTmP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 15:42:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l46Jg4Lg003699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 12:42:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l46Jg3tA014803;
	Sun, 6 May 2007 12:42:03 -0700
In-Reply-To: <463E19D4.4030400@uwaterloo.ca>
X-Spam-Status: No, hits=-3.483 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46366>



On Sun, 6 May 2007, Michael Spang wrote:
> @@ -461,7 +462,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
>  			memcpy(fullname + baselen, de->d_name, len+1);
>  			if (simplify_away(fullname, baselen + len, simplify))
>  				continue;
> -			if (excluded(dir, fullname) != dir->show_ignored) {
> +			if ((exclude = excluded(dir, fullname)) != dir->show_ignored) {

Style issue: please write this as

			exclude = excluded(dir, fullname);
			if (exclude != dir->show_ignored) {

instead. 

Yes, both are valid C, and mean the same thing, but one is much more 
readable than the other.

Combining multiple things inside an if-statement is convenient if:

 - the things inside are _really_ trivial.

 - it's done as part of macro expansion etc (ie it's not visible as such, 
   and the code is readable in its pre-preprocessor format)

but it's not good form otherwise.

		Linus
