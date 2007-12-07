From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Thu, 6 Dec 2007 16:30:15 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
References: <1196968023-45284-1-git-send-email-win@wincent.com> <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com> <200712070111.23283.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-2022-JP
Cc: Blake Ramsdell <blaker@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0R7c-0006BD-R9
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 01:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbXLGAa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 19:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbXLGAa6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 19:30:58 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42549 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142AbXLGAa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 19:30:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB70UFII012921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Dec 2007 16:30:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB70UFil021758;
	Thu, 6 Dec 2007 16:30:15 -0800
In-Reply-To: <200712070111.23283.jnareb@gmail.com>
X-Spam-Status: No, hits=-4.727 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67360>



On Fri, 7 Dec 2007, Jakub Narebski wrote:
>
> The problem is that it should be check that tests for compile time 
> _warnings_; my solution was to use '-Werror' flag to make warning into 
> error, and AC_COMPILE_IFELSE, but this might be gcc only solution.
> 
>   Message-ID: <1196895948-25115-1-git-send-email-jnareb@gmail.com>
>   http://permalink.gmane.org/gmane.comp.version-control.git/67209
> 
> So please send it.

Umm. Why not just make the test be whether the following compiles cleanly?

	#include <iconv.h>
	
	extern size_t iconv(iconv_t cd,
	  char **inbuf, size_t *inbytesleft,
	  char **outbuf, size_t *outbytesleft);

because if the compiler has seen a "const char **inbuf", then it  should 
error out with a "conflicting types for ‘iconv’" style message..

Just do

	 $CC -c test-iconv.c

or something.

Totally untested. I don't do autoconf.

		Linus
