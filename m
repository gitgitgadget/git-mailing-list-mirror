From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Use of strbuf.buf when strbuf.len == 0
Date: Fri, 28 Sep 2007 17:51:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709281746500.3579@woody.linux-foundation.org>
References: <7vir5wy6fv.fsf@gitster.siamese.dyndns.org>
 <20070927101300.GD10289@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 02:52:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbQZC-0003si-Cy
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 02:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbXI2AwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbXI2AwO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 20:52:14 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56853 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755840AbXI2AwO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 20:52:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8T0pbnH018124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Sep 2007 17:51:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8T0panQ025454;
	Fri, 28 Sep 2007 17:51:36 -0700
In-Reply-To: <20070927101300.GD10289@artemis.corp>
X-Spam-Status: No, hits=-2.445 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.41__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59437>



On Thu, 27 Sep 2007, Pierre Habouzit wrote:
> 
>   I can see a way, that would need special proof-reading of the strbuf
> module, but should not harm its users, that would be to change
> STRBUF_INIT to work this way:
> 
>   { .buf = "", .len = 0, .alloc = 0 }

I'd like to pipe up a bit here..

I think the above is a good fix for the current problem of wanting to 
always be able to use "sb->buf", but I thinkit actually has the potential 
to fix another issue entirely.

Namely strbuf's that are initialized from various static strings and/or 
strings not directly allocated with malloc().

That's not necessarily something really unusual. Wanting to initialize a 
string with a fixed constant value is a common problem.

And wouldn't it be nice if you could actually do that, with

	{ .buf = "static initializer", .len = 18, .alloc = 0 }

and have all the strbuf routines that modify the initializer (including 
making it shorter!) notice that the allocation is too short, and create a 
new allocation?

Hmm?

			Linus
