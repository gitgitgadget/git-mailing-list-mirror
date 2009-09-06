From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 4/6] fast-import: test the new feature command
Date: Sun,  6 Sep 2009 16:35:46 +0200
Message-ID: <1252247748-14507-5-git-send-email-srabbelier@gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIrB-00078l-HP
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbZIFOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757980AbZIFOgT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:51847 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757970AbZIFOgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:15 -0400
Received: by ey-out-2122.google.com with SMTP id 25so801745eya.19
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UJDpKOiXN7GNkD0kEG/usPExDKtvU64HovXBu6c3n18=;
        b=RJhdUubO40XGohYsRwcNhCmI1JMLD7v+WyBOuZtGUsKobwzuMzqsuDebOGJBrxVO7e
         ujiarxpr7xUi9rTI86sSZCLXu2qM1SMEbCZISIkrFLxi2jbNWyJ0R45vfcI0n1O4tiOA
         0h9PEO/oFKCvNBamic53Eg8uFlFCRBG7P9J68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LHM66X9W8J0XBIyKPxxAd1+aAZhr2ZO1W1Dfx8t7Oz+kjEfsFd90Tuen4tXORdYYX4
         AQik7jhooiiK3VWXcSkH0AVbjiJonDoK16g/E2bnniv/fCWm8tooc5edbh/o+TgRnA1/
         a9T/1W25K0QLmju+nHz9lbAqlQb7ZOjCHuF40=
Received: by 10.216.90.7 with SMTP id d7mr1261832wef.81.1252247777281;
        Sun, 06 Sep 2009 07:36:17 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1252247748-14507-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127858>

Test that an unknown feature causes fast-import to abort, and that a
known feature is accepted.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged since v6.

 t/t9300-fast-import.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..564ed6b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,24 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series R (feature)
+###
+
+cat >input <<EOF
+feature no-such-feature-exists
+EOF
+
+test_expect_success 'R: abort on unsupported feature' '
+	test_must_fail git fast-import <input
+'
+
+cat >input <<EOF
+feature date-format=now
+EOF
+
+test_expect_success 'R: supported feature is accepted' '
+	git fast-import <input
+'
+
 test_done
-- 
1.6.4.16.g72c66.dirty
