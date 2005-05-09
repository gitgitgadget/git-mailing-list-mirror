From: Morten Welinder <mwelinder@gmail.com>
Subject: "git-checkout-cache -f -a" failure
Date: Mon, 9 May 2005 14:25:29 -0400
Message-ID: <118833cc05050911255e601fc@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon May 09 20:51:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVCpp-0006s9-50
	for gcvg-git@gmane.org; Mon, 09 May 2005 20:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVEISZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVEISZj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 14:25:39 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:43453 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261470AbVEISZa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 14:25:30 -0400
Received: by rproxy.gmail.com with SMTP id a41so837197rng
        for <git@vger.kernel.org>; Mon, 09 May 2005 11:25:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zv1ys7JlouZMVwVKbuWedk6dgK1B7CF5qWtPgEuPvHCRH55m8qI+WeUJiDdQ06bQNwOkA2JzBmrrzLS6I7b4ogwXhtKX+NzrbcVD7CcdMR+pCrCK9Nucnp2y+feoz18y+6S8ME+X9QFIqc3x53drkFAtVe2Xq2Z60kpqx+bKBkQ=
Received: by 10.38.151.37 with SMTP id y37mr1631957rnd;
        Mon, 09 May 2005 11:25:29 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Mon, 9 May 2005 11:25:29 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-checkout-cache is having problems when files change from directories to
plain files or vice versa.  cg-seek seems to be similarly affected.

Note also, that  git-checkout-cache's error messages haven't caught up with
the command renaming.

Morten


cd /tmp
mkdir xxx
cd xxx
rm -rf .git empty yyy 
touch empty
cg-init </dev/null
cg-tag initial
mkdir yyy
touch yyy/zzz
cg-add yyy/zzz 
cg-commit </dev/null
cg-tag dir
rm -rf empty yyy
rm -f .git/HEAD
cat .git/refs/tags/initial > .git/HEAD 
git-read-tree -m HEAD
git-checkout-cache -f -a
touch yyy
cg-add yyy
cg-commit </dev/null 
cg-tag file
# Got that?

# yyy is a file right now.
git-read-tree `cat .git/refs/tags/dir`
git-checkout-cache -f -a
# error: checkout-cache: unable to create file yyy/zzz (Not a directory)
# Not good!

rm -rf empty yyy
git-read-tree `cat .git/refs/tags/dir`
git-checkout-cache -f -a

# yyy is a directory right now
git-read-tree `cat .git/refs/tags/file`
git-checkout-cache -f -a
# error: checkout-cache: unable to create file yyy (Is a directory)
# Not good!
