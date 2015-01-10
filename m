From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] git-svn: show progress in working_head_info()
Date: Sat, 10 Jan 2015 08:21:36 -0500
Message-ID: <1420896096-15254-1-git-send-email-artagnon@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9vzF-0000OE-2d
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 14:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbbAJNVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 08:21:46 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:62115 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbAJNVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 08:21:45 -0500
Received: by mail-qg0-f45.google.com with SMTP id z107so12647846qgd.4
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mF5tHvJ03CRfxaINjcg+rleg084JMQLZScTrozRHo4M=;
        b=D7ky93/4vtSTJhxHLTJnXD2wAhmev8cqp+LQXH2eZIQR8cviPumeB90Z8jFfohrloy
         pmhGpejl3mAPJEm0Linj0CSiejEulWLwGp5uk8c8msGw19JaBU3CmKFFQ5S01FKGCVZ7
         Gyz8lkJS7R1+QZH4nhF0jj3uH+nHFTs8VRWXzBFxItfOJ788J+NSLUvcHLt5L3WQ0paw
         6n+GIBhrcFixvXhaqfWVJZh4sDJlclxBa6ACOVGVOAw+NTEGocTZvOn1F/7/5GH87Koe
         h0KSvrZY53z2Az/W+9uhu4zyN50Difjj5CkDmBwbZJuoblLojebn5/8/N+fWs1t4oSLr
         sdnQ==
X-Received: by 10.140.107.230 with SMTP id h93mr33911768qgf.6.1420896103636;
        Sat, 10 Jan 2015 05:21:43 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id c7sm9680150qar.33.2015.01.10.05.21.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 05:21:42 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262261>

The working_head_info routine takes a very long time to execute on large
repositories. The least we can do is to comfort users that some progress
is being made.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I was worried because of the long wait, so I wrote this to convince
 myself that git-svn wasn't stuck.

 git-svn.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 60f8814..6aa156c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2022,6 +2022,9 @@ sub working_head_info {
 			next;
 		}
 		next unless s{^\s*(git-svn-id:)}{$1};
+		my $chomped = $_;
+		chomp $chomped;
+		print "[Importing] $chomped\n";
 		my ($url, $rev, $uuid) = extract_metadata($_);
 		if (defined $url && defined $rev) {
 			next if $max{$url} and $max{$url} < $rev;
-- 
2.2.1
