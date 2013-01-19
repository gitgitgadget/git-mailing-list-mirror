From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] am: invoke perl's strftime in C locale
Date: Sat, 19 Jan 2013 08:39:41 -0800
Message-ID: <20130119163940.GA12307@sigill.intra.peff.net>
References: <20130114205933.GA25947@altlinux.org>
 <20130115155953.GB21815@sigill.intra.peff.net>
 <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
 <20130115165058.GA29301@sigill.intra.peff.net>
 <20130115174015.GA7471@altlinux.org>
 <20130115190517.GB7963@altlinux.org>
 <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 17:40:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwbSh-0007mt-VA
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 17:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab3ASQjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 11:39:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38108 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807Ab3ASQjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 11:39:46 -0500
Received: (qmail 4718 invoked by uid 107); 19 Jan 2013 16:41:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Jan 2013 11:41:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Jan 2013 08:39:41 -0800
Content-Disposition: inline
In-Reply-To: <7vehhiqlcx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213982>

On Fri, Jan 18, 2013 at 12:36:46PM -0800, Junio C Hamano wrote:

> > diff --git a/git-am.sh b/git-am.sh
> > index c682d34..8677d8c 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -334,7 +334,8 @@ split_patches () {
> >  			# Since we cannot guarantee that the commit message is in
> >  			# git-friendly format, we put no Subject: line and just consume
> >  			# all of the message as the body
> > -			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
> > +			perl -M'POSIX qw(strftime :locale_h)' -ne '
> > +				BEGIN { setlocale(LC_TIME, "C"); $subject = 0 }
> 
> I still haven't convinced myself that this is an improvement over
> the simple "LC_ALL=C LANG=C perl ..." approach.

Yeah, I was the one who brought it up, but I think I was probably being
too nit-picky. It almost certainly doesn't matter, and the alternatives
are just as likely to cause problems.

> I am tempted to use the previous one that puts the whole process
> under LC_ALL=C instead, unless I hear a "we already depend on that
> elsewhere, look at $that_code".

I'm fine with that.

-Peff
