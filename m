From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon,  2 May 2011 13:39:09 +0200
Message-ID: <cover.1304318972.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 13:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrTF-0000e9-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985Ab1EBLjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:39:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1EBLjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:39:16 -0400
Received: by bwz15 with SMTP id 15so4521802bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=zDwIK6YBvMHhOgBfNk0uTxqIXuRQ9wnthBvZTDZqoKc=;
        b=cKxlcls/VYvrZXwal3cA5V+sJEJat/rX0Dle89PoMhcslQ4jpyHEuQ/sev8s3qkFcy
         R3DfnIltQ8kPjL56gqwrYndt/9pxXXqhBSTsiHQ5V2RrXfUhsG78wCzYIk3b4j5jvkmE
         ZG3zWMFPlUxBtWUZys8jlRzce1Pp1hQKzNSKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uQkXEEvdp3RI0lhFdOuslZzpWNnUwj0lHXbT/OqCnK4lm9pg3A6JJfsMFtVRLLtSx1
         7FWNpsxp0y21EbYfpptyLhUVbcUdHRVlT/5zwgv334gefB3Xf2F/pjNBYDtqXodifIC6
         gZiUxRnB22rlK7YDooqjinR6ThGoagmK/brX8=
Received: by 10.204.73.206 with SMTP id r14mr3015147bkj.181.1304336355268;
        Mon, 02 May 2011 04:39:15 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id q24sm2371093bks.9.2011.05.02.04.39.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:39:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172570>

This series will teach git grep to match at specified line numbers. This is
particular usefull, if you want to see the lines which emits warnings or errors
from a build run (where you only get the line number) and present it nicely to
the user with function and context lines.

The implementation is split-up into preperation patches which are only noise:

Bert Wesarg (4):
  grep: prepare for re-using the space of the regexp member in struct
    grep_pat

    This one moves the regexp member into an union, so that we can later re-use
    the space for the line number information.

  grep: pass current line number down to match_one_pattern

    To actually match at the line number, the function match_one_pattern needs
    to know the current line number, do it with this patch.

  grep: introduce pattern which matches at line number

    This implements the line number matching in the low level grep machinery.

  grep: provide option to match line number

    And lastly, this exposes the new feature by a new -@ option to git grep.

Patch 5 will than support comma separated line ranges as argument to -@, but
this work has not yet started.

 Documentation/git-grep.txt |    6 +++-
 builtin/grep.c             |   10 +++++
 grep.c                     |   87 ++++++++++++++++++++++++++++++--------------
 grep.h                     |   11 ++++--
 4 files changed, 83 insertions(+), 31 deletions(-)

-- 
1.7.5.349.gfeb1a
