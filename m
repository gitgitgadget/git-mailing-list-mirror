From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH 4/4] merge-file: add option to select union merge favor
Date: Mon,  1 Mar 2010 22:46:28 +0100
Message-ID: <cb7b00f2ff0231ff7febe6e05bf2145e4e2fe585.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDS3-0000k2-CJ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0CAVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:46:45 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:46151 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0CAVql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:46:41 -0500
Received: by mail-bw0-f212.google.com with SMTP id 4so2233909bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=EbGthysvjNTNkk0Zp8iDA05lzOwTyD/vEHDSkGDZeMY=;
        b=isoYmD4qb4ULMj7EpxV7B1MBoJoo4pnedSsOcRRoQJ6ku1TmgGASsFYUiL3OaqfOrV
         gJw0VQu4gpQ3aQTTSvnZQNqgrW5Z0xbNjh8/ggT6a2WqyQmowkOHwHZQq+yveHXl7QbL
         Ie/kwHjZ05JFbXAfI6MzcMKBDThx7wPdNS4xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Oq9p/tX6gLZhtTw0vh3pp/B95RFg7vs4YSfREUt6mfqNV1dROdAouwcaR873eXr8sV
         HmmYu3uuc+HYi3t9erVG4W07bghpwVp5y26l8PqGJV83ZRA4+1gKaumecLFRmRkWRKrP
         wOQUZsAKmd+G39TRWI6pMyZ9NGikXmziGbNL4=
Received: by 10.204.48.214 with SMTP id s22mr3483884bkf.117.1267480001130;
        Mon, 01 Mar 2010 13:46:41 -0800 (PST)
Received: from localhost (drsd-4dbd936b.pool.mediaWays.net [77.189.147.107])
        by mx.google.com with ESMTPS id k7sm927926bka.22.2010.03.01.13.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:46:40 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141359>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

The same argument as for the --marker-size apply here. For merges outside a
git repository, its the only way to get access to the union merge driver.

 Documentation/git-merge-file.txt |   13 +++++++------
 builtin-merge-file.c             |    2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index a5b9c1f..f334d69 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[--ours|--theirs] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
+	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	<current-file> <base-file> <other-file>
 
 
@@ -35,10 +35,10 @@ normally outputs a warning and brackets the conflict with lines containing
 	>>>>>>> B
 
 If there are conflicts, the user should edit the result and delete one of
-the alternatives.  When `--ours` or `--theirs` option is in effect, however,
-these conflicts are resolved favouring lines from `<current-file>` or
-lines from `<other-file>` respectively.  The length of the conflict markers
-can be given with the `--marker-size` option.
+the alternatives.  When `--ours`, `--theirs`, or `--union` option is in effect,
+however, these conflicts are resolved favouring lines from `<current-file>`,
+lines from `<other-file>`, or lines from both respectively.  The length of the
+conflict markers can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
 conflicts otherwise. If the merge was clean, the exit value is 0.
@@ -68,8 +68,9 @@ OPTIONS
 
 --ours::
 --theirs::
+--union::
 	Instead of leaving conflicts in the file, resolve conflicts
-	favouring our (or their) side of the lines.
+	favouring our (or their or both) side of the lines.
 
 
 EXAMPLES
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index c1a35b9..eaa4917 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -41,6 +41,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, "for conflicts, use their version",
 			    XDL_MERGE_FAVOR_THEIRS),
+		OPT_SET_INT(0, "union", &xmp.favor, "for conflicts, use a union version",
+			    XDL_MERGE_FAVOR_UNION),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
 			    "for conflicts, use this marker size"),
 		OPT__QUIET(&quiet),
-- 
1.7.0.584.g2da2b
