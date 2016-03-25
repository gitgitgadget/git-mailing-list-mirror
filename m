From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH 1/2] mergetools: create mergetool_find_win32_cmd() helper function for winmerge
Date: Fri, 25 Mar 2016 16:17:56 -0700
Message-ID: <1458947877-31764-2-git-send-email-jacob.nisnevich@gmail.com>
References: <xmqqio0a17ux.fsf@gitster.mtv.corp.google.com>
 <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 26 00:18:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajazu-0006KG-BW
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbcCYXSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:18:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33299 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcCYXSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:18:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id x3so12899262pfb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LypBmNk3sYFWHgMmv50S4aJfpF3HnDQaERBypy4RYzs=;
        b=eCiZs+rRtE2rRXJOlZMq9ufD3GCx+HySItkzI/VhCro4+njE9MJ7tiRLnlIK1Vg/sy
         HfvE4xxIkT+bp1qspkclEZ6dHxkXuF+f8SOTmdZEcN3+IUdzSbzs8lgv0DyML8fxwmNp
         CU60zZC1FJIXxTicczuCtleYH9xQFyH41qdvQK0X8iNNmZTmX07P6+K6ZqsXl/In7BFX
         dk9/beHidjImz/Tg56VYOPSVJsXxsqwvBug4M+CLDJNs0Tzy9I2bYcmKM1COwSqnGZ/b
         5IV5vfN6SG+WEpe7esViPnDk6wXG5S56W2tTCVlm+VTi7Z1yNldcRAPAflId5zJZrEs4
         Gnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LypBmNk3sYFWHgMmv50S4aJfpF3HnDQaERBypy4RYzs=;
        b=DGicngRMBtx7TcSi6LXRTh27d31pdC4ZLmrUPl2LffKR9gmMIYzrdMvOwKu+V1Uo6B
         WYdIsctTUF8hslZRs8Z02cBYwevbFedZCbg9+t9hfg8MQsBgLunntbCU1qsoT50g6rD1
         mIB57ilesbkX5neUgpNeGPtHVJK2sga7pSsJ0+DTUabpDxBi37PVt57nTmmdoPWWLvGc
         Ytt2PKZ6TQWV8OzC1qC/HemXYVvXxs05GXiWbqDJkuK39JEEpoirZC5OfocfsHzZuD3O
         VVq6gOlUmcVz03qoBr49Ooc+0qO2QWqeyTZ4a1V9Ut8ZOA7+dkRCINGdSD15eyVOE+s9
         4C0w==
X-Gm-Message-State: AD7BkJJ8fxDP3ziu1N3YXHy9SlrFNpbHhj4yahVNIawaoChyWYBt1BAt0G4JneOvvmCdxw==
X-Received: by 10.98.31.21 with SMTP id f21mr24019108pff.134.1458947902716;
        Fri, 25 Mar 2016 16:18:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id y23sm18674072pfi.22.2016.03.25.16.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 16:18:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458947877-31764-1-git-send-email-jacob.nisnevich@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289968>

Signed-off-by: Jacob Nisnevich <jacob.nisnevich@gmail.com>
---
 git-mergetool--lib.sh | 25 +++++++++++++++++++++++++
 mergetools/winmerge   | 21 +--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 54ac8e4..302c56d 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -372,3 +372,28 @@ get_merge_tool () {
 	fi
 	echo "$merge_tool"
 }
+
+mergetool_find_win32_cmd () {
+	executable=$1
+	sub_directory=$2
+
+	# Use $executable if it exists in $PATH
+	if type -p "$executable" >/dev/null 2>&1
+	then
+		printf '%s' "$executable"
+		return
+	fi
+
+	# Look for executable in the typical locations
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
+		cut -d '=' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$sub_directory/$executable"
+		then
+			printf '%s' "$directory/$sub_directory/$executable"
+			return
+		fi
+	done
+
+	printf '%s' "$executable"
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
