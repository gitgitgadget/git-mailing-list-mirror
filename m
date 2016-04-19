From: santiago@nyu.edu
Subject: [PATCH v7 0/6] Move PGP verification out of verify-tag
Date: Tue, 19 Apr 2016 13:47:15 -0400
Message-ID: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:47:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkV-0002Ju-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbcDSRr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:29 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34434 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcDSRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:28 -0400
Received: by mail-qk0-f180.google.com with SMTP id r184so6822389qkc.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ReDH90nOEYqS6kmGt/Rk8uhyh+19W92W2ps86fEguVY=;
        b=JMBuPa/qi11k+s2mg99drTegbGDnQ72B23oooYg6OCPqQT12mtv+K0CK4jKVXXHAVG
         U3Oeo4noNvQCZtlas3I/B2cH3Spua9p5oN2AFxwV/L7NnGYmihNvBshS95hzozA88wTs
         Harop/6IRzgqvyo17Q3W/2xvsFScGbDCO10PIXjyT5qyHzOk2aAtaIENdSyp89IhwRDY
         TpP8OvxdiFJpcBtP5c4KMVDkBSkT8YZ2zx4AW1Gpkds7WZ8k4GKVzS+5CkRmhCbceATF
         yhizs+T7l/3wLKcZ1ZSlw2+ihvO9JdXK/q6ahZMkV/pxevmPpezY7R6AwDW8q5EbILOF
         mBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ReDH90nOEYqS6kmGt/Rk8uhyh+19W92W2ps86fEguVY=;
        b=a/g5TBCTBZlP2AJm7OUeE58tzV1jEtXRpUSdJuVAqQOxvAf0fQLejBhAClPvvDdoML
         D/z9YfZq8kFnK3FmNe68SDPn2HcQllQBeWUe23LcuBi2iN8Q0e0d8No0SkqZEAyxpg8X
         QdujX6XjVDffh/wKKG6Re1qm1ZXW5Gmpuw/y568RnA5muP3JvrGWdfPyhCLgZ03n3T4K
         amoKfZH7pvN3aCpp76ca5Yy+htW9DX2fRqfWq5EnczLwpvId/rT77V8VN6wdLCr64dmL
         fjuWi7DUa6K3cf69Oz5UjjpbAm1r1+Fr6zu1nOlTQm8UiZcJVlwC6LPadYuxyMHJ5boX
         5wpw==
X-Gm-Message-State: AOPr4FUy0v9Z/CEqUYQW/A+tIz2So3FKxOt4VWJ+ht7FiQ+WKfhVW//rGzmB89/6OeZJYeFT
X-Received: by 10.55.72.196 with SMTP id v187mr5375654qka.97.1461088046809;
        Tue, 19 Apr 2016 10:47:26 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291887>

From: Santiago Torres <santiago@nyu.edu>

This is a follow up of [1], [2], [3], [4], [5], [6]. patches 1/6, 2/6, are the
same as the corresponding commits in pu.

v7: 
Mostly style/clarity changes mostly. Thanks Peff, Eric and Junio for the
feedback! In summary: 

 * Eric pointed out issues with 3/6's commit message. It doesn't match the one 
   in pu though. I also took the opportunity to update payload_size to a size_t
   as Peff suggested.
 * 4/6 I updated report_name to name_to_report, I updated the commit message 
   and addressed some nits in the code, one of the fixes removed all three nits
   that Eric pointed out. I updated 5/6 to match these changes
 * I gave the commit message on 6/6 another go.

v6: 
 * As Junio suggested, updated 4/6, to include the name argument and the
   ternary operator to provide more descriptive error messages. I propagated
   these changes to 5/6 and 6/6 as well. I'm unsure about the 80-column
   on 4/6, the ternary operator is rather long.
 * Updated and reviewed the commit messages based on Eric and Junio's
   feedback

v5:
Added helpful feedback by Eric

 * Reordering of the patches, to avoid temporal inclusion of a regression
 * Fix typos here and there.
 * Review commit messages, as some weren't representative of what the patches
   were doing anymore.
 * Updated t7030 to include Peff's suggestion, and added a helped-by line here
   as it was mostly Peff's code.
 * Updated the error-handling/printing issues that were introduced when.
   libifying the verify_tag function.

v4:

Thanks Eric, Jeff, and Hannes for the feedback.

 * I relocated the sigchain_push call so it comes after the error on
   gpg-interface (thanks Hannnes for catching this).
 * I updated the unit test to match the discussion on [3]. Now it generates
   the expected output of the tag on the fly for comparison. (This is just
   copy and paste from [3], but I verified that it works by breaking the
   while)
 * I split moving the code and renaming the variables into two patches so
   these are easier to review.
 * I used an adapter on builtin/tag.c instead of redefining all the fn*
   declarations everywhere. This introduces an issue with the way git tag -v
   resolves refnames though. I added a new commit to restore the previous
   behavior of git-tag. I'm not sure if I should've split this into two commits
   though.

v3:
Thanks Eric, Jeff, for the feedback.

 * I separated the patch in multiple sub-patches.
 * I compared the behavior of previous git tag -v and git verify-tag 
   invocations to make sure the behavior is the same
 * I dropped the multi-line comment, as suggested.
 * I fixed the issue with the missing brackets in the while (this is 
   now detected by the test).

v2:

 * I moved the pgp-verification code to tag.c 
 * I added extra arguments so git tag -v and git verify-tag both work
   with the same function
 * Relocated the SIGPIPE handling code in verify-tag to gpg-interface

v1:
 
The verify tag function is just a thin wrapper around the verify-tag
command. We can avoid one fork call by doing the verification inside
the tag builtin instead.


This applies on v2.8.0. 
Thanks!
-Santiago

[1] http://thread.gmane.org/gmane.comp.version-control.git/287649
[2] http://thread.gmane.org/gmane.comp.version-control.git/289836
[3] http://thread.gmane.org/gmane.comp.version-control.git/290608
[4] http://thread.gmane.org/gmane.comp.version-control.git/290731
[5] http://thread.gmane.org/gmane.comp.version-control.git/290790
[6] http://thread.gmane.org/gmane.comp.version-control.git/291780

Santiago Torres (6):
  builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
  t7030: test verifying multiple tags
  verify-tag: Update run_gpg_verfy len variable name and type
  verify-tag: prepare verify_tag for libification
  verify-tag: move tag verification code to tag.c
  tag -v: verfy directly rather than exec-ing verify-tag

 builtin/tag.c         |  8 +------
 builtin/verify-tag.c  | 62 +++++++--------------------------------------------
 gpg-interface.c       |  2 ++
 t/t7030-verify-tag.sh | 13 +++++++++++
 tag.c                 | 53 +++++++++++++++++++++++++++++++++++++++++++
 tag.h                 |  2 ++
 6 files changed, 79 insertions(+), 61 deletions(-)

-- 
2.8.0
