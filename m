From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] fix interactive rebase short SHA-1 collision bug
Date: Mon, 12 Aug 2013 00:07:36 -0400
Message-ID: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 06:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8jQv-0006Ii-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 06:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab3HLEI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 00:08:27 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:54813 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3HLEI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 00:08:26 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so7305108iea.23
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GCf1DvKU7SIcsUlQc8swdacfCxNiy7xh2vQvcStx5fg=;
        b=l+rGdLDItvSjAejcGGy9UDThUJdaWT7dRi1T/G0OoBHUcPUyT5O9I71hF8r1H0yCvL
         YHXK0nekvo21vVB1K6+Hl6V3a1bVrXX3RjWEXpK8GNt9KRu3PnzagFdb86Ckc7rjWmlO
         Vrm/V39+LBYECYL+RfMnUwqXm4Riufb75+f+FEh65YNYB9QqOIufNxPyG9bHZgeSGL8u
         jVUWhw66qiBdP1m7Zk0JqZ6QpY4RQq35GlMumMYl03kFZSDz1JYQjxq8ll+wsD46Z8/m
         +T1CvDWSggyf5RSziYqXwChZxHRlC5G3oXCi+7KRFHRL2ilTk+XaYCvWB1ojpWNROA1S
         39Uw==
X-Received: by 10.43.168.67 with SMTP id nh3mr8619558icc.33.1376280505673;
        Sun, 11 Aug 2013 21:08:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id x2sm11986256igw.0.2013.08.11.21.08.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 21:08:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232146>

This series addresses a bug [1][2] which can manifest during interactive
rebase when the prefix of the new SHA-1 of an edited commit is shared
with the abbreviated SHA-1 of a subsequent commit in the 'todo' list.
When rebase attempts to process the subsequent command, it dies with a
"short SHA1 badbeef is ambiguous" error.

patch 1: fix a problem in the interactive rebase test suite which can
    make subsequent tests fail

patch 2: add a test demonstrating the short SHA-1 collision bug

patch 3: fix the bug (this patch is from Junio [3] but augmented also to
    fix up "rebase --edit-todo")

[1]: http://thread.gmane.org/gmane.comp.version-control.git/229091
[2]: http://thread.gmane.org/gmane.comp.version-control.git/232012
[3]: http://thread.gmane.org/gmane.comp.version-control.git/229091/focus=229120

Eric Sunshine (2):
  t3404: restore specialized rebase-editor following commentchar test
  t3404: rebase: interactive: demonstrate short SHA-1 collision

Junio C Hamano (1):
  rebase: interactive: fix short SHA-1 collision

 git-rebase--interactive.sh    | 30 ++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
1.8.4.rc2.460.ga591f4a
