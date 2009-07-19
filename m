From: Jakub Narebski <jnareb@gmail.com>
Subject: ./configure misdetects SNPRINTF_RETURNS_BOGUS (was: [test failure] t4114 binary file becomes symlink)
Date: Sun, 19 Jul 2009 03:33:50 -0700 (PDT)
Message-ID: <m34ot9c67t.fsf_-_@localhost.localdomain>
References: <20090718134551.GC16708@vidovic>
	<20090718135649.GA6759@sigill.intra.peff.net>
	<20090718141658.GE16708@vidovic> <200907182106.06776.j6t@kdbg.org>
	<20090718201721.GF16708@vidovic> <20090718211345.GI16708@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Syzdek <david@syzdek.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Jul 19 12:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSTnu-0003ck-Na
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 12:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbZGSKd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 06:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZGSKdz
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 06:33:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:13602 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZGSKdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 06:33:54 -0400
Received: by fg-out-1718.google.com with SMTP id e21so485469fga.17
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hPFi0qCHv2N/muTfa1YhGxvoWAhKIPv8XR+PR0vjJU8=;
        b=x0KTNsiYM8EKoB6o6yeyBY4wU2eWkDhRyylkPqMLuhra/zS4j6Mltugo7vJk9JP/8f
         KOQ0x0E3X2MIkjUxwLLesbzgsY+Psh2BcT6yqlLByWSoAeGRydTejvyS5jo8YxqRlWdT
         QHnINlBmKX9pxxu8x9uzb5oj3o/fmpsJCOrdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WB4MTE++1EzKNWY9PQdE8rHjoE+uZatGuhk3UrRu3Y0ZdWR9qvb0asCXabRHwcoK82
         Zi9Qnr7bHnIWCQwl+Ky2q/yJrJQ1UsX1jNuL7rzszjFb1h17qj86q1NUuvyNduJzzMoB
         k+8L+h1sqC4T3WCNxvkSNA8xMwzJAm4P824qA=
Received: by 10.86.91.5 with SMTP id o5mr2564819fgb.32.1247999632166;
        Sun, 19 Jul 2009 03:33:52 -0700 (PDT)
Received: from localhost.localdomain (abwe24.neoplus.adsl.tpnet.pl [83.8.228.24])
        by mx.google.com with ESMTPS id e11sm6345795fga.1.2009.07.19.03.33.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 03:33:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6JAXm0j004961;
	Sun, 19 Jul 2009 12:33:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6JAXg1Z004956;
	Sun, 19 Jul 2009 12:33:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090718211345.GI16708@vidovic>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123548>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
 
> Hum, 'rm configure ; make configure ; ./configure' give
> 
>  checking whether snprintf() and/or vsnprintf() return bogus value... yes
> 
> WTF?

It looks like some recent bug in configure.ac, as I have run
./configure without "make configure" and it had

  NO_LIBGEN_H=@NO_LIBGEN_H@
  NEEDS_RESOLV=@NEEDS_RESOLV@

  SNPRINTF_RETURNS_BOGUS=

and when I did "rm configure ; make configure ; ./configure"
it gave me

  NO_LIBGEN_H=
  NEEDS_RESOLV=

  SNPRINTF_RETURNS_BOGUS=UnfortunatelyYes

I have tried to find which commit introduced this regression.

 $ git bisect start origin v1.6.3 v1.6.3.2 -- configure.ac config.mak.in
 $ git bisect run ~/git/test.sh

finds ecc395c (Makefile: add NEEDS_LIBGEN to optionally add -lgen to
compile arguments, 2009-07-10) as a first bad commit.  But I don't see
how it could have changed it... Strange...

CC-ed Brandon Casey, author of blamed changeset, and David Syzdek who
offered at some time help with maintaining autoconf.


P.S. Perhaps it is time for creating MAINTAINERS file for git?

-- >8 --
#!/bin/bash

rm -f configure &&
make configure  &&
./configure -q  &&
grep -q "^SNPRINTF_RETURNS_BOGUS=$" config.mak.autogen

# end of test.sh
-- 
Jakub Narebski
Poland
ShadeHawk on #git
