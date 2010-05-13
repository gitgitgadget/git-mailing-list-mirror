From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 14:45:14 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
 <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 23:48:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgH3-0007Uc-D4
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278Ab0EMVst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 17:48:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54020 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756647Ab0EMVss (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 17:48:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4DLlJeZ021358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 May 2010 14:47:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4DLlIWB022190;
	Thu, 13 May 2010 14:47:18 -0700
In-Reply-To: <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147034>



On Thu, 13 May 2010, Eyvind Bernhardsen wrote:
> 
> Do you agree that "native" eol should only be CRLF if autocrlf is true?  

Not really. We're trying to get _away_ from .gitattributes depending on 
autocrlf, aren't we?

> Otherwise, if .gitattributes looks like this:
> 
> 	*.txt text
> 
> git will put CRLFs in .txt files but LFs in .c files, and I don't think 
> that makes much sense.

Well, but that's what you asked for, isn't it? And I don't see why you say 
*.c files would have LF's, since that depends on what you put in them: and 
under Windows, that might well be CRLF.

And I do think it's perfectly reasonable to override the "native" mode in 
your .git/config. If we're renaming the attributes, we might as well then 
introduce a 

	[core]
		eol=lf

to set the "native" EOL for that repo, exactly because presumably a number 
of Windows people would like to see the saner LF-only model rather than 
the traditional native CRLF.

In fact, maybe it would even make sense to just make LF the default 
"native" end-of-line sequence even on windows, so that Windows people who 
actually want CRLF would have to set core.eol=crlf. Whatever. That would 
be for the Windows git users to fight out, I don't care.

But if we are going to clean up text attribute handling, then I really 
think we want to totally break that old "core.autocrlf" dependency. 

			Linus
