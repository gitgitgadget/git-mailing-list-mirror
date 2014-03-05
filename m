From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t7800: add a difftool test for .git-files
Date: Wed,  5 Mar 2014 01:23:35 -0800
Message-ID: <1394011415-99543-1-git-send-email-davvid@gmail.com>
References: <530FAA2D.8060104@web.de>
Cc: git@vger.kernel.org,
	=?UTF-8?q?G=C3=A1bor=20Lipt=C3=A1k?= <gabor.liptak@gmail.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL83V-00087S-Nc
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 10:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbaCEJXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 04:23:55 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50831 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCEJXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 04:23:53 -0500
Received: by mail-pd0-f178.google.com with SMTP id x10so812395pdj.37
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 01:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AydmXxOZqE1crAxGR2yRWI74qzhzamkHpb2AuSfdJFk=;
        b=v07ZO8LHC2ig0L99dJAI4jI+3HyaJjnz0DO2/ZviFwqyhqgsgI6szbSWrLS7HrLz81
         C6gvqcPfMnR5cvSB44EBK336XGCOEoCxhMSM82Jk/GEC0qcOZdqNbhSWB8mmkyU9VVRJ
         Cbbg4bSINfQWu9gTrrlufHkILPIWMY9OOoCDb26R8Dhiq/qAv6LCDn5KAAf2q4hspOv+
         pV+v4cwe3om365CaSkpykCH6O4heYUz8BjLp4FnT+zdiuo0x5/h6T464AumJHJ34NAev
         9btz34vUPC3d1f/zPlWKegs2rAJdNJOypnGqa7KPLK6CFotVdHoJsw0ZF7eKYd57hRdC
         b1Bw==
X-Received: by 10.68.242.68 with SMTP id wo4mr5788307pbc.32.1394011432508;
        Wed, 05 Mar 2014 01:23:52 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id gg3sm5926547pbc.34.2014.03.05.01.23.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Mar 2014 01:23:51 -0800 (PST)
X-Mailer: git-send-email 1.8.5.5.2.g42fdfc9
In-Reply-To: <530FAA2D.8060104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243429>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a replacement patch for the current tip of da/difftool.

 t/t7800-difftool.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2418528..986b78e 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -434,4 +434,18 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
 	)
 '
 
+test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
+	git submodule add ./. submod/ule &&
+	(
+		cd submod/ule &&
+		test_config diff.tool checktrees &&
+		test_config difftool.checktrees.cmd '\''
+			test -d "$LOCAL" && test -d "$REMOTE" && echo good
+		'\'' &&
+		echo good>expect &&
+		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.8.5.5.2.g42fdfc9
