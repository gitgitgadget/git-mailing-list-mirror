From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-options: add --stat
Date: Thu, 13 Apr 2006 03:32:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604130331210.12456@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0604130308150.11360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 13 03:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTqh7-0006rB-4X
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 03:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWDMBcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 21:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWDMBcW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 21:32:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26504 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932415AbWDMBcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 21:32:21 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9F923BAC;
	Thu, 13 Apr 2006 03:32:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 92F04BD3;
	Thu, 13 Apr 2006 03:32:20 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7F0FCBAC;
	Thu, 13 Apr 2006 03:32:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0604130308150.11360@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18645>

Hi,

On Thu, 13 Apr 2006, Johannes Schindelin wrote:

> I just realized that something is wrong with this patch: the first file 
> of the patchset seems to be ignored. I'll fix it tomorrow.

Okay, so I lied: I fixed it today.

diff --git a/diff-tree.c b/diff-tree.c
index 2b79dd0..536da8e 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -117,7 +117,8 @@ int main(int argc, const char **argv)
 	if (opt->dense_combined_merges)
 		opt->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
+	if (opt->diffopt.output_format == DIFF_FORMAT_DIFFSTAT ||
+			opt->diffopt.output_format == DIFF_FORMAT_PATCH)
 		opt->diffopt.recursive = 1;
 
 	diff_tree_setup_paths(get_pathspec(prefix, argv), opt);
diff --git a/git.c b/git.c
index 5cb0d32..e4fcf92 100644
--- a/git.c
+++ b/git.c
@@ -344,7 +344,8 @@ static int cmd_log(int argc, const char 
 			opt.ignore_merges = 0;
 		if (opt.dense_combined_merges)
 			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
+		if (opt.diffopt.output_format == DIFF_FORMAT_DIFFSTAT ||
+				opt.diffopt.output_format == DIFF_FORMAT_PATCH)
 			opt.diffopt.recursive = 1;
 		if (!full_diff && rev.prune_data)
 			diff_tree_setup_paths(rev.prune_data, &opt.diffopt);
