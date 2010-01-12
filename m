From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: Bug? git-svn clone dies with "fatal: ambiguous argument '...': 
	unknown revision or path not in the working tree."
Date: Tue, 12 Jan 2010 15:58:34 -0800
Message-ID: <36366a981001121558v5324f2fbucf096e4c82402912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 00:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUqdF-00076f-JU
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 00:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448Ab0ALX6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 18:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239Ab0ALX6h
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 18:58:37 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:48453 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0ALX6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 18:58:37 -0500
Received: by ywh6 with SMTP id 6so23001777ywh.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=qFqjg8wcDSl23t1VrJsR5kYI/61QSin8wL1Cd1zTxNk=;
        b=xi2TvBce5noPvOS7l2yPAyvgLE2cuKxt/LaMBlAveY3l8u/mgGI+ZdAIHGrnoYJJnj
         EkdrH7rNOoUyBPAyImtc5u3A2RMxqdTFs9Pep+mW1E6Jm8XvAtHm1uZgoS+M+ZHRVFod
         fr5x774Nhg5ab+V4k1fPwcFNxRRVzJtTH6ZXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=vn/uDYpCqxhMAAhZf7NWu5oZnLbvT5kwBPAaSOlXoJ/jQPhyepNe0/dz3ApyEqITSU
         iOiE3jr5JJrYvafCDbp56obl7trt+6XZMtU4JhWxNDIMboMXZTYVhJj595fDLTdCsoaS
         Z/pYPu8Z7xCxHn2P3oIYvLgNc37TbtWynMei4=
Received: by 10.90.108.19 with SMTP id g19mr3399117agc.64.1263340714533; Tue, 
	12 Jan 2010 15:58:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136762>

I have been using git-svn happily for many months, updating git from
git://git.kernel.org/pub/scm/git/git.git every once in a while.  I
just updated to c0eb604330e1288300d915f25868d1eed88d3038, and tried to
clone the same svn repo that I've been using for a long time:

$ git svn clone http://svn/repos/cozi/kits --stdlayout

It chugged along happily for a while, but then died like this:

fatal: ambiguous argument
'2d2df13977551168a54ffa9b706484242a58736a^..d038748d49a0de5802fe3c13f46d0e080d064290':
unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list 2d2df13977551168a54ffa9b706484242a58736a^..d038748d49a0de5802fe3c13f46d0e080d064290:
command returned error: 128

"git show 2d2df13977551168a54ffa9b706484242a58736a" shows that the
commit in question corresponds to a commit in svn that created an
empty directory:

15:56:46 [COZIGROUP\erich@ubuntu64-erich kits] (master)$  git show -w
2d2df13977551168a54ffa9b706484242a58736a
commit 2d2df13977551168a54ffa9b706484242a58736a
Author: cozigroup\erich <cozigroup\erich@1248e456-dc32-5a46-b6cc-76877e1dc968>
Date:   Wed Jan 14 18:35:00 2009 +0000

    This branch will hold work I've done to refactor the vcs backend
stuff, and add support for Mercurial.


    git-svn-id: http://svn/repos/cozi/kits/branches/vcs-refactor@18735
1248e456-dc32-5a46-b6cc-76877e1dc968


15:41:01 [COZIGROUP\erich@ubuntu64-erich hmm]$ svn log --limit=1
-vr18735 http://svn/repos/cozi
------------------------------------------------------------------------
r18735 | cozigroup\erich | 2009-01-14 10:35:00 -0800 (Wed, 14 Jan
2009) | 2 lines
Changed paths:
   A /kits/branches/vcs-refactor

This branch will hold work I've done to refactor the vcs backend
stuff, and add support for Mercurial.

If I recall correctly, that commit was a mistake: I'd forgotten that
the proper way to create a branch in svn is to copy the trunk, and not
to create an empty directory first.

Here I am creating that branch the proper way:

r18736 | cozigroup\erich | 2009-01-14 10:35:30 -0800 (Wed, 14 Jan
2009) | 2 lines
Changed paths:
   D /kits/branches/vcs-refactor

D'oh.  We branch by _copying_, not making empty directories :-|

------------------------------------------------------------------------
r18737 | cozigroup\erich | 2009-01-14 10:36:37 -0800 (Wed, 14 Jan
2009) | 2 lines
Changed paths:
   A /kits/branches/vcs-refactor (from /kits/trunk:18671)

Refactoring the version-control stuff, and adding Mercurial support.

------------------------------------------------------------------------

15:56:51 [COZIGROUP\erich@ubuntu64-erich kits] (master)$ git show -w
d038748d49a0de5802fe3c13f46d0e080d064290
commit d038748d49a0de5802fe3c13f46d0e080d064290
Merge: 5108824 a370f0b
Author: cozigroup\erich <cozigroup\erich@1248e456-dc32-5a46-b6cc-76877e1dc968>
Date:   Tue Jan 20 18:34:26 2009 +0000

    Merged from trunk.


    git-svn-id: http://svn/repos/cozi/kits/branches/vcs-refactor@18920
1248e456-dc32-5a46-b6cc-76877e1dc968

And here is (what might be) the first attempt to modify stuff in that directory:

15:52:52 [COZIGROUP\erich@ubuntu64-erich kits] (master)$ svn log
--limit=1 -vr18920 http://svn/repos/cozi
------------------------------------------------------------------------
r18920 | cozigroup\erich | 2009-01-20 10:34:26 -0800 (Tue, 20 Jan
2009) | 2 lines
Changed paths:
   M /kits/branches/vcs-refactor
   A /kits/branches/vcs-refactor/lib/CoziPlatform/cozi/resources.py
(from /kits/trunk/lib/CoziPlatform/cozi/resources.py:18919)
   M /kits/branches/vcs-refactor/lib/CoziSecurity/cozi/authorize.py
   M /kits/branches/vcs-refactor/lib/CoziSecurity/cozi/eguidtests.py
   M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/screen_saver_api.py
   M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/screen_saver_calendar_xml.tmpl
   M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/web_client.py

Merged from trunk.


Anyway -- I suspect that my svn repos layout is ... er ... unusual,
and has hit some sorta edge case in git-svn.  Is there some workaround
I can use, or is this a bug?

Thanks
