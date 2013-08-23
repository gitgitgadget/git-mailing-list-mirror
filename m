From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] fix t3010 failure when core.ignorecase=true
Date: Fri, 23 Aug 2013 16:29:17 -0400
Message-ID: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 22:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxzQ-0003HZ-1a
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 22:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab3HWU3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 16:29:40 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54426 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab3HWU3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 16:29:39 -0400
Received: by mail-ie0-f171.google.com with SMTP id 9so1648185iec.30
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fD/Z/487lEzaOJgtkhMM6D6fcX8tu3eMYWtwy0XcDkY=;
        b=I65PKJKah20O41WEMGs6l4VAJECFN1b+y1r6Ep/290m8OdglBdRl3wJUJEygSV5fo1
         WkxJnMYk35g2KMTkZ2I8JIVsT6PywDpFHACiyfc5h6ls1YcDUoI6VrJYPdBPr8Gi/FTH
         pIi588PU7RxJ35c44IGIeD+jyjg354lmYWtudKG2QYb2V3+b8G7Ahsu8qZJNgbBPs1JX
         o3C/BfGHQcaYlWA4QbUJyG8IToskolI3+xwk3dFqle1uXsy1JI/cjdOlgN8nDdE4XDWt
         pOEhq3uVedgQ+T+OnQSbFSpTh5Nd4pNroHZacz6PjXCvpeGUsx4fkNWaQ0xnqmaDk7bA
         PnvQ==
X-Received: by 10.50.152.9 with SMTP id uu9mr2817117igb.53.1377289779078;
        Fri, 23 Aug 2013 13:29:39 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id cl4sm89620igc.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 13:29:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.557.g46c5bb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232833>

This is a re-roll of [1] which fixes a bug in dir.c resulting in failure
of a newly added test in t3010 when core.ignorecase=true.

Recent mailing list discussion [2][3] suggests that changes at a more
fundamental level (if they pan out) would be a more appropriate approach
to resolving this bug.  Such an approach would (happily) make patch 2/2
unnecessary, however, I'm posting this series for posterity since it was
already written before [2][3]. Also, since I'm learning the relevant git
internals as I work on these issues, any fix at the more fundamental
level (if it comes from me) is going to be correspondingly delayed since
there is so much more to digest.

Changes since v1:

patch 1: place the new test in t3010 instead of t3103 [4]

patch 2: make directory_exists_in_index() and
directory_exists_in_index_icase() responsible for their own internal
requirements regarding presence or lack of trailing '/' [5]; also, pass
in already-existing strbufs so that directory_exists_in_index_icase()
doesn't have to make its own copy of the incoming string in order to
append '/'

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232796
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232813
[3]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232822
[4]: http://thread.gmane.org/gmane.comp.version-control.git/232796/focus=232814
[5]: http://thread.gmane.org/gmane.comp.version-control.git/232727/focus=232800

Eric Sunshine (2):
  t3103: demonstrate dir.c:treat_one_path() core.ignorecase failure
  dir: test_one_path: fix inconsistent behavior due to missing '/'

 dir.c                               | 42 +++++++++++++++++++++++--------------
 t/t3010-ls-files-killed-modified.sh |  8 +++++++
 2 files changed, 34 insertions(+), 16 deletions(-)

-- 
1.8.4.rc4.557.g46c5bb2
