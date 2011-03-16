From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] stash: fix incorrect quoting in cleanup of temporary
 files
Date: Wed, 16 Mar 2011 09:14:33 +0100
Message-ID: <4D807169.5070804@viscovery.net>
References: <4D7F3AA4.1080202@elegosoft.com>	<4D7F466A.4090508@viscovery.net>	<4D7F54C2.5060500@elegosoft.com>	<4D7F5DA0.3030608@viscovery.net>	<7vk4g09o9x.fsf@alter.siamese.dyndns.org> <AANLkTi=+-tDz6XSSUAyvzGZ6fJohSU+rY4GhRa5C-+oA@mail.gmail.com> <4D8070E1.8000305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>, casey@nrlssc.navy.mil,
	jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 09:14:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzlsQ-0004Si-85
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 09:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab1CPIOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 04:14:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28142 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751250Ab1CPIOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 04:14:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PzlsH-00068s-Kf; Wed, 16 Mar 2011 09:14:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 57C9E1660F;
	Wed, 16 Mar 2011 09:14:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D8070E1.8000305@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169119>

From: Johannes Sixt <j6t@kdbg.org>

The * was inside the quotes, so that the pattern was never expanded and the
temporary files were never removed. As a consequence, 'stash -p' left a
.git-stash-*-patch file in $GIT_DIR. Other code paths did not leave files
behind because they removed the temporary file themselves, at least in
non-error paths.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..7c0d563 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -17,7 +17,7 @@ require_work_tree
 cd_to_toplevel
 
 TMP="$GIT_DIR/.git-stash.$$"
-trap 'rm -f "$TMP-*"' 0
+trap 'rm -f "$TMP-"*' 0
 
 ref_stash=refs/stash
 
-- 
1.7.4.1.316.g2ab2cb
