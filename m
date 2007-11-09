From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 09:10:35 +0100
Message-ID: <20071109081035.GA2794@steel.home>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <458BC6B0F287034F92FE78908BD01CE814472B3D@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yossi Leybovich <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqOx6-0005Ai-2p
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXKIIKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbXKIIKj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:10:39 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:21305 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbXKIIKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:10:39 -0500
Received: from tigra.home (Fc883.f.strato-dslnet.de [195.4.200.131])
	by post.webmailer.de (mrclete mo37) (RZmta 14.0)
	with ESMTP id 4026f0jA94Oh8X ; Fri, 9 Nov 2007 09:10:36 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 85D05277AE;
	Fri,  9 Nov 2007 09:10:36 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id EDB6656D22; Fri,  9 Nov 2007 09:10:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C9029A36A1@mtlexch01.mtl.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+cUM8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64139>

Yossi Leybovich, Fri, Nov 09, 2007 00:59:47 +0100:
> I wonder if someone can help in this error
> I tried to do git-gc and got error on corrupted object. 
> 
> I do the following:
> 
> $ git-gc
> Generating pack...
> Done counting 3037 objects.
> Deltifying 3037 objects...
> error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'

It is loose. Nothing uses it in this repository. What do you need to
repair it for?

> fatal: object 4b9458b3786228369c63936db65827de3cc06200 cannot be read
> error: failed to run repack
> 
> sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib
> $ cd .git/objects/4b/
> 
> sleybo@SLEYBO-LT /w/work/EMC/ib.071030.001/ib/.git/objects/4b
> $ git-fsck-objects.exe 9458b3786228369c63936db65827de3cc06200
> error: corrupt loose object '4b9458b3786228369c63936db65827de3cc06200'
> error: 4b9458b3786228369c63936db65827de3cc06200: object corrupt or
> missing
> error: invalid parameter: expected sha1, got
> '9458b3786228369c63936db65827de3cc06200'
> missing blob 4b9458b3786228369c63936db65827de3cc06200

the directories directly under .git/objects contain the first bytes of
sha1, to use filesystem in a more efficient way. git-fsck expects an
sha1 (or a reference).

Try running moving the corrupt object (with its *whole* name) some
place else and run git-fsck --all.
