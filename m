From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Thu, 11 May 2006 10:58:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605111054290.3866@g5.osdl.org>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 19:58:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeFQv-0003vJ-VZ
	for gcvg-git@gmane.org; Thu, 11 May 2006 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWEKR6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 13:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWEKR6i
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 13:58:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030404AbWEKR6i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 13:58:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4BHwXtH030005
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 May 2006 10:58:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4BHwWCq021764;
	Thu, 11 May 2006 10:58:32 -0700
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060511173632.G60c08b4@leonov.stosberg.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19909>



On Thu, 11 May 2006, Dennis Stosberg wrote:
> 
> I am not sure whether an int cast or an int32_t cast is more
> appropriate here.  An int is not guaranteed to be four bytes wide,
> but I don't know of any modern platform where that's not the case.
> On the other hand int32_t is not necessarily available before C99.
> 
> Any opinions?  I wonder why no one has hit this on x86_64...

I think the "ntohl()" hides it. It loads a 64-bit value, but since x86-64 
is little-endian, the low 32 bits are correct. The htonl() will then strip 
the high bits and make it all be big-endian.

And while I actually run a 64-bit big-endian machine myself (G5 ppc64), my 
user space is all 32-bit by default, so it never showed up on linux-ppc64 
either.

Anyway, the correct type to use is "uint32_t" in this case. That's what 
htonl() takes.

		Linus
