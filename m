From: Dun Peal <dunpealer@gmail.com>
Subject: Scripted clone generating an incomplete, unusable .git/config
Date: Wed, 10 Nov 2010 17:21:37 -0600
Message-ID: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 00:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGJz6-0003Ct-SN
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 00:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324Ab0KJXVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 18:21:39 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48399 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab0KJXVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 18:21:38 -0500
Received: by qwi4 with SMTP id 4so1011368qwi.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 15:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=wYuuz8Jk2lXsfkdlEhM819FG0kLdshIi306VPlEdvgo=;
        b=NHKOAKRD1tLyp+VqAtvAyub674CvcKz7m3kdLyr389BSTAwzdea+7/P1s+ZUfpxR19
         wPXRzL0HQNN0ihYpNYGXZQ27ln1ntQ40ksIl6ZbnfdJa9KLZUhEKMnBy584wFzWo+Cph
         7OJOb/hn2P+Vriyso9saJmGeO3YID5jyWos/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Up8W4jOSAHsPXYWymjjdI2BIDtkGtp1MwP6kNH4BORWevpoduGagfDCKmIElFA8GOq
         hBt9Gc/mlzAk9kmk0VoBednn5N7C5UzvM15Z3fbEHn8uJr0GebCfuadiaZAITXG8IabZ
         jwy4osteUGZz2uhHgbwMMr+OcISuasaZbb52U=
Received: by 10.224.214.70 with SMTP id gz6mr187325qab.104.1289431298003; Wed,
 10 Nov 2010 15:21:38 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Wed, 10 Nov 2010 15:21:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161191>

This is a weird issue I ran into while scripting some Git operations
with git 1.7.2 on a Linux server.

When running the git-clone command manually from the command line, the
resulting repo/.git/config had all three required sections: core,
remote (origin), branch (master).

When running the exact same git-clone command manually from the Python
scripted, the resulting repo/.git/config was missing the `core` and
`remote` sections.

Here's a bash log fully demonstrating the issue:

  $ python -c "import os; os.popen('git clone
git@git.domain.com:repos/repo.git')"
  [...]
  $ cat repo/.git/config
  [branch "master"]
          remote = origin
          merge = refs/heads/master
  $ rm -Rf repo
  $ git clone git@git.domain.com:repos/repo.git
  $ cat repo/.git/config
  [core]
          repositoryformatversion = 0
          filemode = true
          bare = false
          logallrefupdates = true
  [remote "origin"]
          fetch = +refs/heads/*:refs/remotes/origin/*
          url = git@git.domain.com:repo/repo.git
  [branch "master"]
          remote = origin
          merge = refs/heads/master

What's causing this?  Is it a bug?

Thanks, D
