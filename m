From: santiago@nyu.edu
Subject: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Tue,  5 Apr 2016 12:07:23 -0400
Message-ID: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTW2-0000Tj-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759449AbcDEQHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:38 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:35763 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbcDEQHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:36 -0400
Received: by mail-qg0-f68.google.com with SMTP id b32so1624109qgf.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=waJOQKY2sf3MJ6rgv/pq+VoCfFquy/Zv9tr32OZXMWw=;
        b=bhQkoGY9gTz5cX2h/fybtkwQIOyjjwEp3YCT7QFNGuDfCUAc7epQaKQbF/sUQW9etZ
         ZA1LVb3ObUF+tpSlI7AghOt7GPV2Kc+djvlmJbXFCXlYGHr053uJeOgJ/e+ib/PiFANu
         aOdeRLNJYQEcsvd7aoAOab/7lDTkrdc/evODOSEgAYyKhHd+o/Cs/bvS97AXx6xwps51
         Xi2A7hO/MhbsDokoOjc9Pk7na0OSS4dVgCTnQSHyB7j6wVi9ZaqftgB3D3zbM4gj2rex
         LDHPky1wtZvxqdyD2WcfHzfWLBYpt9QYc9vB9e2QYriVMTQrE87bJiw25DPMN4BiMY+J
         5vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=waJOQKY2sf3MJ6rgv/pq+VoCfFquy/Zv9tr32OZXMWw=;
        b=aH0PBpP6j9IbePuVcopGrLBvzzxrVE7xSkxN4Xn6LsSLxKf7vcKeaKjD1x2ZG43yuH
         sROtlWHKFr3/eoltzzJiHCzr6cByWvvc12gC0XAYyN8niOAQioBhqJt0WGnOdG7wlpke
         kTjsoh5yUSE9GkIvaF+56NGclg17/PN0Fk2X96fjlEoLdOfPqTRcmmLe8gxvdH3Zvcju
         NGvTspZjAYl1jRCQ4w/O/wrNn0tkna3e58W9RZahIcsfyeNKsdvC295SmG/i1YLDxKAm
         nWW9wGm7GuICxgcWZ5Jfp7lkLlp79L6s8IGSF2SGa2QdrdQWIr/oWw41QyErFQSngnQX
         3cYA==
X-Gm-Message-State: AD7BkJIgH3IK8eu6TpBw+S6xTD+xHiFT127NKwLe3t7mCtNhxd+7TyAoIK9/i+azLVAg6BgY
X-Received: by 10.140.18.114 with SMTP id 105mr47484811qge.41.1459872455268;
        Tue, 05 Apr 2016 09:07:35 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290790>

From: Santiago Torres <santiago@nyu.edu>

v5 (this): 
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


Santiago Torres (6):
  builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
  t7030-verify-tag: Adds validation for multiple tags
  builtin/verify-tag: change variable name for readability
  builtin/verify-tag: replace name argument with sha1
  builtin/verify-tag: move verification code to tag.c
  tag: use gpg_verify_function in tag -v call

 builtin/tag.c         |  8 +------
 builtin/verify-tag.c  | 65 +++++++++------------------------------------------
 gpg-interface.c       |  2 ++
 t/t7030-verify-tag.sh | 12 ++++++++++
 tag.c                 | 48 +++++++++++++++++++++++++++++++++++++
 tag.h                 |  1 +
 6 files changed, 75 insertions(+), 61 deletions(-)

-- 
2.8.0
