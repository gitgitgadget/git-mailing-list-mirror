From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse parent..current syntax from pathinfo
Date: Sun, 5 Oct 2008 10:19:39 +0200
Message-ID: <200810051019.39702.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com> <200810040331.27605.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 10:42:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPBr-0003tn-0O
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 10:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYJEITt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2008 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYJEITt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 04:19:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:52126 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbYJEITr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 04:19:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so859935nfc.21
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xM2CT0C5oNOXV7pImQNrWiB51u5ZFnw54SKvomCMpHU=;
        b=CtIlsoy7t+fGH67jmyOtby0i9JMl/FnwfzBrTIVFSUa+WjNWwSEhdNK1jVxFvOjtxG
         9mIPyyuuszcVInIPVPNbHBTRF3sQzcFRDuTgtCvFiB7FyiUqJETfxBL49ywtjkoPgYBj
         xddZ4pCp5c6JIbB+ovh+7oTRyZnAde3BjMTSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tM1rqr2BeymTqMOs0kBaUe+R4HehiODO9AjBWmjfJVg3pdHVUp+13lycSKExhFh4L5
         y0EX2TLbu+RZgEfMnDVKF3moXG5yCL95LTaMyi2u/4bfJgKG5XRk54X4VOwo2HVDQQlq
         EASIWYC21ENLThK5QdEfSEPO8BQ8pmogqottI=
Received: by 10.210.77.2 with SMTP id z2mr4254696eba.158.1223194785404;
        Sun, 05 Oct 2008 01:19:45 -0700 (PDT)
Received: from ?192.168.1.11? (abxa221.neoplus.adsl.tpnet.pl [83.8.250.221])
        by mx.google.com with ESMTPS id 5sm8885255eyf.8.2008.10.05.01.19.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 01:19:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810040331.27605.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97499>

On Sun, 4 Oct 2008, Jakub Narebski wrote:
> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 3e5b2b7..89e360f 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -534,7 +534,9 @@ if ($path_info && !defined $action) {
> > =A0
> > =A0# we can now parse ref and pathnames in PATH_INFO
> > =A0if ($path_info) {
> > -=A0=A0=A0=A0=A0my ($refname, $pathname) =3D split(/:/, $path_info,=
 2);
> > +=A0=A0=A0=A0=A0$path_info =3D~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?=
$/;
> > +=A0=A0=A0=A0=A0my ($parentrefname, $parentpathname, $refname, $pat=
hname) =3D (
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$2, $4, $5, $7);
>=20
> Style: I would use (but that is perhaps matter of taste)
>=20
> +=A0=A0=A0=A0=A0=A0=A0my ($parentrefname, $parentpathname, $refname, =
$pathname) =3D
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0($2, $4, $5, $7);
>=20
> Also it would be I think simpler to use instead non-catching grouping=
,
> i.e. (?: xxx ) extended pattern (see perlre(1)), and use=20
> ($1, $2, $3, $4), or even simpler =A0'list =3D (string =3D~ regexp)' =
=A0form. =A0

Alternate solution would be to use split(..., ..., 2), but I think you
got the regular expression right.  Just mentioning...

--=20
Jakub Narebski
Poland
