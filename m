From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart transports.
Date: Wed, 2 Dec 2009 19:06:34 +0100
Message-ID: <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com> 
	<20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix> 
	<20091201193009.GM21299@spearce.org> <7vskbuwhmy.fsf@alter.siamese.dyndns.org> 
	<20091202055632.GD31244@Knoppix> <7vy6llnar5.fsf@alter.siamese.dyndns.org> 
	<20091202160446.GA32667@Knoppix> <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtbQ-0006H1-Cl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZLBSGt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 13:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbZLBSGs
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:06:48 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:63832 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbZLBSGs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 13:06:48 -0500
Received: by vws35 with SMTP id 35so187185vws.4
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9j90jdM2jHSVO9teFIas5B1tEGrvKccqLfc2otCft5E=;
        b=fWYYzqvnIxYALAdppTL86OXvuJD3lcRi0WI+xnYLbfopRlYhe/zd8g1bSCcp9OLsN/
         ejR8E3eUKeT/bMfODJ46HG5hPRm3zIrwkpoLeBrlpiwhlvWwCEMHOEUiN3oKZKmHHM9B
         t5E7asg+MjL1UrMnPXcpz2fS1XRfIEinT+Zt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YYIN8HfIgLvKa+/cdLFpWBujkPXKp1DXwaGKUu3omm+L/oOYbV87j+iQXKsMZG6DI7
         iZQUvyTRycDYt+k4/jQkXHvgG15yOY9acFUWf232sNSDX2Rapfid6PFVQDpDxil27FNQ
         coge2RyKZB9yaptoadvTYo/NNG4QVIZJTlVKI=
Received: by 10.220.121.155 with SMTP id h27mr571340vcr.20.1259777214102; Wed, 
	02 Dec 2009 10:06:54 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134365>

Heya,

On Wed, Dec 2, 2009 at 18:39, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> This is definitely a good direction, and it would be even better if t=
he
> absence of the remote helper was also handled gracefully.

Yes, that is definitely an improvement we can and should make
regardless of how we handle http(s) and ftp(s), since currently "git
clone nonsense::http://...." will error out with the message that
"git-remote-nonsense" cannot be found.

> Of course, I never understood why the backend should know the
> implementation detail that it is based on cURL, so it would be even m=
ore
> modular (at least by my definition) if there was no hard-coded mappin=
g.

Agreed.

> Sverre -- Cc'ed -- seemed to like URLs of the form "svn::http://..." =
and
> "cvs::pserver..." to trigger looking for a remote helper explicitely.=
 =A0I
> find the compiled-in mapping rather limiting.

Yes, I do think the double-colon syntax is very nice. That is, someone
who sees "git clone svn::http://" is likely to understand that it is a
svn repo over http that git treats specially.

However, I am not convinced that we should do any magic to map
"foo://" to git-remote-foo. On the other hand, I do think it makes
sense to have something modular that allows "git-remote-http" to be
implemented as a separate package that can be installed.

Perhaps instead of the current special case where "git-remote-curl" is
invoked, it would make more sense to instead special case on "http://"
(etc) and invoke "git-remote-http" in that case. So "git clone svn://"
would not work, but "git clone svn::svn://" would (as is the case
now), as well as "git clone http://" being handled by
"git-remote-http".

--=20
Cheers,

Sverre Rabbelier
