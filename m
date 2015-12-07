From: Alex Jones <ajones@netsertive.com>
Subject: git branch in Bash subshell "$(git branch -a)" including ls output as
 part of return?
Date: Mon, 7 Dec 2015 11:52:28 -0500
Message-ID: <CAJGk2Wx4B=AHFxkJep=yYVKU9UyJieazoNaC44W5yBXoMi+gdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 17:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5z1e-0007Sv-1Q
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 17:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbbLGQwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 11:52:30 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:35379 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbbLGQw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 11:52:29 -0500
Received: by ioc74 with SMTP id 74so186965390ioc.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netsertive.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5HasKVxPM4lLBZCykcuyd4zR3KEK3eZfIKo2q0ozp/M=;
        b=CPK6zJFqqQ1Up9fyuGqkFv3mzlWmLqW6W49rQ+6P8li+VoqUrWU+WHbMktJPIIfUMG
         4z/oiD6u1m3Uj6HlyBPr7zopLxRPqdzcuqurWTn2ce5f0QdbpKecttw5rjcSDpCSfY2J
         qHM1DcDZ0YON7aMZDMd2K3JIt7rnamAtuvUWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=5HasKVxPM4lLBZCykcuyd4zR3KEK3eZfIKo2q0ozp/M=;
        b=PEilTX9UZrRcIhGLLqLaJFtfSQ9AIZ0G0Rl1Vq9raAnoUrHIWxbcahitx1uYdx9Dbe
         o1DRKU0fWGoDfEOFJh1V5VR5EdqpGY3tt7rNSPKl5QC5gTCQh07F+v+k9cwk4nhw4eIB
         hK7dSrMfnhUvhI1ghoMIjWIDzBzxtR5l1K4j+OMiRmKHbY47h7yhIKIzU9oVC/rqIfrI
         3R2wXtEXHUDM+KA53KjmiqCQngS7OqJ5lmCNQDAklUEqWz4j0V4UaEB7A63ecG0zHzQt
         rK2Wn9LnUttrIRB57hjE6/nPPrZNzaEWg7gFYF4lJHSDM0AvRpdVfpGJzA1ovurofYfZ
         jgDA==
X-Gm-Message-State: ALoCoQk+Vg/bCiOoSV2PamTpN3dnz+IH76fq74F+oTkp7K762Y4pvw8EzSSwlF7JyMJtYSFvHFsj
X-Received: by 10.107.3.212 with SMTP id e81mr25285212ioi.101.1449507148413;
 Mon, 07 Dec 2015 08:52:28 -0800 (PST)
Received: by 10.107.168.161 with HTTP; Mon, 7 Dec 2015 08:52:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282096>

Hello Folks,

I am Running OSX 10.10.5 Yosemite along with git 2.6.3 installed via
homebrew package manager.

I recently stumbled across the following bug in some scripting I was
doing. "git branch -a --list" and "git branch -a" seem to include the
output of an "ls" command if executed as part of a subshell in a bash
script. I can't speculate to the reason.

Script goal: Delete all branches aside from master in the repository
Example outputs from several commands  repo:

ls output:

ajonespro:Deploy_Script ajones$ ls -l
total 0
drwxr-xr-x  11 ajones  wheel  374 Dec  7 10:50 AppDeploy
drwxr-xr-x  11 ajones  wheel  374 Dec  7 11:15 WebDeploy


git branch -a output:

ajonespro:Deploy_Script ajones$ git branch -a

* DWH_concurrent_api
  Email_No_Error_If_No_Old_Version
  IT/configs_in_app_support
  PHP_Build_Repo
  master
  remotes/origin/DWH_concurrent_api
  remotes/origin/Email_No_Error_If_No_Old_Version
  remotes/origin/IT/configs_in_app_support
  remotes/origin/PHP_Build_Repo
  remotes/origin/master

echo $(git branch -a) output:

ajonespro:Deploy_Script ajones$ echo $(git branch -a)
AppDeploy WebDeploy DWH_concurrent_api
Email_No_Error_If_No_Old_Version IT/configs_in_app_support
PHP_Build_Repo master remotes/origin/DWH_concurrent_api
remotes/origin/Email_No_Error_If_No_Old_Version
remotes/origin/IT/configs_in_app_support remotes/origin/PHP_Build_Repo
remotes/origin/master

While it might be hard to see from that output, The first two
"branches" in the subshell's output are actually the directories
contained within the repo. If I place a file at the root it includes
that in the branch list as well. Since my test file "test.txt" (not
shown in example) and "WebDeploy" are sorted before all the branches,
I suspect some output buffer is being accidentally being written to.

Has any experienced this before, and can anyone reproduce it on a
different configuration? I wouldn't be surprised if it was some weird
bug with Apple's included terminal, but since I've only observed it
with git branch, I thought I'd try contact git maintainers first.
