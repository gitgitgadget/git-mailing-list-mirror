From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon --inetd
Date: Fri, 16 Sep 2005 10:30:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161027460.26803@g5.osdl.org>
References: <43290EFF.3070604@zytor.com> <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
 <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 19:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGK3I-0005QP-RC
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 19:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbVIPRbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 13:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVIPRbF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 13:31:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030591AbVIPRbE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 13:31:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GHUmBo000488
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 10:30:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GHUi81002218;
	Fri, 16 Sep 2005 10:30:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8696>



On Fri, 16 Sep 2005, Junio C Hamano wrote:
> 
> Later exchanges between you and HPA appeared to me that we would
> need a chroot environment which has "enough stuff" and that this
> patch may not help him very much.  Am I mistaken?

No, I think that's correct.

> I think resolving user and group to numeric before you do
> chroot() might make the setting up of chrooted environment a
> little simpler; no need for supporting getpwnam and getgrnam
> there.

Right you are. Much better.

>  On the other hand it may not matter -- you can always
> give numeric uid/gid to begin with.

Well, the symbolic names are much nicer and more readable. So it would be 
better to do the uid/gid translation early, and change the "chroot" thing 
to be done after all that.

It gets a bit messy.. Easy enough to just save a "const char *new_root",
but then you have to split up the "set_user_group()" to be two functions,
around the actual chroot(), since the chroot needs to be done while we're
still root.

I think we can drop the patch for now. It doesn't buy much.

		Linus
