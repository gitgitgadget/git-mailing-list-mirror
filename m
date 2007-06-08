From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/6] gitweb: Provide links to commitdiff to each parent in
	'commitdiff' view
Date: Fri, 08 Jun 2007 13:24:56 +0200
Message-ID: <20070608112419.3594.94911.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcVz-0001aZ-J8
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967838AbXFHLTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967593AbXFHLTo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:19:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:47648 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967838AbXFHLTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:19:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so929229ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:19:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=gblzo0mw3N2Q7vnppV9MBjPuEBgAI2JVLkMcVLM/9tTivqbOMZdFrFH4vZqztzuACaE29DWw8mcvX8Wlz8/MqUK+0Yw3S3EP9GwZAIV+ceEKG7Xu2x/dlUWQf6kMz8FFXLKaE3ShUwxZ1LXAn1VZrxmqGw+Xhy0by9YX8ZRg1DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=IRqxObBtawedP2V2ehFG30lfT68QWHAgyv+GX+9vaDemuNG7u8yluuG/R3lPC84HYL7GliyHMppEsOYfafSEKm4icxKzONp6mbgLmMVO/dQNeuJXH0ZSRXqWjdaHVE5H7kzFuNDmsMkx0PMiEZADErV+5VK6vFfnx2i+t/6VNaI=
Received: by 10.82.189.6 with SMTP id m6mr5140029buf.1181301582059;
        Fri, 08 Jun 2007 04:19:42 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id i7sm5610668nfh.2007.06.08.04.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:19:41 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BOu9h003623;
	Fri, 8 Jun 2007 13:24:57 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49464>

Since commit-fb1dde4a we show combined diff for merges in 'commitdiff'
view, and since commit-208ecb2e also in 'commit' view. Sometimes
though one would want to see diff to one of merge commit parents. It
is easy in 'commit' view: in the commit header part there are "diff"
links for each of parent header. This commit adds such links also for
'commitdiff' view.

Add to difftree / whatchanged table row with "1", "2", ... links to
'commitdiff' view for diff with n-th parent for merge commits, as a
table header.  This is visible only in 'comitdiff' view, and only for
a merge commit (comit with more than one parent).

To save space links are shown as "n", where "n" is number of a parent,
and not as for example shortened (to 7 characters) sha1 of a parent
commit.  To make it easier to discover what links is for, each link
has 'title' attribute explaining the link.

Note that one would need to remember that difftree table in 'commit'
view has one less column (it doesn't have "patch" link column), if one
would want to add such table header also in 'commit' view.

Example output:
                          1       2       3 
  Makefile      patch | diff1 | diff2 | diff3 | blob | history
  cache.h       patch | diff1 | diff2 | diff3 | blob | history

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9f0822f..7908fe3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -181,10 +181,15 @@ table.diff_tree {
 	font-family: monospace;
 }
 
+table.combined.diff_tree th {
+	text-align: center;
+}
+
 table.combined.diff_tree td {
 	padding-right: 24px;
 }
 
+table.combined.diff_tree th.link,
 table.combined.diff_tree td.link {
 	padding: 0px 2px;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e92596c..e2d5222 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2401,6 +2401,26 @@ sub git_difftree_body {
 	print "<table class=\"" .
 	      (@parents > 1 ? "combined " : "") .
 	      "diff_tree\">\n";
+
+	# header only for combined diff in 'commitdiff' view
+	my $has_header = @parents > 1 && $action eq 'commitdiff';
+	if ($has_header) {
+		# table header
+		print "<thead><tr>\n" .
+		       "<th></th><th></th>\n"; # filename, patchN link
+		for (my $i = 0; $i < @parents; $i++) {
+			my $par = $parents[$i];
+			print "<th>" .
+			      $cgi->a({-href => href(action=>"commitdiff",
+			                             hash=>$hash, hash_parent=>$par),
+			               -title => 'commitdiff to parent number ' .
+			                          ($i+1) . ': ' . substr($par,0,7)},
+			              $i+1) .
+			      "&nbsp;</th>\n";
+		}
+		print "</tr></thead>\n<tbody>\n";
+	}
+
 	my $alternate = 1;
 	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
@@ -2673,6 +2693,7 @@ sub git_difftree_body {
 		} # we should not encounter Unmerged (U) or Unknown (X) status
 		print "</tr>\n";
 	}
+	print "</tbody>" if $has_header;
 	print "</table>\n";
 }
 
