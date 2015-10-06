From: Andrei Neculau <andrei.neculau@gmail.com>
Subject: git diff --check in a bare repository
Date: Tue, 6 Oct 2015 12:31:45 +0200
Message-ID: <CAOGnN1enXp42dQLO_JwzFBBWwuXn7psBUjRp4kj=_p1tkNGvOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 12:32:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjPXY-0003Gg-K8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 12:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbbJFKcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 06:32:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36450 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbJFKcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 06:32:06 -0400
Received: by lbcao8 with SMTP id ao8so73561328lbc.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=s3sb2blOBi2DOWEyw+YpgAzlMZA3h9bNqpjg/NHCDjQ=;
        b=uaBvaAxf8VORBggGTkUavyMDxsafmBxvqODz9d6335z/cQTvmd96hjc5+cxxwcZcj+
         NIidGGxQ/6x6xiBGfrbiRjykSImcxRX1qMNXr40CJPjefRUxKlQiyj7K3V77I8iORixr
         NwY0cBXhmJOZi0PLtJzeZ4QSOgtYFaF0C8jDhiKjealNtIE8qsLyx/WCY0mAdRIiuidl
         Qbzb7bWjp+fX8fOMeekva98IlcAXk3Gm1Jgfn0meH4nxaaxwF1uVbGe+3uwtYeVIlVeY
         5/8VGxHY65DK2RQreMX0VEPOgs7H638RVOZpBsEavOvqMnUL8Prm5MfGshHusBjFRJzZ
         Tryw==
X-Received: by 10.112.173.198 with SMTP id bm6mr14094926lbc.43.1444127524842;
 Tue, 06 Oct 2015 03:32:04 -0700 (PDT)
Received: by 10.25.125.133 with HTTP; Tue, 6 Oct 2015 03:31:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279129>

Hello

I am using "git diff --check" on the "server-side" (i.e. in a bare
repository as part of a git hook)
with a .gitattributes rule saying

*.md text whitespace=-trailing-space # notice the - in front of trailing

I can check that the attribute is set/read correctly thanks to another
thread on this mailing list

$ export GIT_INDEX_FILE=index.tmp
$ git read-tree --reset -i $SHA
$ git check-attr --cached foo.md # shows up whitespace: -trailing-space
$ rm index.tmp

but then when I run

$ git diff --check $SHA^..$SHA -- foo.md

then I get an error that foo.md contains a trailing space (as if the
.gitattributes in $SHA is ignored).

The reverse applies as well. Since trailing-space is enabled by
default, I edited ~/.gitconfig and set core.whitespace =
-trailing-space.

now "git diff --check" doesn't complain, but if I commit and push a
rule in .gitattributes saying

*.md text whitespace=trailing-space

then I do not get an error when pushing foo.md with trailing-space.

I experience the same behaviour in 1.9.1 and 2.6.1.
For what it's worth as input to the above issue, I have also tried

$ export GIT_INDEX_FILE=index.tmp
$ git read-tree --reset -i $SHA
$ git diff --check --cached -- foo.md

but the same behaviour can be noticed.

I am not subscribed to the mailing list, so please keep me in CC

Thank you in advance,
Andrei

--
andreineculau.com
