From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 4/6] fast-import: test the new feature command
Date: Wed,  2 Sep 2009 19:57:01 +0200
Message-ID: <1251914223-31435-5-git-send-email-srabbelier@gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu6E-0007Zr-03
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZIBR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZIBR5p
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:45 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48496 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZIBR5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:44 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so909246bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E386h6sZJo6XuP7+oohtqajxhJCSSQdMOvTyjnK/PFA=;
        b=rPTJ2sUy2Pl1OszshXmScmbJHzmERd7oRGldBcHgZ+vIpr8Sj5y/BJW9fgbigdpE9R
         2hV3dkO8BeqxvrE3bEpyLBZTqjgrKPOWDCjGalF0aj3J6JusFWG/Cst5wTLwb2pE5i71
         oncWFe76bvtUcvQIDXJw5PPE0bv0MVDSkq7j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v6x6U/QNmex61LwC6q7FuMhZXCOPl8ksn7O3bTmQsgJ+I6NKWXkTO5ImbEFXb0IrYQ
         v7Pc9peCTL8x339Hv/ND+w+2U9o1K7ivnIYxmBnyusxg/6pA+28vBYn6xtUraT4AlSE7
         UezrJ3CXiTnKbxC3ffbPfQ7G9Yaqd7sHF9aTk=
Received: by 10.204.163.65 with SMTP id z1mr6982095bkx.145.1251914266294;
        Wed, 02 Sep 2009 10:57:46 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127617>

Test that an unknown feature causes fast-import to abort, and that a
known feature is accepted.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
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
