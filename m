From: Ingo Molnar <mingo@elte.hu>
Subject: Re: enforcing DB immutability
Date: Wed, 20 Apr 2005 09:53:20 +0200
Message-ID: <20050420075320.GA22676@elte.hu>
References: <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org> <20050420074053.GA22436@elte.hu> <20050420074948.GA22620@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:49:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9xW-0000LF-Cj
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDTHxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDTHxc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:53:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7300 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261426AbVDTHx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:53:29 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 70DC9319B2C;
	Wed, 20 Apr 2005 09:52:22 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id F29531FC2; Wed, 20 Apr 2005 09:53:22 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050420074948.GA22620@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > perhaps having a new 'immutable hardlink' feature in the Linux VFS 
> > would help? I.e. a hardlink that can only be readonly followed, and 
> > can be removed, but cannot be chmod-ed to a writeable hardlink. That i 
> > think would be a large enough barrier for editors/build-tools not to 
> > play the tricks they already do that makes 'readonly' files virtually 
> > meaningless.
> 
> immutable hardlinks have the following advantage: a hardlink by design 
> hides the information where the link comes from. So even if an editor 
> wanted to play stupid games and override the immutability - it doesnt 
> know where the DB object is. (sure, it could find it if it wants to, 
> but that needs real messing around - editors wont do _that_)

so the only sensible thing the editor/tool can do when it wants to 
change the file is precisely what we want: it will copy the hardlinked 
files's contents to a new file, and will replace the old file with the 
new file - a copy on write. No accidental corruption of the DB's 
contents.

(another in-kernel VFS solution would be to enforce that the files's 
name always matches the sha1 hash. So if someone edits a DB object it 
will automatically change its name. But this is complex, probably cannot 
be done atomically, and brings up other problems as well.)

	Ingo
