From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] diff: support --cached on unborn branches
Date: Sun, 31 Oct 2010 10:24:13 +0700
Message-ID: <20101031032413.GA27346@do>
References: <7vhbg56i9s.fsf@alter.siamese.dyndns.org>
 <1288437377-30405-1-git-send-email-pclouds@gmail.com>
 <7vwroz3vj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 04:28:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCOaa-0001zv-Lb
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 04:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab0JaDYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 23:24:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56786 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab0JaDYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 23:24:14 -0400
Received: by gxk23 with SMTP id 23so2649178gxk.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uBaUd86s2u/gpfXuBdR+rseeXkcx4ZQiiAiA+g7FbgE=;
        b=gAz3h6sk1mCQiaEv3tras5VIGJg9f6UB98YHgiAr7GoeDRwRxxkjsaLf/7Bg+j2Gr6
         BiKKOvAWDz1tLhRVGS7G/olnOhydePtdh93G7710BhmeWRm3M79jCU3BqKkxfjoJ7+cg
         uLElGEyVXW5DgGQ+wBurmpB0Zvw+jhe8c88LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wcBQEO4Et8RhWZRVfqQ9XJpFPNoZ9hFVtm+D5j4v3+667qNPcrRMjw4Tl/B8OMsoin
         p5F8NS1cyChoM/bn9zq0y3YxTnUakQy7SCR/zrMVSRTTwoLmz53Rm2QP3Hy+jlqzTMO5
         bFnsvkB+stLgPEBQm9aFVSE5evvKYYn6ZViEs=
Received: by 10.151.78.6 with SMTP id f6mr12271489ybl.404.1288495453933;
        Sat, 30 Oct 2010 20:24:13 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id k2sm856183ybj.20.2010.10.30.20.24.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 20:24:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 31 Oct 2010 10:24:13 +0700
Content-Disposition: inline
In-Reply-To: <7vwroz3vj8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160410>

On Sat, Oct 30, 2010 at 08:12:27PM -0700, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > "git diff --cached" (without revision) used to mean "git diff --cac=
hed
> > HEAD" (i.e. the user was too lazy to type HEAD). This "correctly"
> > failed when there was no commit yet. But was that correctness usefu=
l?
> >
> > This patch changes the definition of what particular command means.
> > It is a request to show what _would_ be committed without further "=
git
> > add". The internal implementation is still the same "git diff
> > --cached HEAD" when HEAD exists, but when there is no commit yet, i=
t
> > compares the index with an empty tree object to achieve the desired
> > result.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>=20
> Will take a look at it, and queue.  Thanks.
>=20
> >  "git diff --cached HEAD" does fail, but I don't really care.
>=20
> I _do_ care, and so should you.  And I think it _should_ fail, if the=
 user
> explicitly asked to compare the index with HEAD that does not exist y=
et.
>=20
> As we are updating the semantics of a Porcelain command, there should=
 be
> an update that explains the new usage in the documentation, no?

Yes.

--8<--
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index dd1fb32..518e46b 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -32,7 +32,9 @@ directories. This behavior can be forced by --no-inde=
x.
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
-	do not give <commit>, it defaults to HEAD.
+	do not give <commit>, it defaults to HEAD. If HEAD does
+	not exist (e.g. unborn branches) and <commit> is not
+	given, it shows all staged changes.
 	--staged is a synonym of --cached.
=20
 'git diff' [--options] <commit> [--] [<path>...]::
--8<--
--=20
Duy
