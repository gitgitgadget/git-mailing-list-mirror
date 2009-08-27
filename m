From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v5 4/6] fast-import: test the new feature command
Date: Thu, 27 Aug 2009 11:12:14 -0700
Message-ID: <1251396736-928-4-git-send-email-srabbelier@gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com>
 <1251396736-928-2-git-send-email-srabbelier@gmail.com>
 <1251396736-928-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:13:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgjTI-0007KF-2j
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbZH0SMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbZH0SMl
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:12:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:64890 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbZH0SMi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:12:38 -0400
Received: by ey-out-2122.google.com with SMTP id 25so299070eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uHgo8W6Yhh7PLRmZhvbJ04QQoxlQaKOF5BEHrmgguTE=;
        b=IqaAbetHqESFJeuvrw6CSzZYrb5a6+fdIljuOUqvH9E+EWGGG1m85rPj1nWLcqj8Jz
         FGazVmVEBesmiZz0a/fnsRaeQu5JleUK7zbJ1oI9TNxgwADHeQ/nhVCoy5ee/1UFNUqw
         qNC2VB2bI53OYYtSABOSHQ3fj7xFUKH6irfyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ePAUOB9ERZBlud53oXCplAcjJlhTD8FSyJAaabtHK/g2KDacumifvVhijUKTUZwmhc
         behJ6yRkxblYMl3dcwvv11kz5Vix1Juejr+I7PszmLDkBOyuuCbMaB3Bxz8NrAZ9CnwU
         sdw1cQUCnq/HTG9MswwKM1xK0R5baIVU2TWGA=
Received: by 10.210.38.2 with SMTP id l2mr4948684ebl.59.1251396759878;
        Thu, 27 Aug 2009 11:12:39 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id 10sm62710eyz.25.2009.08.27.11.12.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:12:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251396736-928-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127186>

From: Sverre Rabbelier <srabbelier@google.com>

Test that an unknown feature causes fast-import to abort, and that a
known feature is accepted.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	New in this series, nothing special here.

 t/t9300-fast-import.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..a5b9b38 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,24 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series Q (feature)
+###
+
+cat >input <<EOF
+feature no-such-feature-exists
+EOF
+
+test_expect_success 'Q: abort on unsupported feature' '
+	test_must_fail git fast-import <input
+'
+
+cat >input <<EOF
+feature date-format=now
+EOF
+
+test_expect_success 'Q: supported feature is accepted' '
+	git fast-import <input
+'
+
 test_done
-- 
1.6.4.122.g6ffd7
