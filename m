From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Mon, 27 Mar 2006 19:11:43 -0800
Message-ID: <13360.1143515503@lotus.CS.Berkeley.EDU>
References: <7v1wwnnyvt.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 28 05:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO4ci-0008VK-SV
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 05:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWC1DLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 22:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWC1DLp
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 22:11:45 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:12185 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751219AbWC1DLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 22:11:44 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k2S3BigH013362
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 19:11:44 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k2S3Bi9B013361
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 19:11:44 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <7v1wwnnyvt.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18107>

And Junio C Hamano writes:
 - I wonder what the dependency is, since ALL_LDFLAGS is not
 - modified on AIX, [...]

Specifically, -lcrypto.  Mine is in a funny place, so I need
LDFLAGS passed in.

 - > Once it builds, only one test "fails" on AIX 5.1 with 
 - > 1.3.0.rc1, t5500-fetch-pack.sh, but it looks like it's some
 - > odd tool problem in the tester + my setup and not a real bug.
 - 
 - Curious and would appreciate more details.

I just found it.  The progress meter stuff in pack-objects
splats all over the output.  So trash/client/log.txt is
completely mangled.  Everything functions correctly, but
the textual output is garbage.  If I set progress to 0 in 
pack-objects.c, everthing's happy.

There's no way to pass -q through fetch-pack to upload-pack...
Gee, look, a comment that says "Yeah, yeah, fixme."  I have
no real desire to add an args argument and propagate that
change through all the connect routines.  An alternative is
to add a "quiet" command to the protocol.  Another would be 
to dup all three file descriptors.  yech.  Preference?

(I haven't updated git in a while on this platform.  
Recompiling and testing takes a while on a 375 MHz Power3.)

Jason
