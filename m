From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] rebase: test ack
Date: Mon, 19 May 2014 00:17:51 +0300
Message-ID: <1400447743-18513-4-git-send-email-mst@redhat.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 23:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm8UC-0006OI-Cs
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 23:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbaERVTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 17:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61641 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139AbaERVS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 17:18:58 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4ILIvKY011808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:58 -0400
Received: from redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s4ILIulj018717
	for <git@vger.kernel.org>; Sun, 18 May 2014 17:18:57 -0400
Content-Disposition: inline
In-Reply-To: <1400447743-18513-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249513>

test ack! handling

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t3415-rebase-autosquash.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 41370ab..9d7db13 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -74,6 +74,21 @@ test_expect_success 'auto squash (option)' '
 	test_auto_squash final-squash --autosquash
 '
 
+test_expect_success 'auto ack' '
+	ack="Acked-by: xyz"
+	msg=$(test_write_lines "ack! first commit" "" "$ack")
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
