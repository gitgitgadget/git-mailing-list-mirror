From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] config: test for --replace-all with one argument and fix
	documentation.
Date: Tue, 17 Mar 2009 10:46:37 +0100
Message-ID: <1237283197.10001.9.camel@equipo-loli>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: felipe.contreras@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Mar 17 10:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjVuA-0004o2-UL
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 10:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbZCQJqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 05:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZCQJqo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 05:46:44 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:36301 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762961AbZCQJqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 05:46:43 -0400
Received: by ey-out-2122.google.com with SMTP id 25so888823eya.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=w4WcbOvIMofxXETyODTT62hKNhcbuU4uxftyH4yV3R8=;
        b=j4zimKGzFo+iCuW5dpMM7fxT3NP97RkayG3cDjjStu4BOQdOYdqutnr1m4kdFS28r1
         yutwvS/h9KfnzjdOmpiIWSTyxygPPM4SJ4MZttEKq3aOCLjsIXM4TQVBXR55oeQVFcbK
         Suc24vKPKWepcnJlR/Cd6sBodZwrlTROSuO04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=QSNYDCYEHgdZmKQH6CuJTjem3DcKpYnFCDLotZou1cLK3JqPHFyzSUtQQjWnvp495F
         YfCUJ5bbWeVbLJ59Nyt/cbR7BMaQhqdbMzJUoOjp87XBSM2L+vbagjMYAkkw7tqWV0Aa
         WLub1DuDV6IPPyav6ch9vcaUY6oTF7vdvZ01M=
Received: by 10.216.23.212 with SMTP id v62mr2067355wev.43.1237283200971;
        Tue, 17 Mar 2009 02:46:40 -0700 (PDT)
Received: from ?192.168.0.192? ([89.7.153.138])
        by mx.google.com with ESMTPS id 28sm3149106eye.14.2009.03.17.02.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Mar 2009 02:46:40 -0700 (PDT)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113447>

Option --replace-all only allows at least two arguments, so
documentation was needing to be updated accordingly. A test showing
that the command fails with only one parameter is also provided.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

This is applied on top of current pu, using the Felipe
Contreras changes for adding parse-options to git-config.

 Documentation/git-config.txt |    2 +-
 builtin-config.c             |    2 +-
 t/t1300-repo-config.sh       |    9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 82ce89e..7131ee3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [type] --add name value
-'git config' [<file-option>] [type] --replace-all name [value [value_regex]]
+'git config' [<file-option>] [type] --replace-all name value [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-regexp name_regex [value_regex]
diff --git a/builtin-config.c b/builtin-config.c
index 1a3baa1..d8da72c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -55,7 +55,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, "get all values: key [value-regex]", ACTION_GET_ALL),
 	OPT_BIT(0, "get-regexp", &actions, "get values for regexp: name-regex [value-regex]", ACTION_GET_REGEXP),
-	OPT_BIT(0, "replace-all", &actions, "replace all matching variables: name [value [value_regex]", ACTION_REPLACE_ALL),
+	OPT_BIT(0, "replace-all", &actions, "replace all matching variables: name value [value_regex]", ACTION_REPLACE_ALL),
 	OPT_BIT(0, "add", &actions, "adds a new variable: name value", ACTION_ADD),
 	OPT_BIT(0, "unset", &actions, "removes a variable: name [value-regex]", ACTION_UNSET),
 	OPT_BIT(0, "unset-all", &actions, "removes all matches: name [value-regex]", ACTION_UNSET_ALL),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c06842..9c81e04 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -118,7 +118,14 @@ EOF
 
 test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
 
-mv .git/config2 .git/config
+cp .git/config2 .git/config
+
+test_expect_success '--replace-all missing value' '
+	test_must_fail git config --replace-all beta.haha &&
+	test_cmp .git/config2 .git/config
+'
+
+rm .git/config2
 
 test_expect_success '--replace-all' \
 	'git config --replace-all beta.haha gamma'
-- 
1.6.0.5
