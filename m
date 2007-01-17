From: "Josh Boyer" <jwboyer@gmail.com>
Subject: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 07:10:03 -0600
Message-ID: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 17 14:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7AYZ-0003uP-Vt
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 14:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXAQNKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 08:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAQNKK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 08:10:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:17915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbXAQNKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 08:10:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1981740uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 05:10:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C+Y7RyUPDV18v4oGYH4V3pRlS3JK2LdIhHhJEI+AWevfjIfrGaro3wVhluW8IuhTUNMeqP85upAu3hJJxvwF6NQdOQyn+RMVxaxt4k09iW6u/clASDxU2pg/3aB7W0w2g646PUgHNA8dZJGQIcWqTG2WHY9RuX+58yhchOQBMac=
Received: by 10.82.183.19 with SMTP id g19mr1520622buf.1169039403888;
        Wed, 17 Jan 2007 05:10:03 -0800 (PST)
Received: by 10.82.107.18 with HTTP; Wed, 17 Jan 2007 05:10:03 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36997>

Hi All,

I use git quite a bit to track my changes and then use
git-format-patch to generate patches to send on to others.  For the
most part, it works great but I find myself constantly doing:

mv xxxx-foo.txt xxxx-foo.patch

Could we add an option to git-format-patch to use ".patch" as the file
suffix instead of ".txt"?  Something like the below?

josh

diff --git a/builtin-log.c b/builtin-log.c
index a59b4ac..4eb2d32 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -217,6 +217,7 @@ static int git_format_config(const char *var,
const char *value)

 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
+static int psuffix = 0;

 static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 {
@@ -265,7 +266,11 @@ static void reopen_stdout(struct commit *commit,
int nr, int keep_subject)
 		while (filename[len - 1] == '.' || filename[len - 1] == '-')
 			len--;
 	}
-	strcpy(filename + len, ".txt");
+
+	if (psuffix)
+		strcpy(filename + len, ".patch");
+	else
+		strcpy(filename + len, ".txt");
 	fprintf(realstdout, "%s\n", filename);
 	freopen(filename, "w", stdout);
 }
@@ -436,6 +441,8 @@ int cmd_format_patch(int argc, const char **argv,
const char *prefix)
 				die("Need a Message-Id for --in-reply-to");
 			in_reply_to = argv[i];
 		}
+		else if (!strcmp(argv[i], "--psuffix"))
+			psuffix = 1;
 		else
 			argv[j++] = argv[i];
 	}
