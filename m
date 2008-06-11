From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 19:39:16 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>  <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>  <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
  <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>  <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>  <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>  <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org> 
 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>  <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org> <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6GGX-0001Vs-BT
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbYFKCj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbYFKCj2
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:39:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57837 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254AbYFKCj2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 22:39:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B2dIUT030432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 19:39:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B2dGJ7009120;
	Tue, 10 Jun 2008 19:39:17 -0700
In-Reply-To: <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.376 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84584>



On Tue, 10 Jun 2008, Ben Lynn wrote:
>
> Ah, I hadn't seen that. Yes, it is better to use the first write as
> the timestamp. Would this catch everything? If the filesystem clock is
> monotonically increasing and consistent then with this setup, you can
> touch files even as they are being indexed? (Disregarding nonsense
> like changing sizes by 2^32.)

Yes, I think that at that point it would protect against arbitrary 
modifications even concurrently to index file creation.

That said, I don't think you even need a new index file format. We could 
just do a stat() on starting the index file creation, and then do a 
futimes() system call at the end to re-set the mtime to the beginning 
before we rename it back over the old index file.

		Linus
