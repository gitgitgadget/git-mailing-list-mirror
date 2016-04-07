From: David Turner <dturner@twopensource.com>
Subject: [PATCH 21/24] check_aliased_update(): check that dst_name is non-NULL
Date: Thu,  7 Apr 2016 15:03:08 -0400
Message-ID: <1460055791-23313-22-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDn-0007MT-08
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbcDGTDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:52 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34386 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932403AbcDGTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:49 -0400
Received: by mail-qg0-f45.google.com with SMTP id c6so71719072qga.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=qomMHZwQMSPiWD8rGMt3FsXI1XLEfCpt1TAYYY4vYao=;
        b=weOJ/ifNKMFGYh8CK4WXIsBmgTn/DNW0oKmfsRA1JmSsuPA33rifvnsM1bWoXszkhm
         Bt2r0n1x2MpTHuNYTadp+SgQAE8Fxo1pLDsmTP6A2c2gySR5z/mdz3pCjsvgaHIk9yHU
         esAY9GMBq7WM/jZ/Ae1rDT42DsYGaNxfQ0xxl5Lt9YDiefVdkdWuTABNf1DK9TSsvkfR
         e670SvljNVgNz9iwxknNYHWaBkZuyVOrEgPBxBAg1dHpTP3H5xpnFvVIny7hdvcaqebZ
         +Q1RS+edm/u81Sq3TWOOoefmjKqsM9pg8nBjXfpjFrn/SYS+qz+Ovv86sQFsrK+HSfLG
         f/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=qomMHZwQMSPiWD8rGMt3FsXI1XLEfCpt1TAYYY4vYao=;
        b=Y+sAxGOHhFtNAg20V9Z23S+Pvk9KjKnhs5qV8EpV0zXu2WOdLsXLA7lUrLixq64Hhz
         hJ7jLYijYGy1iOX9VfbR2zzn+Zxa9St4vkv/QLU+i28VqmpsaKFyBef6xewniFmjkCvX
         CbYdmtbsnqN0mz/PpWItpMEQ6i60i7XVE8IZD8jz2Xf3FXZ63bO3TcokE64VnJidV764
         lhh57ieTvD+PCdNHF1xjbSadSkT71xTlbPWAYWgw40e9d9Pm8GaSS2hv0/M7EryFLeIn
         Yy/MfXmByhAfDZ7RdhirsHp2URXLFZtGRBe8y6W2W7qaFGY9y1RCeNhHl8+38smd3P5H
         sGeA==
X-Gm-Message-State: AD7BkJJIul/iVZmCUpoap7pr/V/g0g0T5VMypXtRN0IaZuyzkVaQLD3mppt2ajD+57K2mA==
X-Received: by 10.140.27.132 with SMTP id 4mr6071353qgx.6.1460055823437;
        Thu, 07 Apr 2016 12:03:43 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290963>

From: Michael Haggerty <mhagger@alum.mit.edu>

If there is an error in resolve_ref_unsafe(), it returns NULL. We check
for this case, but not until after calling strip_namespace(). Instead,
call strip_namespace() *after* the NULL check.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c8e32b2..49cc88d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1081,13 +1081,13 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	if (!(flag & REF_ISSYMREF))
 		return;
 
-	dst_name = strip_namespace(dst_name);
 	if (!dst_name) {
 		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
 		cmd->skip_update = 1;
 		cmd->error_string = "broken symref";
 		return;
 	}
+	dst_name = strip_namespace(dst_name);
 
 	if ((item = string_list_lookup(list, dst_name)) == NULL)
 		return;
-- 
2.4.2.767.g62658d5-twtrsrc
