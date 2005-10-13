From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 08:56:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510130847190.15297@g5.osdl.org>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
 <7vachd6hdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
 <434E8117.3090102@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 18:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5Rq-0005dI-Li
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbVJMP4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbVJMP4n
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:56:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751588AbVJMP4n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 11:56:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DFuS4s006436
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 08:56:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DFuR1J021147;
	Thu, 13 Oct 2005 08:56:27 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434E8117.3090102@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10079>



On Thu, 13 Oct 2005, H. Peter Anvin wrote:
> 
> Because of the special case of 255 which looks indistinguishable from EOF,
> therefore making it required?

Yeah, and I agree, that was a mistake. It could have been fixed by making 
EOF be MIN_INT (or any other value outside the range of either "unsigned 
char" or "signed char" - preferably still negative), but there are 
probably programs that depend on it being -1. 

The stupid thing I just posted doesn't care. It happens to return 0 for 
EOF for all cases, but that's a side effect of (a) not doing locales (so 
255 is never printable or alpha) and (b) not even implementing iscntrl().

In general, the rule for ctype and EOF _should_ have been that it's part 
of an acceptable input range, but that the return value is undefined ;)

(Which would allow you to test EOF later, and not worry about any faults).

		Linus
