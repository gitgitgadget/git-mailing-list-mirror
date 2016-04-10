From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] rebase: test ack
Date: Sun, 10 Apr 2016 16:54:50 +0300
Message-ID: <1460296343-17304-4-git-send-email-mst@redhat.com>
References: <1460296343-17304-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bafain@gmail.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:55:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFpx-0005MQ-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbcDJNyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbcDJNyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:54:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47418C049E1D;
	Sun, 10 Apr 2016 13:54:52 +0000 (UTC)
Received: from redhat.com (vpn1-4-6.ams2.redhat.com [10.36.4.6])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3ADsokV023868;
	Sun, 10 Apr 2016 09:54:51 -0400
Content-Disposition: inline
In-Reply-To: <1460296343-17304-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291172>

test ack! handling

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t3415-rebase-autosquash.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 8f53e54..e78897d 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -74,6 +74,21 @@ test_expect_success 'auto squash (option)' '
 	test_auto_squash final-squash --autosquash
 '
 
+test_expect_success 'auto ack' '
+	ack="Acked-by: xyz" &&
+	msg=$(test_write_lines "ack! first commit" "" "$ack") &&
+	git reset --hard base &&
+	git commit --allow-empty -m "$msg" -- &&
+	git tag ack &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	git show -s first-commit | grep -v ^commit > expected-msg &&
+	echo "    $ack" >> expected-msg &&
+	git show -s HEAD^ | grep -v ^commit > actual-msg &&
+	diff actual-msg expected-msg
+'
+
 test_expect_success 'auto squash (config)' '
 	git config rebase.autosquash true &&
 	test_auto_squash final-squash-config-true &&
-- 
MST
