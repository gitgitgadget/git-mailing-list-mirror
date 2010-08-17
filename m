From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/5] compat/regex: get the gawk regex engine to compile within git
Date: Tue, 17 Aug 2010 09:24:39 +0000
Message-ID: <1282037082-12996-3-git-send-email-avarab@gmail.com>
References: <20100817080322.GA28476@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIRN-0001Ud-90
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab0HQJ0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:26:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47361 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab0HQJ0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:09 -0400
Received: by wyb32 with SMTP id 32so6801577wyb.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=y0r91rnGigFSkdXo1Gakn3P3opri3Utd2nnFJM3x+FU=;
        b=SiwctP6ddMI/9hu1eA0422061fRBPJj4q60dXAqLyA5zbncI1FOXQXW9SqKjZOdm0u
         PvdZz13XK3Wzs5o8ntoxm+WIlsTP2xRRqY9GGR2z8V/D5QLZRi3bzjQoCy0RI17LpOgL
         aXWmxF+vkNXOZdRp5Q5kuqJZ3QMtviqrraqFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Blv+7SxVQYRR6OKXPmjlZ5RJUyXSHUIH0hFZQggVn42MS/v2hWPlwYhzpZ9Yfx7erB
         J3Hr6uq0SA8y45RtxFYY5HJlM/DcgP4TcWgpfVl8Uh88YwTXhf6W0oSJJkNrBSAkuowr
         0uK2LuYjh4EHO+zyXOKxw+HPDkUvPN8FZPpIU=
Received: by 10.216.196.160 with SMTP id r32mr5483593wen.36.1282037168144;
        Tue, 17 Aug 2010 02:26:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm3916254weq.33.2010.08.17.02.26.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:26:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <20100817080322.GA28476@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153740>

We need to define -DGAWK -DNO_MBSUPPORT so that the gawk regex engine
will compile, and include stdio.h and stddef.h in regex.h. Gawk itself
includes these headers before it includes the regex.h header.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile             |    4 ++++
 compat/regex/regex.h |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4745a5..23a9f0d 100644
--- a/Makefile
+++ b/Makefile
@@ -1879,6 +1879,10 @@ ifdef NO_EXPAT
 http-walker.s http-walker.o: EXTRA_CPPFLAGS =3D -DNO_EXPAT
 endif
=20
+ifdef NO_REGEX
+compat/regex/regex.o: EXTRA_CPPFLAGS =3D -DGAWK -DNO_MBSUPPORT
+endif
+
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS)
=20
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index de93327..61c9683 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <stddef.h>
+
 /* Definitions for data structures and routines for the regular
    expression library.
    Copyright (C) 1985,1989-93,1995-98,2000,2001,2002,2003,2005,2006,20=
08
--=20
1.7.2.1.389.gc3d0b
