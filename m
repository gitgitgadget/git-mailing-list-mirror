From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/5] contrib: contacts: add documentation
Date: Sun, 21 Jul 2013 06:52:42 -0400
Message-ID: <1374403962-48361-6-git-send-email-sunshine@sunshineco.com>
References: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 12:53:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0rGs-0003Xj-6j
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 12:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab3GUKxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 06:53:34 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:59467 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab3GUKxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 06:53:20 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so13081846iej.15
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WieXDfDNxu2pLCaezrpZW5GkhB3Kx9hAt1VqBZertCA=;
        b=CCjk6i//Wu6+fiiLTkJK0++md2zh1z5cKK79fjl1AZwCmgGZI22QssBbit+LDNiE4Y
         SdT6SKDgGWdALMZAbGClgS/3e/boteg6+aa4FCbqrADZG1mKLml3zOMwTfGBGH+qa2G0
         KQx2aLTNGpAc4gWlo8Xl4bNpH2igyeWUviX7t01yxiz4KAwOR2DemtyajODvg4zW31ww
         gAdiMOU1TBSZUOo+Bqu5ButsS1tPzS9ANUD0HKD+QoKSvZ16hUxc85XBRGmBg+Dwzowi
         5SjBm5X7TMTUWr5Luht+nVNmGaE16IEwtk/sdDT/9e7pK0fu6A2VWNHLrQ6kFLyNp+v5
         TY9g==
X-Received: by 10.50.225.66 with SMTP id ri2mr7169506igc.55.1374404000447;
        Sun, 21 Jul 2013 03:53:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d14sm50204105igz.6.2013.07.21.03.53.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 03:53:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.803.gd114dc6
In-Reply-To: <1374403962-48361-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230925>

Assuming that git-contacts may some day be promoted to a core git
command, the documentation is written and formatted as if it already
belongs in Documentation/ even though it presently resides in
contrib/contacts.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/contacts/git-contacts.txt | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 contrib/contacts/git-contacts.txt

diff --git a/contrib/contacts/git-contacts.txt b/contrib/contacts/git-contacts.txt
new file mode 100644
index 0000000..dd914d1
--- /dev/null
+++ b/contrib/contacts/git-contacts.txt
@@ -0,0 +1,94 @@
+git-contacts(1)
+===============
+
+NAME
+----
+git-contacts - List people who might be interested in a set of changes
+
+
+SYNOPSIS
+--------
+[verse]
+'git contacts' (<patch>|<range>|<rev>)...
+
+
+DESCRIPTION
+-----------
+
+Given a set of changes, specified as patch files or revisions, determine people
+who might be interested in those changes.  This is done by consulting the
+history of each patch or revision hunk to find people mentioned by commits
+which touched the lines of files under consideration.
+
+Input consists of one or more patch files or revision arguments.  A revision
+argument can be a range or a single `<rev>` which is interpreted as
+`<rev>..HEAD`, thus the same revision arguments are accepted as for
+linkgit:git-format-patch[1]. Patch files and revision arguments can be combined
+in the same invocation.
+
+This command can be useful for determining the list of people with whom to
+discuss proposed changes, or for finding the list of recipients to Cc: when
+submitting a patch series via `git send-email`. For the latter case, `git
+contacts` can be used as the argument to `git send-email`'s `--cc-cmd` option.
+
+
+DISCUSSION
+----------
+
+`git blame` is invoked for each hunk in a patch file or revision.  For each
+commit mentioned by `git blame`, the commit message is consulted for people who
+authored, reviewed, signed, acknowledged, or were Cc:'d.  Once the list of
+participants is known, each person's relevance is computed by considering how
+many commits mentioned that person compared with the total number of commits
+under consideration.  The final output consists only of participants who exceed
+a minimum threshold of participation.
+
+
+OUTPUT
+------
+
+For each person of interest, a single line is output, terminated by a newline.
+If the person's name is known, ``Name $$<user@host>$$'' is printed; otherwise
+only ``$$<user@host>$$'' is printed.
+
+
+EXAMPLES
+--------
+
+* Consult patch files:
++
+------------
+$ git contacts feature/*.patch
+------------
+
+* Revision range:
++
+------------
+$ git contacts R1..R2
+------------
+
+* From a single revision to `HEAD`:
++
+------------
+$ git contacts origin
+------------
+
+* Helper for `git send-email`:
++
+------------
+$ git send-email --cc-cmd='git contacts' feature/*.patch
+------------
+
+
+LIMITATIONS
+-----------
+
+Several conditions controlling a person's significance are currently
+hard-coded, such as minimum participation level (10%), blame date-limiting (5
+years), and `-C` level for detecting moved and copied lines (a single `-C`). In
+the future, these conditions may become configurable.
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.8.3.3.803.gd114dc6
