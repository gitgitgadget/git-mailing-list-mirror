From: Francis Galiegue <fge@one2team.com>
Subject: Re: [PATCH 6/6] Remove bareword filehandles in git-send-email.perl
Date: Sun, 3 May 2009 23:34:03 +0200
Organization: One2team
Message-ID: <200905032334.03286.fge@one2team.com>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <1241010743-7020-7-git-send-email-wfp5p@virginia.edu> <20090503205826.GF20468@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Pemberton <wfp5p@virginia.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 03 23:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0jKi-0003Es-H9
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 23:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZECVeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 17:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbZECVeW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 17:34:22 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:43378 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbZECVeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 17:34:21 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id AC24F92C009;
	Sun,  3 May 2009 23:34:08 +0200 (CEST)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 55DD82F2C3;
	Sun,  3 May 2009 23:34:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090503205826.GF20468@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118193>

Le Sunday 03 May 2009 22:58:26 Jeff King, vous avez =C3=A9crit=C2=A0:
> On Wed, Apr 29, 2009 at 09:12:23AM -0400, Bill Pemberton wrote:
> > The script was using bareword filehandles.  This is considered a ba=
d
> > practice so they have been changed to indirect filehandles.
>
> I think this is a real improvement; using indirect filehandles mean t=
hey
> get scoped properly, which can avoid errors (especially forgetting to
> close() them, which happens automagically when they go out of scope).
> Assuming, of course, that the scoping added by your change is correct=
,
> and doesn't close a handle during a loop that we may have wanted to k=
eep
> open (I didn't check carefully).
>
> But in the patch itself:
> > -	open(C,">",$compose_filename)
> > +	open my $C,'>',$compose_filename
>
> There are actually two things happening here:
>
>   1. s/C/my $C/, which I think is good
>
>   2. losing the parentheses around open(). This is a style issue, but=
 I
>      think we usually prefer the parenthesized form of most perl
>      builtins (and certainly in the absence of other information, it
>      should be left as-is).
>

And why not go the full way and using IO::File?

my $fh =3D new IO::File;

$fh->open("/the/file", O_RDONLY|...)

--=20
=46rancis Galiegue
fge@one2team.com
Ing=C3=A9nieur syst=C3=A8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
One2team
40 avenue Raymond Poincar=C3=A9
75116 Paris
