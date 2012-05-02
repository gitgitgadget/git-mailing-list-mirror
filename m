From: Jiang Xin <worldhello.net@gmail.com>
Subject: Maintenance of the maint and master branches of git-po
Date: Wed, 2 May 2012 10:42:33 +0800
Message-ID: <CANYiYbHa_0ZKFwRz-FfJO4fP7E9fCqAaEQ2JfPr_UotzBOGpYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed May 02 04:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPPWY-0001nm-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 04:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387Ab2EBCme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 22:42:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50577 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586Ab2EBCmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 22:42:33 -0400
Received: by yhmm54 with SMTP id m54so174711yhm.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=hj5iFIM5gkyJD7aIpR0vjLNLSdg7mRKcfxeIv7CvikE=;
        b=Tz7UixXo71XbkQqkMB+hRsxjAvHS5ZWotx8GJJ5PInzqhVLSBeqfEKsKItnxNrBxi1
         4ADvQgGKqoIqCx5NtJNtwyltwP2Rl5+IJcE8FBe8NIzSjdP5TAQCn2m92Mf0l4PAWSel
         1Pd2cglO99gre9Osa6zOTJkxb6j2QlakQXMcNJ5/eIjtwfMM1ZTW/zkolRfiatqF9gk5
         79tNq7tW7RBkuO22vfrU1QaZ95Zxxyk43rkb0de8dvkn66RuLuK3/ERAlw51SRi2vwG4
         gOdLw/VlgbMAdqHaZEsyyk8zRtl+N55j27hxXfLVBMX5VVabzj5GK6N9/+CA0VWsuUC1
         3d1Q==
Received: by 10.50.36.195 with SMTP id s3mr3499336igj.27.1335926553250; Tue,
 01 May 2012 19:42:33 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Tue, 1 May 2012 19:42:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196777>

The git-po repository (https://github.com/git-l10n/git-po/) has two
branches: maint and master. These two branches track the l10n
updates for the counterparts of git.git.

 * When translaters send pull requests to maint branch of git-po,
   they want their translations go into the next maintenance
   release of git (i. e. 1.7.10.1 for now).

 * When translaters send pull requests to master branch of git-po,
    they want their translations go into the next release of git
    (1.7.11 for now).

When I received pull request(s) to maint branch, I will not only
merge commit(s) to maint branch, but also merge back to
master branch. If not merge maint branch back to master
branch of git-po before I send git-request-pull to Junio, it will
make troubles to the maintenance of git.git:

1. Maint branch can not fast-forward to master branch,
    when new release is out. (See the "Maintenance branch
    management after a feature release" section of
    `git help workflows`)

        $ git checkout maint
        $ git merge --ff-only master

2. Will encounter lots of hard to resolved conflicts when
    merge maint branch back to master branch, because
    of the indepent location lines like "#: filename:line" in
    the git.pot and XX.po files.

So when there are updates in maint branch of git-po, I
will always generate two request-pull to Junio, one for
maint branch, and one for master branch.

To make the merge less pain and less complication, I
use a custom merge driver learned from TopGit.

 * File ".git/info/attributes"

        po/git.pot      merge=ours

 * File ".git/config"

        [merge "ours"]
                name = \"always keep ours\" merge driver
                driver = touch %A

-- 
Jiang Xin
