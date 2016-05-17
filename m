From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t1500: be considerate to future potential tests
Date: Tue, 17 May 2016 15:36:26 -0400
Message-ID: <20160517193630.10379-2-sunshine@sunshineco.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2knz-0008Ue-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbcEQThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35995 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcEQThP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:15 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so5486383iof.3
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EhbbrddfA1utnCYlKLr6+WNEvaEFR0MfuCMLX9gijZU=;
        b=prWfyDqKS7RGaLBHGTL+yxBlnTwv3thpHnYuYaWBHQq08LU48h5vTsCCYfrvMmxQqV
         6uuRE30Gna5PuEjzXToj+FYFs6lFGH9TAdqdX/dbERwjnazZ+ou3SWsSQU+dNqQk+Z+t
         RZDMhlP4X+mM68zz4qxhD9WrGJ2d6Z+LKwLNA0UWuJXfZOkTsd/1dZSQGhgKFVYvpETJ
         BbNR9iXE2Fqc6R6kDWRorEP7w6N/XUz0T368bxXc8kpa4RB4Mffhrq8q3gJwflR7lg7F
         Q71xCv0udQM8rogWEDaPnAqbVvN6JK92xu9FtGxHrZ0MMWcxNl06l8WZuebHuIpcIUAh
         SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=EhbbrddfA1utnCYlKLr6+WNEvaEFR0MfuCMLX9gijZU=;
        b=JKRuaYR+2dNQA9neeV1gctuDIA1wjE4Rw/b6IiYf/TvzmQ6yXwdu2twpQmG4IyhMg9
         3DgJTUFt0ltidedXuM94DKAf0npdlIG1gC+JiTVvb1RP9QYKf0m79BDhboFyuJ0HOLs2
         rewt/xAVilYrXBI6VC01PaXA5DdKUbbVpO02mt+z42HxV81mQgXSzK/DeM9v5NLw9b6x
         JdqgfRCmJ2iCwd/0aNYY+sS0QUqPNTjiPF7CnEhS7NldPfxjejZbIRDp/gptEau5Siz3
         RTFMzQ8NYv8aqr6Wg9DS1UlJ5mpgIM2hWU+E8ejGZkSLotmQketdx8CHxXejNfKrMek2
         10Ow==
X-Gm-Message-State: AOPr4FVBiYzEaaogKEqjVWsNLsHz4lh8EgZNJvSg0PwHAtEX2kzXgtjoZZvOke5ys7Taww==
X-Received: by 10.107.56.131 with SMTP id f125mr2410354ioa.188.1463513833791;
        Tue, 17 May 2016 12:37:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
In-Reply-To: <20160517193630.10379-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294899>

The final batch of git-rev-parse tests work against a non-local object
database named repo.git. This is done by renaming .git to repo.git and
pointing GIT_DIR at it, but the name is never restored to .git at the
end of the script, which can be problematic for tests added in the
future. Be more friendly by instead making repo.git a copy of .git.

Furthermore, make it clear that tests in repo.git will be independent
from the results of earlier tests done in .git by initializing repo.git
earlier in the test sequence.

Likewise, bundle remaining preparation (such as directory creation) into
a common setup test consistent with modern practice.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..0194f54 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -37,6 +37,11 @@ test_rev_parse() {
 
 ROOT=$(pwd)
 
+test_expect_success 'setup' '
+	mkdir -p sub/dir work &&
+	cp -R .git repo.git
+'
+
 test_rev_parse toplevel false false true '' .git
 
 cd .git || exit 1
@@ -45,7 +50,6 @@ cd objects || exit 1
 test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
 cd ../.. || exit 1
 
-mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
 test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
 cd ../.. || exit 1
@@ -56,7 +60,6 @@ test_rev_parse 'core.bare = true' true false false
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
 
-mkdir work || exit 1
 cd work || exit 1
 GIT_DIR=../.git
 GIT_CONFIG="$(pwd)"/../.git/config
@@ -71,7 +74,6 @@ test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
 git config --unset core.bare
 test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-mv ../.git ../repo.git || exit 1
 GIT_DIR=../repo.git
 GIT_CONFIG="$(pwd)"/../repo.git/config
 
-- 
2.8.2.703.g78b384c
