From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/5] submodule--helper, module_clone: catch fprintf failure
Date: Thu, 31 Mar 2016 14:04:40 -0700
Message-ID: <1459458280-17619-6-git-send-email-sbeller@google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljlz-0008U3-BL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266AbcCaVEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:04:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33506 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933147AbcCaVEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:50 -0400
Received: by mail-pa0-f54.google.com with SMTP id zm5so74217883pac.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dUxC/mWSujUk0vaPP5nHw6YfVIuWLldSFzu+m4FFUOE=;
        b=nK4eosx+pm2dl54edpN30Bcu+pq7DqG3m0+1femvCYX/WJWxKLsAfjBvFn94sztgFT
         oPTl+N3RYwiGwIC41cxx6OxW90C00KvUlQ2Stt59mXJNxyE4RfTEwjMXtrKQUKE6eeYq
         ofXykG0FYARYIAfMWoItxQ9O6vZ89MyF+YxPzX8CHaICfe9faFrLH3GhI+w8IrBp6SO6
         eTdKKn4qj8eExkuD6x0WEjEfszLnu3eSDd3pCjdb9BKY+OELHjkGGoftNuxRAgKaDB/E
         iOAcGMTLXudSyuRcjLGmxx4UJNUVMIUIAmG+7k/IjboGXIxFxFNPmgPn/Dl1L26mjatK
         oJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dUxC/mWSujUk0vaPP5nHw6YfVIuWLldSFzu+m4FFUOE=;
        b=jzmApZBVu7hvSYRnVNHZfCWXscdu3kQJA2s0mGa5GgpoCaCQbaUjmYjmDjMOEALFrb
         iNLqImpYDXvB3C/x16sAqdlaKt0wJOIOqKK0rtreS7fPKXLQu1y3NFWeyooQxJVIO0n0
         dnj9P5tdSN5dFK38Xwdg9Rn37O2WlKZ/zF1dRSbvqAphbSlEFXk/a/V2nlGDXRdyqLtr
         8A/f+Pu5Yr9XoOGZ63S7eA1VZkWwm3oPx5zvHB7csjdHVWavj7OXffFH+0NVb2pEvwdD
         sF7Y/fARIBv4RUueTkSBT2PDro7tCUTAu6eE63YrlwtfGy+E8g33xA+ZyCT6/LV8CVib
         au/Q==
X-Gm-Message-State: AD7BkJIrB3pGoEmXa1yjp+Gc1jxnBS22UJyQXQgK7pNAdQ39+NhTdu5peVN4XTrt49NFukHx
X-Received: by 10.66.124.167 with SMTP id mj7mr24986535pab.153.1459458289701;
        Thu, 31 Mar 2016 14:04:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id o71sm15472556pfj.68.2016.03.31.14.04.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
In-Reply-To: <1459458280-17619-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290470>

The return value of fprintf is unchecked, which may lead to
unreported errors. Use fprintf_or_die to report the error to the user.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 56c3033..89cbbda 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -240,8 +240,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	submodule_dot_git = fopen(sb.buf, "w");
 	if (!submodule_dot_git)
 		die_errno(_("cannot open file '%s'"), sb.buf);
-	fprintf(submodule_dot_git, "gitdir: %s\n",
-		relative_path(sm_gitdir, path, &rel_path));
+	fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
+		       relative_path(sm_gitdir, path, &rel_path));
 	if (fclose(submodule_dot_git))
 		die(_("could not close file %s"), sb.buf);
 	strbuf_reset(&sb);
-- 
2.5.0.264.g39f00fe
