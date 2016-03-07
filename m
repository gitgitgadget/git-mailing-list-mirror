From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] lib-gpg: drop unnecessary "missing GPG" warning
Date: Sun,  6 Mar 2016 19:10:24 -0500
Message-ID: <1457309427-30124-2-git-send-email-sunshine@sunshineco.com>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 01:11:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acilS-00082O-03
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 01:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbcCGALC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 19:11:02 -0500
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35528 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcCGAK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 19:10:58 -0500
Received: by mail-ig0-f195.google.com with SMTP id ww10so3985289igb.2
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 16:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ApyIb4+pFhP7lJFl4TD5W1yqnE5bIqBBLkmspDcW4BY=;
        b=dsCwd23Hu+JkibdhDfTN6Qb1JiYYixO0m5bjO8t8ByItn7oBjXpMRu47FyLPoUxaSu
         SlkVxMKQ9dD53bVf0VYlCpT6lb4meSxJXnyEMkBTw0a41MjidcncknzxviZvNi4HgCpb
         BfUP6cOiL0BowwoEGt3pcXZLIP7qnErUCxd+XV43pBA9yF+ablyFZ8w+HTxob3+cP1Bh
         JQhIhzL+lXulUsKLc7LXRmbE9VwhGyIGbjcrnCvlY8Vi6EtLBat6lkRpF8qvAJuXLSuL
         C1tMtfRRrGLq3DoSg4FmkKhGgLrJmTv4AyJERCQhv81X1wYxj8Fz2lqPTUvvt/t+OBTf
         UvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ApyIb4+pFhP7lJFl4TD5W1yqnE5bIqBBLkmspDcW4BY=;
        b=Q3fv+KQdF4DY6ewB2BKppGOEADrq/+Y+N3gahXCzdVNPD0uFa2HM/vls+/Xi2yEtVc
         uK+SRLWxn8ej8r4jJkDCls4R1Ar2MF/2BBV68MzJHbXmeXjL2MytxpL/URiFeHtZ/MOU
         eoj7u0lmy0VYWnj6Uf2epi9iie903k9OPapcoUcUlS0MgD6YBGkp8U5nun64ADXm7c0q
         X9UPWc28xnpFGqUZHoLENK8XoN9Ax87SK5ptP17qQi+jvLDGLUE44VwFFtQxNZEKyE25
         hAML7njEIwu24C9kvMQNf/7Gs/c/1NtPdyoG3F91kAK9gWXwmw1m3FYR7+ly8G4rCyd6
         6cCg==
X-Gm-Message-State: AD7BkJLLO2OOqbBBv2M7rceJ3WpVmiQfMqtK+rhspjZ1R7hzA7QKBhZx/b7sPFbVP+4+GQ==
X-Received: by 10.50.64.242 with SMTP id r18mr7359306igs.65.1457309458027;
        Sun, 06 Mar 2016 16:10:58 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id t62sm1337418ioi.41.2016.03.06.16.10.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 16:10:57 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc1.175.g19dcece
In-Reply-To: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288370>

When 37d3e85 (t7004: factor out gpg setup, 2011-09-07) pulled gpg
detection code out of t7004-tag.sh and turned it into a standard test
prerequisite, it added an unconditional "missing GPG" warning when gpg
is not detected.

However, this is redundant since all tests which require GPG already
warn via either 'test_expect_success GPG' ("skipping: missing GPG") on a
test-by-test basis, or when skipping all tests in a script ("skipping
all foobar tests; missing GPG").  Consequently, the extra warning from
lib-gpg.sh is unnecessary, so retire it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

At first I found this warning alarming and then annoying when changing
t6302 to skip only signed tag testing (rather than skipping all tests
entirely). It does seem like a redundant warning, hence this patch...

I also sneaked in a minor style cleanup.

 t/lib-gpg.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index db2ef22..ec2aa8f 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,9 +1,8 @@
 #!/bin/sh
 
 gpg_version=$(gpg --version 2>&1)
-if test $? = 127; then
-	say "You do not seem to have gpg installed"
-else
+if test $? != 127
+then
 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
 	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
-- 
2.8.0.rc1.175.g19dcece
