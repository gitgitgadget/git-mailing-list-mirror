From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/9] port branch.c to use ref-filter printing APIs
Date: Fri,  2 Oct 2015 23:08:57 +0530
Message-ID: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 02 19:39:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi4Ii-0003kO-FW
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbJBRjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 13:39:07 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34707 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbbJBRjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 13:39:05 -0400
Received: by pablk4 with SMTP id lk4so12536188pab.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QokTcIuPwjSNHWrvWZMUFvui9wj4IFD8pBt8qtAGToQ=;
        b=l9I19MY2CiXHY4UOanb+iG0I5KpWVMeCWBkxllIh0Ue/2JdCxzGj/eHC/+2sHEHyWk
         73Od8B//e58oI+wwhJxBvgGaSuwf+L3FivvpLSWF9P/Y99Hif9NGT7XrURtJMIKbYyEh
         cif5UZm3jFEcT2fID2OkM8G9GB7IxnLD/vGE341ECR6yQBdZ1yb5xIvBroB/1SVbpHIK
         q7JGCDt1WUXN21XQWlXAUbEVWcWz7c5TPbccgkc3lKcgD0mVwqGei5lOS6SRu7T30zaJ
         T0ohGLlL8nzwa9+ZXAmyKwPolAwkT8Yw3EW4Edi3B1317uI0THNrtOLaT5OL23Kkd7Yr
         PO8g==
X-Received: by 10.66.161.7 with SMTP id xo7mr21087015pab.57.1443807544982;
        Fri, 02 Oct 2015 10:39:04 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pq1sm12993384pbb.91.2015.10.02.10.39.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Oct 2015 10:39:03 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278926>

This series ports over branch.c to use ref-filter APIs
This is the last part of unification of 'git branch -l', 'git tag -l'
and 'git for-each-ref'.

There are a few topics worth discussing here :

1. [7/9] This ensures that when we use the "%(upstream:track)" atom we
print "[gone]" for upstreams which are invalid. We either implement
this and try to mimic what branch.c does when we use the verbose
option or we can drop this in branch.c.

2. [8/9] The usage of get_format() function in branch.c which provides
us the needed format for printing. This seems overly complex to the
uninitiated as it uses a complex atom combinations to mimic the
existing branch printing format.

Karthik Nayak (9):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: add support for %(path) atom
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: adopt get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  32 ++++-
 builtin/branch.c                   | 262 ++++++++++---------------------------
 ref-filter.c                       | 250 +++++++++++++++++++++++++++++++----
 ref-filter.h                       |   3 +
 t/t3203-branch-output.sh           |  11 ++
 t/t6040-tracking-info.sh           |  12 +-
 t/t6300-for-each-ref.sh            |  24 +++-
 t/t6302-for-each-ref-filter.sh     | 105 +++++++++++++++
 9 files changed, 480 insertions(+), 226 deletions(-)

-- 
2.6.0
