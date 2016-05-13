From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t3404 static check of bad SHA-1 failure
Date: Fri, 13 May 2016 18:09:35 +0200
Message-ID: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 18:09:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Fen-0005NA-DP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcEMQJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 12:09:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33554 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbcEMQJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 12:09:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id y6so11686902ywe.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=Lnb10n1a4u/3hTuCKeTDFaiZzLlE6RBjkog0FEOcO0s=;
        b=hNUR8tdugW/mEahoF0qNC7lTmXNGGh4jEsaH/QOeA4Vm8RsmqZHgBV5KJR3TwHeKhn
         KzHOimmwG82N0PJFq2ldMUclqzsb/nZRyA2EXAGrOtjiGrAABDmJM0Gp3oCxIuBGzDTH
         QZjxJd+mW34Zz9wnx6WwnGamkDN4Z/MmHzQykTM1zVsFkqISNRHnca9Zu+iNRYeDUoq8
         dA1JxAL/oDusI+Hk9rKY6yUKqWs6ZF12X4Ewk7rQu0Gu2RW2ZOp4u14adhWc3aEF4NUs
         9oEvAKN/WkQow2nqgMjB5BjXxj4C4tQ9hGzbyevmPogGx3NnFvkriJ4/YR4z+tpakznX
         qR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Lnb10n1a4u/3hTuCKeTDFaiZzLlE6RBjkog0FEOcO0s=;
        b=kCarU+ttd2jdtocMZpwMNpXjqGigOfu0xchzJrw5sYYtxJycqj2HC4nPD5mkKky+JF
         QT5oKT0cPRou8AmKBdXgLE3ZEs4jzeXQD5NO3Coop99j4sgBYNTPtgS5UJjuuQqCP1ha
         pOn7pT/7tcNncu8GH29d+8Ls1b1dZUWE5OezB3xoG6i913ev9EbIizPyljW4PaN07yw1
         msrfJfE0KMNtvQCKe9eFEVZthE0FkkE8fatmOlVfAqpPck1ti707Exx9mEpswgcUTsWJ
         J494NYk90v5lZ5Rg7HTYvA34nqGX934LYT8MH8+2N+ttKn7SPU4hmLoXRmPLzesQ3d+d
         DE7w==
X-Gm-Message-State: AOPr4FW4GFs1SaqO2Hrentz23ZYvkH/MXAZ/xkfwN9efoufok2MoW01+cb+ePBT4vMod6+igY4Rdg5EQb0LEgQ==
X-Received: by 10.13.204.69 with SMTP id o66mr7632839ywd.168.1463155775358;
 Fri, 13 May 2016 09:09:35 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Fri, 13 May 2016 09:09:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294539>

Hello,

in t3404 test 91 - static check of bad SHA-1 fails (with ksh) with a
syntax error in git-rebase.
git-rebase[6]: test: argument expected

Reason is, again, a test -z without quotes in git-rebase--interactive:
*** ../git-rebase--interactive.orig     Tue May 10 17:36:59 2016
--- ../git-rebase--interactive  Fri May 13 17:57:27 2016
***************
*** 870,876 ****
                badsha=1
        else
                sha1_verif="$(git rev-parse --verify --quiet $1^{commit})"
!               if test -z $sha1_verif
                then
                        badsha=1
                fi
--- 870,876 ----
                badsha=1
        else
                sha1_verif="$(git rev-parse --verify --quiet $1^{commit})"
!               if test -z "$sha1_verif"
                then
                        badsha=1
                fi

Maybe it would be a good idea, to quote the test -z $1 in the same
function check_commit_sha too.
The test completes successfully without it, but since it's an user
option, I think it should be quoted.
Then there would be no more unquoted test -z anymore :-)

Armin
