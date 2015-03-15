From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 3/3 v2] t3700-add: added test for --exclude option
Date: Mon, 16 Mar 2015 01:07:08 +0600
Message-ID: <1426446428-6279-1-git-send-email-kuleshovmail@gmail.com>
References: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXDsh-0003dL-0Z
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 20:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbbCOTHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 15:07:18 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34756 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbCOTHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 15:07:17 -0400
Received: by lagg8 with SMTP id g8so24034496lag.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDS2PE1J+m0aUp2zMPYtWIIX2cOdtgvz+RTGxScX9tg=;
        b=xq8E4LsYzjYBAgp4bTySzASlEqVHruZKgOgm9wsUNS9wzrMsmsCdud5RPYPRcpUX0g
         //N6fTEpHwW+pgyUKcdeh8dEjQQ7dWm+hZb2JfbVtTzWxitW7U+ZuF4Jao2Xg11exdXw
         zP8d0+DmCFbeLm+QMP1as0G5yau0hhXer6IdoQGjLhE/lRK0q4VTw+Cu27buuilD0HUe
         TTw+Le8pIHxKeOo6F0htw8tR374zHK/k5sOPga/XUBU8OAmcNiaUT7953SyyyE8nqtFO
         ZBhTgE8DCX7nb96o4s5VVZeXGu1hPpleV0pNED7adt/eQ2AvayHLq4O0my8eqyi4D83h
         uJ+g==
X-Received: by 10.152.198.203 with SMTP id je11mr43725247lac.85.1426446436178;
        Sun, 15 Mar 2015 12:07:16 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id dz1sm1715602lbc.47.2015.03.15.12.07.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 12:07:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac.dirty
In-Reply-To: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265514>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 t/t3700-add.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f7ff1f5..6f71c67 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -332,4 +332,22 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success 'Test that "git add --exclude" works' '
+	>foo &&
+	>bar &&
+	git add --exclude=bar . &&
+	! (git ls-files | grep bar)
+	(git ls-files | grep foo)
+'
+
+test_expect_success 'Test multiply --exclude' '
+	>foo &&
+	>bar &&
+	>"b a z" &&
+	git add --exclude="bar" --exclude="b a z" . &&
+	(git ls-files | grep foo)
+	! (git ls-files | grep "b a z")
+	! (git ls-files | grep "baz")
+'
+
 test_done
-- 
2.3.3.472.g20ceeac.dirty
