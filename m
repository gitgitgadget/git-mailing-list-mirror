From: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
Subject: "git checkout foo" is getting confused by folder named "foo"
Date: Tue, 24 Sep 2013 23:07:53 +0200
Message-ID: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 23:08:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOZqE-0000U2-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 23:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab3IXVIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 17:08:14 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49190 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab3IXVIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 17:08:13 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so4226415pad.35
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=TAcuaHElvO1Rq57GxKBrxbDZTCm3EXJdYyba4GqV4xA=;
        b=f0CvQsXzewLVZl1vhsOzL++fgkWaS/fEpE93jWVeWGR66NRqzlcfMiF2+7PTCvYqfh
         BXnvT7Htz6QJn74UWRT/3LaZEX1eMvgMO090H9EExU+Jxtz/gprJvfDlpasuVhYMZU2V
         CfEng0WxFBd7vGunjCedZ8+moAd7kIktJZgqh5OQ6Rgom7rrxA5m7DwIeER63t7A3LXz
         mHRfml+OrlCb+C9KM5EYjpNDgv52Gpn9iWijI0kl2/hD3jnogt2OKFM015Hc3tO44SE9
         oBJGKqpTYD9WVxFZBARnpDdq85anmLJAzO456tI0RcmV4IgiD0lNmZNJWjI6gtgfVRJc
         32yw==
X-Received: by 10.66.146.42 with SMTP id sz10mr30603082pab.100.1380056893369;
 Tue, 24 Sep 2013 14:08:13 -0700 (PDT)
Received: by 10.66.229.70 with HTTP; Tue, 24 Sep 2013 14:07:53 -0700 (PDT)
X-Google-Sender-Auth: KIZz57Z82uNHGzsveepTbCsk_ls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235317>

Hi,

maybe this has already been reported, but I didn't find it in the mail archive.

If I understand correctly, after I clone a repo, I should be able to
switch to branch foo just by running

git checkout foo

This doesn't seem to work if a folder called "foo" exists in the root
of the repo.

I got the same behavior with git 1.8.3.2 on a Mac and git 1.7.9.5 on Linux.

Steps to reproduce:

git clone https://github.com/dbpedia/extraction-framework.git
cd extraction-framework/

First the happy path - there is a remote branch "live-dev", but no
folder "extraction-framework/live-dev":

git checkout live-dev

Response:

Branch live-dev set up to track remote branch live-dev from origin.
Switched to a new branch 'live-dev'

Fine! Now the unhappy path - there is a branch "wiktionary", but also
a folder "extraction-framework/wiktionary":

git checkout wiktionary

Nothing - no response, no changes to working tree. .git/index seems to
be modified though.

Slightly different - cd to some folder, try checkout again:

cd mappings
git checkout wiktionary

Response:

error: pathspec 'wiktionary' did not match any file(s) known to git.


My workaround is that when I switch to a branch for the first time, I
have to call

git checkout -t -b wiktionary --track origin/wiktionary

Response:

Branch wiktionary set up to track remote branch wiktionary from origin.
Switched to a new branch 'wiktionary'

Looks good. After that, I can switch back and forth between branches
just by git checkout wiktionary / git checkout master.


Cheers,
Christopher
