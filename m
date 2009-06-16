From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 1/5] t4150: test applying with a newline in subject
Date: Tue, 16 Jun 2009 15:32:57 -0700
Message-ID: <1245191581-11127-2-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-1-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhER-0001yF-Ff
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbZFPWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758699AbZFPWdK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:28763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759538AbZFPWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:04 -0400
Received: by wa-out-1112.google.com with SMTP id j5so969312wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=bxpGZbgvPlc46WMwVOUI7eQwWqHirSoAI3yjovHzwh8=;
        b=QYSZLgM7T4WOgCrHi31kG5Pcgmgxyv/gxbwrTFFSb+8mQpcpAc8g5RkKP1L1vZ6xye
         VFP0OGr6SeJCOUf3EiUDp+zhWrxE7C+h/PTchPKphLdA3CCUlcYmtILvW7mCix3bpFL7
         FNU6xW02xg+bFHZqVUQdtxLvGZ2iu6dJGu/OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Up3GzrHp/sTrypxjX0SZGIRnd3vHf6gdS0dme5hiHlmFiyESJ/oCdM4mxe1FkCmkMT
         QgGt4qkgs+hrzj0j8RdkosifSKOJ4wnzE/xNZepvOblVMrQi/Fa/CpFgFTjl5szfkiJX
         d01omlVMgizNMO+kker1QdkP9w+4Su7yqNxTQ=
Received: by 10.115.50.5 with SMTP id c5mr14356933wak.228.1245191586988;
        Tue, 16 Jun 2009 15:33:06 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id c26sm1530720waa.15.2009.06.16.15.33.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:06 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:04 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121721>

Commit 4b7cc26 (git-am: use printf instead of echo on user-supplied
strings, 2007-05-25) fixed a bug where subjects with newlines would
cause git-am to echo multiple lines when it says "Applying: <subject>".

This test ensures that fix stays valid.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Nothing new here.

 t/t4150-am.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d6ebbae..51c369a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -305,4 +305,12 @@ test_expect_success 'am into an unborn branch' '
 	test "z$result" = "z$(git rev-parse first^{tree})"
 '
 
+test_expect_success 'am newline in subject' '
+	git checkout first &&
+	test_tick &&
+	sed -e "s/second/second \\\n foo/" patch1 > patchnl &&
+	git am < patchnl > output.out 2>&1 &&
+	grep "^Applying: second \\\n foo$" output.out
+'
+
 test_done
-- 
1.6.3.2.306.g4f4fa
