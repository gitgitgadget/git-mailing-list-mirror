From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 11/13] remote-testgit: implement the "done" feature manually
Date: Wed, 28 Nov 2012 23:11:07 +0100
Message-ID: <1354140669-23533-12-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprt-0003JU-O6
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822Ab2K1WME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:12:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab2K1WMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:12:00 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=O8292BZY+b+GDB9+cfKAkrq/iCcvNaVsN1q8zFiRoHs=;
        b=erdc4UDVGD+mQZHMyXx2lyNdqkDh8BMhIHLX3+6dz1n7psNWsNQyAG/TUiT5VEci0r
         9QXdlCAfqEijixequQ1T34IylP/AzREYLyeF5nmhvksN1k/oeN6wOvIagsGpTcjJY3s+
         YTdvmOQPEuuNNgJY39460MArZYWjTj4VNBUQG1asui2GDYjWX7vb8WWmVLacJ4Xbolls
         vZROFnOBhorXwSJ0hd9f8Da2JSMmE+gumSEYa8wuiO64CdhzbKraSFQZq3Dsp243Wd2i
         pDnVELNHp70eNTuuF39iY24Yo9exNqEs3elBmnE77Awor2aeJugqxYV2JyxIRSqJ3HxW
         Yw2Q==
Received: by 10.204.12.202 with SMTP id y10mr6413297bky.51.1354140720105;
        Wed, 28 Nov 2012 14:12:00 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id f24sm13785025bkv.7.2012.11.28.14.11.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:59 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210794>

People who want to write their own remote-helper will find it more
useful to see clearly how they are supposed to advertise and implement
the "done" feature themselves.

Right now we are relying on fast-export to do that by using the
--use-done-feature argument. However, people writing their own
remote-helper would probably not have such an option, as they would
probably be writing the fast-export functionality themselves.

It should now be clearer to them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 6fb8780..b395c8d 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -61,8 +61,10 @@ do
 			echo "feature import-marks=$gitmarks"
 			echo "feature export-marks=$gitmarks"
 		fi
-		git fast-export --use-done-feature "${testgitmarks_args[@]}" $refs |
+		echo "feature done"
+		git fast-export "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
+		echo "done"
 		;;
 	export)
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
-- 
1.8.0.1
