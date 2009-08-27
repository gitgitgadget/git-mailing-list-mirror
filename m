From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH v5a 4/6] fast-import: test the new feature command
Date: Thu, 27 Aug 2009 11:40:29 -0700
Message-ID: <1251398431-12461-5-git-send-email-srabbelier@gmail.com>
References: <1251398431-12461-1-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-2-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-3-git-send-email-srabbelier@gmail.com>
 <1251398431-12461-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgjuq-0007FJ-0f
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZH0SlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbZH0SlR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:41:17 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:54967 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZH0SlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:41:14 -0400
Received: by ey-out-2122.google.com with SMTP id 25so303985eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DFraJ4W83YhviclqpWiCG3428nEKa5EkimGwG+gwcpk=;
        b=m/rdB6Ule3BQQI2wQ4Zl7fdfI0doYKPbbjygcM/OnkXAvM5Q+h9zXO82krhyfbkvHQ
         poGVCpVz+lORgd84xVfyKRINwh/kvqNlY/TpNaOpkkGiGIqexEee/X63vh5X+pHEy+6d
         j3neX618+6P2slm0G+bnlaOquxiD2zUz66QF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RfOtSVOhtDUGEgIm1dKOvqUCk9ZXeQSpjOiHgaPTg6JeW9QpCDypn2OeiDUl7SUcdV
         poFn+BQUYQCwkVlIr0axVrvOkgX4gYsRdEW9g7yaY+Gt3U+rueQRBhO72QMYqFysEhO+
         pZk4Vy5d0bLw5hW/rAg/ieJh2hyJRmnU1XFnw=
Received: by 10.216.3.195 with SMTP id 45mr32508weh.8.1251398476494;
        Thu, 27 Aug 2009 11:41:16 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id i35sm1687558gve.26.2009.08.27.11.41.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:41:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251398431-12461-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127193>

Test that an unknown feature causes fast-import to abort, and that a
known feature is accepted.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	New in this series, nothing special here

	Also fixed from line.

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
