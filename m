From: Andy Parkins <andyparkins@gmail.com>
Subject: git-blame not tracking copies
Date: Wed, 2 May 2007 20:33:23 +0100
Message-ID: <200705022033.25885.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 21:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjKaf-0003Ya-KK
	for gcvg-git@gmane.org; Wed, 02 May 2007 21:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXEBTdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993161AbXEBTdj
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 15:33:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60610 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbXEBTdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 15:33:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so316295uga
        for <git@vger.kernel.org>; Wed, 02 May 2007 12:33:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JS4AOYXUBHi9FWhDZif7op6aoq/BGftnqiCw5QE9J3MsyLL5AvN2YOiBGkq7S/ie4acdTA8KSy2+hRvUGqIEoNwRymsovqzLBzQVfvcHi5gGVd7jJ9iKnPf5FALsi7XgCbQ4Jprdb/eMiJOTl0getrhO7LUiDtDAcvlkcxlypq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L7xYDwjrxO7HKppwV/pfiJwJvnaR50loto8YLoivhDJH3qIws7Mw7LXrb4/WEm/EAEqpyl5iFuBSyXJ+SEjy9MAaNTAo/M/k4urddgU25Oxw6FEXHXE9hRo5sTK+d3ezkuvW69HhlCibeRkD9og2F9ntxvlN2893x3V/pFkSx+E=
Received: by 10.67.100.17 with SMTP id c17mr284746ugm.1178134417415;
        Wed, 02 May 2007 12:33:37 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 54sm1939472ugp.2007.05.02.12.33.36;
        Wed, 02 May 2007 12:33:36 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46046>

Hello,

During the discussion on the ffmpeg list about potential migration to 
git the following came up.  It seems like a bug to me, so I said I 
would raise it here.

This is the output of a test script (which I can supply if wanted, but 
you can guess the content from the output.

Initialized empty Git repository in .git/
----- echo ABC to commit 1
Created initial commit beb7140: 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 newtest
----- echo DEF to commit 2
Created commit 207f5a3: 2
 1 files changed, 1 insertions(+), 0 deletions(-)
----- echo ghijk to commit 3
Created commit 14abf8c: 3
 1 files changed, 1 insertions(+), 0 deletions(-)
----- Blame 1...
^beb7140 (Andy Parkins 2007-05-02 20:25:27 +0100 1) ABC
207f5a35 (Andy Parkins 2007-05-02 20:25:27 +0100 2) DEF
14abf8ce (Andy Parkins 2007-05-02 20:25:27 +0100 3) ghijk
----- Copy newtest to newtest2, commit 4
Created commit 48861ce: 4
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 newtest2
----- Blame 2...
48861ced (Andy Parkins 2007-05-02 20:25:27 +0100 1) ABC
48861ced (Andy Parkins 2007-05-02 20:25:27 +0100 2) DEF
48861ced (Andy Parkins 2007-05-02 20:25:27 +0100 3) ghijk
----- Edit newtest2, commit 5
Created commit 2d2ec0f: 5
 1 files changed, 1 insertions(+), 0 deletions(-)
----- Blame 3...
^beb7140 newtest  (Andy Parkins 2007-05-02 20:25:27 +0100 1) ABC
207f5a35 newtest  (Andy Parkins 2007-05-02 20:25:27 +0100 2) DEF
2d2ec0f0 newtest2 (Andy Parkins 2007-05-02 20:25:27 +0100 3) XXXX
48861ced newtest2 (Andy Parkins 2007-05-02 20:25:27 +0100 4) ghijk

All git-blame commands are "git-blame -C1 -C1"

The issues are

 - Blame2 says all the lines come from commit 4, when actually they
   come from commits 1, 2 and 3.  It was pointed out that this is
   particularly annoying because the file is an exact copy and so the
   copy has the same hash as the original so should be easy to spot

 - The output isn't stable, even if blame2 had a good reason for not
   assigning lines 1 and 2 to their correct commits, why isn't the same
   true in blame3?

 - Blame3 incorrectly ascribes line 4 to commit 4, when it should have
   remained as it was in blame1 - to commit 3.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
