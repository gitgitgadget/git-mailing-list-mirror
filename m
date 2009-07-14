From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: git-am: less strong format "mbox" detection
Date: Tue, 14 Jul 2009 10:20:59 +0200
Message-ID: <20090714082059.GA13808@vidovic>
References: <bb3a84e2b817268a88832dc7043383e4b91a3df3.1247553623.git.ni.s@laposte.net> <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:21:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdGe-0006jw-9K
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZGNIVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 04:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZGNIVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:21:09 -0400
Received: from ey-out-1920.google.com ([74.125.78.149]:24741 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZGNIVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 04:21:07 -0400
Received: by ey-out-1920.google.com with SMTP id 3so541078eyh.36
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3XJaNr/KoIRiGcxXSvqGBclDS3cuM6bTYBUvjSEGLDM=;
        b=jyhEGbXtp8rsplRe8eW9DGiF2WtetuuQBqK0tzCmfFyvx4tgrIQisc0ZMtVodKANQa
         XUgAKkGQJ+qju6Gspv80gFkFYlO0zI6yGl0EHL/u26b9QEp/2fbDEJaIUiSDC+Lw0tuz
         Lyv51xcfwFOXisxsGTAfKuVIRQ+0rONZy0eRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wpa1Ek+vO2gEq+tQTZO6GsvOuanTH8/xuchQCNM51SgH4Y1NyHXcqHtsI/x5XeEfbB
         WprdeP/5IelZ32vzH0n/fxec7vn6+xhmj5yX0fqn9b1opx0wS0S7c6/pfkv5lOUx4pMj
         4j97K96MKEck4Sa+M3kd8xfRgFYk2/jM75g+k=
Received: by 10.210.13.12 with SMTP id 12mr7364150ebm.98.1247559665094;
        Tue, 14 Jul 2009 01:21:05 -0700 (PDT)
Received: from @ (91-165-132-96.rev.libertysurf.net [91.165.132.96])
        by mx.google.com with ESMTPS id 5sm2179734eyh.50.2009.07.14.01.21.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 01:21:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0907140016r4807c008h9c98f76200e9c3a5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123226>

Le 14/07/09, Giuseppe Bilotta a =E9crit :

> > diff --git a/git-am.sh b/git-am.sh
> > index d64d997..d10a8e0 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -169,7 +169,7 @@ check_patch_format () {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read l2
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read l3
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$l1" in
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "From "* | "From: "*)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "From "* | "From: "* | "X-Account-Key=
:"* | "Return-Path:"* | "Delivered-To:"*)
>=20
> Nitpick: for consistency, should we either expect a space after the
> colon also in the new keys, or not expect i in the From: key either. =
I
> don't think the RFC requires a space, but most clients probably add
> it.

RFC 822 says:
    =20
" 3.4.2. WHITE SPACE
    =20
  Note:  In structured field bodies, multiple linear space ASCII
         characters  (namely  HTABs  and  SPACEs) are treated as
         single spaces and may freely surround any  symbol.   In
         all header fields, the only place in which at least one
         LWSP-char is REQUIRED is at the beginning of  continua-
         tion lines in a folded field.
"

A trailing space after the colon is not required. I'll remove it and
resend a patch.

And why should we accept "From "?

--=20
Nicolas Sebrecht
