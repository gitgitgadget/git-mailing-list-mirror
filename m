From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] add -i: revisit hunk on editor failure
Date: Thu, 12 Feb 2009 00:19:41 -0500
Message-ID: <1234415981-22789-1-git-send-email-deskinm@umich.edu>
Cc: gitster@pobox.com, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 06:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXU0k-0001rt-BS
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 06:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZBLFTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 00:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbZBLFTu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 00:19:50 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:27977 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbZBLFTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 00:19:49 -0500
Received: by el-out-1112.google.com with SMTP id b25so382164elf.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 21:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=u4s7Obo53HDBO+HuOddG82NavN5qGngubRicOjaR/sA=;
        b=Kcyjw76NNENMWjXDpHjWg9/a2cTuLNWdjY5HnCgzuE6Nmt4QfrYWRJNkGL6FV9ZsOw
         XT+f6uAeZzUxDOKPvw7aq/ISQ4b6RLE7mIT+Cdh9WlrzIQeljsEBxJi/fml3hH0rWUHh
         hMY8FW/RemAB3mN3gzR3m/07PhVOMCpvPPJQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=IaPIgiVre6pHfNV2iMDyCFtxny4XP2QJDhh1cSPSqGyfjWyMkrDWAY4ffY/HfRs2Ze
         IUlKqmz4OKm8Z9XhLVsovH3iLZ8cA4ZFluZIUyaP3/0PGgHvEM5dKJYhrjdGv014m5nx
         3g+49X4Pg7vrovwTCxCbZhmV5YUdYWd98m4zE=
Received: by 10.64.65.17 with SMTP id n17mr216900qba.69.1234415988010;
        Wed, 11 Feb 2009 21:19:48 -0800 (PST)
Received: from localhost.localdomain ([68.40.49.130])
        by mx.google.com with ESMTPS id p31sm785554qbp.21.2009.02.11.21.19.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 21:19:47 -0800 (PST)
X-Mailer: git-send-email 1.6.1.399.g0d272
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109576>

Similar to the behaviour for editing a commit message, let terminating
the editor with a failure abort the current hunk edit and revisit the
option selection for the hunk.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
I find it much easier to type :cq in vi than to read the helpful
message that's in the comments and then delete all the hunk lines.
Besides, I already learned how to abort a commit message this way.

Deskin Miller

 git-add--interactive.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5f129a4..f7b0761 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -753,6 +753,10 @@ EOF
 		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 	system('sh', '-c', $editor.' "$@"', $editor, $hunkfile);
 
+	if ($? != 0) {
+		return undef;
+	}
+
 	open $fh, '<', $hunkfile
 		or die "failed to open hunk edit file for reading: " . $!;
 	my @newtext = grep { !/^#/ } <$fh>;
-- 
1.6.1.399.g0d272
