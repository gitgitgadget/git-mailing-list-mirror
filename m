From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 08:22:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com> 
 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org> 
 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com> 
 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>  <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
  <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G91VO-00085V-Cp
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWHDPW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWHDPW1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:22:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932526AbWHDPW0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:22:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k74FMOnW023810
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Aug 2006 08:22:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k74FMN07003880;
	Fri, 4 Aug 2006 08:22:24 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24793>



On Fri, 4 Aug 2006, Jon Smirl wrote:
> 
> Could repack-objects be modified to take the objects on stdin as I
> generate them instead of me putting them into the file system and then
> deleting them? That model would avoid many gigabytes of IO.

I'd suggest against it, but you can (and should) just repack often enough 
that you shouldn't ever have gigabytes of objects "in flight". I'd have 
expected that with a repack every few ten thousand files, and most files 
being on the order of a few kB, you'd have been more than ok, but 
especially if you have large files, you may want to make things "every <n> 
bytes" rather than "every <n> files".

You _could_ also decide to create packs very aggressively indeed, and if 
you do them quickly enough, the raw objects never even get written back to 
disk before you delete them. That will leave you with a lot of packs, but 
you could then "repack the packs" every once in a while.

That said, it's obviously not _impossible_ to do what you suggest, it's 
just major surgery to pack-objects (which I'm not going to have time to 
do, since I'll be going on a vacation this weekend).

			Linus
