From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 5/7] t5520: factor out common code
Date: Sat,  2 Apr 2016 23:28:30 +0530
Message-ID: <1459619912-5445-6-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:01:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPrc-0000cY-66
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbcDBSBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:01:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34647 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbcDBSBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:01:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id d184so1367915pfc.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yO0IoEKuNmzMj9ehXJP278dXSboYKiqtk/1zrkRIB2Y=;
        b=JXJfx2dv0vEyLY+1z/wy5CUwreuPe48Zwf+dLpH4dlQsaYgk6Ehpbib18My+XhDOc1
         BCeo72ibFfj8L//8Y2TMs5Ltrbmml+UbIEntQbvwpJKpYhFrgp0lQkh1HpkBCihnl8z3
         NOFID9UnkgLQTwdIo6BKuvAq4L7DbDszA70PHvtvhkHFXhrp1I0rNC0NAqAUqYFNpyDu
         U3hFzKdjcancyYTcCesnYNDc5hsoMTPRSnd17v55gYaH1iU6s4iIRaR6qNa54KkdA7E+
         XnnW572gqHBRWZDp2cCOIAdBalwMaOI3RHqZjJKqf2XO6P2Vnfc0MlAeiCPmqwaiavOU
         ui3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yO0IoEKuNmzMj9ehXJP278dXSboYKiqtk/1zrkRIB2Y=;
        b=gmFOIWqZl9yI3MBmQVaVRoQHtzhHRIiSExQE3p9LmBP6I7QG116HOVb0WiFgek6nPE
         ODnn0r7MVxO7JoGVqeU8Ps0I0edd4cs1zTdrdpPqHHw6KoZ6V1kfmzs4azk1YBnKABwn
         lxGGqtEx3Mx70hKO3jdC3VUJVyInqEfy5MlQZF8r4CbcOdTVCoiwGC4i7/K1/EDcCPPm
         5s/srmwnccEX5Kw8/1Ad7Es61A/K3jtv1Q3o9iYEboMle0R4n5faVYRZrY8ifbvxkidX
         Jukn2wQxqeqO4w5cNXG38KHFt6RnzpPOMEXhOl9iHvIazxshoBv7AiLdMNoD+pr87Sko
         Ae8Q==
X-Gm-Message-State: AD7BkJI39SQCNVjKM42IOIXXHwes/9/FGWOYLWTcgy6heYh09szDuHUAGO0VPlZhRYfP/Q==
X-Received: by 10.98.68.71 with SMTP id r68mr7840048pfa.119.1459620091224;
        Sat, 02 Apr 2016 11:01:31 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:01:30 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290601>

Three tests contains repetitive lines of code.

Factor out common code into test_pull_autostash_fail() and then call it in
these tests.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ac063c2..fb9f845 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -19,6 +19,14 @@ test_pull_autostash () {
 	test "$(cat file)" = "modified again"
 }
 
+test_pull_autostash_fail () {
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull $@ . copy 2>err &&
+	test_i18ngrep "uncommitted changes." err
+}
+
 test_expect_success setup '
 	echo file >file &&
 	git add file &&
@@ -277,29 +285,17 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash unset' '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_pull_autostash_fail --rebase --no-autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_pull_autostash_fail --rebase --no-autostash
 '
 
 test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_unconfig rebase.autostash &&
-	git reset --hard before-rebase &&
-	echo dirty >new_file &&
-	git add new_file &&
-	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
-	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+	test_pull_autostash_fail --rebase --no-autostash
 '
 
 test_expect_success 'pull --autostash (without --rebase) should error out' '
-- 
2.7.1.340.g69eb491.dirty
