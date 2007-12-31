From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less
 aggressive
Date: Mon, 31 Dec 2007 12:37:36 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>  <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>  <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>  <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
 <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 21:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9ROs-0003JB-EX
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 21:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXLaUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 15:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXLaUhp
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 15:37:45 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58213 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992AbXLaUho (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Dec 2007 15:37:44 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBVKbauZ000320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Dec 2007 12:37:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBVKbaBL008854;
	Mon, 31 Dec 2007 12:37:36 -0800
In-Reply-To: <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.218 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69418>



On Sun, 30 Dec 2007, Marco Costalba wrote:
> 
> Sorry to ask, but just out of curiosity, what were the reasons to
> choose zlib compression algorithm among the possible ones?

It's out there, it's common, it's stable, and it's very good "on average". 

In other words, other compression methods tend to be worse. No, zlib isn't 
perfect, but it was the obvious default choice for me (I've used it 
before, we use it in the kernel, it's usually good enough), and I actually 
expected the SHA1 to be the bigger expense.

Even today, I don't really know of a better compression choice, despite 
now being more aware of how critical uncompression performance is.

And quite honestly I'm not really even sure that the performance downside 
is entirely about zlib itself: I suspect a lot of the reason zlib shows up 
in the profiles is that the source data is usually cold in the cache, so 
it probably takes a lot of cache misses (it also will take all the page 
faults!).

Quite possibly, the cache miss costs dominate over any algorithmic costs.

		Linus
