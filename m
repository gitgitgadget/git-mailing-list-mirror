From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] completion: clone can recurse into submodules
Date: Fri, 10 Jun 2016 16:07:53 -0700
Message-ID: <20160610230753.11641-4-sbeller@google.com>
References: <20160610230753.11641-1-sbeller@google.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 11 01:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBVXV-0008Tx-KJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcFJXIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 19:08:24 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36168 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbcFJXIW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 19:08:22 -0400
Received: by mail-pf0-f174.google.com with SMTP id t190so27322163pfb.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LPI5OybbtbCfqGICz6WqTlcKGP9I6l1F45W2Gov9oDY=;
        b=EbQCM61RAT0P2p1SoLfVkOnZkPQTt74eUxkY1u4qihBXWAdmvqbBTqooIS8yH/DiFS
         Qkh6oJPxh0zL1AKgOj2FWSxi8EmLkqzmSeLamyIICNUSDrxX32qeo2+dc8Yg3O5XOPji
         ahLtj2ZIU3/6yzATY2dxxgfxmzDwRYZc6y/+7JbHkND7pGirdec39ZsIgkMdJkkApnSl
         vbRNHIifLhiF+YgfCTIKPsAwpNwnIYGlLjydejH0LNiuGDvqFqtYEoKZQi8dx2iVe/8Y
         EPb+HIqkpQ22E2h6ro5mgu7V3IuDtILSFcMhdkXg0JUOlK8zcEMDlTas+5K0g2Wf53ed
         ODlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LPI5OybbtbCfqGICz6WqTlcKGP9I6l1F45W2Gov9oDY=;
        b=WlonZQqeVg98Xl3XVUMssgjOwCx7fOf5rf+A+qfUccsaM7DYBaX3yTo5luoUKLg2Hs
         W8sbDIazXa/2AjmADkiqe6XDfX4SgDAf9FHai4Qdf+QhkRvx5G6epMLOGaXTonIX4Zj5
         jq2FvH01UmCP+Dy2fcieXCyTqifP18+BXIoPT75pHvRJk9apiUNOdb6DSdPPrYaFZ7BC
         FcuNKUlE1xR6MUqOBzeKbv5HnKgzYlhg3cvke4PktzkecYcq7FqY7/u/YN+xKDXN3aWb
         4sUX6ALuP413VgjTyIUeTJRo4G/qMDgTIMYxz3gRYvcfn3/E9YnreXlB75jXatMO4HGP
         95yg==
X-Gm-Message-State: ALyK8tJ6ibEOAR39uPpxRf8rdmknKlucColZsFKCnDOY41iDvoOaZfvp7DT0AhLiHqb0XNL1
X-Received: by 10.98.90.132 with SMTP id o126mr4769149pfb.146.1465600101964;
        Fri, 10 Jun 2016 16:08:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2099:4ff:ce85:68a])
        by smtp.gmail.com with ESMTPSA id e71sm1165870pfd.44.2016.06.10.16.08.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 16:08:21 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.141.g4e46f88
In-Reply-To: <20160610230753.11641-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297082>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..3d4d24a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1092,6 +1092,8 @@ _git_clone ()
 			--depth
 			--single-branch
 			--branch
+			--recursive
+			--init-submodule
 			"
 		return
 		;;
-- 
2.8.2.141.g4e46f88
