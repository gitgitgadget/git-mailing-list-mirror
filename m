From: "Thomas Harning Jr." <harningt@gmail.com>
Subject: Best method of detecting if list of commit refs is a parent
Date: Sun, 17 Aug 2008 22:24:20 -0400
Message-ID: <e47324780808171924j237688faj9e13740f89e75fdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 04:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUuQv-0005Lq-Gh
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 04:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYHRCYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 22:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbYHRCYV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 22:24:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:47938 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYHRCYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 22:24:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2840108wfd.4
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=DzvtXsivXD+R1rEEximUnN0V12nzpz5rLHvCQNEpCnk=;
        b=HLGjSnanBCob0R9g8m+a26QuQBy1y0n8ofLYiLRqVgxP4esOv52AR4iJof9meLonUq
         6cFQd72qIfvYHk7TdvuDjh6wgMAjI/as/3GkWDlf5tDSUltIdBnZjUc6rGjKJqm/m7Hg
         iQxuKIIuEz5aOwBYgbRcmDqhwbADAJx8Qz2BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xvgzw7SHwAydkv28w0yOx+EOlIyy46tK5s4TGX4a/JiiTn3/cSTpxGyHpJo/y3Gvl+
         RP+fzqAg7yYTOz1A50ZzQsYDz9nqoTxUx6ku1MEW6RKd9GECo0zj7uO834s6su6VSH+R
         q+REgG6Z+u2oHTvYM/9pvG2obgRRNCjpcjZ3I=
Received: by 10.142.223.20 with SMTP id v20mr1863322wfg.336.1219026260228;
        Sun, 17 Aug 2008 19:24:20 -0700 (PDT)
Received: by 10.142.199.3 with HTTP; Sun, 17 Aug 2008 19:24:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92677>

I'm working on my 'Stick' git bug-tracking tool and am working on the
functionality to get a list of relevant bug-items at a specific point
in history.

Before I get into figuring out the 'best' way to do this, I thought
I'd at least get the simple single-item case of detecting if a
specific commit can be walked to from another commit... and that
doesn't seem to work as expected.

 git rev-list 0..Y --graph --abbrev-commit --abbrev=4
* Y
*   X
|\
| * d
| * c
| * b
* | E
* | D
* | C
* | B
|/
* A

For example... bug is reported to affect 'B'.. .user is at 'd' and is
wondering if said bug is listed as affecting him.
Command:
git rev-list B..d --graph ..  reports:
* d
* c
* b

... shouldn't this fail as the path from B to d doesn't really exist?
Or is there some better command or algorithm to use.
One mechanism that I thought 'could' work is to show the parents as
well and check that the last listed commit contains B ... but then I
can't take advantage of the no-output option for speed...

Now... into 'best method'...  given a list of N revisions with
associated bug-items, how would one determine the subset that revision
A is affected by.
Basically the bug storage mechanism is a directory structure w/ files
containing bug-items that can have one or more commit references....
to facilitate faster reports, a small database is used as a caching
mechanism to help create a distinct list of commits to worry about and
look up all the items associated w/ the status-processed commit...

Note: bug-items can mean anything from bug reported at X, bug-status
affected by X, or bug-closed at X  (at which case any previous items
related to a given bug could be ignored and not displayed... but
that's deeper implementation...).

I intend this bug tracker to be best-suited to git... but if other bug
trackers could have the mechanisms to provide this commit-tracking,
then those could be dropped in...
As for web interface idea... I'd probably have it "linked" to a
specific branch-head for its status-tracking............

-- 
Thomas Harning Jr.
