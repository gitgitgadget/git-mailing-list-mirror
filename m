From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 14:04:45 -0500
Message-ID: <20131216190445.GB29324@sigill.intra.peff.net>
References: <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <20131205202807.GA19042@sigill.intra.peff.net>
 <52AEAEB2.6060203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsdTI-0004rF-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3LPTEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:04:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:45672 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755190Ab3LPTEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:04:48 -0500
Received: (qmail 23586 invoked by uid 102); 16 Dec 2013 19:04:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Dec 2013 13:04:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Dec 2013 14:04:45 -0500
Content-Disposition: inline
In-Reply-To: <52AEAEB2.6060203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239345>

On Mon, Dec 16, 2013 at 08:41:38AM +0100, Michael Haggerty wrote:

> The old naming scheme is documented in
> Documentation/git-pack-objects.txt, under "OPTIONS" -> "base-name":
> 
> > base-name::
> > 	Write into a pair of files (.pack and .idx), using
> > 	<base-name> to determine the name of the created file.
> > 	When this option is used, the two files are written in
> > 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
> > 	of the sorted object names to make the resulting filename
> > 	based on the pack content, and written to the standard
> > 	output of the command.
> 
> The documentation should either be updated or the description of the
> naming scheme should be removed altogether.

Thanks. I looked in Documentation/technical for anything to update, but
didn't imagine we would be advertising the format in the user-facing
documentation. :)

The original patch is in next, so here's one on top. I just updated the
description. I was tempted to explicitly say something like "this is
opaque and meaningless to you, don't rely on it", but I don't know that
there is any need.

-- >8 --
Subject: docs: update pack-objects "base-name" description

As of 1190a1a, the SHA-1 used to determine the filename is
now calculated differently. Update the documentation to
reflect this.

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/name-pack-after-byte-representations, naturally.

 Documentation/git-pack-objects.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d94edcd..c69affc 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -51,8 +51,7 @@ base-name::
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files are written in
 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
-	of the sorted object names to make the resulting filename
-	based on the pack content, and written to the standard
+	of the bytes of the packfile, and is written to the standard
 	output of the command.
 
 --stdout::
-- 
1.8.5.524.g6743da6
