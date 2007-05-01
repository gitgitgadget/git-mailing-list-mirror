From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Wed, 2 May 2007 00:48:53 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705020048.53853.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <7v8xc85ill.fsf@assigned-by-dhcp.cox.net> <200705020044.47171.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 23:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0Bu-0003M9-9t
	for gcvg-git@gmane.org; Tue, 01 May 2007 23:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945962AbXEAVrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 17:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945976AbXEAVrT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 17:47:19 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:37478 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1945962AbXEAVrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 17:47:18 -0400
Received: from southpark.local (unknown [85.101.46.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id E84785FA4EC7;
	Wed,  2 May 2007 00:47:08 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200705020044.47171.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45982>

On Wednesday 02 May 2007 00:44:46 you wrote:
> On Wednesday 02 May 2007 00:39:34 you wrote:
> > Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > > Ok found out the reason. decode() tries to decode data that is al=
ready
> > > UTF-8 and borks.
> > >
> > > This is from Encode.pm :
> > >
> > > sub decode_utf8($;$) {
> > >     my ( $str, $check ) =3D @_;
> > >     return $str if is_utf8($str); <--- Checks if the $str is alre=
ady
> > > UTF-8 if ($check) {
> > >         return decode( "utf8", $str, $check ); <--- Else do what =
gitweb
> > > does [...]
> > >
> > > So my patch is indeed correct.
> >
> > Ok, I think that makes it an improvement from the current code,
> > so I'd apply.
> >
> > But at the same time I wonder why should the callers be feeding
> > an already decoded string to to_utf8().  It might be that some
> > callers needs fixing.
>
> FWIW it was passing my name "=C4=B0smail D=C3=B6nmez" based on user i=
nfo I guess.

I guess its line 1116:

 if (check_export_ok("$projectroot/$path")) {
	my $pr =3D {
	path =3D> $path,
	owner =3D> to_utf8($owner), <---- Here
};

My system is configured for UTF-8 so $owner will be UTF-8 but in some s=
ystems=20
it might not be so I don't think there is anything to fix here.

Regards,
ismail
