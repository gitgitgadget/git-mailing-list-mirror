From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Thu, 12 Feb 2009 21:44:14 +0100
Message-ID: <bd6139dc0902121244i4f894209m37f6c80716cbc397@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <alpine.DEB.1.00.0902122126460.10279@pacific.mpi-cbg.de>
	 <bd6139dc0902121230w1b9fec28sae4e14bdda58a50b@mail.gmail.com>
	 <alpine.DEB.1.00.0902122134500.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiRM-0001Jt-Dk
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049AbZBLUoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 15:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758927AbZBLUoR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:44:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:19312 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758447AbZBLUoQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 15:44:16 -0500
Received: by fg-out-1718.google.com with SMTP id 16so296367fgg.17
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 12:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=oOlJgttVQjKvfqrUCDCRhfMCxSTO5shlUwhlx/M7ZL8=;
        b=iDe/8aRo9LuLf3UNemPw1e01yfa2hd4d4uNW+PXLwDl8CW7N8UpQ6TzHdOFidFvABF
         cE1A63rU7uBoMhcBoeEORbIqVHaIYbP56vXnIgwR5tOZ7KgWRbd0afBx8prtVF9jjWpV
         NdFk+3VYPFj2yEesDNokKNELzl05HU945+P8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kARKqI+nu5xMLXlgY1b1Vrs8jFXRCIg1xOc4McSgVPcFZ6J1mFfWHD9/Ksd1XqffQt
         SCRp+VY/TYSvgxtqBJDwgUGyAcle8gGG12Dj9I0vG1wHw09rAhPc5FvNe3fbRMQacA8M
         k0Ow+FdjQjab73BF4r6FlLXuKAY3vh6Rh8XA8=
Received: by 10.86.33.10 with SMTP id g10mr1649052fgg.44.1234471454093; Thu, 
	12 Feb 2009 12:44:14 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902122134500.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 35e6bf90c57e64b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109647>

On Thu, Feb 12, 2009 at 21:37, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> So in contrast to the other situation, there are commits left to be
> rebased :-)

Ah, I see, funky hack :).

>> Also, any comments on the patch? ;)
>
> There is probably a thinko in it: if "master" already has your patche=
s,
> then you cannot apply them on top of "master". =A0That should conflic=
t
> rather horribly, and not change the commits that are already upstream=
=2E

Hmmm, afaik there are two cases in which 'git rebase' will abort with
'already up to date':
1. onto =3D=3D current
2. onto =3D=3D current + some extra patches

A quick demo of 1:

$ git rebase origin/master
Current branch master is up to date.
$ git rebase -f origin/master
Current branch master is up to date, rebase forced.
=46irst, rewinding head to replay your work on top of it...
=46ast-forwarded master to origin/master.


A quick demo of 2:

$ git rebase origin/master
Current branch master is up to date.
$ git rebase -f origin/master
Current branch master is up to date, rebase forced.
=46irst, rewinding head to replay your work on top of it...
Applying: Do not attempt to render a field if it is disabled
Applying: Add ToS agreement to org_admin application related forms.
Applying: Added mentor ToS

> Or I misunderstand something here. =A0Quite possible, I am pretty tir=
ed.

I hope that's the case, in my manual tests everything worked as
expected, but perhaps I didn't understand your concern correctly.

--=20
Cheers,

Sverre Rabbelier
