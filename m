From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 4/4] pull: parse pull.ff as a bool or string
Date: Wed, 13 May 2015 17:52:20 +0800
Message-ID: <1431510740-9710-5-git-send-email-pyokagan@gmail.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTM6-0004XL-JN
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbbEMJxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:53:31 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32984 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbbEMJx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:53:29 -0400
Received: by pdbnk13 with SMTP id nk13so46531048pdb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NfDcKVMBcXx3q9GYzgK3oORsktC7+eiEs3AcK99HU9M=;
        b=vYh2wiUSy1wVYQ+EjEzLRCewfFHSqP4lU3R2J3modagc60kUD8RvFTAuOORpb1VQmo
         n4H9nmW/IUn0psDeR2aTPN13C5kwRBsZ5FXvesAglsswtwHo9y20HDjVWG+7lnFAr+86
         nj1d7MHBUhyGISSARx/0a88YdFU8KeN1XeeUWxfct/28pCV1e7ERXmkzUDDs7B4jlqKE
         oWEfRGXsoITjNg8BeHeYxLVE9XoAOLVRo2RYHpwCBdPf4T2ivSABfAesddvFbSQcKU/9
         Qdi91durVjFrS9FguhRfZ0dU+mEkHGJHdxdLh7h+7eOjPoYHdMca31gmlcEfAeY9rlHh
         Dk4g==
X-Received: by 10.66.222.72 with SMTP id qk8mr35979403pac.7.1431510808088;
        Wed, 13 May 2015 02:53:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18777927pdr.50.2015.05.13.02.53.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:53:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268971>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15) git-pull
supported setting --(no-)ff via the pull.ff configuration value.
However, as it only matches the string values of "true" and "false", it
does not support other boolean aliases such as "on", "off", "1", "0".
This is inconsistent with the merge.ff setting, which supports these
aliases.

Fix this by using the bool_or_string_config function to retrieve the
value of pull.ff.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index e51dd37..09bc678 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -54,7 +54,7 @@ then
 fi
 
 # Setup default fast-forward options via `pull.ff`
-pull_ff=$(git config pull.ff)
+pull_ff=$(bool_or_string_config pull.ff)
 case "$pull_ff" in
 true)
 	no_ff=--ff
-- 
2.1.4
