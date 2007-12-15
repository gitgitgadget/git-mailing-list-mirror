From: Jeff King <peff@peff.net>
Subject: Re: git-browse-help?
Date: Sat, 15 Dec 2007 06:11:54 -0500
Message-ID: <20071215111154.GB3447@coredump.intra.peff.net>
References: <20071214092829.GA22725@coredump.intra.peff.net> <7vtzmlrxc2.fsf@gitster.siamese.dyndns.org> <20071215100811.GA1692@coredump.intra.peff.net> <20071215110153.GA3447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3UwQ-00072d-MP
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 12:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbXLOLL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 06:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbXLOLL7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 06:11:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3052 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbXLOLL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 06:11:58 -0500
Received: (qmail 11286 invoked by uid 111); 15 Dec 2007 11:11:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Dec 2007 06:11:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 06:11:54 -0500
Content-Disposition: inline
In-Reply-To: <20071215110153.GA3447@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68384>

On Sat, Dec 15, 2007 at 06:01:53AM -0500, Jeff King wrote:

>      problem. Shawn, perhaps it should simply ignore *--* as plumbing?

And here is a patch to do that.

-- >8 --
teach bash completion to treat commands with "--" as plumbing

There is a convention that commands containing a double-dash
are implementation details and not to be used by mortals. We
should automatically remove them from the completion
suggestions as plumbing.

Signed-off-by: Jeff King <peff@peff.net>
---
BTW, Junio, I remember discussion a long time ago about doing:

  cover letter
  -- >8 --
  commit
  ---
  diff

versus

  commit
  ---
  cover letter
  diff

and I recall that you did not have a strong preference. I have started
using the former, as I find it a bit more convenient to write (and I
think it is more readable when you are following up a discussion rather
than writing a real cover letter or commenting on the patch). However,
I wanted to confirm that you don't find it significantly more annoying.

 contrib/completion/git-completion.bash |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 58e0e53..2fd32db 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -291,7 +291,7 @@ __git_commands ()
 	for i in $(git help -a|egrep '^ ')
 	do
 		case $i in
-		add--interactive) : plumbing;;
+		*--*)             : plumbing pattern;;
 		applymbox)        : ask gittus;;
 		applypatch)       : ask gittus;;
 		archimport)       : import;;
@@ -308,7 +308,6 @@ __git_commands ()
 		diff-tree)        : plumbing;;
 		fast-import)      : import;;
 		fsck-objects)     : plumbing;;
-		fetch--tool)      : plumbing;;
 		fetch-pack)       : plumbing;;
 		fmt-merge-msg)    : plumbing;;
 		for-each-ref)     : plumbing;;
-- 
1.5.4.rc0.1124.g1b66f-dirty
