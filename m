From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Fri, 14 May 2010 14:27:57 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005141421560.3711@i5.linux-foundation.org>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
 <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org> <7DF58EB2-F6A0-47FB-BC89-72757B29FAE6@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 23:31:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD2Tv-0005lJ-Lr
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 23:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab0ENVbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 17:31:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57756 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118Ab0ENVbi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 17:31:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4ELU3mG026676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 May 2010 14:30:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4ELU24C023583;
	Fri, 14 May 2010 14:30:03 -0700
In-Reply-To: <7DF58EB2-F6A0-47FB-BC89-72757B29FAE6@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147120>



On Fri, 14 May 2010, Eyvind Bernhardsen wrote:

> On 13. mai 2010, at 23.45, Linus Torvalds wrote:
> 
> > On Thu, 13 May 2010, Eyvind Bernhardsen wrote:
> >> 
> >> Do you agree that "native" eol should only be CRLF if autocrlf is true?  
> > 
> > Not really. We're trying to get _away_ from .gitattributes depending on 
> > autocrlf, aren't we?
> 
> I'm not sure we still are.  I certainly was when I started this series, 
> but that was because autocrlf just plain didn't work with many existing 
> repositories.  When "safe autocrlf" fixed that, I decided that the extra 
> complexity of core.eolStyle wasn't worth it.

The thing is, I disagree with your notion of "safe autocrlf". I think it's 
ugly, and I don't think it's safe at all. It adds a _feeling_ of safety 
that isn't actually safe.

In short:

 - core.autocrlf is _always_ dangerous. Your "safe" thing isn't any safer 
   at all, since it depends on something that isn't reliable (previous 
   state).

   Example: new binary files, or changed files, or renames.

 - so if you want text conversion, but you want it to be truly safe, and 
   only happen for certain files, YOU MUST NOT ENABLE autocrlf.

 - Ergo: if you make the .gitattributes behaviour depend on autocrlf, 
   you're still screwed, and you've not actually improved on anything at 
   all in the end.

It's really that simple. I think "autocrlf" actually works pretty well, 
but at the same time, I think we made mistakes in the initial design. 
Let's not make them again.

		Linus
