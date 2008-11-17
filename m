From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix encode handling for site_{header,footer}
Date: Mon, 17 Nov 2008 11:40:44 +0100
Message-ID: <200811171140.45884.jnareb@gmail.com>
References: <87vdumbxgc.wl@vaj-k-334-sugi.local.valinux.co.jp> <7v8wrizlxo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tatsuki Sugiura <sugi@nemui.org>, git@vger.kernel.org,
	Gerrit Pape <pape@smarden.org>,
	"Recai =?utf-8?q?Okta=C5=9F?=" <roktas@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:42:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21Ye-0007n6-MB
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYKQKlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2008 05:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYKQKlA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:41:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:14792 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYKQKk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:40:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1119053nfc.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Od8y9j1YAefnEI/fdoDQOS9ENCqymxFM2zczCdDnT2Y=;
        b=mYt6Zx4C7Y2lQ8a6oOBC1+afRl+pnJxpceHIS6U51v6JEDBMRhjeQMNMTj19LwZsUc
         1rPUOnVh/i6mxBb38VPnwvUpqcz7pvF6XainxxWL8IsLU3KPeLA+xp0r6aazASyk6MnD
         lKXu+q9t++AsVR1mWx85fntDSj8R48AsAAERU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nEJRfCKMFckqtQwgozXAMyKSb1Da8rvEA2ShFmkVHMJ1XLNF7r+oie5fV60tWklMtx
         JU2QnpFrlGBKTDYxu+AmGPD3hzfKL3efPDYC6eL2TqMF6S2u63ajrCocg7RjgHGgUdea
         7RJqj2nRjlrHDbLUmSJcfyD3uk4D3zYhXY5AM=
Received: by 10.210.143.11 with SMTP id q11mr3788485ebd.146.1226918456663;
        Mon, 17 Nov 2008 02:40:56 -0800 (PST)
Received: from ?192.168.1.11? (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id 7sm4100567eyb.1.2008.11.17.02.40.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 02:40:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8wrizlxo.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101213>

On Mon, 17 Nov 2008, Junio C Hamano wrote:
> Tatsuki Sugiura <sugi@nemui.org> writes:
>=20
> > All non-ASCII chars of site_{header,footer} will be broken
> > by perl IO layer without decoding to utf8.
> >
> > Here is a fix to just call to_utf8 for inputs from these files.
> >
> > Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
>=20
> Looks good, thanks.

Hmmm... it is good _partial_ solution. I wonder if gitweb doesn't
have the same problem with per-project README.html file...

> > ---
> >  gitweb/gitweb.perl |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 933e137..79ca5c2 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2929,7 +2929,7 @@ EOF
> > =20
> >  	if (-f $site_header) {
> >  		open (my $fd, $site_header);
> > -		print <$fd>;
> > +		print map {to_utf8($_)} <$fd>;
> >  		close $fd;
> >  	}
> > =20
> > @@ -3018,7 +3018,7 @@ sub git_footer_html {
> > =20
> >  	if (-f $site_footer) {
> >  		open (my $fd, $site_footer);
> > -		print <$fd>;
> > +		print map {to_utf8($_)} <$fd>;
> >  		close $fd;
> >  	}
> > =20
> > --=20
> > 1.5.6.5

There was some patch by Recai Okta=C5=9F, or Gerrit Pape (or me)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4c104d2..8b5fcc1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -16,7 +16,7 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
-binmode STDOUT, ':utf8';
+use open qw(:std :utf8);
=20
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};


Then to_utf8() wouldn't be necessary. But I'd like for Perl experts to=20
check it first; for example this doesn't allow $fallback_encoding.

--=20
Jakub Nar=C4=99bski
Poland
