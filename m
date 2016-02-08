From: larsxschneider@gmail.com
Subject: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Mon,  8 Feb 2016 09:59:18 +0100
Message-ID: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 09:59:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aShfL-00039E-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 09:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbcBHI7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 03:59:23 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35166 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcBHI7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 03:59:22 -0500
Received: by mail-wm0-f46.google.com with SMTP id c200so4995794wme.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JxN2p6wZLW2fHjiGzoRFDEMbA6acDzRDORHs1432tw4=;
        b=BQ8jtxQ47gESFKWUlAK3VCt0pym2O6SW4ncl9JDybHZaqZtnVOs4lg1MM1ueH+V7p6
         5lm9DCaXb92Bk8CNNLydNjoRAsTzMYFIDG1V9r5I+wFcSqT7gXogQVqQBx9aLpa33r1S
         Ur9EMLI843Zo9NR2FZhMkfiZNlUlv8kehyV2zshwYE4hK+BGiAb0jJLIoqok6tCGi/fm
         LsOY6ClE0s0bSdqnkpkBclUQmnLyVF1Ao0zlTw9VVt4/9mXrKkuxOk2QOj/GBI9xS9pq
         usyHRphCN90A04/0NtrAZ6n67E0q6Jf1t5I053zEZCod2lp7uR3euDWtPaklXBUHtLng
         viuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JxN2p6wZLW2fHjiGzoRFDEMbA6acDzRDORHs1432tw4=;
        b=fF5opxKmYb+pIibohOPSYlFmYRG7Wlin85QRfbeYZ6fWc6lLn/j7bNmDk0hzQ+xMco
         Rpmo6lKw8+G9vrb/aColhiJKjIaqoqaMxKy9nhBADtLBqpfIaBOEKmLtkZcfpDYLFNXR
         d6PtL3poG3NPRLr5shW0//j3RxJwQmOas9lGRTxE3mRW6vrGhIVlz+U8jCbfa/CaYWgV
         fphl74L2KU5XiS+aNlFJc1tx/xlOw4Ye6GgShJ5lWojTfwdlF/7jcM7m6+ATF66kv/eE
         c8Vi1moJMsJEu3QXNE7TPZqkz2TAVDp9Hsh/FNj0NcsK9Nfp21GrlCDFB+7pU7NsBOUd
         dyug==
X-Gm-Message-State: AG10YOSYF6a4UAk+Iz82Fa1i43/9iftK1EBN5oG1LytyX5bK1O787o3XNy+80kW5UoVq+A==
X-Received: by 10.28.188.138 with SMTP id m132mr12022351wmf.29.1454921960853;
        Mon, 08 Feb 2016 00:59:20 -0800 (PST)
Received: from slxBook3.fritz.box (p508BAC29.dip0.t-ipconnect.de. [80.139.172.41])
        by smtp.gmail.com with ESMTPSA id e77sm11518731wma.18.2016.02.08.00.59.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Feb 2016 00:59:20 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285752>

From: Lars Schneider <larsxschneider@gmail.com>

The global Travis-CI environment variable CFLAGS did not override the
CFLAGS variable in the makefile. Pass CFLAGS as make variable to
override it properly.

In addition to that, add '-Wdeclaration-after-statement' to make a
Travis-CI build fail (because of '-Werror') if the code does not adhere
to the Git coding style.

Inspired-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

I made this patch because Peff pointed out to me that "git style doesn't
allow declaration-after-statement" [1]. I wonder if it would make sense
to add this check even in the makefile [2]? I am no make expert, but I
also wonder why we don't use the override directive [3] for the CFLAGS?
AFAIK this would allow a make invocation like this:

make target CFLAGS+=-Wdeclaration-after-statement

Thanks,
Lars

[1] http://www.spinics.net/lists/git/msg267273.html
[2] https://github.com/git/git/blob/ff4ea6004fb48146330d663d64a71e7774f059f9/Makefile#L377
[3] https://www.gnu.org/software/make/manual/make.html#Override-Directive

 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c3bf9c6..29abff4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -20,7 +20,7 @@ env:
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3"
     - GIT_TEST_OPTS="--verbose --tee"
-    - CFLAGS="-g -O2 -Wall -Werror"
+    - CFLAGS="-g -O2 -Wall -Werror -Wdeclaration-after-statement"
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
@@ -68,7 +68,7 @@ before_install:
     echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
     git-lfs version;

-before_script: make --jobs=2
+before_script: make CFLAGS="$CFLAGS" --jobs=2

 script: make --quiet test

--
2.5.1
