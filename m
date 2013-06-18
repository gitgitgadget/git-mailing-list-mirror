From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/8] sh-setup: make die_with_status clear GIT_REFLOG_ACTION
Date: Tue, 18 Jun 2013 17:44:28 +0530
Message-ID: <1371557670-12534-7-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uour9-00080s-4l
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab3FRMRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:49 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45781 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab3FRMRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:47 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so3841012pbc.9
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tK94aPb0UKxn82IN0LVKesc6QLBKHKIuog09gmhK/Yk=;
        b=YPOMRfvNDv5rnr+NwNluKehmEsl1JVIefpv/TbQE2xcJljV68YXZoHGc9Fyrl7Yp7M
         bUJAZmHiZTAmOMGdXfu+cHz1DAQN1DT/A3t0ULge5ERm9t7sQMZXqjAQC0uqvBUtKM/R
         BTi4ciq/H8kmgMPcf7BJr1I3Dt0I9jYYDP3lj4KwFF0x39JrZRdC/L+17WOtq/YRHplb
         cRc4yWFQtd5CXnCrksg4FDAtWS45IrT5kVZXbtgak6+q+wRQBnWCQO+EnzizSAg1RU8L
         arPldnsVgLPEe3jpx3+jsF8stH7WL28Q8/7uE9EH0iRViXaJUiLd/+JHKU+QIa3JL0SA
         E2jQ==
X-Received: by 10.66.219.1 with SMTP id pk1mr1959299pac.29.1371557867172;
        Tue, 18 Jun 2013 05:17:47 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228208>

Several callers set GIT_REFLOG_ACTION via set_reflog_action(), but
nobody unsets it, leaving a potentially stray variable in the
environment.  Fix this by making die_with_status() unset it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2f78359..3297103 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -51,6 +51,7 @@ die () {
 }
 
 die_with_status () {
+	export GIT_REFLOG_ACTION=
 	status=$1
 	shift
 	echo >&2 "$*"
-- 
1.8.3.1.456.gb7f4cb6
