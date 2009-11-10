From: Ingo Molnar <mingo@elte.hu>
Subject: [RFC, PATCH] git send-email: Make --no-chain-reply-to the default
Date: Tue, 10 Nov 2009 05:08:47 +0100
Message-ID: <20091110040847.GC29454@elte.hu>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 05:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7i2R-0006Of-JN
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 05:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbZKJEIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 23:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZKJEIt
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 23:08:49 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:55073 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbZKJEIt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 23:08:49 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1N7i2G-0002cR-76
	from <mingo@elte.hu>; Tue, 10 Nov 2009 05:08:52 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2D6CE3E22F5; Tue, 10 Nov 2009 05:08:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257789555.4108.348.camel@laptop>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132526>


(moved from lkml to the Git list)

* Peter Zijlstra <peterz@infradead.org> wrote:

> >                            Mailer: 
> > git-send-email 1.6.5.2
> 
> Please teach your git-send-email thing to use --no-chain-reply-to.

about half of every patch series that gets sent to me on lkml is 
unreadable in my email client due to the default threading that 
git-send-email does. It looks like this:

28685 r T Nov 05 Hitoshi Mitake  (  31) [PATCH v5 0/7] Adding general performance benchmarki
28686   T Nov 05 Hitoshi Mitake  (  31) +->[PATCH v5 1/7] Adding new directory and header fo
28687   T Nov 05 Hitoshi Mitake  ( 368) | +->[PATCH v5 2/7] sched-messaging.c: benchmark for
28688   T Nov 05 Hitoshi Mitake  ( 148) | | +->[PATCH v5 3/7] sched-pipe.c: benchmark for pi
28689   T Nov 05 Hitoshi Mitake  ( 149) | | | +->[PATCH v5 4/7] builtin-bench.c: General fra
28690   T Nov 05 Hitoshi Mitake  (  24) | | | | +->[PATCH v5 5/7] Modifying builtin.h for ne
28691   T Nov 05 Hitoshi Mitake  (  25) | | | | | +->[PATCH v5 6/7] Modyfing perf.c for subc
28692   T Nov 05 Hitoshi Mitake  (  30) | | | | | | +->[PATCH v5 7/7] Modyfing Makefile to b

and with 10 or more patches it's an absolute pain as threading depth 
increases. Furthermore, the subject lines are not aligned vertically, 
making it very hard to see the general shortlog-alike structure of the 
series, at a glance. Plus i dont even _see_ the title over a certain 
depth, as i run out of screen real estate.

So ... the question would be ... could git-send-email flip its default 
please, via the patch below? Am i missing something subtle about why 
this default was chosen?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/git-send-email.perl b/git-send-email.perl
index a0279de..ff00940 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -188,7 +188,7 @@ my (@suppress_cc);
 
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
-    "chainreplyto" => [\$chain_reply_to, 1],
+    "chainreplyto" => [\$chain_reply_to, 0],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
