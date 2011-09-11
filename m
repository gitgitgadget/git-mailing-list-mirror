From: Jeff King <peff@peff.net>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Sun, 11 Sep 2011 02:27:40 -0400
Message-ID: <20110911062740.GA8018@sigill.intra.peff.net>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
 <20110911062206.GA29620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 08:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2dWB-0003Zb-Cy
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 08:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab1IKG1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Sep 2011 02:27:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34948
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab1IKG1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 02:27:42 -0400
Received: (qmail 20135 invoked by uid 107); 11 Sep 2011 06:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Sep 2011 02:28:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Sep 2011 02:27:40 -0400
Content-Disposition: inline
In-Reply-To: <20110911062206.GA29620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181167>

On Sun, Sep 11, 2011 at 02:22:06AM -0400, Jeff King wrote:

> Hmm. I can easily replicate the problem here, but interestingly it do=
es
> not happen with sub-trees like:
>=20
>   git archive --format=3Dzip HEAD:drivers -o ../kernel.zip
>=20
> Going back in history, I can replicate it with Ren=C3=A9's 62cdce1
> (git-archive --format=3Dzip: add symlink support, 2006-10-07). So the=
re's
> nothing to bisect.

Weirder still. I get roughly the same output as you:

  finishing deferred symbolic links:
    arch/microblaze/boot/dts/system.dts -> ../../platform/generic/syste=
m.dts
    drivers/scsi/aic94xx/aic94xx_reg.h -> /*^J * Aic94xx SAS/SATA drive=
r...

But looking at the generated file with zipinfo, I see:

  $ zipinfo kernel.zip
  ...
  lrwxrwxrwx  2.3 unx       33 b- stor 11-Aug-25 14:02 arch/microblaze/=
boot/dts/system.dts
  ...
  -rw----     0.0 fat    10470 b- defN 11-Aug-25 14:02 drivers/scsi/aic=
94xx/aic94xx_reg.h

IOW, the zip file looks right. I wonder if this is actually a bug in
"unzip".

-Peff
