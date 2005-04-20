From: Ingo Molnar <mingo@elte.hu>
Subject: Re: enforcing DB immutability
Date: Wed, 20 Apr 2005 09:49:48 +0200
Message-ID: <20050420074948.GA22620@elte.hu>
References: <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org> <20050420074053.GA22436@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 09:46:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO9uO-0008Ln-0t
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 09:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTHuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 03:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDTHuO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 03:50:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23683 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261338AbVDTHuI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 03:50:08 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id CD54E319722;
	Wed, 20 Apr 2005 09:48:50 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 8C2461FC2; Wed, 20 Apr 2005 09:49:51 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050420074053.GA22436@elte.hu>
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

> perhaps having a new 'immutable hardlink' feature in the Linux VFS 
> would help? I.e. a hardlink that can only be readonly followed, and 
> can be removed, but cannot be chmod-ed to a writeable hardlink. That i 
> think would be a large enough barrier for editors/build-tools not to 
> play the tricks they already do that makes 'readonly' files virtually 
> meaningless.

immutable hardlinks have the following advantage: a hardlink by design 
hides the information where the link comes from. So even if an editor 
wanted to play stupid games and override the immutability - it doesnt 
know where the DB object is. (sure, it could find it if it wants to, but 
that needs real messing around - editors wont do _that_)

i think this might work.

(the current chattr +i flag isnt quite what we need though because it 
works on the inode, and it's also a root-only feature so it puts us back 
to square one. What would be needed is an immutability flag on 
hardlinks, settable by unprivileged users.)

	Ingo
