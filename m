From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Fix diff-tree -s
Date: Tue, 27 Jun 2006 19:43:22 +0300
Message-ID: <20060627194322.3608050a.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 18:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvGfK-0001e5-W5
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 18:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWF0Qnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 12:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWF0Qn1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 12:43:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6063 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161187AbWF0QnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 12:43:25 -0400
Received: by nf-out-0910.google.com with SMTP id m19so756613nfc
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 09:43:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=M09HFnjlUSlI7RKSflz7I4bicBBQvfjq0pnaQLnlrOul+LxGJyh5/JtiF3BvNIwldc/+YQEZKq3QrZoMtVdJj4uui3G0dzKp7Ip+53fX7Fnvwf6g64QHkEoUEfYXvJr9hyq5I+UhxokwUSo42ujr2h+9e+90/lx/812q+VdA4oU=
Received: by 10.49.3.3 with SMTP id f3mr5751257nfi;
        Tue, 27 Jun 2006 09:43:23 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id g1sm7401737nfe.2006.06.27.09.43.23;
        Tue, 27 Jun 2006 09:43:23 -0700 (PDT)
To: junkio@cox.net
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22741>

setup_revisions() calls diff_setup_done() before we can set default
value for output_format.  Don't convert DIFF_FORMAT_NO_OUTPUT to 0 in
diff_setup_done(), it is useless and makes diff-tree believe no diff
format parameters were given and thus lets it reset output_format to
DIFF_FORMAT_RAW.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 diff.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2c47f11..9b8a6e5 100644
--- a/diff.c
+++ b/diff.c
@@ -1385,9 +1385,6 @@ int diff_setup_done(struct diff_options 
 	    (0 <= options->rename_limit && !options->detect_rename))
 		return -1;
 
-	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
-		options->output_format = 0;
-
 	if (options->output_format & (DIFF_FORMAT_NAME |
 				      DIFF_FORMAT_NAME_STATUS |
 				      DIFF_FORMAT_CHECKDIFF |
-- 
1.4.1.rc1.g1ef9
