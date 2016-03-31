From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] submodule--helper clone: simplify path check
Date: Wed, 30 Mar 2016 17:17:35 -0700
Message-ID: <1459383457-6848-3-git-send-email-sbeller@google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 02:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQJC-00054y-H5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbcCaARt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:17:49 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34481 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcCaARr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:17:47 -0400
Received: by mail-pa0-f54.google.com with SMTP id fe3so52555694pab.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6/3JQf7cqgGC53B6miKD5usqfaaI0zRbCGF1IZHxMU4=;
        b=lgAOlc6ZdBvchXc/HbKg424t7oeMc3r//zfGPOm3qIP+7Ab+t0sJVi5jTfXIvs14ZD
         dvu46ynEQ2JCiVp7DrAuJMGU0MZjBfn4xyMd4mIg0SH9SqHI1Yy/BiHCEmonsjXKK0ko
         IGgFD6M8LfxXjXiviIL2/IOR2771zJZsxFiv5k0PC/aXj0+He0HUqfe3jGjiIdSfQSlA
         gy2RGH5MUI3E7v+kbRgK+xtOc84SDRkiBx2pJdcSunN6Xhrwq7YYJmztmXz9KkVGy13j
         HaiVHk0S13dGD6Ti8cetGl2WuY+jzJ47zBneXGgBTWFCx0l7P04Gi27dFP7r/GREUB3u
         Fu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6/3JQf7cqgGC53B6miKD5usqfaaI0zRbCGF1IZHxMU4=;
        b=mZHfM8uLtEpSbb/G95CwI+y0KaVcRLnq8mcqG7+HOOH//z4LdAhHBrFVRRddIDlaTv
         w9hdu47BIietby/DKBmFqfhKE4loVjXPtmgUD5oGATpakujccMi78uMCxsr9uyEXAkvN
         /fEPBA19aymjjx0UzjXy+JJKc4pT7K1SHinT1Fp167LgXtZf+hTSD47E/1s6sLVZwtun
         fvxfbhi+1OhYAcct+G5FYW8R4daftfGkcEIoMEAxIp7BA7yQ8Dx35C+lFmdPc0t5vinC
         XHHCBqtWww9zAdVnDTwlKlFVKA4swjIZiuoR/hcROS9ZHYljuVf+f4pjBNafQd3JdCWf
         sKLQ==
X-Gm-Message-State: AD7BkJLdkhKwpPeN5KpkmDY416vjKSPn/tqqzQW+sM7ev6kLk2RTq7NAHBHqhUMBQ8lEFhb/
X-Received: by 10.66.102.104 with SMTP id fn8mr17544313pab.129.1459383466393;
        Wed, 30 Mar 2016 17:17:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id n66sm8504576pfj.39.2016.03.30.17.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 17:17:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459383457-6848-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290360>

The calling shell code makes sure that `path` is non null and non empty.
(side note: it cannot be null as just three lines before it is passed
to safe_create_leading_directories_const which would crash as you feed
it null).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..88002ca 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -215,10 +215,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (safe_create_leading_directories_const(path) < 0)
 		die(_("could not create directory '%s'"), path);
 
-	if (path && *path)
-		strbuf_addf(&sb, "%s/.git", path);
-	else
-		strbuf_addstr(&sb, ".git");
+	strbuf_addf(&sb, "%s/.git", path);
 
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
-- 
2.5.0.264.g4004fdc.dirty
