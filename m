From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 05/11] perf: suppress aggregation also in 'run'
Date: Mon, 12 Mar 2012 16:10:01 +0100
Message-ID: <f6d2a82ece115f05d2fc7ff8214c39cf530373c0.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76tF-0001iv-TW
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab2CLPKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737Ab2CLPKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:13 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:08 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192875>

perf-lib.sh avoids calling aggregate.perl on the results if
$GIT_PERF_AGGREGATING_LATER is set.  'run' uses this to suppress the
table for test runs, so that it can display them all together at the
end.

However, other users may want to do the same while still benefiting
from run's facilities such as automatic compilation/testing of
arbitrary revisions.  So teach 'run' the same interface: when
GIT_PERF_AGGREGATING_LATER is set, do not call aggregate.perl.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/run |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index cfd7012..886290b 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -69,6 +69,7 @@ run_dirs () {
 	done
 }
 
+orig_GIT_AGGREGATING_LATER=$GIT_PERF_AGGREGATING_LATER
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 
@@ -79,4 +80,4 @@ if test $# = 0 -o "$1" = -- -o -f "$1"; then
 	set -- . "$@"
 fi
 run_dirs "$@"
-./aggregate.perl "$@"
+test -z "$orig_GIT_AGGREGATING_LATER" && ./aggregate.perl "$@"
-- 
1.7.10.rc0.230.g16d90
