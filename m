From: Patrick Doyle <wpdster@gmail.com>
Subject: OK, how should I have done this...
Date: Mon, 22 Nov 2010 08:22:09 -0500
Message-ID: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWLr-0006BC-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab0KVNWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 08:22:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60216 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab0KVNWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 08:22:30 -0500
Received: by fxm13 with SMTP id 13so2601365fxm.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 05:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=OdYeKC6WGTJNlLrrLklELBUD6WEus0tUWPydZGGYQ04=;
        b=JSqtbUpTvSkmrhN8ZSo3M8cs91boGP+Zj3nKFbvdn6RkyxchADHr2QuICYrMHUueAx
         LVXsJU5h6VmCLDu9mAANtuTAuKuDPNTW2+SuEscjUqgonWeOSBEHSZ5hYQS4u508u9vs
         EGFgd0vE1SVs3EEfE5EVq0d7oOt/8u62outZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=uT8TTNKqlxEbEylC5mOJtEldOCOPWfl8Tp5wvXtAAZ3x3V4Y4kYg6bH6xZLoFNgdem
         9QKk7u98w48pkGdF8OadSxCzP/VCfaDOXW1+blsYTdId1CwSkTp4UGcymLsoRliei8py
         TWFf+Q8RELMsTxCdFIE19FIHJwcfGVKQ2aWaU=
Received: by 10.223.86.206 with SMTP id t14mr3599238fal.30.1290432149107; Mon,
 22 Nov 2010 05:22:29 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Mon, 22 Nov 2010 05:22:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161890>

I just checked in modifications to 1/2 dozen or so files in a single
commit and pushed them to my server.

Then I switched to a different machine, pulled the latest version of
my repository from the server, tried running my code, and discovered
that I introduced a problem that didn't manifest itself when running
on my laptop.

So now I want to figure out which modification(s) in which file(s)
introduced the problem.

I did a git log and saw that things were fine back at commit 5ccce3, so I did

$ git checkout 5ccce3

fully expecting (and seeing) the warning about 'moving to "5ccce3"
which isn't a local branch'

ran my code.  It worked (as expected).

$ git diff --name-status master

Saw the list of files that had changed.

$ git checkout master -- file1

Grabbed the version of file1 from master & reran my test.  It passed.
Repeated the process until I'd identified the set of 3 files that
caused things to break, and fixed those three files.

Now I want to check those 3 files in on the master branch.  My first
inclination, since every time I've tried doing stuff like this in the
past has failed miserably, was to copy those 3 files to a safe
location, revert them to their unmodified state, switch to the master
branch, copy the modified files into my working directory, and commit
them.

Instead, I did:

$ git checkout master

hoping that would just switch me to the master branch, keeping those 3
modified files.  Instead, what I got was:

error: Entry 'blah/file7' not uptodate.  Cannot merge.

and now "git status" shows a bunch of files staged to be committed
(all the files that were different between master and rev 5ccce3) and
my 3 files with their modifications.

I'm gonna go back to plan A, copy those 3 files to someplace safe, and
checkout/reset until I get back to a clean checkout of master, copy
those 3 files in, and commit that change.

But I _know_ that there must be a better way to do this.  What should
I have done?

--wpd
