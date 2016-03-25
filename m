From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 1/2] mergetools: create mergetool_find_win32_cmd() helper function for winmerge
Date: Fri, 25 Mar 2016 15:52:55 -0700
Message-ID: <1458946376-30296-2-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqq60wbc24h.fsf@gitster.mtv.corp.google.com>
 <1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 25 23:53:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajac7-0001a6-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 23:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbcCYWxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 18:53:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35157 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbcCYWxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 18:53:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id u190so12863566pfb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/WtfnRC+6wqcSXwUaf2UnsKwus2lV57w/qXeB80O7E=;
        b=bSd4ETWAjiSrRAwavckA3AWIXVX9oG8tWS/Upl7OZX0jleiXArUy1WIE8qrRCqCwPn
         k+kCrn2e4CtMBM4O9OTwccCN9udbE9kE2TSfEffc2l1osj39mlo/4wGEO7SM4UCzavoP
         eGmVUIUCU+hKj12qH/KHCkFIa9KgscC9EmcSw/7jZg5tteeYf2+JslFJyLpnofdUaJKK
         w5eoZ8IofxygSpQRca0S4MfTF7x30bOxgYHfNH3rPMzCSW5V2mb90gzuEiGQFknuhm8x
         v9aJDs5FWyHJI4IqcM0HQTzGCmgFBhGf9u6OrOkreW9FLIkRk1WVr4CLcAj+XCoqWDl/
         2NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/WtfnRC+6wqcSXwUaf2UnsKwus2lV57w/qXeB80O7E=;
        b=KBGg/srr1Ld03RSA0zA22XpjzSOhtHoeHvZ1aW4JUYg774ehKWEfDmX00UoBC0J7PY
         VYU8uqcc4Wa7FEWHPg/7vbMqaIj1A0OnIW4XpWfFL5qyHI4ouFXEXlmvCBa6YFdNeiaJ
         /hdeiEffSPcu93PjfiiIsQrp5hSdiW+aECwWixV0MwQ+eXeaAOS5ZtogZ3EtK0+vysOJ
         UUJTonsSQJAVTOp5KMghivKElvVmgkAxYWflltrlIk16pEPYSJzsZm99Flu8teRXHCvl
         SlNLlAO2M8b2k5WB/xlsmOAnlSiLTuSVmdhNlnDIybIt6K1NnnYndW2zxvqu5+9U93h/
         AYAw==
X-Gm-Message-State: AD7BkJLZUSrsuiPMTPbkAyskhb3MxIRHLCmYpMYG7rkm90tzEFPbJa7aFDtVfmFw/SPoGg==
X-Received: by 10.98.68.145 with SMTP id m17mr24222187pfi.65.1458946416402;
        Fri, 25 Mar 2016 15:53:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id 17sm18583342pfp.96.2016.03.25.15.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 15:53:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458946376-30296-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289962>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
 mergetools/winmerge   | 21 +--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 54ac8e4..c5fa820 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -372,3 +372,28 @@ get_merge_tool () {
 	fi
 	echo "$merge_tool"
 }
+
+mergetool_find_win32_cmd () {
+	executable=$1
+	folder=$2
+
+	# Use executable.com if it exists in $PATH
+	if type -p $executable >/dev/null 2>&1
+	then
+		printf '%s' $executable
+		return
+	fi
+
+	# Look for executable in the typical locations
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
+		cut -d '=' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$folder/$executable"
+		then
+			printf '%s' "$directory/$folder/$executable"
+			return
+		fi
+	done
+
+	printf '%s' $executable
+}
diff --git a/mergetools/winmerge b/mergetools/winmerge
index 74a66d4..f3819d3 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -13,24 +13,5 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	# Use WinMergeU.exe if it exists in $PATH
-	if type -p WinMergeU.exe >/dev/null 2>&1
-	then
-		printf WinMergeU.exe
-		return
-	fi
-
-	# Look for WinMergeU.exe in the typical locations
-	winmerge_exe="WinMerge/WinMergeU.exe"
-	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
-		cut -d '=' -f 2- | sort -u)
-	do
-		if test -n "$directory" && test -x "$directory/$winmerge_exe"
-		then
-			printf '%s' "$directory/$winmerge_exe"
-			return
-		fi
-	done
-
-	printf WinMergeU.exe
+	mergetool_find_win32_cmd "WinMergeU.exe" "WinMerge"
 }
-- 
1.9.1
