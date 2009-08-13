From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 4/4] fast-import: test the new option command
Date: Wed, 12 Aug 2009 22:09:46 -0700
Message-ID: <1250140186-12363-5-git-send-email-srabbelier@gmail.com>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSaM-0001rC-2Z
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbZHMFKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZHMFK2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:65153 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbZHMFKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:25 -0400
Received: by rv-out-0506.google.com with SMTP id f6so169039rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4wOteGDBoh+/BgzBC6oaXzaafa8zPmWqiWwoXGEJvb4=;
        b=mh+YzNHnIoFTSYQDfJ8hbNa/G0QwIOieTKeBAJcIWrVh6CmkziuMUdcr5+w71cQTf9
         Qay5LQQs+VO+kVD5oSvlTrdAyj9JEpSC8V94OyI76dCncYg8vYJ1EHbTRgrxbLYX8YUk
         GpYTufefxNccp//LpQmI/vbVV+EgCkP5/r+pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TzyP3mdgsLEO57llTRmH+ti4FCBCNcGXi33F+sw3EjTxlaZUEGTOVHv54owhRR71Qg
         YTwuLIdnH/khpQ5HMdmrZxCKyHj1PUY30T8Q8jU6suCHEZJApsRljk+Qk6md51pXmXRt
         kXPZHWEyh8jRJGw/rmx4B8ncAhrODaplbBIHY=
Received: by 10.141.27.7 with SMTP id e7mr372493rvj.257.1250140226429;
        Wed, 12 Aug 2009 22:10:26 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm6740240rvb.20.2009.08.12.22.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:10:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250140186-12363-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125780>

---

    Only difference with the previous version is
    s/export-marks /export-marks=/

 t/t9300-fast-import.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..4152c3a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,37 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series Q (options)
+###
+
+cat >input << EOF
+option quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'Q: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input << EOF
+option export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'Q: export-marks option results in a marks file being created' \
+    'cat input | git fast-import 2> output &&
+    grep :1 git.marks'
+
 test_done
-- 
1.6.4.16.g72c66.dirty
