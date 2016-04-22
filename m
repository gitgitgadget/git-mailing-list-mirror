From: santiago@nyu.edu
Subject: [PATCH v8 0/6] Move PGP verification out of verify-tag
Date: Fri, 22 Apr 2016 10:51:59 -0400
Message-ID: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRN-00058b-KD
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbcDVOwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:12 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32800 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcDVOwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:11 -0400
Received: by mail-qk0-f179.google.com with SMTP id n63so39137101qkf.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yG1n291S8X8/UVOesq/Rh/SBVfDH8TRPfvbvpQwFJUw=;
        b=sS0z1Vujt8HaXM84Ic3QTJg1rGZgf5raTKQk2M2/3sI96vFWRD8dmL96kfjVgDmpDb
         7QDYtPVBP47BUMDCZZ2A2ReswyTtkz32lXdCYzHjivSYdoDUENCkP8yqj7Fo8pvmtlOz
         ENqcIp6wkgBd1vrLgBTgB4T7mhWKFgu56/TAmocnEIa+9uYkutswYKGPyer21Kq4Q0gk
         Yhbp/v2UfRLrOCofVAA1M12VzVS7ieypWOz/99eDmRmFr0yBxKilqXF0nsfEl/bjrmSI
         BMqpGwqvj+sn20G5s6Q699Dw5eEG5V7MmFJf7lA41wFuN1BzEUQMNBUsIdDeXSjZke0h
         kZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yG1n291S8X8/UVOesq/Rh/SBVfDH8TRPfvbvpQwFJUw=;
        b=kOurD2h7RniRkDjx31QIUqOrvvN/19ll9dyUPWF9tTY1TYh+bbjLKK3iH45mMUOiEd
         GL2z229o3KqHSqfrCC4PS/cqfs0qIGHEo9GuxbrApR1FQOo1DF+t3p77i771G5tq2hXX
         rmLZ9YMwGtXfbDC14xnV2aLzB9yykoszmLF7CbRM5I94nf6lorollK37VlfwfhUgCOGu
         OmSvHEx7J1GanI6UBi+P/yvm3YY2Fr6rF5pHYEkVaGGR0/NDIiV4Hz5q5aLv4G6mmmoT
         P86rvEMj+srw6/n/kc1N4jQ8gA3KWBKi5g76rKHIQNTsnPBbIBSjGSoth2CBki6TW3/u
         K41A==
X-Gm-Message-State: AOPr4FWJp6pJ5v54peYgeYQ8bVvMQKZAmWaIZCMzzIrRLwEtYuM/PAatSrobPaG2VNklKrnx
X-Received: by 10.55.117.12 with SMTP id q12mr5127646qkc.192.1461336730259;
        Fri, 22 Apr 2016 07:52:10 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292220>

From: Santiago Torres <santiago@nyu.edu>

This is a follow up of [1], [2], [3], [4], [5], [6], and [7].  patches 1/6,
2/6, and 3/6, are the same as the corresponding commits in pu.

v8:  
Minor nits, I decided to quickly reroll to drop the extern qualifier in tag.c:
  * Eric pointed out that we could block-scope the declaration of name and sha1
    in b/verify-tag.c, for 4/6
  * There was a typo in 6/6
  * I dropped the extern qualifier in tag.c for 5/6 as suggested by Ramsay
    Jones[8]

v7: 
Mostly style/clarity changes. Thanks Peff, Eric and Junio for the
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
[7] http://thread.gmane.org/gmane.comp.version-control.git/291887
[8] http://thread.gmane.org/gmane.comp.version-control.git/292029



Santiago Torres (6):
  builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
  t7030: test verifying multiple tags
  verify-tag: update variable name and type
  verify-tag: prepare verify_tag for libification
  verify-tag: move tag verification code to tag.c
  tag -v: verify directly rather than exec-ing verify-tag

 builtin/tag.c         |  8 +------
 builtin/verify-tag.c  | 61 ++++++---------------------------------------------
 gpg-interface.c       |  2 ++
 t/t7030-verify-tag.sh | 13 +++++++++++
 tag.c                 | 53 ++++++++++++++++++++++++++++++++++++++++++++
 tag.h                 |  2 ++
 6 files changed, 78 insertions(+), 61 deletions(-)

-- 
2.8.0
