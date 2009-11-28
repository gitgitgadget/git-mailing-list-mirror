From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] Makefile: fix .s pattern rule dependencies
Date: Sat, 28 Nov 2009 05:37:09 -0600
Message-ID: <20091128113709.GD10059@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELQG-0002Jp-7s
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZK1LYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2009 06:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZK1LYx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:24:53 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35659 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbZK1LYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:24:52 -0500
Received: by yxe26 with SMTP id 26so1865882yxe.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IKl2oLfKavUFIvHTPMFcPfNewaH3anhA3L9OAyWyKsw=;
        b=Y0BWpQKINMd99VYq3N83UfYHvN2rIi02BhKguzI+UHFr24g0ooqnqaA2MOoPxR9lJi
         a3rRJHLGs5JUQk+Z90Fb2MRsdC4HSTHphDtkTU1VfsgX05y3RmlVpO621J13HOfeo0vR
         AYM2EjSBXz24JZFLP6Jf1kNtK5b/w8OmzAkTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fcBGn4o+Rlg7qPOYHMHwJnBBkxP2kolcV3+//NyOcWsQxDFzGKyWlqh271rMahFSn2
         gHF0OkpY4/Bu6KRZF59HQfYZ/H4HSbrqaev1j8BRm4A+8PCuvZyk+Bl0GEWDKkGFIyAp
         ZkJRoZS7PJ/1aJ4oSUaqzfUoqTRuS9X6rxNqc=
Received: by 10.150.21.3 with SMTP id 3mr3340453ybu.210.1259407498659;
        Sat, 28 Nov 2009 03:24:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm563350gxk.9.2009.11.28.03.24.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:24:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128112546.GA10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133953>

'make git.s' fails to regenerate an assembler listing if git.c
has not changed but a header it includes has.  The %.s: %.c
pattern rule is meant to be invoked by hand, so it would be
better to make it always run.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This adds yet another phony .FORCE-foo target.  Wouldn=E2=80=99t it be =
simpler
to use a single target called .FORCE, or is there something I am
missing that that would break?

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bb3879e..cd210e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1524,7 +1524,7 @@ git.o git.spec \
=20
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
-%.s: %.c GIT-CFLAGS
+%.s: %.c GIT-CFLAGS .FORCE-LISTING
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
@@ -1859,7 +1859,7 @@ endif
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
-.PHONY: .FORCE-GIT-BUILD-OPTIONS
+.PHONY: .FORCE-GIT-BUILD-OPTIONS .FORCE-LISTING
=20
 ### Check documentation
 #
--=20
1.6.5.3
