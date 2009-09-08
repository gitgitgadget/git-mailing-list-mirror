From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 11:19:59 -0400
Message-ID: <D79F79B1-A4F4-4AEA-9E3B-F0CF59019B88@gernhardtsoftware.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com> <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com> <vpqhbvekldk.fsf@bauges.imag.fr> <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com> <4AA66C54.4060101@viscovery.net> <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 17:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml2Ul-0003M1-6f
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 17:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbZIHPUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZIHPUN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 11:20:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60608 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZIHPUM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 11:20:12 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 467A91FFC087; Tue,  8 Sep 2009 15:20:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.155] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id A74A71FFC06B;
	Tue,  8 Sep 2009 15:19:57 +0000 (UTC)
In-Reply-To: <a4c8a6d00909080752p5b663fc8r8bf1c60023ef39b4@mail.gmail.com>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128013>


On Sep 8, 2009, at 10:52 AM, Thiago Farina wrote:

> On Tue, Sep 8, 2009 at 10:38 AM, Johannes Sixt<j.sixt@viscovery.net>  
> wrote:
>> Then guessed wrong. You really only have to say "make". The use of
>> autoconf and ./configure is purely optional and not necessary.
> I don't think so.
> Running only "make".
> $ make
> GIT_VERSION = 1.6.5.rc0
>    * new build flags or prefix
>    CC fast-import.o
> In file included from builtin.h:4,
>                 from fast-import.c:143:
> git-compat-util.h:129:25: error: openssl/ssl.h: No such file or  
> directory
> git-compat-util.h:130:25: error: openssl/err.h: No such file or  
> directory

You don't have OpenSSL, a perquisite mentioned in the INSTALL file at  
line 55.  You can do the following:

make NO_OPENSSL=Yes

or save the option so you don't have to retype it each time:

echo "NO_OPENSSL=Yes" > config.mak
make

Or install OpenSSL or run the autoconf.

The Makefile tries it's best to be as smart as possible without being  
a configure script of it's own (see ll. 656-925), and it's highly  
commented at the beginning so that only a minimal knowledge of make is  
required (ll. 4-198).  I suppose we could  note that the defines  
should be put in a config.mak file.

> Running configure and then make
> $ make configure
> GIT_VERSION = 1.6.5.rc0.dirty
>    GEN configure

  $ ./configure
[lots of output]
> $ make
>    CC fast-import.o

As pointed out before, you forgot to run the generated configure  
script (as already documented at Makefile:20).

However, it's generally considered preferable to hand-create a  
config.mak for the few options you need on a regular basis and let the  
Makefile do it's work.  The autoconf files occasionally lag behind the  
rest of development as they're not widely used by git developers  
(AFAICT).

I'd personally argue that we should point out in INSTALL that git can  
be configured via a hand-written config.mak using the defines  
described at the top of the Makefile before we talk about using  
autoconf.  (Perhaps with quick notes about the most commonly used  
defines.)

For example, my config.mak contains:

prefix=/usr/local
ASCIIDOC8=Yes
MAN_BOLD_LITERAL=Yes
BLK_SHA1=Yes

The rest of the configuration for my OS (OS X/Darwin, specifically)  
are handled by the Makefile.

~~ Brian
