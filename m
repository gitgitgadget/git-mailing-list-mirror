X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 17:42:58 +0100
Organization: Harddisk-recovery.com
Message-ID: <20061123164258.GE6581@harddisk-recovery.com>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org> <4565C205.8050300@lsrfire.ath.cx> <20061123155431.GD6581@harddisk-recovery.com> <4565C8F4.6000606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 16:43:19 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4565C8F4.6000606@lsrfire.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32150>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnHfG-0006Ur-If for gcvg-git@gmane.org; Thu, 23 Nov
 2006 17:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933877AbWKWQnC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 11:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbWKWQnB
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 11:43:01 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:2726 "HELO
 abra2.bitwizard.nl") by vger.kernel.org with SMTP id S933877AbWKWQnA (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 11:43:00 -0500
Received: (qmail 18181 invoked from network); 23 Nov 2006 17:42:58 +0100
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26) by
 abra2.bitwizard.nl with SMTP; 23 Nov 2006 17:42:58 +0100
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
 id 1GnHf8-0002Ng-00; Thu, 23 Nov 2006 17:42:58 +0100
To: Ren? Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 05:14:44PM +0100, Ren? Scharfe wrote:
> Erik Mouw schrieb:
> > On Thu, Nov 23, 2006 at 04:45:09PM +0100, Ren? Scharfe wrote:
> >>  Is there really a compiler that inserts padding between arrays of
> >> unsigned chars?
> > 
> > Yes, that compiler is called "gcc".
> > 
> > #include <stdio.h>
> > 
> > struct foo {
> >         unsigned char a[3];
> >         unsigned char b[3];
> > };
> > 
> > int main(void)
> > {
> >         printf("%d\n", sizeof(struct foo));
> >         return 0;
> > }
> > 
> > On i386 that prints 6, on ARM it prints 8.
> 
> Does it add 1 byte after a and and 1 after b or two after b?
> I suspect it's the latter case -- otherwise Gerrit's patch,
> which started this thread, wouldn't help solve his problem.
> Or the pad sizing follows complicated rules that I do not
> understand at the moment.

You're right, it adds the padding after b:

#define offsetof(TYPE, MEMBER)  __builtin_offsetof (TYPE, MEMBER)
printf("%d %d\n", offsetof(struct foo, a), offsetof(struct foo, b));

prints "0 3" on ARM.

> Time to look for an ARM emulator, it seems.

objdump -D -S is your friend. I didn't have an ARM target ready, but at
least I know enough ARM assembly that I can see what it will print :)


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
