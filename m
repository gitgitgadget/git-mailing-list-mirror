From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 26/36] rebase: cherry-pick: fix abort of cherry mode
Date: Sun,  9 Jun 2013 14:24:40 -0500
Message-ID: <1370805890-3453-27-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHk-0003yF-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456Ab3FIT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40344 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab3FIT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:59 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so9135232obb.15
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TCS3QidtT44FLGA2ZGFWPm0BGB2Kzo6jgeEmbXm+7x0=;
        b=qAicyloY7S5fE+Mtr1aZWKTjHpT0cbE7jQbOSzHIRiAqJ+OG75OwPaQ9JdJvCVYxtM
         WbGRm1kN1o/VE7Dkzp/GYioPB2X+Kr9n/ahz64ByENXKzNadojILhO/bZgdobIhsqg33
         d9Y0vpwmKYUikje3+OnD1OjKaiz19UY05SJjR6mwDATndv1LcV1j7EiFwAVKpUwW8f6Z
         uE/h6qj7pnMnE79VYFHnJPc+XjFyZdd5zlhoov97RglAo2eVbodDWWyC6lq6jCDB61bG
         doFvmLdLOqrz7AXZtpXJjLawmv1/zBz/gYIifVnICAXsNnM35JcKRHdWYUY5+VOMZiA3
         zduA==
X-Received: by 10.182.105.102 with SMTP id gl6mr5579550obb.18.1370806078846;
        Sun, 09 Jun 2013 12:27:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm15947631oby.12.2013.06.09.12.27.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227133>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 4465daf..0937e2c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -369,6 +369,7 @@ skip)
 	run_specific_rebase
 	;;
 abort)
+	test "$type" == "cherrypick" && git cherry-pick --abort
 	git rerere clear
 	read_basic_state
 	case "$head_name" in
-- 
1.8.3.698.g079b096
