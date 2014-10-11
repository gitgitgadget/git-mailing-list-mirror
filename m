From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/3] mergetool: don't require a work tree for --tool-help
Date: Sat, 11 Oct 2014 01:39:37 -0700
Message-ID: <1413016778-94829-2-git-send-email-davvid@gmail.com>
References: <1413016778-94829-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 10:39:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcsDJ-00089U-37
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 10:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbaJKIjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 04:39:42 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54499 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbaJKIjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 04:39:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so3069742pac.21
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFKzJ4rB+FollasRdqhKmNtL0vRU6ZtjeIb3t3m21QY=;
        b=nNUNr3vJJe/YHqQIQLljMtMXV5v9Gl1Cm58OLo5a05qfiBLo+YmHoqi9eNK9lzkG4/
         gGRyFXFjJ0SQgF5lN2D2oSHj2wGrIxGhsmM/qONUAA5QHNAQ1T0t7HZdbCBMgd6ybcyP
         wiJE3QexZ3PKSStb0ItazzFyXFzkj2EVHZ3RHcG0uk7Ei7f3bhNgcrFc4VTplNWyMumO
         aAuUatXgGJAtP6C6knjLkdYGrM0BdJGLK/u0kB5DrxPmIXbndrYps2VegKhiVV+3YbPJ
         RVS8MEm2Js/PtfeJTZbLssXhBkbIufdNIfKZKgIuIzAVNKN8vNUn9xHVn6hQB4lvIzfP
         I82A==
X-Received: by 10.67.14.69 with SMTP id fe5mr10437811pad.73.1413016780270;
        Sat, 11 Oct 2014 01:39:40 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id gz1sm5558417pbb.8.2014.10.11.01.39.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 Oct 2014 01:39:39 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.378.g89c0b73
In-Reply-To: <1413016778-94829-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v2:

This now uses the new git_dir_init function.

 git-mergetool.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 96a61ba..cddb533 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -10,11 +10,11 @@
 
 USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
+NONGIT_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
 . git-sh-setup
 . git-mergetool--lib
-require_work_tree
 
 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -378,6 +378,9 @@ prompt_after_failed_merge () {
 	done
 }
 
+require_work_tree
+git_dir_init
+
 if test -z "$merge_tool"
 then
 	# Check if a merge tool has been configured
-- 
2.1.2.378.g89c0b73
