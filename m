From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Sat, 8 Aug 2009 09:27:55 +0200
Message-ID: <c77435a80908080027p6a8de468w68983bd81364cefd@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <4A7B95A8.2010000@vilain.net>
	 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
	 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
	 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
	 <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
	 <7vfxc3ov8t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 09:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgLY-0006g8-64
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZHHH14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 03:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbZHHH14
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:27:56 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:61563 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZHHH1z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 03:27:55 -0400
Received: by ewy10 with SMTP id 10so1991771ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nZfxl6xyCSAfEYbpbx+mlqRbMsvwkeTl5jOcJ/fqVkE=;
        b=cOckIN73qZpOdQ0UG0Sb6dXLzcANT99Wtq8o9Xk5XBLCIdPEUGmkokF6+O6XOSsZtJ
         sIEabjq+GP+qolLzGffuTzOakTQyGG72Nf69j8VlcWJ0avvyi/AcmqAD43bcu2QIl3Gn
         b8zCcvYNN9NDEfE55pcQltaOntGW+ftlalF+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D3WlgXzlf5au7jbm4Vz9vzcxiQtdLfQewP5/jYIbr17bxki+LzY5tulbkDR7NKVKVA
         aQdzERL9EYgtMsXnlK7uxIW01rrIj5x1mtN/XK4GxCLthrFk7dDWrFaq6S0CwhfsK/kR
         LV6YaDQ7kreLtETtUCiEe+MojZYj5NffkwvEI=
Received: by 10.216.30.206 with SMTP id k56mr424572wea.86.1249716475464; Sat, 
	08 Aug 2009 00:27:55 -0700 (PDT)
In-Reply-To: <7vfxc3ov8t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125252>

> IIRC from previous discussions, kernel.org's main performance problem=
 is
> I/O, not CPU. Are there any provisions for sharing rev-caches between
> similar repositories, as we already do for objects?

I haven't implemented a transmission protocol or anything, but it
would be perfectly possible to copy cache slices from one repo to
another.  Generating the revision cache from scratch on large repos
can take several minutes, so this wouldn't be a bad idea.

> That depends primarily on how heavily the patches needed to change in
> response to review comments, but until the series lands in 'next', yo=
u
> would typically send updated series as a replacement, not incremental=
=2E
>
> Many people seemed to be interested in the series and had a volume of
> comments on it. =A0I suspect the updated series would be quite differ=
ent
> from the original, so for the next round I would suspect it would be =
best
> to start anew, marking them as [PATCH N/M (v2)], in a fresh thread. =A0=
It
> would help reviewers if you said "this corresponds to [PATCH 3/5] in =
the
> original series, with the following improvements based on X and Y's
> comments" after the three-dash line.

Ok, that sounds good.  I've added a new patch as well so the numbering =
changes.
