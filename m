From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] perf-lib: fix ignored exit code inside loop
Date: Wed, 25 Mar 2015 01:25:55 -0400
Message-ID: <20150325052555.GA31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:26:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadpP-0007pC-NP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbCYF0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:26:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:38154 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752432AbbCYFZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:25:58 -0400
Received: (qmail 17257 invoked by uid 102); 25 Mar 2015 05:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:25:58 -0500
Received: (qmail 11464 invoked by uid 107); 25 Mar 2015 05:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:26:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:25:55 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266254>

When copying the test repository, we try to detect whether
the copy succeeded. However, most of the heavy lifting is
done inside a for loop, where our "break" will lose the exit
code of the failing "cp". We can take advantage of the fact
that we are in a subshell, and just "exit 1" to break out
with a code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a8c9574..5cf74ed 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -91,7 +91,7 @@ test_perf_create_repo_from () {
 				*/objects|*/hooks|*/config)
 					;;
 				*)
-					cp -R "$stuff" . || break
+					cp -R "$stuff" . || exit 1
 					;;
 			esac
 		done &&
-- 
2.3.4.635.gd6ffcfe
