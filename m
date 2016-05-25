From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] submodule update: make use of the existing fetch_in_submodule function
Date: Wed, 25 May 2016 15:00:04 -0700
Message-ID: <20160525220006.27138-2-sbeller@google.com>
References: <20160525220006.27138-1-sbeller@google.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 00:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gqv-0007XY-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbcEYWAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:00:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35885 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbcEYWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:00:14 -0400
Received: by mail-pa0-f50.google.com with SMTP id eu11so12633247pad.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3c9qycYeLjadtaT47e440USXoOR97e++1HMKbZo5whQ=;
        b=bvpniXigu5AW/aLwLFPhAWg2TfkvD65+Cc0cyjWcI26rUvHLfLi3LhZFq3SgKrKD9d
         axA/EB3LaOPTgd7JOIl/DbxjMor406P7jbyiTzrrC5vuzffxnkAo0FsQOrcAXUAXxmkJ
         JoIcC+Yy4WxmbnZDIWnATA1LUiHBo8GR16Arht0YfTtDdSvvsp5tlfsaw7CMj7c52Xpt
         sC19a/zW64IO6GwJDjTyoOtOHHPsHM5OgPm2T08YU5RGXFiTDcTq2McNniE7ZX0XqB1Y
         QBqXt0Gfxw4WtzcYvlC+APK2e4xt+kDwcag8n9pSALojOzXl7B5aGPlAjEKHD9o1knKu
         Qbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3c9qycYeLjadtaT47e440USXoOR97e++1HMKbZo5whQ=;
        b=Naa1a9R6/qZumNcko+r9K0CFFSWDHnQYxUbCT3Kn0H1iNkm1PhgT4VGhkwmkZzk32G
         jd1kJsDYmyhfOUuh+sNYI8tRiNB+zrCow3yhg7RZuZxjX5Tv+a0bHVDC45F2GREyyo0S
         MyrplKn/1BL0pw/KVmUHPzWhC0QUrkXcKGVIon3WctNwtXhqBBAMv0ccIha1ynnzlPXy
         jD/NpLy/LqccTiY60RUWZAayBPSyxjUY5iz/PKLLR0Realf+gJVjLIqVi4iePFRPGOxV
         KO+5HYNqSbLU79OwXIFqxkMBNdDRgba2kxkoZGb6s0usm2YCEnH2l1WvxqqGbruYU2El
         h2JA==
X-Gm-Message-State: ALyK8tJsRcagFP8BpJcODSLhoVW9JNnY6vQuGnjSMwkvy9z/IO7VK+CI161f6ySeSTB9gKCB
X-Received: by 10.66.141.139 with SMTP id ro11mr9206674pab.74.1464213613303;
        Wed, 25 May 2016 15:00:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id s14sm15064803pag.7.2016.05.25.15.00.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 15:00:12 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.3.g892bdd0.dirty
In-Reply-To: <20160525220006.27138-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295597>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5a4dec0..7698102 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -640,7 +640,7 @@ cmd_update()
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-				(sanitize_submodule_env; cd "$sm_path" && git-fetch) ||
+				fetch_in_submodule "$sm_path" ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
-- 
2.9.0.rc0.3.g892bdd0.dirty
