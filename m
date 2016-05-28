From: Fabrizio Cucci <fabrizio.cucci@gmail.com>
Subject: error: Can't cherry-pick into empty head
Date: Sat, 28 May 2016 18:54:40 +0100
Message-ID: <CAOxYW4yTCMYcY=9YvwHNK5rKDK0_f-Uc7L92-QuQkv_hwCV+HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 19:54:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6iRi-0007rz-Ci
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 19:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbcE1Rym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 13:54:42 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35897 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcE1Ryl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 13:54:41 -0400
Received: by mail-it0-f54.google.com with SMTP id e62so14301671ita.1
        for <git@vger.kernel.org>; Sat, 28 May 2016 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=fym/uaPuBnuF2QtoQufXMWgZ15yhg9CC3iVMJLSx9RA=;
        b=f4z2yOQ3OAk+rERDiStp7MNy5O9iPLvZAb8AI6C2a0MF3Zv+V7UFRrE7veudzDrUVb
         K83ySQw01O71jIyXGVlGAMkL2X2ygJxB9N8W8tyN6zCwQJq4EjuH+uaUqG9I22IwsiTy
         gdK9IMn+ZIGOCbyBxeWSJKZ8MhV14/Lt/simrrWYfzzxDjkgx3GYdXotkE0i9pKApiTm
         pNo6GSHPpyV9YxHLyMMk+cLWohp3ywgoRelu8YL+gONilv5ExRHNV+BSAziE1yY12kY0
         MBnqWXPQ/L0+KufOd3tVGJkapKqlJ2B9iI+QnJxpy5H46gzRBVgkoGj+P3dSeqEL58rR
         yyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fym/uaPuBnuF2QtoQufXMWgZ15yhg9CC3iVMJLSx9RA=;
        b=RYNSc0hnCaW6LZHc2acU/bO4RSoB/wZOsruQu1ikz/FWa9D3DqND152eIGNabmAweD
         fBUAxQRBc7eRJVO245xnFVOlS0zFViMT9bF594+sxYDD7zfB1sp3d23DJIP2sLFkGAgO
         xrfkzWvN8XNawK3OhVy3Gv9PSbfo3C2UzI9EZeqmlEYpvCcWr9O1w0jxYjPoHkyvQiDN
         Ga6FWsMbOf7gkbs8HdexItd+rPzXzvskaOSF7hJDtDYSUb+kKrPqJFWP2QKIJAAN1j55
         NV4+s1jsLJXlvl+uaU6tkCdRL4CASts+vuGoQtnYC7d5sICmATSvwLUzs6i9PY90FqAJ
         pCnA==
X-Gm-Message-State: ALyK8tLz33gQsI+JhYcsaNdyXE0pSC8q6U0T6QN2Ww1xIgwORADGbcRAuAfmrNvrgrs9LIn1Du3MWF41/3iAWQ==
X-Received: by 10.36.65.168 with SMTP id b40mr3120295itd.10.1464458080742;
 Sat, 28 May 2016 10:54:40 -0700 (PDT)
Received: by 10.79.112.15 with HTTP; Sat, 28 May 2016 10:54:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295830>

Hello everyone,

I'm trying to understand why I'm getting the error as per subject.

The scenario is the following: I'm on the master branch (which
contains several commits) and I would like to create a new empty
branch (let's call it new-orphan) and cherry-pick only the commits
related to a specific folder (let's call it my-folder) from the master
branch.

So, I tried the following command sequence:

  master $ git checkout --orphan new-orphan
  new-orphan $ git rm --cached -r .
  new-orphan $ git clean -df

After confirming that I'm in a clean state (with "$ git status") I tried:

  new-orphan $ git rev-list --reverse master -- my-folder/ | git
cherry-pick --stdin

as suggested https://git-scm.com/docs/git-cherry-pick, but what I get
is "error: Can't cherry-pick into empty head".

What I don't really understand is:

1) if I cherry-pick a single commit instead of multiple commits,
everything works fine:

  new-orphan $ git cherry-pick <some-commit-id>

2) if I commit something before trying the above command, everything works fine:

  new-orphan $ touch README
  new-orphan $ git add README
  new-orphan $ git commit -m "added README"
  new-orphan $ git rev-list --reverse master -- my-folder/ | git
cherry-pick --stdin

Can someone please help me understand this?

Thanks,
Fabrizio
