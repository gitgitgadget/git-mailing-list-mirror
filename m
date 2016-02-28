From: larsxschneider@gmail.com
Subject: [PATCH v1] git-p4: map a P4 user to Git author name and email address
Date: Sun, 28 Feb 2016 11:25:25 +0100
Message-ID: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <lars.schneider@autodesk.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 11:25:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZyXe-0004OR-CU
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 11:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbcB1KZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 05:25:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34493 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbcB1KZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 05:25:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id p65so5368093wmp.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 02:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=75EgHfK5o0rsdNzUsJxds5/KW9RvMAOoX+CHj2llU+A=;
        b=AisNqJAUXBLYXVoAY5pXlzf5WvvYjA++AIcME6lVMsBMJwr2rCXzaSwe5fK4EJBn3H
         DOaQ3MdqF32QmGicYpBmjtTvDTsKAe11/GiN/o3fvGEyrw6bKMI5GU2578bHZQPOiIA+
         NITXVEGRG5WdAJPJpeNNnjmzvp6MzA+eGodAFSdGXryfJ6VXvSkPMR6KIFuhWfGSzaEN
         ty9Szt8/bGbSReytBjOfAvg+Kh9jvHUmFeXulZ0IXgHFYubAAo7ykPnYZG+WSTh2a8mh
         SI/p8McYWi3AliIQhgphVUJ1UtVXhOKR+A8VWRVM/cetQb1/aU5bHxrcF8NNqakvp9OK
         RbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=75EgHfK5o0rsdNzUsJxds5/KW9RvMAOoX+CHj2llU+A=;
        b=c7rKKpSOjfwSR4bMYXcZWB0eEyzsK3kil+2Kx6DpldrkMCxWnqI3Z7joI0h0e+1Idf
         JWgUCNbIPE1cAPVVg4e6W2nzHtmcpRvf3evxz8V+oWFv5472SroOFMUsFw44i4wowxe2
         tETwN0jyj6ynNYEXXHUE2wzARFGZeBheDJ4CRT9sWzzjFeAs6i/zlefPN7jyUslVYqxX
         EYaMpGv4JjeOfHPpYxtnjVqGFf4au2sIfTWFngpaMYxtxs6vBGFAMV1OYsT0WslkKoyE
         fmyJQXA9KEmPa+yzVjIXyknZc4VnHo9Zk6xJOlEstw3URtM3FwcrwqrlJR2HPJ6jJp+T
         kDWw==
X-Gm-Message-State: AD7BkJJslCjZ1diheJ9xl3+l9F2PiGG9AlMVrhB1qLaAfIz9ND0V9gG5hLqDLRoUtagVKw==
X-Received: by 10.194.250.72 with SMTP id za8mr9576248wjc.4.1456655125924;
        Sun, 28 Feb 2016 02:25:25 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB4692.dip0.t-ipconnect.de. [93.219.70.146])
        by smtp.gmail.com with ESMTPSA id j18sm11035022wmd.2.2016.02.28.02.25.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 02:25:25 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287764>

From: Lars Schneider <lars.schneider@autodesk.com>

Map a P4 user to a specific name and email address in Git with the
"git-p4.mapUser" config. The config value must be a string adhering
to the format "p4user -> First Lastname <email@address.com>".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt   | 11 +++++++++
 git-p4.py                  |  9 +++++++
 t/t9828-git-p4-map-user.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 t/t9828-git-p4-map-user.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 738cfde..b453e79 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -553,6 +553,17 @@ git-p4.keepEmptyCommits::
 	A changelist that contains only excluded files will be imported
 	as an empty commit if this boolean option is set to true.
 
+git-p4.mapUser::
+	Map a P4 user to a name and email address in Git. Use a string
+	with the following format to create a mapping:
++
+-------------
+git config --add git-p4.mapUser "p4user -> First Last <mail@address.com>"
+-------------
++
+	A mapping will override any user information from P4. Mappings for
+	multiple P4 user can be defined.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index c33dece..97e4334 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1160,6 +1160,15 @@ class P4UserMap:
             self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
             self.emails[output["Email"]] = output["User"]
 
+        mapUserConfigRegex = re.compile(r"^(\S+)\s->\s(.+)\s<(\S+)>$", re.VERBOSE)
+        for mapUserConfig in gitConfigList("git-p4.mapUser"):
+            mapUser = mapUserConfigRegex.findall(mapUserConfig)
+            if mapUser and len(mapUser[0]) == 3:
+                user = mapUser[0][0]
+                fullname = mapUser[0][1]
+                email = mapUser[0][2]
+                self.users[user] = fullname + " <" + email + ">"
+                self.emails[email] = user
 
         s = ''
         for (key, val) in self.users.items():
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
new file mode 100755
index 0000000..daf2567
--- /dev/null
+++ b/t/t9828-git-p4-map-user.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='Clone repositories and map users'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo with different users' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+
+		>author.txt &&
+		p4 add author.txt &&
+		p4 submit -d "Add file author\\n"
+
+		P4USER=mmax
+		>max.txt &&
+		p4 add max.txt &&
+		p4 submit -d "Add file max"
+
+		P4USER=mo
+		>moritz.txt &&
+		p4 add moritz.txt &&
+		p4 submit -d "Add file moritz"
+
+		P4USER=no
+		>nobody.txt &&
+		p4 add nobody.txt &&
+		p4 submit -d "Add file nobody"
+	)
+'
+
+test_expect_success 'Clone repo root path with all history' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config --add git-p4.mapUser "mmax -> Max Mustermann <max@muster.com>"  &&
+		git config --add git-p4.mapUser "mo -> Moritz Untreu <moritz@untreu.com>" &&
+		git p4 clone --use-client-spec --destination="$git" //depot@all &&
+		cat >expect <<-\EOF &&
+			no <no@client>
+			Moritz Untreu <moritz@untreu.com>
+			Max Mustermann <max@muster.com>
+			Dr. author <author@example.com>
+		EOF
+		git log --format="%an <%ae>" >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
