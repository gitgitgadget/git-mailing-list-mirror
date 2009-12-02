From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Wed, 2 Dec 2009 10:32:34 +0800
Message-ID: <be6fef0d0912011832k12eaa093o73b057ddf4ab866@mail.gmail.com>
References: <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>
	 <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>
	 <1254510286-23155-1-git-send-email-nmiell@gmail.com>
	 <25718488.post@talk.nabble.com>
	 <20091127234110.7b7e9993.rctay89@gmail.com>
	 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
	 <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st>
	 <7vzl62zisy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>,
	git@vger.kernel.org, Nicholas Miell <nmiell@gmail.com>,
	gsky51@gmail.com, Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFf1M-0003o6-RS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZLBCc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 21:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbZLBCc2
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:32:28 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:56591 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZLBCc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:32:28 -0500
Received: by iwn1 with SMTP id 1so3567111iwn.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 18:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+xtb2ZLpIeZGPFqriaCcZPMS8Udwh87DxLOz03skFBQ=;
        b=lwXSFa5ZUdFl5/RQcaV60ahEND8teUChrv6RfXtppVNryYXhbyvGZxGClmdU1By683
         CEIVadCmkXuYy748QuJJ8T2u+u4jVEpdynVDMixhiY6cL6ILCh4058QFj2WDjD9G24jm
         j0TOPguRzBW1E+yVXOenGGH/G572WhCmE2q3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QesOot+6CzRuU9IrErexbVZzJRgTxL5sQ0rTcuoe6GcbMKr5rk1A7CgzJEw2aG4ni/
         4b03V5lHG5nbUwwM07VVnrVe8dszGFzXy1OZKSV1yhMl/dvH3Pzkuyku0ZaMfqRmg2A5
         bFQdjvKpgfo/XdAwfsaZ79buQtSFbGgVxzAaA=
Received: by 10.231.42.150 with SMTP id s22mr551738ibe.22.1259721154405; Tue, 
	01 Dec 2009 18:32:34 -0800 (PST)
In-Reply-To: <7vzl62zisy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134295>

Hi,

On Wed, Dec 2, 2009 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> ... and if the current buffer isn't the first one, what do we do?
> [snip]
> What will this result in? =A0A failed request, then the user increase=
s
> http.postBuffer, and re-runs the entire command? =A0I am not suggesti=
ng the
> code should do it differently (e.g. =A0retry with a larger buffer wit=
hout
> having the user to help it). =A0At least not yet. =A0That is why my f=
irst
> question above was "what do we do?" and not "what should we do?".

I guess that by "we" you're referring to the "normal" users of git?

> I am primarily interested in _documenting_ the expected user experien=
ce in
> the failure case, so that people can notice the message, run "git gre=
p" to
> find the above line and then run "git blame" to find the commit to re=
ad
> its log message to understand what is going on.

Yes, the code will just fail. As you might suspect, the code won't
attempt to mitigate the failure by doing anything, and would require
intervention on the part of the user.

What the user could do to make this work:

1. Turn off multi-pass authentication and just go with Basic.

2. Allow for persistent curl sessions. In theory, we get a 401 the
first time when we send a GET for info/refs; subsequently, curl knows
what authentication to use, so the POST request *should* take place
without the need for rewinding. In theory.

3. Increase http.postBuffer size in the config.

--=20
Cheers,
Ray Chuan
