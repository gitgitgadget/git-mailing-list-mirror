From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 21:04:53 +0100
Message-ID: <20120214210453.16c6bd2e@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<201202131944.50886.jnareb@gmail.com>
	<20120213220917.4cf14eb1@gmail.com>
	<201202141831.59699.jnareb@gmail.com>
	<20120214192340.2d473866@gmail.com>
	<20120214185233.GA12072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOca-0007gL-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760476Ab2BNUE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 15:04:59 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61674 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab2BNUE6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 15:04:58 -0500
Received: by eekc14 with SMTP id c14so126819eek.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=3nFgHwsogZNgTEJcUXNucffyF78mdpdQyD8y5a9MzwE=;
        b=hAcTpivnCwzyxqpvpvmiJhFKoXJmP6KYT9rhfWNCmE7D5s/KG1BMnxnf0YJdJxfHEJ
         +hBEucmgrIaB9vyay2PNUXIJIm/S9bolbeQL8K/8QdFFveiGthw/tvHw7hJKB52Y0CwE
         jdTdux5POqqnlu/76Sv/wLldouyUABZFOSiRs=
Received: by 10.213.8.135 with SMTP id h7mr3803519ebh.95.1329249897574;
        Tue, 14 Feb 2012 12:04:57 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id c16sm2370986eei.1.2012.02.14.12.04.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 12:04:57 -0800 (PST)
In-Reply-To: <20120214185233.GA12072@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190743>

Jeff King <peff@peff.net> wrote:

> On Tue, Feb 14, 2012 at 07:23:40PM +0100, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> > > > > BTW GitHub is closed source, but we can check what algorithm =
does Trac
> > > > > use for diff refinement highlighting (highlighting changed po=
rtions of
> > > > > diff).
> > > > >=20
> > > > I think it's
> > > > http://trac.edgewall.org/browser/trunk/trac/versioncontrol/diff=
=2Epy
> > > > (see markup intraline_changes()).
> > [...]
> > [...]
> > > The markup_intraline_changes() function compares lines from preim=
age and
> > > from postimage pairwise, requiring that number of lines matches, =
the same
> > > like in your algorithm.
> >=20
> > So using Jeff's diff-highlight we remain quite consistent with Trac
> > output. There's nothing we can "steal" from it.
>=20
> Neat. When I originally wrote diff-highlight, I was inspired by seein=
g
> what Trac and GitHub did, but came up with the algorithm on my own.
> Learning that Trac does the multiline thing (as we started doing with
> recent patches) makes me feel even better that it's a good strategy.
>=20
> As an aside, I looked at what GitHub does. It turns on highlighting o=
nly
> for the single-line case, and does the same prefix/suffix thing.
>=20
> It's really not very complex code; most of the hassle in diff-highlig=
ht
> is ignoring (but preserving) embedded colors, so that we build on top=
 of
> existing colorization. A web tool will be doing the line coloring its=
elf
> anyway, so it can be much simpler. Elsewhere, I suggested lib-ifying
> diff-highlight for gitweb to use. But once you remove the embedded co=
lor
> handling, there really is not that much code, and it's probably simpl=
er
> to just rewrite it.
>=20
> -Peff

Sure, now it's a simple algorithm, but if we add more code, we will
have problems with making it consistent in both gitweb and
diff-highlight (which is nice-to-have IMO). Note that my patches to
gitweb already support combined diffs (in obvious cases) while
diff-highlight will fail on them badly (see for example 09bb4eb4f14c).
I haven't done it in diff-highlight because I noticed that problem
while working on patches for gitweb.

Anyway, thanks for looking at Trac/GitHub code and sharing your opinion=
=2E
