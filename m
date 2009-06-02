From: Ben Willard <benwillard@gmail.com>
Subject: [PATCH 1/2] t8006: Add test to show blame failure
Date: Tue, 2 Jun 2009 15:28:55 -0400
Message-ID: <4a257d7b.1358560a.504d.47c3@mx.google.com>
References: <cover.1243969358.git.benwillard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 21:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBZfd-0007Ba-G4
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbZFBT3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 15:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbZFBT3A
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 15:29:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:42429 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZFBT3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 15:29:00 -0400
Received: by fg-out-1718.google.com with SMTP id 16so3154121fgg.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7k95KOinUQh2j6hg+9SqKyww1uHx1Qz7xu3Ww7NLPq8=;
        b=Pad7QW/UGZ257JZPExcDCU/vqPbyQ4MUGnoDQPJTFp75dW68Fy2aMwE3UXsH0nShWI
         vdSa/avD53+I37+5UvDef3RtvfjWWWJOJ4t2Mz/Jp6z4z7zNNdMjqcf7TIAEbtwn9497
         gDDktdRzTGvPftzuWquh7ltOtWq/xEreQX6r4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V/ig6XfOwtecNykJszwpS113sNsb3hl2WGzH2pvdC4hRTHvvSsmko9QmeP8dLU2qWV
         3aealsmh/BCtgP5DUvmrRHCCWtikJLDZoqE8yEaMnyHTHNjI6T3ruoHCpCIYH3cBAbHW
         30XBG4LjddtSQJ56Rap5lPReOPaJXXJzjep+8=
Received: by 10.86.70.20 with SMTP id s20mr216465fga.1.1243970940932;
        Tue, 02 Jun 2009 12:29:00 -0700 (PDT)
Received: from ben-laptop (rn--cgr-1-1-a38.uwaterloo.ca [129.97.253.234])
        by mx.google.com with ESMTPS id l19sm12356148fgb.7.2009.06.02.12.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 12:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1243969358.git.benwillard@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120536>

'git blame' fails on a file which was changed from a directory to a file
in a single commit.  This test shows the failure.

Signed-off-by: Ben Willard <benwillard@gmail.com>
---
 t/t8006-blame.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100755 t/t8006-blame.sh

diff --git a/t/t8006-blame.sh b/t/t8006-blame.sh
new file mode 100755
index 0000000..7c271f0
--- /dev/null
+++ b/t/t8006-blame.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='git blame on file which changed from a directory to a file in the same commit'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	touch dir/file &&
+	git add dir/file &&
+	git commit -m "Add dir/file" &&
+	git rm dir/file &&
+	echo "File contents" > dir &&
+	git add dir &&
+	git commit -m "Add dir as a file"
+'
+
+test_expect_failure 'blame runs on dir' '
+	git blame dir
+'
+
+test_done
-- 
1.6.3.1.279.gd4bf4
