From: Ingo Molnar <mingo@elte.hu>
Subject: enforcing DB immutability
Date: Wed, 20 Apr 2005 09:40:53 +0200
Message-ID: <20050420074053.GA22436@elte.hu>
References: <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:37:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9lf-0007Io-CK
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDTHlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDTHlN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:41:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62593 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261303AbVDTHlE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:41:04 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 0E1E8319D3F;
	Wed, 20 Apr 2005 09:39:56 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 109AB1FC2; Wed, 20 Apr 2005 09:40:57 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 13 Apr 2005, Ingo Molnar wrote:
> > 
> > well, the 'owned by another user' solution is valid though, and doesnt 
> > have this particular problem. (We've got a secure multiuser OS, so can 
> > as well use it to protect the DB against corruption.)
> 
> So now you need root to set up new repositories? No thanks.

yeah, it's a bit awkward to protect uncompressed repositories - but it 
will need some sort of kernel enforcement. (if userspace finds out the 
DB contains uncompressed blobs, it _will_ try to use them.)

(perhaps having an in-kernel GIT-alike versioned filesystem will help - 
but that brings up the same 'I have to be root' issues. The FS will 
enforce the true immutability of objects.)

perhaps having a new 'immutable hardlink' feature in the Linux VFS would 
help? I.e. a hardlink that can only be readonly followed, and can be 
removed, but cannot be chmod-ed to a writeable hardlink. That i think 
would be a large enough barrier for editors/build-tools not to play the 
tricks they already do that makes 'readonly' files virtually 
meaningless.

	Ingo
