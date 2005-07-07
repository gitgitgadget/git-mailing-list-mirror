From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 12:04:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 22:48:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqdIG-0001eW-2G
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 22:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVGGTIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGGTFk
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 15:05:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261995AbVGGTFT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 15:05:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67J4xjA001451
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 12:05:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67J4war018356;
	Thu, 7 Jul 2005 12:04:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Junio C Hamano wrote:
> 
>    - X.git/objects/pack can have packed GIT archives.  I
>      envision that this will be a series of 5 to 20 MB packs,
>      occasionally adding a new incremental pack when
>      X.git/objects/??/ directories accumulate enough standalone
>      SHA1 files.  It is not necessary to have X.git/objects/??/
>      files if an object is contained in one of the packs.

Note that I just re-packed the kernel archive on kernel.org, and removed 
_all_ unpacked files. Once that percolates to the mirrors, the http 
protocol will be useless without anything like this.

That said, I really think the dumb protocols are useless anyway. No other 
system supports pure static object pulling anyway, and as far as I'm 
concerned, I want "rsync" to kind of work (but it won't be optimal, since 
re-packing will delete all the old objects and replace it with the new 
pack that is downloaded anew). But plain http? I'm not convinced.

I'd much rather have a "stupid server" that just listens to a port, and
basically forks off and executes "git-upload-pack" when it's connected to
(perhaps reading the directory name first).  Nothing else. Then we can do 
a security analysis of upload-pack, which should be fairly easy since it's 
not actually ever _writing_ anything.

At that point, you can do

	git pull git://www.kernel.org/pub/scm/git/..

and it would just connect to some default "git port", pass off the 
directory name, and be done with it - exact same discovery protocol that 
now use for ssh. And "git clone" would also automatically work.

		Linus
