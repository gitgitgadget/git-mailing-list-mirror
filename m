From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: problem with setlocale trick in gettext.c
Date: Mon, 24 Sep 2012 21:08:57 +0700
Message-ID: <CACsJy8A+YvdGc6LM5baFqHoB91p6TAjQ9kKXuaPspvL--mfe0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:09:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG9Lu-0005nX-7T
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab2IXOJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 10:09:29 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54054 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab2IXOJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 10:09:28 -0400
Received: by ieak13 with SMTP id k13so10904253iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=w7cNYy3PCMzEmDDIEUeGJr30y8gErM6pRScdgcDghSI=;
        b=aC//6yGXbIxvvtfBAi6yvESW0hwYAdGHO+EObGneLOUwnX5dzJkLmV6FXUBet79we8
         a8zz+JZ0KV1dQjFGvfOiYqu64EgSYymGmpfUm3nh2JbrTJf1WUbXI9dwBgdOloOeJ28V
         +GmHcnIBruuvqE7ApouWPlAFUzplR88b8a6veM0FbuXhWTEk4kJj/dNgyoOeWySb8gzK
         M+bhICwNuRoEfExRpd09N/eHapug6HWI39+P1Vejb7mwqoneE0pt+GJWNn0PR2Z8QMAt
         Yhmqh5x/LZOXbXaLIaPyg/5IMYxs5ehboDPAEt8C4sBUHJB+O808S87tmlInSBCrOCXJ
         85eg==
Received: by 10.50.87.167 with SMTP id az7mr5378039igb.40.1348495768020; Mon,
 24 Sep 2012 07:09:28 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 07:08:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206272>

Hi,

I think the setlocale() trick in init_gettext_charset() messes up
locale support from library. Currently I get

fatal: Could not switch to '/foo/': Kh?ng c? t?p tin ho?c th? m?c nh? v=
?y

The question marks are what I actually see. The point here is to call
strerrno(), which should return a l10n string. With this patch

diff --git a/gettext.c b/gettext.c
index 71e9545..eeb88c5 100644
--- a/gettext.c
+++ b/gettext.c
@@ -115,7 +115,7 @@ static void init_gettext_charset(const char *domain=
)
        setlocale(LC_CTYPE, "");
        charset =3D locale_charset();
        bind_textdomain_codeset(domain, charset);
-       setlocale(LC_CTYPE, "C");
+       //setlocale(LC_CTYPE, "C");
 }

 void git_setup_gettext(void)

I get correct output again

fatal: Could not switch to '/foo/': Kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin =
ho=E1=BA=B7c th=C6=B0 m=E1=BB=A5c nh=C6=B0 v=E1=BA=ADy

Anybody knows how this happens?
--=20
Duy
