From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] pull: propagate --progress to merge
Date: Sun, 20 Feb 2011 04:56:56 -0500
Message-ID: <20110220095655.GC1082@sigill.intra.peff.net>
References: <20110220094803.GA988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:57:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr62J-0007fB-Qv
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab1BTJ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 04:56:59 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42946 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab1BTJ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 04:56:58 -0500
Received: (qmail 16567 invoked by uid 111); 20 Feb 2011 09:56:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 09:56:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 04:56:56 -0500
Content-Disposition: inline
In-Reply-To: <20110220094803.GA988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167410>

Now that merge understands progress, we should pass it
along. While we're at it, pass along --no-progress, too.

Signed-off-by: Jeff King <peff@peff.net>
---
Probably not a big deal, but good for people who do "git pull
--no-progress" from a cronjob (which should be !isatty(2), but ISTR some
complaints by people with weird setups).

Fetch respects --no-progress, but I don't think it actually works right.
The transport code seems to only understand "want progress" or "don't
know, guess on isatty". But it's not really related to this topic, so I
didn't investigate too far tonight.

 git-pull.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index f6b7b84..63b063a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -53,6 +53,8 @@ do
 		verbosity="$verbosity -v" ;;
 	--progress)
 		progress=--progress ;;
+	--no-progress)
+		progress=--no-progress ;;
 	-n|--no-stat|--no-summary)
 		diffstat=--no-stat ;;
 	--stat|--summary)
@@ -293,8 +295,8 @@ true)
 	;;
 *)
 	eval="git-merge $diffstat $no_commit $squash $no_ff $ff_only"
-	eval="$eval  $log_arg $strategy_args $merge_args"
-	eval="$eval \"\$merge_name\" HEAD $merge_head $verbosity"
+	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
+	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
 esac
 eval "exec $eval"
-- 
1.7.4.1.26.g5e991
