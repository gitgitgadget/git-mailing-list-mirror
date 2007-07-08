From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gitweb: New cgi parameter: filter
Date: Sun, 8 Jul 2007 03:35:43 +0200
Message-ID: <20070708013543.GD29994@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 03:35:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Lgq-0005eC-Li
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 03:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbXGHBfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 21:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbXGHBfy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 21:35:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51317 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569AbXGHBfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 21:35:53 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1I7Lgj-0006f7-Pq
	from <vmiklos@frugalware.org>; Sun, 08 Jul 2007 03:35:52 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 51C7816A8066; Sun,  8 Jul 2007 03:35:43 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51853>

Currently the only supported value is "nomerges". This allows one to filter
merges from many actions, like rss, log and shortlog.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 gitweb/gitweb.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc609f4..ce592cf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -383,6 +383,13 @@ if (defined $hash_base) {
 	}
 }
 
+our $filter = $cgi->param('filter');
+if (defined $filter) {
+	if ($filter != "nomerges") {
+		die_error(undef, "Invalid filter parameter");
+	}
+}
+
 our $hash_parent_base = $cgi->param('hpb');
 if (defined $hash_parent_base) {
 	if (!validate_refname($hash_parent_base)) {
@@ -534,6 +541,7 @@ sub href(%) {
 		action => "a",
 		file_name => "f",
 		file_parent => "fp",
+		filter => "filter",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
@@ -1770,6 +1778,7 @@ sub parse_commits {
 		($arg ? ($arg) : ()),
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
+		((defined $filter and $filter == "nomerges") ? ("--no-merges") : ()),
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
-- 
1.5.3.rc0.39.g46f7-dirty
