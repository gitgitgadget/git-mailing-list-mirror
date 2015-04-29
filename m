From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Diffing submodule does not yield complete logs for merge commits
Date: Wed, 29 Apr 2015 15:53:11 -0500
Message-ID: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnYyr-0005J2-Ty
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 22:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbbD2UxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 16:53:14 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35690 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbbD2UxL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 16:53:11 -0400
Received: by igbyr2 with SMTP id yr2so130754820igb.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=74ZqOT8czBIAP2IOZ9KngMrlWS+TPselZPVz1IQb80o=;
        b=kf/jFDS4uAa472uwKW8n81+k5nAiLZxfeleVCLWcoso3CU+wp1W8hLcvri8d+qCsJ2
         uH/lpAFGVHWiFVYrJK6EBjyUB0ZqMMiNVGCj2SA0598YiLvufF6wgJ78ibUAwCPugXYN
         /BuiFZc048gUt/2ebIT+mH/mgSq1sU7ygWDqjJn4u7NpI7GXIcD/EELNyEONbJhKW1tF
         N8HtqM38WnC1mGBhE4mdmdbDpme/7wkQyDQw6PJm8novLApT1jEfRORV3bR/PKN6PBHN
         W4of0iqyR5MrSNqt0nP+fHVlV4eORwU+LYKOREirP4Mit4ZG9KWkiyQNqHyb8r0sJ46M
         OdJQ==
X-Received: by 10.43.97.130 with SMTP id ck2mr5671661icc.91.1430340791116;
 Wed, 29 Apr 2015 13:53:11 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Wed, 29 Apr 2015 13:53:11 -0700 (PDT)
X-Google-Sender-Auth: Opvp1dYGtuIjiQ-iRQNEVUJ816o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268000>

I am attempting to diff a submodule modified in my working copy and
the only difference is a merge commit. However, I do not get the
"full" range of commits introduced by the merge commit when I diff it:

$ git diff --submodule=log Core
Submodule Core 8b4ec60..def2f3b:
  > Merge remote-tracking branch 'origin/master-ah3k'

However if I go inside my submodule and run `git log` by hand, I get
more information about the TRUE commits introduced:

$ git log --oneline 8b4ec60..def2f3b
def2f3b Merge remote-tracking branch 'origin/master-ah3k'
015c961 Remove log spam in FontManager
7713ba1 Update third party submodule to latest
10aac78 Merge pull request #9 in FE/core from
feature/FE-1348-selecting-continue-on-zero-balance to master-ah3k
287882f FE-1376 Nedd to remain in check detail screen when selecting
donation after SBI
a5a6bed Do not overwrite the current check# within loop
dfb8547 Adding list of checks to CRspChecks before saving
1be280a FE-1354: Guest logged out in specific multiple check scenario
de06d5a [FE-1348] Fix PATT exit while checks still open

It's almost as if the `git diff --submodule=log` approach is passing
in --first-parent to git log, which would exclude commits in the range
that I'm seeing when I run git log manually.

Is this by design? Is there a way to enable the full log history with
`git diff` on a submodule?
