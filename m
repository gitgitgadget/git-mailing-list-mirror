From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 12:59:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com> 
 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org> 
 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net> <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcqE-0004jp-1i
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992454AbXBIU72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992837AbXBIU72
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:59:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45908 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992454AbXBIU71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:59:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l19KxNUI015728
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Feb 2007 12:59:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l19KxMwI025788;
	Fri, 9 Feb 2007 12:59:23 -0800
In-Reply-To: <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
X-Spam-Status: No, hits=-0.429 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39199>



On Fri, 9 Feb 2007, Marco Costalba wrote:
> 
> If I modify qgit in running 'git runstatus' as a fallback in case 'git
> status' exits with an error (without checking what kind of error
> exactly) could be an acceptable path or could hide subtle
> side-effects? I have no the knowledge to answer this by hand.

It's probably better for you to just

 - run "git update-index --refresh" and don't care about the exit value
 - run "git runstatus" unconditionally

which should basically get you something working.

HOWEVER, it's also quite possible that "git-commit.sh" should just do this 
on its own. If the update-index fails, we really only care if we literally 
use the index later to *write* something, ie the commit case. For just 
"git status", maybe we should just silently ignore the error..

		Linus
