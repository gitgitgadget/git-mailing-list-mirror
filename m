From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.1 3/4 (amend)] gitweb: File based caching layer (from git.kernel.org)
Date: Sun, 28 Nov 2010 12:31:46 +0100
Message-ID: <201011281231.46786.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011130056.24222.jnareb@gmail.com> <201011281223.03141.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 12:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMfU8-00068z-G9
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 12:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab0K1Lby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 06:31:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57651 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab0K1Lby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 06:31:54 -0500
Received: by bwz15 with SMTP id 15so3073887bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XcNsbQtKv97XGgqpiOnsJrFvm5oRujABwCWbkXnTwyw=;
        b=AvlchiORsl7F1jO7jLFaGF8OY3W8bJe+CduyBMblhqDg3+I8dzkYVa7iflimwDM2on
         GaGkAhF9dXpmX+E3OEQ+sfiZ4qTzG2S6UbBhz3RunX4uxS+FqKbL2+asOKQUGr3M8z8C
         q4M6JaEB71RTZoGKF5MfX8PSqvEKLZ8cUny0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NDeC/bioL1/Mnfe/Tbf/kJqera2poS+RoA1EMb1BKtz1/tb2T0LC3UWIpFODHaachD
         GkqIa17oIJams7ePIMzUefrDjkBzhgjiyigrA9tcBlJBrF5GlW6gjPD0ZI1nOK5iQG+P
         +QBfKY0ZsHYIout7zX0JsF4zKhZd9sW7+G4bQ=
Received: by 10.204.77.15 with SMTP id e15mr3734955bkk.45.1290943911683;
        Sun, 28 Nov 2010 03:31:51 -0800 (PST)
Received: from [192.168.1.13] (abwq157.neoplus.adsl.tpnet.pl [83.8.240.157])
        by mx.google.com with ESMTPS id b17sm1425096bku.8.2010.11.28.03.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 03:31:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201011281223.03141.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162340>

On Sun, 28 Nov 2010, Jakub Narebski wrote:
> On Sat, 13 Nov 2010, Jakub Narebski wrote:
>=20
> > +sub cacheUpdate {
> > +=A0=A0=A0=A0=A0=A0=A0my ($action,$areForked) =3D @_;
> > +=A0=A0=A0=A0=A0=A0=A0my $lockingStatus;
> > +=A0=A0=A0=A0=A0=A0=A0my $fileData =3D "";
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if($backgroundCache){
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0open(cacheFileBG, '>:=
utf8', "$fullhashpath.bg");
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $lockStatBG =3D fl=
ock(cacheFileBG,LOCK_EX|LOCK_NB);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$lockStatus =3D $lock=
StatBG;
> > +=A0=A0=A0=A0=A0=A0=A0}else{
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0open(cacheFile, '>:ut=
f8', \$fullhashpath);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 ^^^^^^^^^^^^^^
>=20
> I have made mistake with this line when moving $caching_enabled check
> out of cache_fetch to its caller.
>=20
> Reusing $fullhashpath variable as a *capture buffer* (it has nothing
> to do with path; it is not a filename no longer) wouldn't help there.

Errr... I meant that this abuse didn't help avoiding my mistake.

--=20
Jakub Narebski
Poland
