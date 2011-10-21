From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/3] completion: use __gitcomp_nl for ctag matching
Date: Fri, 21 Oct 2011 13:37:48 -0400
Message-ID: <20111021173748.GB24406@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
 <20111021173021.GC24417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 19:37:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHJ2a-0001Ij-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1JURhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 13:37:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38983
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754323Ab1JURhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:37:51 -0400
Received: (qmail 21946 invoked by uid 107); 21 Oct 2011 17:37:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Oct 2011 13:37:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2011 13:37:48 -0400
Content-Disposition: inline
In-Reply-To: <20111021173021.GC24417@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184075>

On Fri, Oct 21, 2011 at 01:30:21PM -0400, Jeff King wrote:

> +		if test -r tags; then
> +			__gitcomp "$(__git_match_ctag "$cur" tags)"
> +			return
> +		fi

Once this is merged with sg/complete-refs, this can be applied on top:

-- >8 --
Subject: [PATCH] completion: use __gitcomp_nl for ctag matching

It's much faster than __gitcomp for large numbers of matches
(which ctags often have; there are almost 10,000 matches for
"" in git.git).

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, this is one of those patches that is easier to review using
"diff-highlight" from patch 1 of this series.

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 391c054..53d3dcb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1473,7 +1473,7 @@ _git_grep ()
 	case "$cword,$prev" in
 	2,*|*,-*)
 		if test -r tags; then
-			__gitcomp "$(__git_match_ctag "$cur" tags)"
+			__gitcomp_nl "$(__git_match_ctag "$cur" tags)"
 			return
 		fi
 		;;
-- 
1.7.7.rc1.28.g5dd2ee
