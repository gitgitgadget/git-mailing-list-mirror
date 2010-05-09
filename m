From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sun, 9 May 2010 11:11:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005091046570.3711@i5.linux-foundation.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <alpine.LFD.2.00.1005081600490.3711@i5.linux-foundation.org> <A5422145-63E1-4AF4-9184-7A6D15E9C2B6@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 20:13:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBB0k-0002CH-2r
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245Ab0EISNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:13:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56572 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751063Ab0EISNd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 14:13:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o49ID9lw007745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 May 2010 11:13:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o49ID8Yp019024;
	Sun, 9 May 2010 11:13:08 -0700
In-Reply-To: <A5422145-63E1-4AF4-9184-7A6D15E9C2B6@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146733>



On Sun, 9 May 2010, Eyvind Bernhardsen wrote:
> 
> I'm sorry.  Are you the same Linus Torvalds who wrote this:
> 
> > Btw, since we're discussing this, I do think that our current "crlf=input" 
> > syntax for .gitattributes is pretty dubious.

Yes, it's dubious. But as with the kernel, we need to support backwards 
compatibility for things that have reasonably been used (and "input" has).

I really brought it up as an example of things that weren't necessarily 
all that well designed.

That said, it looks like people actually do want per-file line-ending 
settings, ie not just a global "I want CRLF vs LF". So it looks like 
crlf=input is actually useful in a .gitattributes files, if only because 
some people seem to want to mix CRLF and just LF in the same repository.

It also sounds like people actually want to have the reverse (ie not just 
"input", but have a mode where LF may be the default, but then some 
particular files must always be CRLF even if most files are normal text).

So I suspect we want to really have support for all four combinations 
_both_ in the .git/config file, _and_ in the .gitattributes file.

The four cases would be "none" ("binary" or "-crlf"), "lf" ("input" or 
"crlf=input"), "system default", and "force crlf".

Honestly, I would personally have preferred to have just a repo-wide "this 
is the line ending". Not some path-specific endings like "crlf=input" in 
the .gitattributes. But people do seem to want it.

			Linus
