From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/6] config: add 'git_config_string' to refactor string config variables.
Date: Sat, 16 Feb 2008 19:21:42 +0100
Message-ID: <200802161921.43346.chriscool@tuxfamily.org>
References: <20080216060024.385fa360.chriscool@tuxfamily.org> <20080216115310.GA11318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:16:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQRaM-00073a-NJ
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYBPSPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbYBPSPw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:15:52 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:51391 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbYBPSPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 13:15:51 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 221CD1AB340;
	Sat, 16 Feb 2008 19:15:50 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F39BF1AB32D;
	Sat, 16 Feb 2008 19:15:49 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080216115310.GA11318@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74054>

Le samedi 16 f=C3=A9vrier 2008, Jeff King a =C3=A9crit :
> On Sat, Feb 16, 2008 at 06:00:24AM +0100, Christian Couder wrote:
> > +int git_config_string(const char **dest, const char *var, const ch=
ar
> > *value) +{
> > +	if (!value)
> > +		return config_error_nonbool(var);
> > +	*dest =3D xstrdup(value);
> > +	return 0;
> > +}
>
> I'm not sure I see the point in using a 'const char *' as the
> destination. The string isn't inherently const, since it is allocated=
 on
> the heap; callers are free to use it as they please (and are responsi=
ble
> for freeing it; while constness doesn't impact calling free() at a
> language level, I think that stylistically it is uncommon for a
> heap-allocated string to be stored as 'const').

Well, in many places where this function could be used the dest string =
is=20
a "const char *" and in many other places it's a "char *", but it feels=
=20
safer to try to promote the latter into the former (like I did in the=20
following patches) rather than the other way around.

Christian.
