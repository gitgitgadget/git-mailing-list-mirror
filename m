From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Replace literal STRLEN_ #defines in refs.h with
 compiler evaluated expressions
Date: Sat, 29 Sep 2007 11:15:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709291103380.3579@woody.linux-foundation.org>
References: <200709291400.13880.andyparkins@gmail.com>
 <7vd4w1l872.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 20:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibgqo-0002dp-DV
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 20:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbXI2SPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbXI2SPb
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 14:15:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49129 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbXI2SPa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2007 14:15:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8TIFMxw005644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Sep 2007 11:15:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8TIFLFv026878;
	Sat, 29 Sep 2007 11:15:21 -0700
In-Reply-To: <7vd4w1l872.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.246 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.41__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59483>



On Sat, 29 Sep 2007, Junio C Hamano wrote:
> 
> I do not think the above is wrong per se, but doesn't a good
> compiler optimize
> 
> 	#define PATH_REMOTES	"remotes/"
> 	#define STRLEN_PATH_REMOTES strlen(PATH_REMOTES)

Gcc does, yes.

HOWEVER.

Using "strlen()" may be optimized at compile-time, but it still ends up 
resulting in illegal C code if the constant needs to be a constant in the 
semantic sense.

IOW, the "sizeof()" trick can be portably used for things like array 
declarations etc. But strlen() cannot. Ie

	char array[sizeof("hello")-1];

is legal in non-function scope, but doing the same with "strlen()" is not.

(That said, gcc has been known to accept bad C code, and will in fact 
accept this one too!)

		Linus
