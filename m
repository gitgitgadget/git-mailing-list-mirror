From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 18:36:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>  <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>  <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
  <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>  <7v1w34dfn3.fsf@gitster.siamese.dyndns.org> <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:37:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FHf-00005w-2p
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYFKBga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbYFKBga
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:36:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51442 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbYFKBga (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 21:36:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1aKYK027573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 18:36:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1aICR007036;
	Tue, 10 Jun 2008 18:36:19 -0700
In-Reply-To: <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.38 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84572>



On Tue, 10 Jun 2008, Ben Lynn wrote:
> 
> I call time(NULL) for each file out of laziness. I could cache the
> value somewhere the first time, but that means I'd have to pass around
> an extra argument to a whole bunch of functions, because of the way
> I've written my code. But I don't think it's much of a drawback,
> because I stat() each file anyway.

No, that would be horrible. There is no guarantee that time() has 
anything to do with the stat timestamps anyway. 

The right way to do things would be to just do a stat() on the index file 
as it is created, and then save the mtime of that stat into the file. That 
way, you have the mtime of the index file not for the *last* write, but 
for the *first* one.

		Linus
