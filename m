From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 16:27:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031619150.4880@localhost.localdomain>
References: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
 <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org> <20090603224413.GA2902@coredump.intra.peff.net> <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain>
 <20090603230606.GA5462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 01:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzsn-0005ax-V5
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 01:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbZFCX2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 19:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbZFCX2V
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 19:28:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39155 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753665AbZFCX2U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 19:28:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53NRdF7010392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 16:27:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53NRdJY032149;
	Wed, 3 Jun 2009 16:27:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090603230606.GA5462@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120663>



On Wed, 3 Jun 2009, Jeff King wrote:
>
> Try (and this is a simplified version of the original example):
> 
>   mkdir repo && cd repo && git init &&
>   echo content >base && git add base && git commit -m base &&
>   echo context >a.txt && git add a.txt && git commit -m 'master 1' &&
>   git checkout -b other HEAD^ &&
>   echo content >b.txt && git add b.txt && git commit -m 'other 1' &&
>   echo conflict >a.txt && git add a.txt && git commit -m 'other 2' &&
>   git checkout master &&
>   git merge other ;# conflicts
> 
>   rm b.txt && git add b.txt &&
>   echo resolve >a.txt && git add a.txt &&
>   git commit -m merged

This doesn't work at all for me.

Do

	git show HEAD:b.txt

and it still shows b.txt in the commit. You should have used

	git rm b.txt

rather than "git add b.txt" (or you use use "-u" or "-a" to git add).

That looks like a bug, btw, but whatever. It seems intentional (we do the 
whole "ADD_CACHE_IGNORE_REMOVAL" flag thing).

But you're right. Even when fixed, it does seem to need "--full-history" 
to stay around, and --simplify-merges is insufficient. Bug in merge 
simplification?

			Linus
