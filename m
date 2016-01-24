From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 06/19] mingw: try to delete target directory before renaming
Date: Sun, 24 Jan 2016 17:42:34 -0000
Organization: OPDS
Message-ID: <4C2ED807DD184A168C87221809034B70@PhilipOakley>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <d75b0dc0b76beefee9e705555ca4f2fa4f4b96ce.1453650173.git.johannes.schindelin@gmx.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "nalla" <nalla@hamal.uberspace.de>
To: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 18:42:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNOgS-0005Mq-O0
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 18:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbcAXRmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 12:42:37 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:62578 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752149AbcAXRmg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2016 12:42:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AFCgC/DKVWPMHNYAJeGQEBAQELAQIBAQECgwpSbYZfbYELr3ZsgxcehWsEAoEdTQEBAQEBAQcBAQEBQSQbhDwGAQEECAEBKAEFHgEBIQsCAwUCAQECFQwlFAEEGgYHAxQGARIIAgECAwGHdQMWkHSjNYgrDB6GMoRtgkmBUAIRAYNKgQ8FlnYBgTmEDJcJjj+ESzwuAYYCCReBGQEBAQ
X-IPAS-Result: A2AFCgC/DKVWPMHNYAJeGQEBAQELAQIBAQECgwpSbYZfbYELr3ZsgxcehWsEAoEdTQEBAQEBAQcBAQEBQSQbhDwGAQEECAEBKAEFHgEBIQsCAwUCAQECFQwlFAEEGgYHAxQGARIIAgECAwGHdQMWkHSjNYgrDB6GMoRtgkmBUAIRAYNKgQ8FlnYBgTmEDJcJjj+ESzwuAYYCCReBGQEBAQ
X-IronPort-AV: E=Sophos;i="5.22,341,1449532800"; 
   d="scan'208";a="606452455"
Received: from host-2-96-205-193.as13285.net (HELO PhilipOakley) ([2.96.205.193])
  by out1.ip03ir2.opaltelecom.net with SMTP; 24 Jan 2016 18:22:37 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284687>

=46rom: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>From: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>

Is this Nalla's preferred email, or just a carry over from cautions of =
the=20
Github interface?

>
>When the rename() function tries to move a directory it fails if the
>target directory exists. It should check if it can delete the (possibl=
y
>empty) target directory and then try again to move the directory.
>
>This partially fixes t9100-git-svn-basic.sh.
>
>Signed-off-by: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>
>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>---
>compat/mingw.c | 7 ++++++-
>1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/compat/mingw.c b/compat/mingw.c
>index db92f5d..e4839b9 100644
>--- a/compat/mingw.c
>+++ b/compat/mingw.c
>@@ -1603,7 +1603,12 @@ repeat:
>  if (gle =3D=3D ERROR_ACCESS_DENIED &&
>      (attrs =3D GetFileAttributesW(wpnew)) !=3D INVALID_FILE_ATTRIBUT=
ES) {
>  if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
>- errno =3D EISDIR;
>+ DWORD attrsold =3D GetFileAttributesW(wpold);
>+ if (attrsold =3D=3D INVALID_FILE_ATTRIBUTES ||
>+     !(attrsold & FILE_ATTRIBUTE_DIRECTORY))
>+ errno =3D EISDIR;
>+ else if (!_wrmdir(wpnew))
>+ goto repeat;
>  return -1;
>  }
>  if ((attrs & FILE_ATTRIBUTE_READONLY) &&
>--=20
>2.7.0.windows.1.7.g55a05c8
--
Philip
