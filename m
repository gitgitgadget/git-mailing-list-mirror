From: Aaron Dufour <thedufer@gmail.com>
Subject: bug: git branch -d and case-insensitive file-systems
Date: Mon, 24 Aug 2015 12:11:13 -0400
Message-ID: <CAJrRhQz1UmnDi6Giejetfoh3aPX08aYcgY-neZfcKjpUav0=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 18:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTuLT-0003iQ-VX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 18:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbbHXQLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 12:11:35 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34508 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbHXQLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 12:11:34 -0400
Received: by lbbtg9 with SMTP id tg9so83420701lbb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=64Rlyh5uPGuLxqlDagRj2RMNK2wX6q+nUg7cgTdv//c=;
        b=ZYNN183Moi6RfJs9sARdDUkZhMAjcby57CTjKsSPpJv0b73ddsycIJ9rGOKmXgUqEU
         mC4k4yS6hC4AM1pUYBA60YL3o8xHXf378QKl/FrhWw6Cl/SogpuB7WXY79MWYv3DEvLH
         FE5AVKNyoMjLCRIb8Qd2nmNKlb0HsEI3aEPo2RG4LvpdD4gLcKlqcYgvdZyY92Fy7i4N
         xODKBtd5rhs22aVy0EgZAP4etInh2ZguwVWZiphrvZalD/Nq82APqJaCRZODQEGoV7fe
         shUJKzgYCwE+KY99NS8h8a2gkZxLpE2nSzqV8CStlXAaEOId9k1q5AlFoLDqwY2N4N3w
         KqHg==
X-Received: by 10.152.37.196 with SMTP id a4mr21240289lak.59.1440432692812;
 Mon, 24 Aug 2015 09:11:32 -0700 (PDT)
Received: by 10.25.21.84 with HTTP; Mon, 24 Aug 2015 09:11:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276456>

I use git (2.2.1) on OS X (10.9.5) and recently my repo got into a bad
state.  I think this involves a mis-handling of case-insensitive file
systems.

This reproduces the problem:

    > git init
    Initialized empty Git repository in /Users/aarond_local/code/git-test/.git/
    > git commit --allow-empty -m 'first commit'
    [master (root-commit) 923d8b8] first commit
    > git checkout -b feature
    Switched to a new branch 'feature'
    > git checkout -b Feature
    fatal: A branch named 'Feature' already exists.
    > git checkout -B Feature
    Switched to and reset branch 'Feature'
    > git branch -d feature
    Deleted branch feature (was 923d8b8).
    > git log
    fatal: bad default revision 'HEAD'

This is the behavior when there isn't a case mismatch, which is what I
would have expected in the previous case as well:

    > git init
    Initialized empty Git repository in /Users/aarond_local/code/git-test/.git/
    > git commit --allow-empty -m 'first commit'
    [master (root-commit) 48df19f] first commit
    > git checkout -b feature
    Switched to a new branch 'feature'
    > git branch -d feature
    error: Cannot delete the branch 'feature' which you are currently on.

I can also reproduce the issue on git 2.5.0.

-Aaron Dufour
