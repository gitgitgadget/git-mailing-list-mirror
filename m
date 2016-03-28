From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/7] submodule foreach: test path handling in recursive submodules
Date: Mon, 28 Mar 2016 16:28:17 -0700
Message-ID: <1459207703-1635-2-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaJ-0004rF-On
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbcC1X23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:29 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36776 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbcC1X22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:28 -0400
Received: by mail-pa0-f51.google.com with SMTP id tt10so109073993pab.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8YLlCCxt/q1F8RZDghjm8sRmy8q7owCXhBg/C3yGHxY=;
        b=lXt5miC0iNr7URtS9oVIWbucVq/RvjGLxGpnhe2i01XPUpjfnRBDdRyd0kaH+wQjH6
         SIMgdaIMDXQVJa3GFJTnyXnMUG9Ks6JWuH+CQ1/aZjfrLpFKEWfUSpJ55ukD6/dm31Sd
         YtKc6+M9fh8mgCduPNCSdFVe9OX04dGJ70CtumaNE5r4vtCWupi+riXGPAVnBGkz3Clo
         Yt9bmn6ls2XJOxdv7fqa/Izzb5LKptSxD6/UYx9+lqWUXWDJZh649z088HP1bgTE4gLv
         ydHnQAEDHcsySTL/gkZkHsX2VCPkqswgU6sm2kpjklASRBaWyccsd3NU1c97Her0NUZy
         BrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8YLlCCxt/q1F8RZDghjm8sRmy8q7owCXhBg/C3yGHxY=;
        b=cPI5b3K3LVYkujBr9exUqZ/mgM4HnCewU5sLyQ28PFX+MSfVECgz9iyfX3Sd4iRyq6
         aFpUB8rdeKFfCU1d4k1qOb0oY0W8R3PFC7YyfyKH3hnuIb8uStnLajOsM//31T9FrliT
         X40Ca9N5Wi/AgxM9L/kHBGH7yhutrNcH8wCCOod/V7M8YbQEEHpN5k809HZdvh45+R5v
         y+aTGOtd7iHU2RlTMV42ozZ7FqodiXN+TBRWltYvT4rBhNK+HelWUsImxJhqg+dHhtB3
         FKZhNiUB5VuJRAbJSXqoJDVWb497wOD1WtJrIHDb9Py1mD4Qx5+kPw7jfyazqcLmQMNT
         J7hA==
X-Gm-Message-State: AD7BkJJx+ixEa1LYdgMpcebHNg7lTucCm+sU87yYYrLdGp0ctZoTqaYiiqg3ZGF6i1k3jxM6
X-Received: by 10.66.189.166 with SMTP id gj6mr46829556pac.158.1459207707136;
        Mon, 28 Mar 2016 16:28:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id yj1sm38213852pac.16.2016.03.28.16.28.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290084>

This replicates the previous test with the difference of executing
from a sub directory. By executing from a sub directory all we would
expect all paths to be prefixed by '../'.

Document this as failure in this patch, to be fixed in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7407-submodule-foreach.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 7ca10b8..f868636 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -178,6 +178,26 @@ test_expect_success 'test messages from "foreach --recursive"' '
 '
 
 cat > expect <<EOF
+Entering '../nested1'
+Entering '../nested1/nested2'
+Entering '../nested1/nested2/nested3'
+Entering '../nested1/nested2/nested3/submodule'
+Entering '../sub1'
+Entering '../sub2'
+Entering '../sub3'
+EOF
+
+test_expect_failure 'test messages from "foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		mkdir untracked &&
+		cd untracked &&
+		git submodule foreach --recursive >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
+cat > expect <<EOF
 nested1-nested1
 nested2-nested2
 nested3-nested3
-- 
2.8.0.rc4.23.gd22361a.dirty
