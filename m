From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule--helper, module_clone: catch fprintf failure
Date: Thu, 31 Mar 2016 17:17:29 -0700
Message-ID: <1459469849-9643-3-git-send-email-sbeller@google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:17:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almmX-0008Cc-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561AbcDAARi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:17:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34099 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757394AbcDAARe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:17:34 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so80796231pfb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gmvbM2SyOsTcylkCppSWn+tYLTakWB/XabKG55trbx4=;
        b=RVlU8jN2oE2Vo6GxYdFdJj0F5MlaVqU8ih2p6d9nGBDvX9squRp1WRKhfoQmQsk5PY
         NMoDNM0yK5x4VCqPjJeO574h67GQI1qIgP3veWzYuBh/L1hXbSvV4CmQLVcQLzdJFKy2
         zre5qv6PbJvcEv6hY8QrosjnG1KDkx9ud4cZHq381COGlxWFj74R6g8LGe++BkVb6Phx
         08AcjmsOQZa7zjnmDaiyfs5Rgf+icAFYEjvu60XmPg3n1bWKdeyQdlLoqwwS15DMIwSd
         to50fDp8qlihX58RsYQAilWf0jtq/lWTyiwPFNsDQLEb8zyj/RTn5XEfDE9Dx3Hq7bLT
         /nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gmvbM2SyOsTcylkCppSWn+tYLTakWB/XabKG55trbx4=;
        b=a0W/A8UyYl5JONGuX/vP9J8XNJ68qHoBCv6RT8F29aYSGmaK4Cg7EP5S0bxPYsQViy
         a29NFgXZu74xKe0QGtleg95Y+A8UEN+thLbAV177ceBwNUh5VROnDNRvflAMy1y5PVCs
         dmj2UuGzxq0uW1QHUH6HwJtGuUIGpGAjQAlnEvcVuUkpgl840YpduG5/GaiOwmiG0NQO
         OkD+9+gEuxchV4WYF/U+nQ9CSjMb1NvBT7CaSE7zKCOW3NjbR/xoFFVUCQN48Mqh5gZd
         RGBVTf2Vkzl/qFQfhxsRR1BThdHrEAlp1xm1yAxbEpKryjUgZYHcWjCpDS47MTdeaTY0
         AjVg==
X-Gm-Message-State: AD7BkJLZfXxU131M0p7Nccars0T2TLitU7nsEzekqvubued1jwdbRKdZn2gNGd26Uzo5/RBX
X-Received: by 10.98.17.132 with SMTP id 4mr26260637pfr.16.1459469854135;
        Thu, 31 Mar 2016 17:17:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id m89sm15963505pfi.12.2016.03.31.17.17.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:17:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459469849-9643-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290493>

The return value of fprintf is unchecked, which may lead to
unreported errors. Use fprintf_or_die to report the error to the user.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b099817..be7bf5f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -230,8 +230,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
2.5.0.264.gc776916.dirty
