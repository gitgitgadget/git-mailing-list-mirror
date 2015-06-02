From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 0/2] Improve git-pull's option parsing
Date: Tue,  2 Jun 2015 22:22:51 +0800
Message-ID: <1433254973-13797-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 16:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzn5w-0000RR-N8
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbbFBOXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:23:04 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36244 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948AbbFBOXA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:23:00 -0400
Received: by pabqy3 with SMTP id qy3so13545999pab.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jWAJsNryic7oVFcrwA9CFgnizIoY8P2DjASdVXBbzpM=;
        b=g1zOmpH6/APkLekEWENpUuXCs0hT8xUYELKPgcj9VVqLsWy/1iGaF+A0Eb4Jfq4jOn
         o+YRkmlIrXjR4RSTu+zcnjfnZwkRu/qng82Dl/a3ttwXDZI+FmyBUMDVFOcPb6HS0Q6H
         2L9IhRwNWpUBPK2S08BAzeNVsRSNJSVvA4z/L7/JQ+VpTbfkCVcug22Q+r8OHGGn1mwk
         JSxy6Uan68fxzG0mxqPgVXaiwlYR/Tk5fezTz28bDScj0IRwgB8SQ0Y6wclYZzfvJIL0
         Q2YJfuhC6soodrpCZYe78XPiET4j9rD35nDUjKNU6ACUVhD+7y0R7haGZJ6JQjelZQF1
         l0cQ==
X-Received: by 10.66.101.103 with SMTP id ff7mr51061725pab.13.1433254980240;
        Tue, 02 Jun 2015 07:23:00 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id fd3sm5329786pac.39.2015.06.02.07.22.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 07:22:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270542>

This is a re-roll of [v1]. Thanks Johannes for the reviews last round.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/269249

This patch series is based on pt/pull-tests.

While parsing the command-line arguments, git-pull stops parsing at the
first unrecognized option, assuming that any subsequent options are for
git-fetch, and can thus be kept in the shell's positional parameters
list, so that it can be passed to git-fetch via the expansion of "$@".

However, certain functions in git-pull assume that the positional
parameters do not contain any options. Fix this by making git-pull
handle git-fetch's options as well at the option parsing stage.

With this change in place, we can move on to migrate git-pull to use
git-rev-parse --parseopt such that its option parsing is consistent with
the other git commands.

I believe this is the last required behavior change for my rewrite of
git-pull.sh to C.

Paul Tan (2):
  pull: handle git-fetch's options as well
  pull: use git-rev-parse --parseopt for option parsing

 Documentation/git-pull.txt |   3 --
 git-pull.sh                | 128 +++++++++++++++++++++++++++++++--------------
 t/t5520-pull.sh            |  20 +++++++
 t/t5521-pull-options.sh    |  14 +++++
 4 files changed, 122 insertions(+), 43 deletions(-)

-- 
2.1.4
