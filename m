From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use line buffering for standard output
Date: Sun, 3 Aug 2008 14:46:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808031444270.3668@nehalem.linux-foundation.org>
References: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPlQm-0000qQ-Ne
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbYHCVq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 17:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbYHCVq5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:46:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752646AbYHCVq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2008 17:46:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m73LkJC6000796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 14:46:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m73LkIiE008860;
	Sun, 3 Aug 2008 14:46:18 -0700
In-Reply-To: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.413 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91278>



On Sun, 3 Aug 2008, Anders Melchiorsen wrote:
>
> Normally, stdout is fully buffered, unless it refers to a terminal
> device. This gives problems when fork() is in play: the buffer is
> cloned and output appears twice.
> 
> By always setting stdout to line buffering, we make the output work
> identically for all output devices.

Please don't.

This is a huge peformance issue for things like

	git log -p > file

where we really want it to be fully buffered.

So please just find the place where we do a fork() without flushing 
pending output...

(We really shouldn't have all that many "fork()" calls left, I thought - 
the Windows stuff means that most of it should be abstracted away. So it's 
not like we're talking about hundreds of sites, there should be just a 
couple).

		Linus
