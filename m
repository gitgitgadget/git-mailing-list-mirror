From: Jeff King <peff@peff.net>
Subject: Re: [CRASH] git segfaults on invalid binary diff
Date: Mon, 18 Oct 2010 13:40:31 -0400
Message-ID: <20101018174031.GA9511@sigill.intra.peff.net>
References: <20101018180632.7eb40628@wai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmFmYcOrbCBDYXJyw6k=?= <rafael.carre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:40:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tgs-0006VL-I8
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab0JRRj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 13:39:57 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757455Ab0JRRj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:39:57 -0400
Received: (qmail 5310 invoked by uid 111); 18 Oct 2010 17:39:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 18 Oct 2010 17:39:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Oct 2010 13:40:31 -0400
Content-Disposition: inline
In-Reply-To: <20101018180632.7eb40628@wai>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159272>

On Mon, Oct 18, 2010 at 06:06:32PM +0200, Rafa=C3=ABl Carr=C3=A9 wrote:

> I noticed git crashed on a patch generated with:
> git show --full-index --pretty=3Demail <commit>
>=20
> (I had forgotten --binary)
>=20
> % git --version
> git version 1.7.3.1.120.g38a18
> % mkdir test
> % cd test
> % git init
> Initialized empty Git repository in /home/fun/test/.git/
> % git am ~/bad.diff
> Applying: foo bar
> Segmentation fault (core dumped)
> Patch failed at 0001 foo bar
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort"=
=2E
> % cat ~/bad.diff

Hmm, the key seems to be applying it in a new repo without the actual
objects. Git will fall back to trying to apply based on the index line,
and that is presumably where the bug is. I'll try to work up a patch.

-Peff
