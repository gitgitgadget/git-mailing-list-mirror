From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] imap-send: link against libcrypto for HMAC and others
Date: Mon, 6 Dec 2010 00:06:28 -0600
Message-ID: <20101206060628.GA30188@burratino>
References: <7vwro2sd83.fsf@alter.siamese.dyndns.org>
 <1290629033-20566-1-git-send-email-flameeyes@gmail.com>
 <1291613304.3339.12.camel@fixed-disk>
 <1291613978.4756.157.camel@yamato.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Diego Elio =?utf-8?Q?Petten=C3=B2?= <flameeyes@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 07:06:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPUDz-0006tJ-0u
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 07:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab0LFGGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 01:06:54 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:41522 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab0LFGGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 01:06:53 -0500
Received: by gwb20 with SMTP id 20so6204462gwb.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 22:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fq5R4tOJ+q3IAOB2aqiQMJPRr7Me0nli+fQbPjxY09o=;
        b=spWO8mzMbCKWw+QFP4ZPPzFl68ddPGuHHKvMbdp9zDl3u+Vo062a0mIJ2MrhvOToek
         vhGLrHvNbc1fapiF0yjaWzMhhzh5INxtxsKjmlGHeEwYIN2qDJaS0/XofUPBr1gJY3iu
         XCkz6npx7cMny/1cLU40Zq8OwBcqxWB0Y5kwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X/7L5MpAOHaAdKDlnFJrgYLToGAihRF3Wy6Q6J6KpBKz3TjCvf7GPYsv/+G/Ezp99W
         ccVJDW0osVaAYuZAmuWTc2eMqYaPc6OlU5ZkZL4jRJ4HZYJxa4CvRryXn7E1wq1hYO7T
         mx9zRVpOUCV+022Jc4wAahqlRONeeKgWg3bVI=
Received: by 10.150.202.7 with SMTP id z7mr8519277ybf.384.1291615611727;
        Sun, 05 Dec 2010 22:06:51 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id t38sm2905329yhg.9.2010.12.05.22.06.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 22:06:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291613978.4756.157.camel@yamato.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162975>

Diego Elio Petten=C3=B2 wrote:
> Il giorno lun, 06/12/2010 alle 00.28 -0500, Anders Kaseorg ha scritto=
:

>> Also, the Makefile already has a NEEDS_CRYPTO_WITH_SSL flag that=E2=80=
=99s
>> automatically set on Darwin, Windows, and MinGW.  We shouldn=E2=80=99=
t have two
>> mechanisms for addressing the same problem; maybe we just need to en=
able
>> the existing flag on more (or all) platforms?
>
> No, these should be different issues

Are you sure?  The change description for v1.6.5-rc1~23 (Makefile: Add
NEEDS_CRYPTO_WITH_SSL, 2009-10-08) says:

    The Makefile comment for NEEDS_SSL_WITH_CRYPTO says to define it "i=
f
    you need -lcrypto with -lssl (Darwin)."  However, what it actually
    does is add -lssl when you use -lcrypto and not the other way aroun=
d.
    However, libcrypto contains a majority of the ERR_* functions from
    OpenSSL (at least on OS X) so we need it both ways.

and grepping that version reveals the same hit I think your patch
deals with:

 $ git grep -F -e ERR_ v1.6.5-rc1~23
 v1.6.5-rc1~23:imap-send.c:      fprintf(stderr, "%s: %s\n", func, ERR_=
error_string(ERR_get_error(), NULL));

I am guessing the reality is closer to:

    Previously we relied on -lssl pulling in libcrypto on most
    platforms.  That has at least three problems:

     (1) it is not resiliant against future changes in libssl.
         The DT_NEEDED entries in a library are generally
         considered an implementation detail that is allowed to
         change.

     (2) it does not work on all platforms; for example, ld on
         Mac OS X and ld --no-copy-dt-needed-entries on Linux
         do not permit that trick.

     (3) it is tricky.  A simple rule is "explicitly link to
         all libraries whos symbols you use directly".

    To fix this, eliminate the NEEDS_CRYPTO_WITH_SSL knob and
    always treat it as true.  NEEDS_SSL_WITH_CRYPTO can stay
    because there really are differences between platforms
    for that one.

Warning: I could be totally wrong. :)  I have not verified any
of these claims.
