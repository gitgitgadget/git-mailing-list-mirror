From: Jacob Nisnevich <jacob.nisnevich@gmail.com>
Subject: [PATCH] mergetools: created new mergetool file for ExamDiff
Date: Sat, 19 Mar 2016 21:58:52 -0700
Message-ID: <1458449932-24342-1-git-send-email-jacob.nisnevich@gmail.com>
Cc: Jacob Nisnevich <jacob.nisnevich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 05:59:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahVSS-0005h5-5j
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 05:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbcCTE7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 00:59:00 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33655 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcCTE67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 00:58:59 -0400
Received: by mail-pf0-f172.google.com with SMTP id 4so92035465pfd.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 21:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qndYojHSK+QEuPHyxBuccf6VCHmRmrPj9t+08zkuEEY=;
        b=iy4iklxm3A0vrw+OXtkdHHnav0+hjH/Xi24HdBnFPMoQPPLyXrjETbDDOBJ4P9HVOj
         YpLqYfJAH1BQkNBaNXQPyoGQ5sNk+O1br2CFERGGgz5Y5Wx/Wn5Pn30Iq9j3xiLO5tbn
         03z+/CHoib6rgR4pmjtoMkvp3HmRqm2djlsnnTvBvYX41qIJMMjAtGgzfIAJIOsO0T1R
         UDqgH1AQCtbo5cEGB5vy7bMqOpBxycX5CT4RvXPQ6sSMiCYwo675khltIyxJSZvWVUOR
         oeAOTe4mDx1RWdohw9FIQWdYWLJHfo1hMDfgKTmfA5tUSiEc7ha4VGuwNAkeQtDY0On/
         QfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qndYojHSK+QEuPHyxBuccf6VCHmRmrPj9t+08zkuEEY=;
        b=IJxieWWq6Zglaqtil+cyQ8LmxfQ7JZzV62sDDQRs/KMSIxZRYUvLr1FR/D63eZVoDK
         3VcBKU4qGPsxeXXpiYl+qhShL4k+Qt32nQnyw4yKkH02MozqUQdw+8CBJqAXOFTQHSYK
         sxs8UGYOwttrV3e8BKEZ2+Vq3+0e9TU3wlJuZE0qbRGf3LkvkbG2Qtdhi3fH58UAnOAq
         S/9PTkpIQRo2Bl/Msu7ifDcEUzV6ahOW24AxeDQ1jfYFwUFyr1x/b4EmdhpYd0lAXEeu
         gZoLF+6MNFmLtP92ARpHv6OEljUCvIA1n1aNNsICPV5eXN23H7feMtJq97aG45ovo+tm
         2Dkg==
X-Gm-Message-State: AD7BkJKl6UzoZBhRddbD4GhMEkkp8OpIAULuTKfpKlcXZgXTJuM5n54IdwMBLyChb4cuFg==
X-Received: by 10.98.12.153 with SMTP id 25mr35323920pfm.27.1458449939091;
        Sat, 19 Mar 2016 21:58:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-108-185-180-179.socal.res.rr.com. [108.185.180.179])
        by smtp.gmail.com with ESMTPSA id 17sm31252629pfp.96.2016.03.19.21.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Mar 2016 21:58:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289333>

---
 mergetools/examdiff | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 mergetools/examdiff

diff --git a/mergetools/examdiff b/mergetools/examdiff
new file mode 100644
index 0000000..474fffe
--- /dev/null
+++ b/mergetools/examdiff
@@ -0,0 +1,37 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" -nh
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
+	else
+		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	# Use ExamDiff.com if it exists in $PATH
+	if type -p ExamDiff.com >/dev/null 2>&1
+	then
+		printf ExamDiff.com
+		return
+	fi
+
+	# Look for ExamDiff.com in the typical locations
+	examdiff="ExamDiff Pro/ExamDiff.com"
+	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
+		cut -d '=' -f 2- | sort -u)
+	do
+		if test -n "$directory" && test -x "$directory/$examdiff"
+		then
+			printf '%s' "$directory/$examdiff"
+			return
+		fi
+	done
+
+	printf ExamDiff.com
+}
\ No newline at end of file
-- 
1.9.1
