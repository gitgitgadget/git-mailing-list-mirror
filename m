From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 10/13] git submodule update: cmd_update_recursive
Date: Mon, 21 Sep 2015 15:39:16 -0700
Message-ID: <1442875159-13027-11-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kb-0006mJ-SC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbbIUWjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:52 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33107 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbbIUWjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:37 -0400
Received: by pacex6 with SMTP id ex6so128686658pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ZOcJ8dVIG1ZkWZk68jF3y2NlrmKWoUAHGUWXerpSaw=;
        b=XicpuTr1YRAIE7Z/WS6v9dOGsCUMsyHtYgd+PYnI5sgbKObwHCKP5PprpF3q2Qx1IF
         mDYhzTPG5VkXyWPdU7a7NbjR9sz+1Nqh4Du9PyMayuKMbqBcUMNJceobMHaQvKEXE7ww
         4E3e61qUzfchFu+QZaNeaO5IGvXTxPfzk3UF2G8qBaAVWHbZ3Qk96p7QCOD1o60UU+Fk
         PD+o0IQ+HbOzwZdTnEJKAEQe3+t0sRSFyDpr/eqjDSjEOPN2sUzFausUewsxwd+wY3Zd
         HeBjac8hsObK6BZJFV/pAu5Hhj7DvRVuQEC/u2lyqEB67kYdqIPFDrL98q0sWcqbTBaP
         YanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ZOcJ8dVIG1ZkWZk68jF3y2NlrmKWoUAHGUWXerpSaw=;
        b=g+7vgEL1gX2mj+bmHs40Z1Q2StfOACF1uQmf2UVnNB+ugK6WMNnrQG4+Y5aVuB+kvB
         xM7v80JviXhZfwrbF6Ku6Njil2TrGn4un+nPmldGicRhtWltrrJMBe36d6k41UB86Raw
         8hxkBKmQsldIwXvvEUr/71F3G5aMHaffKEScpv+h8I2ZAKLVyN4peeeYlZCrTUm7QVDg
         d7ihhIQTe93ngyazc308nYtjBO2heJoqpu+jRaXpQ3O3aE5eFfAnylAmNW8d/EYWKlOK
         XOxil5O3zoeuTtIjiNq/cQ3KQJj5xd7NDGoDTi08mMKD2ILb7e0/haSaE5mPRNY2N+zP
         Wz5Q==
X-Gm-Message-State: ALoCoQnG/fvCDK1P/Gh13W74tQGzaqw5UNZnVmEgUnrh9PBhsUNLXwNX+VATfwuuaC+gWEdEP6i4
X-Received: by 10.68.94.195 with SMTP id de3mr27477528pbb.47.1442875176893;
        Mon, 21 Sep 2015 15:39:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id uy4sm26467455pbc.69.2015.09.21.15.39.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278345>

split the recursion part out to its own function

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8964b1d..71385cb 100755
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
2.5.0.275.ge015d2a
