From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick question: how to generate a patch?
Date: Mon, 27 Feb 2006 09:28:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602270923120.22647@g5.osdl.org>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com> 
 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org> 
 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com> 
 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
 <44033241.6070001@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aubrey <aubreylee@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 18:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDmAv-0003dE-UN
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWB0R2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWB0R2n
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:28:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751512AbWB0R2m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 12:28:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1RHScDZ030587
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 09:28:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1RHSbLX031141;
	Mon, 27 Feb 2006 09:28:37 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44033241.6070001@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16868>



On Mon, 27 Feb 2006, Andreas Ericsson wrote:
> 
> Did you by any chance do chmod -R, chown -R or start an ntp daemon somewhere
> in between there (don't know if clock skews will be detected by git, but...)?

off on this tangent: git shouldn't care about clock skew, because git 
never cares about the current time. The only thing that matters is that 
"stat()" returns the same time when called sequentially.

Now, if you have a distributed filesystem, and the _filesystem_ has some 
strange clock-skew problem, that would definitely screw up git.

That sounds insane, but a trivial case of it might be a networked 
filesystem where the mtime/ctime for a file create is filled in by the 
client first, but then the server will do the "final version" when it 
actually writes the file.

We used to have some bugs in our NFS client that did things like that: the 
"mtime" of a file had this confusing duality between "client time" and 
"server time", and it depended on whether the client had done a "getattr" 
to the server which one you saw.

I could well imagine that we still have some bug like that (ctime in 
particular is much less used than mtime, and thus more likely to have not 
been noticed). And it could be much worse on some less-commonly-used and 
less-unixy networked filesystem like smb, which is why I was wondering 
what OS version and filesystem Aubrey might be using.

		Linus
