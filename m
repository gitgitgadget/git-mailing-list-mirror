From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v3/GSoC 4/5] test-lib.sh: unset all environment variables defined in xdg base dir spec[1]
Date: Wed, 23 Mar 2016 18:13:24 +0800
Message-ID: <1458728005-22555-4-git-send-email-huiyiqun@gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Cc: peff@peff.net, pickfire@riseup.net, Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifnW-000210-2s
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcCWKNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:13:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34269 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbcCWKNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:13:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id n5so2390826pfn.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTGwhJPnnQE4iM+j5k7RTPcuomvIH1txLGdUcSy7Rbo=;
        b=LeGtuVG0YNsFcuaPZaplNxejtYiu33LsG9wIaaEApkaiMB+mhBxdgoK9HuRWDtBQnv
         YE/ah4dx0AurL7j7dc7Kb4DIbo1lOzShGtxq8i8h4mu9hv29BLhxzcGlyXcqa5HgJ4pJ
         Cuvr+L7Md60yy4Z7zNJ421MyeQvrv89TkbueKPpijunoxKkgS+CfHXvq37WwwDq4k7fb
         EKkEX9ObwlULSdEqQTvMPhEhFM0mtFoqJf2UvHS68loRTumx/C+lQo2UNmsybyne7KI4
         e/p07KtLbc/EWNx/284C9kxxSZY7k+4DV/TNS/WqyIkxounOQLCw/zIhU62GEGTFLZPd
         rYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTGwhJPnnQE4iM+j5k7RTPcuomvIH1txLGdUcSy7Rbo=;
        b=dlcioyC6XYjLaKJmOyLYTitBcQch1IBrfuaCjdnsBTu34Q7Gw5TeleyWDEU6fR+d7Q
         1awrJL7Fge6B77MCE4S01srsYFUxCnIeWOHA6MmTDeLBi7YcGbyefUTFJhQVqCkTRRkn
         T6W1WppUSr35ICrkhkrhUJTuJBp4yO55Xz/5DRFKGbu/adnpV7+uqk561Ulc0Y0k+5W/
         tDRzUL5Wphw9tg/MdV/zeXG20NFe0oJwgsr3eNNMmOhAHogoTxk85yyVoX8zlZnNfDhp
         yZvmDhMxvH4mBsrWFXX5IcMf5kvCDx8l++tJFJPnnN8yCuMHTKc0YUfZUfJ4zO4qmqhk
         yizQ==
X-Gm-Message-State: AD7BkJIuVl3TL+WHCXBjM51c7ynYll9NkrPFHA1bzriDLYVcTvl1CqTk8x7rq+EMHD4m3A==
X-Received: by 10.66.193.161 with SMTP id hp1mr2860852pac.9.1458728018898;
        Wed, 23 Mar 2016 03:13:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:ae9e:17ff:fe87:5adb])
        by smtp.gmail.com with ESMTPSA id x18sm3232325pfi.42.2016.03.23.03.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:13:38 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289621>

Otherwise, on environments where these variables and set, an assignment
to one of these variables will cause the variable being implicitly exported.

For example:

    $ XDG_RUNTIME_DIR=/run/user/2000 bash
    $ XDG_RUNTIME_DIR=/tmp/whatever # it should not be exported!
    $ bash
    $ echo $XDG_RUNTIME_DIR
    /tmp/whatever # instead of empty

[1] https://specifications.freedesktop.org/basedir-spec
    /basedir-spec-latest.html

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 t/test-lib.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0b47eb6..60a837a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -93,7 +93,17 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
+# Unset all environment variables defined in xdg base dir spec[1]
+# to make sure that the test are running with a known state.
+#
+# [1] https://specifications.freedesktop.org/basedir-spec
+#     /basedir-spec-latest.html
+unset XDG_DATA_HOME
 unset XDG_CONFIG_HOME
+unset XDG_DATA_DIRS
+unset XDG_CONFIG_DIRS
+unset XDG_CACHE_HOME
+unset XDG_RUNTIME_DIR
 unset GITPERLLIB
 GIT_AUTHOR_EMAIL=author@example.com
 GIT_AUTHOR_NAME='A U Thor'
-- 
2.7.4
