From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: t5505-remote.29 not working correctly
Date: Mon, 15 Mar 2010 20:12:36 -0500
Message-ID: <OGVB8d37MB-s4H3VOECmd2htUvpq3B4NginojN-XskLyvHmnbfGA4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 02:13:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrLLO-0001SF-Dn
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 02:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937306Ab0CPBNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 21:13:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54361 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937302Ab0CPBNH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 21:13:07 -0400
Received: by mail.nrlssc.navy.mil id o2G1CaKd004557; Mon, 15 Mar 2010 20:12:36 -0500
X-OriginalArrivalTime: 16 Mar 2010 01:12:36.0470 (UTC) FILETIME=[C3A81160:01CAC4A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142289>


Junio,

I ran across this flaw while investigating something else.

The test titled 'remote prune to cause a dangling symref' is
not linked together with &&'s.  When the &&'s are added, it
does not complete successfully.

Here's the copy&pasted diff which adds '&&' in two places:

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a82c5ff..a3406dd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -510,12 +510,12 @@ test_expect_success 'remote prune to cause a dangling symr
        ) 2>err &&
        grep "has become dangling" err &&
 
-       : And the dangling symref will not cause other annoying errors
+       : And the dangling symref will not cause other annoying errors &&
        (
                cd seven &&
                git branch -a
        ) 2>err &&
-       ! grep "points nowhere" err
+       ! grep "points nowhere" err &&
        (
                cd seven &&
                test_must_fail git branch nomore origin


The first grep causes the failure:

   ...
   (
   	cd seven &&
   	git remote prune origin
   ) 2>err &&
   grep "has become dangling" err &&
   ...

'git remote prune origin' is not printing "has become dangling".

-brandon
