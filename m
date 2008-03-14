From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Fri, 14 Mar 2008 09:29:49 -0400
Message-ID: <20080314132949.GC2932@coredump.intra.peff.net>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net> <20080313170016.GA3439@sigill.intra.peff.net> <2008-03-13-18-14-36+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 14:31:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaA0B-0008QW-6A
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 14:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbYCNN3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 09:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757371AbYCNN3x
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 09:29:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4832 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346AbYCNN3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 09:29:52 -0400
Received: (qmail 32716 invoked by uid 111); 14 Mar 2008 13:29:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 09:29:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 09:29:49 -0400
Content-Disposition: inline
In-Reply-To: <2008-03-13-18-14-36+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77222>

On Thu, Mar 13, 2008 at 06:14:36PM +0100, Samuel Tardieu wrote:

> | It's supposed to handle this automatically if the commit message
> | contains non-ascii characters. What version of git were you using?
>=20
> A version from "next" from March 8:
> ea6cde37d54121c5a1e1da51e1cd5cf27bfa3904 (+ 1 unrelated patch)

Hmm, that is certainly recent enough.

> E.g, does "git format-patch a1eebf~1..a1eebf" add MIME headers for yo=
u
> without my patch?

Sorry, I don't have that commit. What repo is it in?

It does work for me with this simple test:

  mkdir repo && cd repo && git init
  echo content >file && git add file && git commit -m one
  echo more >>file && git commit -a -m 'two

  utf8 body: =C3=B1'
  git format-patch HEAD^
  cat 0001-two.patch

I get:

-- >8 --
=46rom a9e3222c0dca0a2b1e1a53ab9b7a7526ed359b79 Mon Sep 17 00:00:00 200=
1
=46rom: Jeff King <peff@peff.net>
Date: Fri, 14 Mar 2008 09:27:30 -0400
Subject: [PATCH] two
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

utf8 body: =C3=B1
---
 file |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/file b/file
index d95f3ad..94b334d 100644
--- a/file
+++ b/file
@@ -1 +1,2 @@
 content
+more
--=20
1.5.4.4.553.g83e84.dirty
-- 8< --

So I assume there is some bug in git that is being triggered by the
commit you mention.

-Peff
