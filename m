From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/10] submodule add: send messages to stderr
Date: Fri, 29 Apr 2016 17:40:40 -0700
Message-ID: <1461976845-18228-6-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIyM-0006nO-KJ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbcD3AlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:41:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35460 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbcD3Ak5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id iv1so51668343pac.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WMN8nmy1jkT7V10HaHEt+OIgnTlV01gv59v6Zazn++Y=;
        b=HK+rd3hha7Trro5nUwmBQNS2fI6hvVUC1ViFha4ml71DKAblzN6XBt80UGTvL6j4zz
         yeECMxgLH2adJmAQNdzrdgpmI2o+TvEgT1loHf/MkxQCq3wSEc/yrmPFviQsAviXbmEN
         4CTG3ke0hxg0twu2y+SMq7F/LKRylrChQONhxL0m8AyIU1vtayyRohHUwbX6EUDH97Uo
         TyNMdeQufWHq7tp4NCRUhSoyNzBxTRCZQ2CUu8HE3odm4CUWdf6d7K1vRlAdfaQJ0G+N
         h8rBaaA1U4ofyuqN7kD0tFEFNJqNmPOb0w82dx5jwovXBSUTzfyxsAtORklV9XpmSGrg
         s/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WMN8nmy1jkT7V10HaHEt+OIgnTlV01gv59v6Zazn++Y=;
        b=WNYE47JV0DxG03nSZ4weuTqwNgZAtB4Yce70wRjkDjQTUYo26VOKty49BsDkn9MUgz
         yC2pkySZdv4fZYmWKZSGCcklFh7Yof0/Hdh6PLiKMk1nYA55DHA+UlwpNXnSDaApXi1D
         RgOHNkGONK3oDo+/YEaOXRturG4swRsUN/VWzrOZ6LlGZucYD4m0apYBH1kB5m752bsL
         /G6bkbxqNXRyGnYr+x/jfta1lca2RvQHaVO4a1aNfFU0npiChzhySJXJuEe6Xvz3KA3x
         4SE/0xsq3SOD0XotTsQdUOdg0rbNJ+6kAWUe3wYR/Xtz8o6C3094+erBLbho1gvKS9lk
         qzFA==
X-Gm-Message-State: AOPr4FWTuZRcjFxpiL2lEE3/csbkz+Jm3WBNvRyJyW9ptU9E+nILdfFJpZKn7m8MjdTaAOIZ
X-Received: by 10.66.166.78 with SMTP id ze14mr33146755pab.149.1461976856558;
        Fri, 29 Apr 2016 17:40:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id g27sm26451525pfd.25.2016.04.29.17.40.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293094>

Reroute the output of stdout to stderr as it is just informative
messages, not to be consumed by machines.

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d689265..f4d500e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -271,7 +271,7 @@ Use -f if you really want to add it." >&2
 				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
 				die "$(eval_gettext "or you are unsure what this means choose another name with the '--name' option.")"
 			else
-				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
+				echo >&2 "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
 		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
-- 
2.8.0.32.g71f8beb.dirty
