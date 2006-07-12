From: Linus Torvalds <torvalds@osdl.org>
Subject: Note on "git grep"
Date: Wed, 12 Jul 2006 14:33:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121428300.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 12 23:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0mKp-0003Ft-LF
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 23:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWGLVd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWGLVd2
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 17:33:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751432AbWGLVd1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 17:33:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CLXNnW015062
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 14:33:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CLXMPK028095;
	Wed, 12 Jul 2006 14:33:22 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23798>


Heh. Since I've been bisecting a laptop of mine that keeps having ACPI 
problems, I notived something fun about "git grep".

Using the external "grep" is about 10 times faster for the hot-cache case, 
but for cold-cache, forcing the internal one is actually a _lot_ faster 
because a fully packed kernel archive just gets wonderfully better IO 
patterns than the "real filesystem" image.

So doing "git grep some-random-string HEAD" takes about 16 seconds 
cold-cache, and 11 seconds hot-cache.

In contrast, doing "git grep some-random-string" takes over a minute 
cold-cache, and about 2 seconds hot-cache. It's kind of sad that we can't 
dynamically notice which case we have, since the hot-cache case is _so_ 
much better for the external grep, but then cold-cache sucks for it..

I just thought I'd point this out to people, since I found it interesting 
how the built-in grep functionality actually outperforms the "real" one 
under some circumstances.

		Linus
