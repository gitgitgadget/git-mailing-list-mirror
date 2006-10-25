X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3 (amend)] gitweb: Use --no-commit-id in git_commit and git_commitdiff
Date: Wed, 25 Oct 2006 14:23:21 +0200
Message-ID: <200610251423.21739.jnareb@gmail.com>
References: <200610241349.54685.jnareb@gmail.com> <200610241354.49396.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 12:23:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=joOzWly/fkQ+/HjJ5l76DM+EG7tYlN78QDHg8f2YtSOBfBKvsMydM3saQ8YulTAsGzBzEKFaS3iNBfhDx3pP1FUwgcjxkLf3zcXnp5/Rp/ea7D2Z7k9DUPpZViWJylfghEsEz/TI9E2Qq4Q4zpiOg5ndeppJZkbYhfu5xBEJ9VY=
User-Agent: KMail/1.9.3
In-Reply-To: <200610241354.49396.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30054>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gchmq-0001oi-ME for gcvg-git@gmane.org; Wed, 25 Oct
 2006 14:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423376AbWJYMXG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 08:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423377AbWJYMXF
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 08:23:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35726 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423376AbWJYMXC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 08:23:02 -0400
Received: by ug-out-1314.google.com with SMTP id 32so72837ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 05:23:00 -0700 (PDT)
Received: by 10.67.97.18 with SMTP id z18mr714740ugl; Wed, 25 Oct 2006
 05:23:00 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id e33sm2164402ugd.2006.10.25.05.23.00; Wed, 25 Oct
 2006 05:23:00 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use --no-commit-id option to git diff-tree command in git_commit and
git_commitdiff to filter out commit ID output that git-diff-tree adds
when called with only one <tree-ish> (not only for --stdin).

This option is in git since at least v1.0.0, so make use of it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is "amend" patch. It adds --no-commit-id option to git-diff-tree
invocation instead of removing commit IDs (tree-ish IDs to be more exact)
from git-diff-tree output.

Still, I'm not sure why git-diff-tree outputs tree-ish before diff
when called with only one tree-ish. Bugwards compatibility?

 gitweb/gitweb.perl |   4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8ac60be..345e336 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3004,7 +3004,8 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
+		@diff_opts, $parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -3321,6 +3322,7 @@ sub git_commitdiff {
 	my @difftree;
 	if ($format eq 'html') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			"--no-commit-id",
 			"--patch-with-raw", "--full-index", $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
-- 
1.4.2.1
