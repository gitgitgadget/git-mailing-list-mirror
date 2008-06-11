From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 19:12:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>  <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>  <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
  <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>  <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>  <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>  <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FqR-00022Y-3T
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbYFKCMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbYFKCMz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:12:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35611 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754874AbYFKCMy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 22:12:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B2CT66029266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 19:12:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B2CSW1008251;
	Tue, 10 Jun 2008 19:12:29 -0700
In-Reply-To: <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.377 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84582>



On Tue, 10 Jun 2008, Ben Lynn wrote:
> 
> Sorry, but if we're assuming no one is touching the files while we're
> updating the index (including writing it to disk), why does it matter
> whether we use the time of first or last write? In fact, if a index
> write takes a long time, using the last write time as the mtime would
> be beneficial for the race condition stuff.

Oh, if you assume nobody is touching the files as the index is created, 
none of this matters. 

So if *that* was your only race worry, then git should already be 
perfectly fine.

The issue with the timestamp of the index only happens if somebody ends up 
modifying the files that are being indexed _as_ they are indexed. Quite 
frankly, git will notice that too in just about all possible cases, but if 
the size stays the same and the modification time ends up still being 
smaller than the final index mtime (because writing the index took so 
long!), then you might miss some modifications that would otherwise be 
noticed.

		Linus
