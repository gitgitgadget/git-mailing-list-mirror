From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: [PATCH] Added 'git-rev-list --igrep' option for case insensitive grep
Date: Sat, 21 Jul 2007 22:33:47 -0700
Message-ID: <a1bbc6950707212233h6047ecfas645b71b9b4c6317e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 07:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICU4w-0002JQ-NY
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 07:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbXGVFdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 01:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXGVFdt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 01:33:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:36369 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbXGVFds (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 01:33:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so31429rvb
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 22:33:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OaWnWE924VUreeVD1GdBkq2bWrpEEksTv0eK/Gr0/epcsTsFADHeJWpupFhGu0Bww2n6jP8NRe2OfPJhA5Q5f4H4S3L7wInhHQCdVB2VLNcLp0aRFrCALujwMQoAH+pn6KqGMlzJbW/w3Yy2HuOKI4nFoiubvMf19eZ6y8QhFYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GYNg+/xf2sLZzPkYRntymzqLiR6W7i7/P+3a236JJyh0Y0FfCqIwlEyrucXZC1N+JHcBXOdp8wAwnI+NPpcZSfYTyc27sGBESNr6ORTzXZNNybQ+EDeWUe+CkLEj8W5bc34Rr+lnfSWSeGy7L1WURLoz8PtwiwcL7/voOMO9tnk=
Received: by 10.141.42.10 with SMTP id u10mr582336rvj.1185082427611;
        Sat, 21 Jul 2007 22:33:47 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Sat, 21 Jul 2007 22:33:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53219>

>From 4b16e1823875f0051e3f0590803ab67dd3ca341d Mon Sep 17 00:00:00 2001
From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
Date: Sat, 21 Jul 2007 22:22:49 -0700
Subject: [PATCH] Added 'git-rev-list --igrep' option for case insensitive grep

---
 Documentation/git-rev-list.txt |    6 +++++-
 revision.c                     |    5 +++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 08e7573..f427862 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -26,7 +26,7 @@ SYNOPSIS
 	     [ \--left-right ]
 	     [ \--cherry-pick ]
 	     [ \--encoding[=<encoding>] ]
-	     [ \--(author|committer|grep)=<pattern> ]
+	     [ \--(author|committer|grep|igrep)=<pattern> ]
 	     [ \--regexp-ignore-case ] [ \--extended-regexp ]
 	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
@@ -227,6 +227,10 @@ limiting may be applied.
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).

+--igrep='pattern'::
+
+	Equivalent to --grep='pattern' --regexp-ignore-case.
+
 --regexp-ignore-case::

 	Match the regexp limiting patterns without regard to letters case.
diff --git a/revision.c b/revision.c
index 28b5f2e..d5e1e69 100644
--- a/revision.c
+++ b/revision.c
@@ -1165,6 +1165,11 @@ int setup_revisions(int argc, const char
**argv, struct rev_info *revs, const ch
 				add_message_grep(revs, arg+7);
 				continue;
 			}
+			if (!prefixcmp(arg, "--igrep=")) {
+				add_message_grep(revs, arg+8);
+				regflags |= REG_ICASE;
+				continue;
+			}
 			if (!prefixcmp(arg, "--extended-regexp")) {
 				regflags |= REG_EXTENDED;
 				continue;
-- 
1.5.2.3
