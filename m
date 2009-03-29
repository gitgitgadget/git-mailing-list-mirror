From: Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH] git-svn: don't output git commits in quiet mode
Date: Sun, 29 Mar 2009 20:34:50 +0100
Message-ID: <49CFCD5A.1080801@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 29 21:44:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo0wE-0002pP-8T
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 21:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbZC2TnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbZC2TnZ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 15:43:25 -0400
Received: from proxima.lp0.eu ([81.187.201.134]:50140 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbZC2TnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 15:43:24 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2009 15:43:24 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=exim; d=fire.lp0.eu;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
	b=LN1j79wNn7VnEScslJSSLMCrH10ObWHa1BZMXmIi3Dar1+NGwwGnJ8R87JEeNcy5Ktju0msofBUByuFOLjLf+PEnXeFQAFQ33w+b9G7P1xJLJpXIgkzDdBvfF0BQMVh9;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44227)
	by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465) with esmtpsav (TLSv1:AES256-SHA:256/CN=Simon Arlott)
	id 1Lo0mQ-0005Fp-UI; Sun, 29 Mar 2009 20:34:50 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090328)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115031>

Ideally only errors should be output in this mode so fetch
can be run from cron and normally produce no output. Without
this change it would output a single line on each git commit,
e.g.
r1909 = 32ef87860662526d4a62f903949ed21e0341079e (u2_10_12_branch)

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8be6be0..e100b69 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2331,13 +2331,13 @@ sub do_git_commit {
 
 	$self->{last_rev} = $log_entry->{revision};
 	$self->{last_commit} = $commit;
-	print "r$log_entry->{revision}";
+	print "r$log_entry->{revision}" unless $::_q;
 	if (defined $log_entry->{svm_revision}) {
-		 print " (\@$log_entry->{svm_revision})";
+		 print " (\@$log_entry->{svm_revision})" unless $::_q;
 		 $self->rev_map_set($log_entry->{svm_revision}, $commit,
 		                   0, $self->svm_uuid);
 	}
-	print " = $commit ($self->{ref_id})\n";
+	print " = $commit ($self->{ref_id})\n" unless $::_q;
 	if (--$_gc_nr == 0) {
 		$_gc_nr = $_gc_period;
 		gc();
-- 
1.6.2

-- 
Simon Arlott
