From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/4] Demonstrate a Windows file locking issue with `git
 clone --dissociate`
Date: Tue, 06 Oct 2015 15:18:03 +0200
Organization: gmx
Message-ID: <278799b6ec328bf9abc028a03298c6c29222adcb.1444131898.git.johannes.schindelin@gmx.de>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <cover.1444131898.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS8B-0004Rt-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbbJFNSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 09:18:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:56469 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbbJFNSF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:18:05 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lp8h6-1aFEe80IHk-00eqEK; Tue, 06 Oct 2015 15:18:04
 +0200
In-Reply-To: <cover.1444131898.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:ig5IzlyRx0MR4/YYTRwgeV2PfqLqp6gp28cLCpnNjR/EDrN5vr/
 Ev9/HRMGqw6yqODt6JKESU0fSEyxGUukWl1/iwV7A2ofMyEQyzdPdXsOIZ1yFnEtmlAIis8
 MposOmtxCOznHIV50vDVYL770wx662xhr6n+iw+hsVmQY2UkXROWFKFpigi944iGEWTahb3
 IxYvEc0WjRmo3EjFstPUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Quv5uZCUzxQ=:Ka/o5RvsQgZ1hAOYYOgEah
 v/rNFvS1jbB6jgGj4qcBfTmwRztin65nfmsUjL4WQd9GMqyFpQjADM9RKbU/2+mpiR8Qih1F5
 D8E25c5Jfic8aOw8GoeVzdX72SaKCwJjdSo6vL/uOK+VKHr3CIjPguqiFMoQubP9A+I4z3tZU
 sqxecSJZYkHkKO7sVjO7IG7APtCk0nHhoBEgVomh8n262ZPU+RBX2bcNSCEzSLjg3C+Gks8qD
 P0wFe2mCicD2DmNjefNpbH4XM+PrDUPoi6ge+ebPcX1x9J/x7KNfYtpnlLC2EK/NG+TcPXVTJ
 nrgXnsTz7O2c56AeloTe7eCKwc+ckTj6xUH6G3XKI2jeg2UA83WsJnIiPkmatNjfU86omPjHw
 B8l6bhLG/1Wqdhyka1u2KODRQtCgei8qU0D3ld5FxAzY5Ugmbpardg/qgAWJoLFBScgeE2EqL
 HD2XMn4yEI/w+dAqOyriLvOBwqmy0E8goY0UtTv3rB6Li6fuCbIvmyCAwNLtgMBk3uabwTfc3
 baq3XVb03bTrWwBqEavPQcKvJ2GjneZ47C7L6sSQ8jkVeIMuwudr4Cz7jzUXLYmfTGLBLXtWM
 H8Ydo9TGBhyHYYrMBRO3mTRvjqcasn72O7dSVxcp4LrslUPZbi+StMxiO7wXySR9g+ckZ9WSn
 8xThcYZg4wHOMvRf75BwLItQh2tJzv2cnrjBz4hxWITuhUriX65FWcS1rBl63dVjDkfRi9k7Q
 0y0+X5mSsIi39NYymrRnfPMlzC40rRwhf9US0RujBK0/klIe7zVhDD5zqMIUvHIvZsAA5vll 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279136>

On Windows, dissociating from a reference can fail very easily due to
pack files that are still in use when they want to be removed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5700-clone-reference.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index ef1779f..f7cec85 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -188,5 +188,26 @@ test_expect_success 'clone and dissociate from reference' '
 	test_must_fail git -C R fsck &&
 	git -C S fsck
 '
+test_expect_failure MINGW 'clone, dissociate from partial reference and repack' '
+	rm -fr P Q R &&
+	git init P &&
+	(
+		cd P &&
+		test_commit one &&
+		git repack &&
+		test_commit two &&
+		git repack
+	) &&
+	git clone --bare P Q &&
+	(
+		cd P &&
+		git checkout -b second &&
+		test_commit three &&
+		git repack
+	) &&
+	git clone --bare --dissociate --reference=P Q R &&
+	ls R/objects/pack/*.pack >packs.txt &&
+	test_line_count = 1 packs.txt
+'
 
 test_done
-- 
2.6.1.windows.1
