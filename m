From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] Quick hack to avoid double qp encoding
Date: Wed, 10 Jan 2007 21:37:35 +0100
Message-ID: <17829.20111.652000.250228@lapjr.intranet.kiel.bmiag.de>
References: <17829.12657.814000.514351@lapjr.intranet.kiel.bmiag.de>
	<11684596371612-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 10 21:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4kD0-0005p0-0t
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 21:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbXAJUiB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 10 Jan 2007 15:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbXAJUiB
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 15:38:01 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:57116 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965090AbXAJUiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 15:38:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id F3D613AED7;
	Wed, 10 Jan 2007 21:37:57 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18203-04; Wed, 10 Jan 2007 21:37:57 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 74F673AED2;
	Wed, 10 Jan 2007 21:37:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id B85D93ADC8;
	Wed, 10 Jan 2007 21:37:53 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 23558-02; Wed, 10 Jan 2007 21:37:48 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 2990B3ADC6;
	Wed, 10 Jan 2007 21:37:46 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <11684596371612-git-send-email-j.ruehle@bmiag.de>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36530>

Juergen Ruehle writes:
 > From: J=C3=BCrgen_R=C3=BChle <j-r@online.de>
                ^

Ok, i should have also reverted the ' ' to '_' conversion, but it
seems that send-email is to blame, because it simply copies the
(possibly) QP encoded author address into the body of a (possibly) not
QP encoded message.

 > Signed-off-by: J=C3=BCrgen R=C3=BChle <j-r@online.de>
 > ---
 >  This is just a hack since I know next to nothing about perl.
 >=20
 >  git-send-email.perl |    1 +
 >  1 files changed, 1 insertions(+), 0 deletions(-)
 >=20
 > diff --git a/git-send-email.perl b/git-send-email.perl
 > index ba39d39..a4a22d3 100755
 > --- a/git-send-email.perl
 > +++ b/git-send-email.perl
 > @@ -555,6 +555,7 @@ foreach my $t (@files) {
 >  	}
 >  	close F;
 >  	if (defined $author_not_sender) {
 > +		$author_not_sender =3D~ s/=3D\?utf-8\?q\?([^?]*)\?=3D/my $bla =3D=
 $1; $bla =3D~ s|=3D([0-9a-fA-F]{2})|sprintf '%c', hex($1)|eg; $bla/eg;

+		$author_not_sender =3D~ s/=3D\?utf-8\?q\?([^?]*)\?=3D/my $bla =3D $1=
; $bla =3D~ s|_| |g; $bla =3D~ s|=3D([0-9a-fA-F]{2})|sprintf '%c', hex(=
$1)|eg; $bla/eg;

 >  		$message =3D "From: $author_not_sender\n\n$message";
 >  	}
 > =20
 > --=20
 > 1.5.0.rc0.g525e
