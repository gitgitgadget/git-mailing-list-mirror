From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 11/14] git submodule update: cmd_update_recursive
Date: Tue, 22 Sep 2015 18:45:29 -0700
Message-ID: <1442972732-12118-12-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8M-0007Dx-5K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934556AbbIWBqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:46:05 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36320 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759991AbbIWBpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:50 -0400
Received: by pacbt3 with SMTP id bt3so6877890pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEpryuBojrKbMASHNrW40BQhzEtEqkr+KHMwvv8fNYg=;
        b=Shm5mEy2A52Fb7y1AHoYN4CyGE6hWgI55Iquzxh86KtWD46tC7CSSYEsO7YzWN/EvH
         /mfi5pmdGmYsh+HGwcw/DDVf9FW6AMOzEutsH0O/uvPW5xnkqTKiVsw/KIrMXvv5W481
         H8ugqCRLvVAfLfLCgtyYlWVfLsqkf/0G4buGe++rf6X0iULLd9EUDyU2x7VZWgYkd3Ew
         jDwBbKd9VOFQWfTakMR0pbhiKedAJQ4uSG9n6SzxI2Uh7BJnbDyEUPTEaZduNhI5i6a7
         j06fpY7OFS0Q/icagtew1bJXblwQkMxuqV9WC1aX8UpDmhd7c3TxevZqZ4jh+1Ob9NDp
         i/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEpryuBojrKbMASHNrW40BQhzEtEqkr+KHMwvv8fNYg=;
        b=id4RLm88L/NvhOnYMkuEPP0LHurWVfIyiQFpXLatdhgav2dpjLUdZW5i7J385t669v
         nACrQbSO0phuh6XlENnZETPKzjkGUUYjKPz6VrnNvYkTEzowgLjwXT5z669KpZ9qMDD0
         jupihlH9eIPObX+2R9o8uvE7DS3cLLeScN5CEgw2eGKChoB+IGxx6faLGbvu4MFTPmof
         nc+wdddEC1mU/Q3hZ4X6nrcTXA+7H66B6lw/D2YYmBZ3l8sjRF0mblbJpJwMZrqQQVM1
         bTs0Ernop25hZcOKvxq5A3PdE0UM9S/yZobBNMxh0vOabQ9jxGNLDF37lRN87HPCJi3q
         SOog==
X-Gm-Message-State: ALoCoQkA+dg6rEOoDGIfoLQ1HBnRzPwacDAeKB7fI70Y1sl/gz4+G8p/KKViJ5vnCdX1RMsXi6C3
X-Received: by 10.68.180.131 with SMTP id do3mr34505899pbc.133.1442972750079;
        Tue, 22 Sep 2015 18:45:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id li11sm4584678pab.43.2015.09.22.18.45.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278462>

Split the recursion part out to its own function, this allow us
in a later patch to convert cmd_update in C.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b0eb9a..ea3260e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -582,6 +582,31 @@ cmd_deinit()
 	done
 }
 
+
+cmd_update_recursive()
+{
+	if test -n "$recursive"
+	then
+		(
+			prefix="$prefix$sm_path/"
+			clear_local_git_env
+			cd "$sm_path" &&
+			eval cmd_update
+		)
+		res=$?
+		if test $res -gt 0
+		then
+			die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
+			if test $res -eq 1
+			then
+				err="${err};$die_msg"
+			else
+				die_with_status $res "$die_msg"
+			fi
+		fi
+	fi
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -790,27 +815,7 @@ Maybe you want to use 'update --init'?")"
 			fi
 		fi
 
-		if test -n "$recursive"
-		then
-			(
-				prefix="$prefix$sm_path/"
-				clear_local_git_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=$?
-			if test $res -gt 0
-			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -eq 1
-				then
-					err="${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
+		cmd_update_recursive
 	done
 
 	if test -n "$err"
-- 
2.5.0.272.ga84127c.dirty
