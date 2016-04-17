From: santiago@nyu.edu
Subject: [PATCH v6 0/6] Move PGP verification out of verify-tag
Date: Sun, 17 Apr 2016 18:26:55 -0400
Message-ID: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:27:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arvA9-00055l-7U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 00:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbcDQW1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 18:27:20 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33337 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbcDQW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 18:27:17 -0400
Received: by mail-qk0-f175.google.com with SMTP id n63so40641212qkf.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PYa3tG22fdX2wpvaPLjf2tqxBDEBO/SdtCd05Bq1nNg=;
        b=hgi3xpFCuDX2Otalm7gFqY8fqzKVUTTkp7HjZiEvcTiF+2TxeukcLNqpc6PM1e/Gpq
         7NhdmPz/6mjwFJYQiCUY2VX1Q07UZ28v8hkKD+GlHUcWMNlEHL2PXxA8FYrAXCNPDuXg
         qXJlg5cf05DU183Yrx+XFYXTfJrIDgC0bIxj6D4YpydJL4hZBY4O1+d2weKZQfCFb/8w
         7EHOmfPp12Ni8DU1+V5OxIKxFrBRoBxdV/U38jgRYdg7U52emnFGIWZFOMKPDjc4pMrB
         FqAeqQtTLnQvPg67RY9pJApHMxLJHajylR/QNqZYGrJoRDQNTOi4p5x3gYJdxEvxILqV
         wlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PYa3tG22fdX2wpvaPLjf2tqxBDEBO/SdtCd05Bq1nNg=;
        b=icRwWBHA7p67rITJFvJhVunoaomgPvwWUbwLh5VxBPgMDorX2l5wg6wVZJdAdu0Doq
         XeGlAv7yA0BAXcWlUAYTsvVZHSJ5YgBYecUsbfWhTjbWk7voqhJ5Jz1wJZQPYM54YI0y
         vFgd0PSjZOxzURWLi5TT+W0RDUF0ep+OGsK8Xij0NIeIhL0+TgEKQabjMVM1iwTU/K/z
         GxVfWQuzijJy7dJu4M0rl25g7fTBD88mbCOeMAh2M9i9rTvHeO110UGesi4NC8SEiehL
         tF4YeMvj4EseNT1gMwpmRcUSHezeqGRjhEv69JT/zzAAtjVn1CnF2Ha/5//a+iYB5gcl
         gvNQ==
X-Gm-Message-State: AOPr4FV1AAMc64ZaQuK0zwCPR1MO8ZgxSeRljgXADDRGm+j1pU6Obu9W0FuA2Ltdi2RwbW+6
X-Received: by 10.55.71.76 with SMTP id u73mr39944938qka.6.1460932031761;
        Sun, 17 Apr 2016 15:27:11 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id j75sm5120767qgd.19.2016.04.17.15.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 15:27:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291780>

From: Santiago Torres <santiago@nyu.edu>

This is a follow up of [1], [2], [3], [4], and [5]. patches 1/6, 2/6 and 3/6
are the same as the corresponding commits in pu.

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

Santiago Torres (6):
  builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
  t7030: test verifying multiple tags
  verify-tag: change variable name for readability
  verify-tag: add sha1 argument to verify_tag()
  verify-tag: move verification code to tag.c
  tag -v: verfy directly rather than exec-ing verify-tag

 builtin/tag.c         |  8 +------
 builtin/verify-tag.c  | 64 ++++++++-------------------------------------------
 gpg-interface.c       |  2 ++
 t/t7030-verify-tag.sh | 13 +++++++++++
 tag.c                 | 49 +++++++++++++++++++++++++++++++++++++++
 tag.h                 |  3 ++-
 6 files changed, 77 insertions(+), 62 deletions(-)

-- 
2.8.0
