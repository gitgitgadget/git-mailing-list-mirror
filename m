From: Mike Fleetwood <mike.fleetwood@googlemail.com>
Subject: git fast-import / working tree status question
Date: Fri, 19 Feb 2010 23:20:24 +0000
Message-ID: <fc5ef2e01002191520u7b50c98fo3a3defe70e31292a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 00:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicG8-0001m2-9f
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0BSX1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:27:39 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:44568 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab0BSX1j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:27:39 -0500
Received: by ywh35 with SMTP id 35so598750ywh.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 15:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=YM+Kx9p/CnO5j9pkCAMRiO3kMgY6HOzVMD6PbXlkTD0=;
        b=hs0agcozmbbt6mJ9QZ86539Nr+4vJzXesaCLf9yTJ4ptgsanBqDzEDTZlRb1plZ1yv
         PsTS9Z97W080gPVzLJmEUIiNOl3xRgjTf6Nx8ZzU7hVMt53Zq2mThNDRzZyl0xIgmjbY
         RCeq8XP6mkk/TUWb5jUnaYJ3YfcqE5YUWQksQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=C9kRAbIfUoAi/RdeX3zM6XHANDaua43jkGkHX+hrUMBzqJbij65YeHksfZT2sW2Dj+
         XPLDHRFXC6ATakDXVD2Yzbm+V74j76jsd340YV46Fifvk1tM+L1NylTSpoqWYX10N6EL
         4WyoxLkTtnfx2bOFd/ug42v0LlVz3OF+Fy7yI=
Received: by 10.101.130.35 with SMTP id h35mr12962457ann.109.1266621624383; 
	Fri, 19 Feb 2010 15:20:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140501>

Hi,

I am a newbie using git and I am testing conversion of a personal
project into git using fast-import.  When fast-import completes
all the files are in the repository but the working tree is empty
and status reports all files are delete but uncommitted.  I have
to use reset --hard HEAD to unwind the pending removal of all of
the files.  Example below.


Is this normal or have I missed something?

Thanks in advance,
Mike


[mike@rockover tmp]$ mkdir test.git
[mike@rockover tmp]$ cd test.git
[mike@rockover test.git]$ git init
Initialized empty Git repository in /tmp/test.git/.git/
[mike@rockover test.git]$ git fast-import << EOF
> # Test git fast-import file
> progress Commit 1/1
> commit refs/heads/master
> mark :1
> committer Fred Bloggs <fred.bloggs@example.com> 1266610576 +0000
> data 16
> Initial checkin
>
> M 644 inline test
> data 10
> Test file
> EOF
progress Commit 1/1
...
[mike@rockover test.git]$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	deleted:    test
#
[mike@rockover test.git]$ ls
[mike@rockover test.git]$ git log | cat
commit 769c8359d963fd13324d522e5e10a0269dd97395
Author: Fred Bloggs <fred.bloggs@example.com>
Date:   Fri Feb 19 20:16:16 2010 +0000

    Initial checkin
[mike@rockover test.git]$ git reset --hard HEAD
HEAD is now at 769c835 Initial checkin
[mike@rockover test.git]$ git status
# On branch master
nothing to commit (working directory clean)
[mike@rockover test.git]$ ls
test
[mike@rockover test.git]$ cat test
Test file
