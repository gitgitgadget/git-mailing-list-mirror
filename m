From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Tue, 8 May 2007 23:50:10 +0200
Message-ID: <20070508215009.GA2670@steel.home>
References: <463FCD7C.4020009@zytor.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue May 08 23:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlXaU-0005nl-9E
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032026AbXEHVvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032042AbXEHVvK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 17:51:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:58566 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032026AbXEHVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 17:51:08 -0400
Received: from tigra.home (195.4.202.90)
	by post.webmailer.de (klopstock mo5) (RZmta 5.9)
	with ESMTP id P01e4fj48In9AB ; Tue, 8 May 2007 23:50:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D874F277BD;
	Tue,  8 May 2007 23:50:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 50CCBD171; Tue,  8 May 2007 23:50:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <463FCD7C.4020009@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTN2dg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46630>

H. Peter Anvin, Tue, May 08, 2007 03:08:12 +0200:
> The following tree:
> 
> http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-newsetup.git;a=summary
> 
> ... has one commit which changes arch/x86_64/boot from a directory to a
> symlink, and another one which changes it back.  Apparently as a result,
> git rebase dies horribly; on the first change it requires manual fixup,
> but it crashes on the second, with or without -m.

What kind of manual fixup did you do? I tried to reproduce it, and did
the following:

    git clone --reference ~/linux.git git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-newsetup.git
    cd linux-2.6-newsetup.git
    git rebase a989705c4cf6e6c1a339c95f9daf658b4ba88ca8

It stopped at 'Revert "x86-64: Make arch/x86-64/boot a symlink to
arch/i386/boot"' aka cd312503f8e8a88895b12bf810677406284142e6.
I went on:

    rm arch/x86-64/boot
    git checkout cd312503f8e8a88895b12bf810677406284142e6 arch/x86-64/boot
    git rebase --continue

And then it just continued until all commits were rebased.
I have a very recent git, so maybe that's why it worked.
