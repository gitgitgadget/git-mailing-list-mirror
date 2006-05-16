From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 20:27:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605152008170.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org> 
 <Pine.LNX.4.64.0605151801100.3866@g5.osdl.org>
 <118833cc0605151910s7619ddf0x8f014adba2a1eba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 16 05:27:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfqDw-0000hI-Ks
	for gcvg-git@gmane.org; Tue, 16 May 2006 05:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWEPD1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 23:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEPD1s
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 23:27:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751098AbWEPD1r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 23:27:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4G3RftH008480
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 20:27:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4G3RebS026613;
	Mon, 15 May 2006 20:27:41 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0605151910s7619ddf0x8f014adba2a1eba5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20096>



On Mon, 15 May 2006, Morten Welinder wrote:
>
> If I read the code right, it calls regexec for every single character
> on every single line.  No wonder that takes a while!  Just call it
> once and it'll search for its match quite nicely.

No, it calls it once per pattern per line.

But yes, it calls it once per line, instead of calling it on some bigger 
boundary. Partly because of the line-based output, partly probably because 
regexec() is not actually amenable to a "<buffer,size>" kind of usage, but 
is based on NUL-terminated strings.

> 1. If the pattern contains no regexp characters  (and that is very
>    common), do a strstr.
> 
> 2. If the pattern must start with a specific character, search for that
>    by itself.

Yeah, we could do some simple stuff, and see if it helps..

		Linus
