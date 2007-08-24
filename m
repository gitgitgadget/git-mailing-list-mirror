From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 01:38:53 -0600
Message-ID: <1187941133.6357.75.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTkF-0001hs-25
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbXHXHiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbXHXHiK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:38:10 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4460 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbXHXHiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:38:09 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 01:37:57 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [134.253.112.50] (sacv8030ay.sandia.gov [134.253.112.50])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7O7btqO004973;
 Fri, 24 Aug 2007 01:37:55 -0600
In-Reply-To: <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.224
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_MEDIA_BODY 0,
 __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824073758; SEV=2.2.2; DFV=B2007082407;
 IFV=2.0.4,4.0-9; AIF=B2007082407; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364345384144352E303039393A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082407_5.02.0125_4.0-9
X-WSS-ID: 6AD0555F2E0211090-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56558>

On Thu, 2007-08-23 at 23:37 -0700, Linus Torvalds wrote:
> 
> On Fri, 24 Aug 2007, David Kastrup wrote:
> > >
> > > So handling ownership outside of the actual filesystem, in a
> > > separate file that git tracks, actually allows you to do things that
> > > you couldn't otherwise sanely do.
> > 
> > Well, about that "sane" bit: I don't see an application for tracking
> > unrestorable ownership values.
> 
> Umm. Like an RPM spec file?
> 
> The thing you "don't see an application" for is exactly the kind of things 
> that people very much ALREADY DO. 
> 
> There are tons of different setups for setting up user and group ownership 
> (and things like permission) in almost any project. And I can pretty much 
> *guarantee* you that none of them depend on actually having ownership on 
> the files themselves.
> 
> In git, just for fun, do
> 
> 	git grep defattr
> 
> or even just look into the Makefile, and think about what lines like that
> 
> 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
> 
> thing means, and why it has a "755" there, and why other Makefiles quite 
> often have things like "-o bin" etc on such lines!

Yes. Permission bits are useful.  I wouldn't want a umask clobbering
some /bin directory to 0644 or some such.

> See? Those ownership things are restorable *as*root*, but that doesn't 
> mean that everybody should do development as root. In fact, I'd argue
>  that any system that is set up so that you have to develop and merge
>  things while being root is pretty damn broken.

If your repository is a full system image (my extreme case), developing
as root (installing packages, altering configs) is *required* if you
expect the image to boot/behave properly.  Squashing ownership in this
case would undoubtedly break many things.

> Which means that any such environment *has* to encode the owndership 
> *separately* from the actual filesystem ownership. Because doing it in the 
> filesystem simply isn't sane.
> 
> So yes, you could have an insane piece of crap that actually tracks file 
> ownership in the filesystem, and requires people to be root.

This is what I've done with SVN.  The mechanisms to save/restore
perms/ownership can be run as hooks before checkin and after checkout.
The performance is pretty depressing even without running those hooks
every time.  I'm just hoping that using .gitattribues will perform
reasonably well.

> Or you could use a ".gitattributes" file or similar _external_ tracking 
> method that allows even people who cannot actually set ownership to work 
> with it.

Yes, although it would be nice if a clone or a pull tells me (running as
a user) that the ownership being set doesn't match the uid/gid in the
attribute file.  Element of least surprise.  For those actually
requesting the behavior, a little extra verbosity seems pretty
acceptable.

-JE
