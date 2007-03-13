From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Remove tab character from conflicted files list part of the merge message
Date: Tue, 13 Mar 2007 13:09:43 +0000
Message-ID: <200703131309.43767.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 14:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR6lH-0007Es-4t
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 14:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbXCMNJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 09:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbXCMNJt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 09:09:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:41764 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXCMNJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 09:09:48 -0400
Received: by wr-out-0506.google.com with SMTP id i28so1325653wra
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 06:09:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=YOv2H8hrQ/DVQp7pB2EdGPck/Uj7vhXTzfzLZmytj7Y6k+KPSICmoTD5qyrpHlzXi4a9fzNECxFZwQrczBg0d2DAEXidkEfrOB8Z1wr8xe5Uls1/ukBhUyvxbFlthpszHekHvlp/Osg9jXOCEcVePmaMs946U21Y2i7z5uJWoT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Q5U9UYwoFxRyHqsuBHn2gcjnUaKRzxRpCk0YopDE2FXyJuw6VbN7OijQ2Zkm9JlOnBitfJHUwnZuFn7I3NkJAu4YUBT1Hv7N2AWW/w1Fv0KGSDZWKpfjqTYzOUxZYuHVokQTSi4Rr11kh/sAHCwnRswqX+ctu+1DlvQWSfj2xIs=
Received: by 10.65.219.1 with SMTP id w1mr1873259qbq.1173791387812;
        Tue, 13 Mar 2007 06:09:47 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id x1sm3435881nfb.2007.03.13.06.09.47;
        Tue, 13 Mar 2007 06:09:47 -0700 (PDT)
X-TUID: 3e8e2438409e3e2f
X-UID: 285
X-Length: 1130
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42116>

Merge can generate sections like this:
 Conflicts:
   file1
   file2
   file3
The filenames were moved forward by embedding a tab.  Tabs are variable
width, so there is no guarantee that the appearance would be the same on
different systems.  In this case the tabs are being used for formatting,
for formatting, spaces are better.

This patch simply swaps the tab for four spaces in the "Conflicts:"
section.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
The reason this makes a difference (to me), is that I often edit the
conflict section to say what the resolution of the conflict was,  I
happen to have expandtabs set for git log messages (to guarantee they
look the same regardless of the viewer's settings), and hadn't noticed
that git was putting tabs into the log message for me.

So what I thought I was formatting as (for example)

Conflicts:
    file.c
     * Chose upstream version over mine, but integrated my small typo fix.

Was appearing in the log display as

Conflicts:
        file.c
     * Chose upstream version over mine, but integrated my small typo fix.

Which isn't how I'd intended at all.

The fix is of course - no tabs.  Tabs for formatting is always going to cause
trouble, so this patch swaps the tab for spaces.

I don't think the actual number of spaces is important (I chose 4), as long
as there are no tab-surprises in the log message (unless the user put them
there themselves of course - but that's their own fault).


 git-merge.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 6ce62c8..a03d22b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -482,7 +482,7 @@ else
 Conflicts:
 '
 		git ls-files --unmerged |
-		sed -e 's/^[^	]*	/	/' |
+		sed -e 's/^[^	]*	/    /' |
 		uniq
 	} >>"$GIT_DIR/MERGE_MSG"
 	if test -d "$GIT_DIR/rr-cache"
-- 
1.5.0.2.205.g74e20
