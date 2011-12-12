From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] t/lib-terminal: test test-terminal's sanity
Date: Mon, 12 Dec 2011 19:09:15 +0100
Message-ID: <44602402ecfd0e49c202f03e87540934aa23bce0.1323713230.git.trast@student.ethz.ch>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAJc-00029C-Ff
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1LLSJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:09:25 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:53412 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab1LLSJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:09:23 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:15 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 19:09:18 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186925>

The previous two commits show that getting test-terminal.perl right is
not trivial.  Let lib-terminal.sh run a simple test that ensures it
actually opens TTYs for std{in,out,err} and that it does not let stdin
pass through.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/lib-terminal.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 58d911d..9e4ff9c 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -33,3 +33,22 @@ test_expect_success PERL 'set up terminal for tests' '
 		}
 	fi
 '
+
+cat >expect1 <<EOF
+stdin: 1
+stdout: 1
+stderr: 1
+EOF
+: >expect2
+
+test_expect_success TTY 'test-terminal.perl is sane' '
+	test_terminal perl -e "
+		use POSIX qw(isatty);
+		print \"stdin: \", isatty(STDIN), \"\\n\";
+		print \"stdout: \", isatty(STDOUT), \"\\n\";
+		print \"stderr: \", isatty(STDERR), \"\\n\";
+	" >actual1 &&
+	test_cmp expect1 actual1 &&
+	echo foo | test_terminal cat - >actual2 &&
+	test_cmp expect2 actual2
+'
-- 
1.7.8.431.g2abf2
