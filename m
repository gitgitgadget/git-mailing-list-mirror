From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Submodule design
Date: Tue, 2 Oct 2012 20:53:28 +0530
Message-ID: <CALkWK0kYh3tKXRqRO9SFMHkrytmhXFkR3yHwmiTpw6KocuLzZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ4KF-00043z-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab2JBPXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:23:49 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:37906 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab2JBPXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:23:48 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so640738qad.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bAQ6vmBw25khWlps8Yb050k/4xuClJaW97xfJn79jyA=;
        b=T3K9qh7DTVAWAiy766WzLiO6thm+hTWmiHaLdb/5DTQ8YoZ8xNn8HSCWHi5eH17Eqw
         UvRg51cdUVWG7Sx5Uf/ghLZ8pECdifTBX/XzDJ716AQV83y9ppLwqtCsgy83/uB6OgZ3
         jdRL5BB2U5EtPxCpqrTTEhBzocXNNCODmvwwriJswNkuXpofUnK9ctASjec2zWZgtRyi
         6J28DxEn57Hr7eH6g6Rwpq477WoJjxJqf0laIb10EqcH8YmRmQ8k2pxF1TdBf4BAd6E/
         mF9zVdsJvbUgb9ffNACb/jCoB693WSvDow6xnvl62Hz1AKnaZcMGIOniH9eFuIGQ9CVJ
         MjoA==
Received: by 10.229.135.193 with SMTP id o1mr12032750qct.100.1349191428325;
 Tue, 02 Oct 2012 08:23:48 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 08:23:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206806>

Hi,

Today I learnt that a gitlink is a commit object embedded in a tree.
However, I can't seem to be able to cat it.

    $ git ls-tree HEAD
    100644 blob 5a91f388f3648b98ae34a19ec42ba9acc7852ef4    .gitmodules
    160000 commit 8daa12004db8862b22f6c7dd244a88ac6108b194  dotfiles
    $ git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194
    fatal: git cat-file 8daa12004db8862b22f6c7dd244a88ac6108b194: bad file

Why is this?  Does the object not exist in the object store at all?
Then how was it embedded in the toplevel tree object in the first
place?  Also, why (how) does 'git diff' give me the impression that
it's a blob?

    $ git diff
    diff --git a/dotfiles b/dotfiles
    index 8daa120..ff61f40 160000
    --- a/dotfiles
    +++ b/dotfiles
    @@ -1 +1 @@
    -Subproject commit 8daa12004db8862b22f6c7dd244a88ac6108b194
    +Subproject commit ff61f40e0938024aa3b748eb733a974b17082ec2

If it is really a blob, I should be able to stage and unstage it
normally, but the following command is a no-op:

    $ git checkout -- dotfiles

What is going on?  Shouldn't we get rid of these ugly inconsistencies?

Ram
