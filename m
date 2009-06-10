From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Wed, 10 Jun 2009 08:58:01 -0700
Message-ID: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>
References: <4A2E576D.704@op5.se>
	<1244629715-30444-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEQBy-00044w-25
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 17:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759371AbZFJP6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 11:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760082AbZFJP6A
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 11:58:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65311 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006AbZFJP6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 11:58:00 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610155800.IZJF17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Wed, 10 Jun 2009 11:58:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 2Fy11c0094aMwMQ04Fy1Hx; Wed, 10 Jun 2009 11:58:01 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0x9OhrcHy5gA:10 a=yTbM2EVNuUQA:10
 a=pGLkceISAAAA:8 a=MGN5XHmoJMpvQNsQxJIA:9 a=To05Rw1fNbU57N2jWdwA:7
 a=c-Tf2RAKwBDhCkPLi0GJ-XbGa0oA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1244629715-30444-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 10
 Jun 2009 20\:28\:35 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121284>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I use git to manage patches in my Gentoo development. In Gentoo, all
> ebuilds (another form of RPM spec) corresponding to different version=
s
> of the same package are grouped into one directory. So patches for
> each version usually have a prefix to separate them from ones for
> other versions. With --filename-prefix it comes handy to produce such
> patches, for example:
>
> git format-patch --filename-prefix dbus-1.2.3- HEAD~5
>
> will generate patches for dbus-1.2.3 for me, all starting with "dbus-=
1.2.3-".
>
> This might be handy for RPM developers as well.

If this patch needs another round, I would prefer seeing the explanatio=
n
done in a different order.  When a busy person who is uninterested in
Gentoo starts reading the above paragraph, the patch will (incorrectly)=
 be
dismissed with an "Ah, Gentoo specific feature?  Not interesting." afte=
r
reading the first two lines.  I.e. "Add X that does Y.  This is useful =
in
such and such situations because ...".

> +--filename-prefix=3D.<pfx>::
> +	Prepend specified prefix in front of generated filenames.

Hmm... ;-)

What happens when I feed a path with a slash in it with --filename-pref=
ix?
We will fail in open/creat if the leading path does not exist?

I am not saying we must allow a slash in the prefix and create necessar=
y
leading paths ourselves, nor we must check for a slash and fail in the
input validation phase, but I am wondering if we can have some clever w=
ay
to internally unify the handling of this new option with --outdir.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 8b33321..cf16c0a 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -246,6 +246,7 @@ format-patch --stdout initial..master
>  format-patch --stdout --no-numbered initial..master
>  format-patch --stdout --numbered initial..master
>  format-patch --attach --stdout initial..side
> +format-patch --attach --stdout --filename-prefix=3Dfoo- initial..sid=
e

Heh, clever.  I wondered what the point of testing with --stdout was
for a patch that affects the generated filename.  The magic of --attach=
 ;-)
