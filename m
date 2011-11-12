From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/14] resumable network bundles
Date: Sun, 13 Nov 2011 00:11:31 +0800
Message-ID: <CALUzUxqsLP11Tcsoc1tzGMfNcMqor2wQF+Yutu3FRiTin4Pnew@mail.gmail.com>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 12 17:11:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPGB9-0002wx-BQ
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 17:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1KLQLe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 11:11:34 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57491 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1KLQLd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 11:11:33 -0500
Received: by bke11 with SMTP id 11so4286684bke.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hJoQLGglImtbQvfPDwlrzoPh3iWs9aXaKnCddJs8Mdc=;
        b=JUznYX1vTjYMyIZ0SPoHb0L7mDZsxeKvOpRqhTdml5NY1zAIBlni2gbF5uggrgCap1
         RjpbcCrl55hPxsALzhlGcUJgYZLZMZ8L0pC9A+6EeLNBYXKpLKo8SOhst0qkIdVlA49z
         h6hDrqJTHnOstz3oURh0iFam+SwRikmmA2wjI=
Received: by 10.205.122.17 with SMTP id ge17mr4719249bkc.109.1321114291436;
 Sat, 12 Nov 2011 08:11:31 -0800 (PST)
Received: by 10.223.71.206 with HTTP; Sat, 12 Nov 2011 08:11:31 -0800 (PST)
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185307>

On Thu, Nov 10, 2011 at 3:43 PM, Jeff King <peff@peff.net> wrote:
> One possible option for resumable clones that has been discussed is
> letting the server point the client by http to a static bundle
> containing most of history, followed by a fetch from the actual git r=
epo
> (which should be much cheaper now that we have all of the bundled
> history). =A0This series implements "step 0" of this plan: just letti=
ng
> bundles be fetched across the network in the first place.
>
> Shawn raised some issues about using bundles for this (as opposed to
> accessing the packfiles themselves); specifically, this raises the I/=
O
> footprint of a repository that has to serve both the bundled version =
of
> the pack and the regular packfile.
>
> So it may be that we don't follow this plan all the way through.
> However, even if we don't, fetching bundles over http is still a usef=
ul
> thing to be able to do. Which makes this first step worth doing eithe=
r
> way.

Jeff, this is a great series, I think the cleanups and refactors
should get integrated independently of the bundle-cloning stuff.

One thing I'm not comfortable with is the "flexibility" allowed in
bundle fetching - servers are allowed to send bundles if they see fit,
and we have to detect it when they do (if I'm reading the "surprised"
scenario in patch 9 correctly).

Perhaps we can expose bundle fetching through /objects/info/bundles?
It could possibly contain information about what bundles are available
and what revs they contain. If bundles are found, fetch them;
otherwise, go through the usual ref advertisement and other steps of
the pack protocol.

That way, we take out the "surprise" factor in the fetching protocol.

--=20
Cheers,
Ray Chuan
