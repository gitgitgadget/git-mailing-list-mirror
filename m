From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] Support relative path in <blah>:path syntax
Date: Thu, 18 Nov 2010 08:47:01 +0700
Message-ID: <20101118014701.GA30452@do>
References: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
 <7vk4kbg7jz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 02:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PItbw-0008KW-PI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 02:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab0KRBsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 20:48:24 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57588 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0KRBsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 20:48:23 -0500
Received: by yxf34 with SMTP id 34so1579508yxf.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 17:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uSxmiZlh/7PzDhxw3IkUwH5w8AgFLpZBUzpMiXHZ3ec=;
        b=YvXXxWcGtkDwloXKiWzhxTwyThmzTlpVxf+fFtn/XrAKcd5w6k+Uv1nyJixYcZm6hS
         ywWoAzfnhsWY9OdhYoOnXg4D1tS6K9kEk7hGBbOF19aGZ1hHTZQkLXdjP4KIcp86nRFm
         gTVjwL7jRAc/iovoRteZ+ncI0x7CB0gETDVO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=emiEln3UY6D+x9fuAkx2Hd4qSACAr0IVg0zJnlh+czk+I7V2O0Nn1EbekbyXKyfF6O
         yyEO2g7RYJE1/yhESdi0ye3sTnfEoU4IklkAXToAEJyYh8VGT2f2lVQLanYCWCBeT0zx
         pdetcgaEt2WTAevCR7fE8FiUxwHA586FtnZ4M=
Received: by 10.100.211.8 with SMTP id j8mr6858721ang.127.1290044899235;
        Wed, 17 Nov 2010 17:48:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.199.2])
        by mx.google.com with ESMTPS id 6sm7053074anx.32.2010.11.17.17.48.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 17:48:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Nov 2010 08:47:01 +0700
Content-Disposition: inline
In-Reply-To: <7vk4kbg7jz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161644>

On Wed, Nov 17, 2010 at 09:54:08AM -0800, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > Sorry Jonathan I lied. I did not pick up your fast-import changes.
> > Could not find how to test it. And it seems fast-import only cares
> > about commits, not the target audience of this syntax.
> >
> > Document is not updated because I think it's intuitive enough.
>=20
> When you say <tree>:<path>, you would intuitively expect that the pat=
h is
> relative to <tree>, but this patch deliberately breaks (in a good way=
)
> that expectation by introducing a magic token "./".  Once you know th=
at
> "./" magic _exists_, it is obvious what it means, but people may not =
even
> imagine that such a magic may exist in the first place (certainly old
> timers won't), and would not know what the magic token is if you do n=
ot
> tell them.
>=20
> It needs to be documented.

OK. How about this, squashing in the last patch of this series?

--8<--
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3d4b79c..3fc3e8b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -121,6 +121,10 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DI=
R/packed-refs` file.
   ':path' (with an empty part before the colon, e.g. `:README`)
   is a special case of the syntax described next: content
   recorded in the index at the given path.
+  A path starting with './' or '../' is relative to current working di=
rectory.
+  The given path will be converted to be relative to working tree's ro=
ot directory.
+  This is most useful to address a blob or tree from a commit or tree =
that has
+  the same tree structure with the working tree.
=20
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path (e.g. `:0:README`); this names a blob obje=
ct in the
--8<--
