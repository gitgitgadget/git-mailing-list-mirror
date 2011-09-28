From: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
Subject: [GUILT 1/6] Refuse to push corrupt patches
Date: Wed, 28 Sep 2011 15:15:19 +0100
Message-ID: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Cc: git@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@googlemail.com>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed Sep 28 16:15:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uvI-0006dQ-P6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab1I1OPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:15:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52041 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1I1OPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:15:36 -0400
Received: by wwf22 with SMTP id 22so8980006wwf.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=95n+8aBZFtD2tts8F58qnV/f4E6qlkrvSiNIVYnRA40=;
        b=geeGkmC4GzGJ6ysrpn/weZCmgTvtC7tck47j6QwzCl7YpwjcSNBcjcD3gKPRdEM9T9
         KkVM88Y8TJKlLzoA2TH0k4tA31orNqcJYu9LhzVbGnNgn6/FrF5BHLUCXMySEQaCeCku
         PMQ4LUYbyBnUL9zRx8YHVZ5a+bx4k6+XhqHTw=
Received: by 10.216.134.217 with SMTP id s67mr3376201wei.101.1317219335531;
        Wed, 28 Sep 2011 07:15:35 -0700 (PDT)
Received: from localhost.localdomain ([86.53.68.233])
        by mx.google.com with ESMTPS id n21sm40795936wbp.2.2011.09.28.07.15.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 07:15:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182319>

"guilt push" would treat corrupt patches as empty,
because "git apply --numstat" prints nothing on stdout.

(You do get an error message on stderr,
 but then guilt says "Patch applied" etc,
 and I didn't notice the earlier error message
 for quite some time.)

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
---
 guilt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/guilt b/guilt
index d1e17d4..51532f9 100755
--- a/guilt
+++ b/guilt
@@ -611,7 +611,7 @@ push_patch()
 		cd_to_toplevel
 
 		# apply the patch if and only if there is something to apply
-		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
+		if [ `do_get_patch "$p" | wc -l` -gt 0 ]; then
 			if [ "$bail_action" = abort ]; then
 				reject=""
 			fi
-- 
1.7.4.1
