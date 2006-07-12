From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Error writing loose object on Cygwin
Date: Tue, 11 Jul 2006 21:36:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607112132540.5623@g5.osdl.org>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 06:36:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0WST-0007Z9-En
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 06:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGLEgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 00:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWGLEgP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 00:36:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932412AbWGLEgO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 00:36:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C4a4nW018569
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 21:36:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6C4a4KD024145;
	Tue, 11 Jul 2006 21:36:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23761>



On Tue, 11 Jul 2006, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Has anyone else seen this type of behavior before?  Any suggestions
> > on debugging this issue?
> 
> I would suggest raising this (politely) to Cygwin people.

Well, since it apparently works with W2000, and breaks with XP, I suspect 
it's actually Windows that just returns the wrong error code.

It's entirely possible that we should just make that whole

	if (ret == ENOENT)

go away. Yes, it's the right error code if a subdirectory is missing, and 
yes, POSIX requires it, and yes, WXP is probably just a horrible piece of 
sh*t, but on the other hand, I don't think git really has any serious 
reason to even care. 

So we might as well say that if the link() fails for _any_ reason, we'll 
try to see if doing the mkdir() and re-trying the link helps.

		Linus
