From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
	performance problems)
Date: Thu, 21 Apr 2005 00:13:48 +1000
Message-ID: <1114006429.5877.42.camel@localhost.localdomain>
References: <200504191250.10286.mason@suse.com>
	 <200504191708.23536.mason@suse.com>
	 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <42660708.60109@zytor.com>
	 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:12:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOFuU-0002de-8V
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDTOOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVDTOOq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:14:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20887 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261627AbVDTOOo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 10:14:44 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DOFyM-0000HX-Tj; Wed, 20 Apr 2005 15:14:38 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-20 at 02:08 -0700, Linus Torvalds wrote:
> I converted my git archives (kernel and git itself) to do the SHA1
> hash _before_ the compression phase.

I'm happy to see that -- because I'm going to be asking you to make
another change which will also require a simple repository conversion. 

We are working on getting the complete history since 2.4.0 into git
form. When it's done and checked (which should be RSN) I'd like you to
edit the first commit object in your tree -- the import of 2.6.12-rc2,
and give it a parent. That parent will be the sha1 hash of the
2.6.12-rc2 commit in the newly-provided history, and of course will
change the sha1 hash of your first commit, and all subsequent commits. 
We'll provide a tool to do that, of course.

The history itself will be absent from your tree. Obviously we'll need
to make sure that the tools can cope with an absentee parent, probably
by just treating that case as if no parent exists. That won't be hard,
it'll be useful for people to prune their trees of unwanted older
history in the general case too. That history won't be lost or undone --
it'll just be archived elsewhere.

The reason for doing this is that without it, we can't ever have a full
history actually connected to the current trees. There'd always be a
break at 2.6.12-rc2, at which point you'd have to switch to an entirely
different git repository.

-- 
dwmw2

