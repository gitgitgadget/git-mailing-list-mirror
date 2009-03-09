From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Sun, 8 Mar 2009 22:22:07 -0400
Message-ID: <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 03:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgV9X-000842-AI
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 03:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZCICWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 22:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbZCICWK
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 22:22:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:26237 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZCICWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 22:22:09 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1419711rvb.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FKZL/30K2ZXqwxAkxvCvOscKHvxub5wqgsnlC3CcFcM=;
        b=PyTt2FQJp58Hz4WzqNF39rDyptVHLczXQB1txG9NwZ+j8uTSaVZCAX8urMl7cvBH3i
         YEE63fOL0xUaG5W3uLe0AS9UWNOEvLDCuW9AZVbEMp9gjEWPalplcRcAxmseLW5L9/O5
         1j6SJsH34XCPRl82VqO1xvmIIrRGIA1oW3jWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C3d0AOBs5urN0uAnG2uZuns816ouQXJ52v190YUBdkPp9yQyXggsjH0+mc1jlq2Wl3
         mNAWYyCGDmC/8fi7pRH6nd9/6RPhRdY4zqWUjm1qhU0u0ghcA8KBb79PIPBxSV1lw6P8
         vwzFb5Uieo9t2CHoP/La7Z6s/FCxvw8nSuo+Y=
Received: by 10.141.86.4 with SMTP id o4mr2778343rvl.172.1236565327932; Sun, 
	08 Mar 2009 19:22:07 -0700 (PDT)
In-Reply-To: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112670>

On Sun, Mar 8, 2009 at 9:15 PM, Brian Gernhardt
<benji@silverinsanity.com> wrote:
> On OS X the printf specifier "%.0s" outputs the entire string instead
> of 0 characters as POSIX states.

Does not reproduce for me:

$ cat foo.c && gcc -m64 foo.c -o foo32 && gcc foo.c -o foo64 && file
foo32 foo64 && ./foo32 && ./foo64
#include "stdio.h"
#include "stdlib.h"
main() {
	printf("1 '%.0s'\n", "foobar");
	printf("2 '%.*s'\n", 0, "foobar");
	exit(0);
}
foo32: Mach-O 64-bit executable x86_64
foo64: Mach-O executable i386
1 ''
2 ''
1 ''
2 ''

OS X 10.5.6 (Darwin 9.6.0). i686-apple-darwin9-gcc-4.0.1. Same linkage for both:

/usr/lib/libgcc_s.1.dylib (compatibility version 1.0.0, current version 1.0.0)
/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current
version 111.1.3)

j.
