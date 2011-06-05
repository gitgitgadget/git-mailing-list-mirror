From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [BUG] "git checkout -b" erronously thinks a branch already exists
Date: Sun, 5 Jun 2011 13:05:13 +0200
Message-ID: <201106051305.13723.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pL26NDR7kIjgQib"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 13:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTB9A-00022a-51
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 13:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab1FELF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 07:05:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50534 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab1FELFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 07:05:25 -0400
Received: by wwa36 with SMTP id 36so2936607wwa.1
        for <git@vger.kernel.org>; Sun, 05 Jun 2011 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:mime-version
         :content-type:message-id;
        bh=+vXkgRVawdVi+CeVw0kUAM8qaBRM0EjCrdkajMnuyQg=;
        b=iaDUOMa1T4Q5tGso4BHdr3nJ+KUwRJpP5u5CCzZL25A/SWCD5kAPG3dPKH0BeVuotn
         cINvbIobYucdZ2DL9Y0p+SuFOEnp2887joAh16oRbetyJLWn8F9n09D8nZyD5oVpoBpH
         Mv+l/Afels0ZrbxM2dF00KNsR9pzrnwMWWRUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :message-id;
        b=k2QA4tTHliLPZ03C4zVt6zt1uHME8pvIF0g2nz89cIf1kxMs+7JHlBbez28tmmbqAe
         +Hngtoc2mclIJaU28TlOST6i3LMpiSAkKgDx7JnhXSdejTG4jZ7Vj7HokuRTnLWQvQY4
         pJLLUme+i+NQ4RYVW/WawYoqBy+0E3qsUaTzo=
Received: by 10.227.5.194 with SMTP id 2mr3813129wbw.93.1307271924095;
        Sun, 05 Jun 2011 04:05:24 -0700 (PDT)
Received: from bigio.localnet (host134-99-dynamic.5-87-r.retail.telecomitalia.it [87.5.99.134])
        by mx.google.com with ESMTPS id c17sm2154256wbh.29.2011.06.05.04.05.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 04:05:23 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.30-2-686; KDE/4.4.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175072>

--Boundary-00=_pL26NDR7kIjgQib
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

First of all, sorry if this is the wrong address for bug reporting,
but I couldn't find any `git-bug' mailing list, nor a bug tracker.

Apparently, "git checkout -b NAME" fails if NAME contains the output
from "git-describe".  This happens for me both with git 1.7.2.3
installed from debian packages, and with the latest developement
version of git.

The attached script demonstrate the failures; here is what it outputs
on my system:

 $ sh bug.sh 
 + GIT=git
 + mkdir foo.dir
 + cd foo.dir
 + git init
 Initialized empty Git repository in /tmp/foo.dir/.git/
 + :
 + git add f1
 + git commit -m none
 [master (root-commit) 9b06795] none
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 f1
 + git tag -a -m 'first commit' v0
 + :
 + git add f2
 + git commit -m none
 [master ef5d975] none
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 f2
 ++ git describe
 + desc=v0-1-gef5d975
 + git checkout -b fix-v0-1-gef5d975
 fatal: git checkout: branch fix-v0-1-gef5d975 already exists

If you need more details, or if you can explain why this is an user error,
please keep me in CC:, as I'm not subscribed to this list.  In case it is
indeed an user error, sorry for the noise.

Regards,
  Stefano

--Boundary-00=_pL26NDR7kIjgQib
Content-Type: application/x-shellscript;
  name="bug.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="bug.sh"

#!/bin/sh
set -ex
GIT=${GIT-git}
mkdir foo.dir
cd foo.dir
$GIT init
: > f1
$GIT add f1
$GIT commit -m "none"
$GIT tag -a -m 'first commit' v0
: > f2
$GIT add f2
$GIT commit -m "none"
desc=`$GIT describe`
$GIT checkout -b fix-"$desc"

--Boundary-00=_pL26NDR7kIjgQib--
