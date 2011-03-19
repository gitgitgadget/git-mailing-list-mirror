From: Jay Soffian <jaysoffian@gmail.com>
Subject: EOL conversion nits
Date: Sat, 19 Mar 2011 19:10:17 -0400
Message-ID: <AANLkTimML1Q-2Eyy=F_y+Z0qy6VrnqtwCUQN-23nuPD8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 00:11:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q15IW-0001eN-OT
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 00:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab1CSXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 19:10:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41139 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab1CSXKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 19:10:47 -0400
Received: by iyb26 with SMTP id 26so5231404iyb.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=ndGy5gHLvmprO0NaIPpv4dZh3iYypOvtVI2HXFGPW/4=;
        b=ch91WKHTaH+qZJqLp4ZnrYgjvG2HZWTPk3yavztppGda/vUTUg3/KooULyitgU0Nzj
         Cf812DUCFYXawLU/zq+tKzW7ltcvepiviuvaGhZAXQlnhg8dDzAT1XrVLXCRRTkIMJ4Y
         wZKyIKPvhOhg/1q66NVElyVMDS+I8BrVuySSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=pFymFiX6yrtJG8JYl7q5eh3MzWEC08Ue5DMRXlbeRbW8UHyYvdJzhbj+lbqM/Hwt9m
         YJojt0WeSsvYejt0vNDblXWCqM+o1Cxa0ScRWL0Sxgx2+JIVRybArfJxDem3zTgM7bzj
         3W/9Kr6Pf46HuHLe4IV1V1X0INe9NAv89vXO0=
Received: by 10.231.141.133 with SMTP id m5mr2499228ibu.107.1300576247135;
 Sat, 19 Mar 2011 16:10:47 -0700 (PDT)
Received: by 10.231.34.7 with HTTP; Sat, 19 Mar 2011 16:10:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169476>

Create a repo with a single DOS EOL file:

  git init foo && cd foo &&
  printf 'foo\r\nbar\r\n' > foobar &&
  git add foobar &&
  git commit -m foobar

Normalize the repo:

  echo 'foobar eol=lf' > .gitattributes &&
  rm .git/index && git reset
  Unstaged changes after reset:
  M	foobar

Commit the changes:

  $ git add .gitattributes foobar
  warning: CRLF will be replaced by LF in foobar.
  The file will have its original line endings in your working directory.

  $ git commit -m normalize
  warning: CRLF will be replaced by LF in foobar.
  The file will have its original line endings in your working directory.
  [master f86ff53] normalize
  warning: CRLF will be replaced by LF in foobar.
  The file will have its original line endings in your working directory.
   2 files changed, 3 insertions(+), 2 deletions(-)
   create mode 100644 .gitattributes

So, there's a few issues here:

1. Why is git warning me three times about the EOL conversion?
Shouldn't once, on commit, be sufficient?

2. Shouldn't the message use "working tree", not "working directory"?

3. The git attributes help doesn't say how to convert the line endings
in the working tree, which I guess is:

  $ rm .git/index && git reset --hard

4. I wonder why git's keeping the original line endings in the working
tree post-normalization, but minimally, I think it should provide a
friendlier way to update the working tree line endings to match what
you'd get from a fresh checkout, honoring whatever your EOL settings
are.

Thoughts?

j.
