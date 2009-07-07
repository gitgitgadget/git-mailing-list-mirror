From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 15:13:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907071504540.3210@localhost.localdomain>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.01.0907071142330.3210@localhost.localdomain> <81b0412b0907071257q14bb544dp99846f2a35fbada2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 00:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOIvL-0001g8-VZ
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbZGGWN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756702AbZGGWN4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 18:13:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51782 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754983AbZGGWNz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 18:13:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n67MDeNf023233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Jul 2009 15:13:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n67MDdCn017459;
	Tue, 7 Jul 2009 15:13:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <81b0412b0907071257q14bb544dp99846f2a35fbada2@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122879>



On Tue, 7 Jul 2009, Alex Riesen wrote:
> 
> Maybe we could at least let the user save the encoding of file names
> in the tree objects somehow?

There's no place to really sanely save it in a tree, nor is there really 
even any way to figure the right encoding out. In fact, one of the 
problems with non-utf encodings is that in theory people could literally 
be mixing different encodings in one tree (imagine test-suites etc). 

There's a reason why the only _sane_ model is to use an encoding that is 
universal. 

So we could in theory save an encoding in the commit, but quite frankly, 
it's unlikely that we could use it sanely. Nobody is ever going to write a 
sane merge that will merge across different encodings. So realistically, 
you're going to have a single encoding not per tree, or per commit, but 
for the whole project.

And then when you get fed up with Latin1 or Shift-JIS or whatever crazy 
sh*t people are still using, you use fast-export + script + fast-import, 
and change the encoding for the whole repository that way. Exactly because 
doing it at a smaller granularity is a total pain in the *ss.

			Linus
