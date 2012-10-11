From: Vasiliy Yeremeyev <vayerx@gmail.com>
Subject: [BUG] Directory probing for aliases
Date: Thu, 11 Oct 2012 14:22:45 +0400
Message-ID: <CAFKeBpcCZwMMcBtP8KywqnyK3e247K1Z_8na5ah+Wb+E15LPVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 12:22:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMFur-00081q-SU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab2JKKWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 06:22:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44355 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758393Ab2JKKWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 06:22:47 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so1172908qch.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Q/vOtz4pVIJ2IPxyx7Y2HU4B7sBYTv5knHul0mfL15M=;
        b=w7qI5kW+1p1xg3PrbdOh5yrUV0ziFGidVzHjDiGOX0o/QcvCEs8YN4ptK2VEfnSO5c
         Ib3gfkQVXQY4ySQSlulfgGOEJQBtHzwaJllK8Ll+1rUu1RpDnPdnGHCmIjb5REHrPImO
         riUPsWZzA112gMRTWnKhnK7Oc96FmOsofTdl3YjQoaDHD+maf6CJkdthUegSkNGB0ztx
         9iMPPDWuXxUHgySxGYl/8E2SAMGNIxTslzk9zwMvyCAp6xiheKXqtX598w+DeRUxMt5E
         aXmiZO1f3nIGobifqLhBEwRrBV7mC5uxDLVYowinp1gTprPJ++LnoPhmX5YreNJu9SMj
         crgA==
Received: by 10.224.193.193 with SMTP id dv1mr980808qab.17.1349950965459; Thu,
 11 Oct 2012 03:22:45 -0700 (PDT)
Received: by 10.49.73.230 with HTTP; Thu, 11 Oct 2012 03:22:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207470>

Hi,
Git aliases stop working when user doesn't have permissions to any
directory within $PATH list:

% git config alias.br branch
% git br
fatal: cannot exec 'git-br': Permission denied

Problem seems to be in directories probing:

execve("/usr/libexec/git-core/git-br", ["git-br"], [/* 76 vars */]) =
-1 ENOENT (No such file or directory)
execve("/home/vayerx/bin/git-br", ["git-br"], [/* 76 vars */]) = -1
ENOENT (No such file or directory)
execve("/usr/local/bin/git-br", ["git-br"], [/* 76 vars */]) = -1
ENOENT (No such file or directory)
execve("/usr/bin/git-br", ["git-br"], [/* 76 vars */]) = -1 ENOENT (No
such file or directory)
execve("/bin/git-br", ["git-br"], [/* 76 vars */]) = -1 ENOENT (No
such file or directory)
execve("/opt/bin/git-br", ["git-br"], [/* 76 vars */]) = -1 ENOENT (No
such file or directory)
execve("/usr/x86_64-pc-linux-gnu/gcc-bin/4.6.3/git-br", ["git-br"],
[/* 76 vars */]) = -1 ENOENT (No such file or directory)
execve("/usr/games/bin/git-br", ["git-br"], [/* 76 vars */]) = -1
EACCES (Permission denied)
write(2, "fatal: ", 7fatal: )      = 7
write(2, "cannot exec 'git-br': Permission"..., 39cannot exec
'git-br': Permission denied) = 39

(user doesn't have access to '/usr/games/bin' directory)
Everything works fine if '/usr/games/bin' is not listed in $PATH variable.
Standard/built-in git commands work fine regardless of  $PATH variable.

-- 
With Best Regards,
Vasiliy Yeremeyev
