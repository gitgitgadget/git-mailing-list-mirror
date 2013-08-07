From: Diogo de Campos <campos@esss.com.br>
Subject: "git log --follow filename" (with diff.renameLimit=0) not working
 after subtree add
Date: Wed, 7 Aug 2013 12:51:41 -0300
Message-ID: <CAMebvcSGzGatdaT-iowCUMqnw0ZYM20qxDBbE7SRn7-jFXs3VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 17:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V761c-0004uY-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 17:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079Ab3HGPvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 11:51:43 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64975 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab3HGPvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 11:51:42 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so4173711wiw.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esss.com.br; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qdfwDx1TaA1I806ttiRxp+Ho7KI0NKWLSzrwngi1leU=;
        b=GSDnPEto6oJFpEmGPA49is4+ZSA0w/pV7GO5Jt7SFiEbFRUpa8cF/FBjXTV68yRfco
         t4Pfw/+9CloiJd4AVnMJka9175o17vRymyVpw2QEoVTc04aQi0pzb+wst6jCdwWL6WYz
         Air6xkOcCQctlMOS1l9+6m0jlirnRZemJc7Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=qdfwDx1TaA1I806ttiRxp+Ho7KI0NKWLSzrwngi1leU=;
        b=fcr8+5LWGwO+2/SZYOtOBFyAax5QxRV9CimBz0DRN08TlNg8uZQG7FpwEj/RuGVZQ9
         9gGlcqjRz1OfWPzn8oAiqNuLGKKR9yKs2mstRrvBm0MLu316jXzw/rgWYHYrZ0/DD8+w
         h5V05wYhrqn6LMi+3fGdyrPviuYHrpDBQpxxQKQKk8r4IZlwM+e4m4qq5DJYIakrsEDR
         KPBnZNpych8sV7HX9n2t46HeVDSkrk09hxgWDROJl/3vd2vHHD85t+Kn0e2gkH0RVeZF
         90kHNA2lMlRHuBMYaq/nmnlW5GCvLLGBedX3JWobZ5Nroz7VaYOjs31pDAplZUTRefpC
         ezuw==
X-Gm-Message-State: ALoCoQn6a5rT0Z/cmv+DImAX4P5R/FAz8+OdLxgJDuB+RmaykiwumCKWQGWZrYjnxZokEnYyvP5d
X-Received: by 10.180.210.243 with SMTP id mx19mr2604980wic.35.1375890701403;
 Wed, 07 Aug 2013 08:51:41 -0700 (PDT)
Received: by 10.216.159.68 with HTTP; Wed, 7 Aug 2013 08:51:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231833>

Problem:

"git log --follow filename" is not working for files after a big move.


Scenario:

Just performed a "git subtree add" where big projects were moved into
another repository, and I'm not able to view history for a single
file.

Sample output:
Output after subtree add (no output)
> git log --follow --oneline file.py

Output from same command in old repository (the one that was merged
with subtree, this is the output i expect to continue having atfer a
merge)
> git log --follow --oneline file.py
cefa32b Convert doc strings to Sphinx
748b2dd Added target for C++ tests
1f2b52e Using default git_source_server for everything after moving to Stash
... [more commits]


A couple of notes:
- Made sure I used --follow
- Using options diff.renameLimit=0 and diff.renames=true
- Tried options -C and -M (even though there were no changes, should
be a 100% rename match)
- "git subtree add" was made without --squash to keep history
- "git blame file.py" works fine, detects all changes and rename history
- Commits added after the merge are tracked, but log stops at merge
- Tested with git 1.8.3.4
- This guy in StackOverflow seems to have the same problem:
http://stackoverflow.com/questions/4393527/why-might-git-log-not-show-history-for-a-moved-file-and-what-can-i-do-about-it

Relevant output for "git config -l" in repository:
core.symlinks=false
core.autocrlf=false
color.diff=auto
color.status=auto
color.branch=auto
color.interactive=true
pack.packsizelimit=2g
help.format=html
http.sslcainfo=/bin/curl-ca-bundle.crt
sendemail.smtpserver=/bin/msmtp.exe
diff.astextplain.textconv=astextplain
rebase.autosquash=true
core.packedgitlimit=128m
diff.renamelimit=0
diff.renames=true
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
core.hidedotfiles=dotGitOnly

--

Diogo Campos
