From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] git-instaweb: Wait for server to start before running  web browser
Date: Fri, 28 May 2010 21:58:55 +0200
Message-ID: <201005282158.57998.jnareb@gmail.com>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com> <1275073885-26537-3-git-send-email-jnareb@gmail.com> <AANLkTilpiwy2NFhOycoMBeYZFZDuVN5yFt8nIiIoYTjL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 21:57:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI5g1-0001aH-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab0E1T47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 15:56:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:19544 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab0E1T46 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 15:56:58 -0400
Received: by fg-out-1718.google.com with SMTP id l26so747213fgb.1
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+OqlnCfPMGv/4/X/T2GZCYLrsTi9qRZ5l77VZ6XeKjs=;
        b=pQnA+m6mMJmhlvoxD0Ddck3XUrBWPvLTpc3WTCBL0yzHrWfHxEERqFvK/H9gGuoUHD
         SpVpVB6CMniPkeO7/CYG1r0LISUR8L+M2e9JOxyrtyvIKeci7O8xI2Ca1FsYx5aFNOrB
         ZLpzaIvX2SQtkXrX8kvo67jVfi9egw4d/9bts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WlY9aZcqNKyxZpWhCdbhJWkFIzqNhkpXjUyCC3J4x9DT9AYh9158Lx2syQrhc3q4X1
         GjdKFrTe3RBryMmzvdaW6zURSFunyaw7D5P3P/0iHAUB4cRmtOqL+mXFw9fFFprDsc/j
         nhKhCxkxv4xtjRawUsRsX9M+n50xRo0b3tvAo=
Received: by 10.87.70.7 with SMTP id x7mr3304412fgk.77.1275076616325;
        Fri, 28 May 2010 12:56:56 -0700 (PDT)
Received: from [192.168.1.15] (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 19sm4098956fkr.39.2010.05.28.12.56.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 12:56:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilpiwy2NFhOycoMBeYZFZDuVN5yFt8nIiIoYTjL@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147936>

On Fri, 28 May 2010, Pavan Kumar Sunkara wrote:
> Jakub Narebski wrote;
> >
> > It uses IO::Socket::INET module, which is core Perl module since v5=
=2E6.0.
>=20
> Core module means it will be installed by default in v5.6. But what
> happens in case of lower versions of Perl?

Gitweb itself requires even higher version of Perl for its utf-8
support: at least v5.8.0 for Encode module, and IIRC at least v5.8.3
or even v5.8.6 for correct handling of utf-8.

Perl v5.8.6 was released in 2006.

>=20
> > +httpd_is_ready () {
> > + =A0 =A0 =A0 "$PERL" -MIO::Socket::INET -e "
> > +local \$| =3D 1; # turn on autoflush
> > +exit if (IO::Socket::INET->new('127.0.0.1:$port'));
> > +print 'Waiting for \'$httpd\' to start ..';
> > +do {
> > + =A0 =A0 =A0 print '.';
> > + =A0 =A0 =A0 sleep(1);
> > +} until (IO::Socket::INET->new('127.0.0.1:$port'));
> > +print qq! (done)\n!;
> > +"
> > +}
> > +
>=20
> One of the solution is to add a web server specific branch in httpd_i=
s_ready().
> So, if the server is plackup it load the module and checks the port,
> if not it will just continue.
>=20
> Just an idea for a common usage.

The above solution is universal, and works for any web server. =20

We can add web server specific branch in httpd_is_ready() to use e.g.=20
server_startup hook (and some blocking mechanism) for server(s) which
support it.

--=20
Jakub Narebski
Poland
