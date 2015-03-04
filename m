From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] completion: add a test for __git_remotes() helper function
Date: Wed,  4 Mar 2015 15:10:28 +0100
Message-ID: <1425478229-11252-1-git-send-email-szeder@ira.uka.de>
References: <20150304150447.Horde.t4rJ5Q_QdRg1uznQKWetMg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Korostoff <mkorostoff@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTA1P-0003mK-29
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 15:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429AbbCDOLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 09:11:25 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33201 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756674AbbCDOLB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 09:11:01 -0500
Received: from x590c628a.dyn.telefonica.de ([89.12.98.138] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YTA0l-00065j-VZ; Wed, 04 Mar 2015 15:10:57 +0100
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <20150304150447.Horde.t4rJ5Q_QdRg1uznQKWetMg1@webmail.informatik.kit.edu>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1425478257.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264760>

The test checks that both remotes under '$GIT_DIR/remotes' and remotes
in the config file are listed.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9902-completion.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f10a752..7a883d1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -351,6 +351,25 @@ test_expect_success '__gitcomp_nl - doesnt fail be=
cause of invalid variable name
 	__gitcomp_nl "$invalid_variable_name"
 '
=20
+test_expect_success '__git_remotes - list remotes from $GIT_DIR/remote=
s and from config file' '
+	cat >expect <<-EOF &&
+	remote_from_file_1
+	remote_from_file_2
+	remote_in_config_1
+	remote_in_config_2
+	EOF
+	test_when_finished "rm -rf .git/remotes" &&
+	mkdir -p .git/remotes &&
+	>.git/remotes/remote_from_file_1 &&
+	>.git/remotes/remote_from_file_2 &&
+	test_when_finished "git remote remove remote_in_config_1" &&
+	git remote add remote_in_config_1 git://remote_1 &&
+	test_when_finished "git remote remove remote_in_config_2" &&
+	git remote add remote_in_config_2 git://remote_2 &&
+	__git_remotes >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
--=20
2.1.2.1369.g8751039
