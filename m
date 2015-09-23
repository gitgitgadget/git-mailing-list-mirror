From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 08:58:26 +0100
Message-ID: <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 09:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zeewx-0004dG-V5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 09:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbIWH6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 03:58:30 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33916 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbbIWH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 03:58:27 -0400
Received: by oiev17 with SMTP id v17so19398692oie.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OICwnzvQw+yHS++SxGnzpePZVTqwOT7u4EZZjRAwemE=;
        b=Vrdu9SvFee/dRHb5/JBpfKQrusz8b57JSCMVGtlAbPj1nFsqmpldM1Clpgxg6q2jj5
         BbguKDK3UjtmujrDoijC2srcE+YB5+zD1+lq6FQdfWpj1Brpvv38TDc/0ATPriH1uYIp
         JLbwsRJztUHURwpl7lH85VIJ9KXkRbadGAaXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OICwnzvQw+yHS++SxGnzpePZVTqwOT7u4EZZjRAwemE=;
        b=XjLz5+/G2JLDAH/iWctumhTmhwGQObYUpmMzuZHIIy9MZzFGaiz7RjLEx7PXJzyGFl
         HaEFZPZk0fEPalcZ3RfOikHSz1dW31CL/FlGD5rfGGAUYitnFPYBeW618aBW6iU6vRkA
         PL5zEGnlBa53MTJuWegDDQlhdvO2YJzF/RG2Q3Weqilzzv/pKQQKO0TW2c2s+BKlcBEt
         rYmQYb5QcRcznATin0ciz84UTFfIcpt0gSdhN20l/J7kqQAPKYf4PrwaXQfQuD6Ar+rx
         lGsx+VDEMo4qpYmtxC6JKZDO99INQ9fEMaVNxyTNUV0pwArdB6vsFOd5DfJPlx58OSdZ
         qMFQ==
X-Gm-Message-State: ALoCoQmKHZ2BwVYxiTF6fmyvwlhMbtfyyhznL1syMoSkdjN9MpNqg0jSQO91TcRzdHLOW6EygYEU
X-Received: by 10.202.211.10 with SMTP id k10mr17506393oig.34.1442995107045;
 Wed, 23 Sep 2015 00:58:27 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Wed, 23 Sep 2015 00:58:26 -0700 (PDT)
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278475>

On 21 September 2015 at 23:41,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v6:
> * fix spaces in .gitattributes for Git-LFS files (old "[:space:]", new "[[:space:]]")
> * generated patch on top of next (95c4325) to resolve merge conflicts

Trying this out by hand (rather than using the test cases) it crashes
for me. Am I doing something wrong?

- I've got the version of git-p4.py from
ef93b8df71f6d8a7936786c989714868c2d3540c in Junio's ls/p4-lfs branch.
- I have git-lfs v0.60 (just downloaded the binary distribution).

Then I created a p4 repo, and added two files in Perforce, small.txt
and bigfile. bigfile is 400k.

Doing a regular git clone works fine:

$ mkdir depot
$ cd depot
$ git init .
$ git p4 sync //depot
$ git checkout p4/master

(I'm using git init + git sync rather than git clone so that I can
setup the git config variables I need in the next step).

Doing a clone with LFS support though doesn't work:

$ mkdir depot2
$ cd depot2
$ git init
$ git config git-p4.largeFileSystem GitLFS
$ git config git-p4.largeFileThreshold 100k
$ git p4 sync //depot
Doing initial import of //depot/ from revision #head into refs/remotes/p4/master
Traceback (most recent call last):
  File "/home/ldiamand/git/git/git-p4.py", line 3624, in <module>
    main()
  File "/home/ldiamand/git/git/git-p4.py", line 3618, in main
    if not cmd.run(args):
  File "/home/ldiamand/git/git/git-p4.py", line 3298, in run
    self.importHeadRevision(revision)
  File "/home/ldiamand/git/git/git-p4.py", line 3085, in importHeadRevision
    self.commit(details, self.extractFilesFromCommit(details), self.branch)
  File "/home/ldiamand/git/git/git-p4.py", line 2651, in commit
    self.streamP4Files(new_files)
  File "/home/ldiamand/git/git/git-p4.py", line 2565, in streamP4Files
    cb=streamP4FilesCbSelf)
  File "/home/ldiamand/git/git/git-p4.py", line 501, in p4CmdList
    cb(entry)
  File "/home/ldiamand/git/git/git-p4.py", line 2559, in streamP4FilesCbSelf
    self.streamP4FilesCb(entry)
  File "/home/ldiamand/git/git/git-p4.py", line 2501, in streamP4FilesCb
    self.streamOneP4File(self.stream_file, self.stream_contents)
  File "/home/ldiamand/git/git/git-p4.py", line 2451, in streamOneP4File
    (git_mode, contents) =
self.largeFileSystem.processContent(self.cloneDestination, git_mode,
relPath, contents)
  File "/home/ldiamand/git/git/git-p4.py", line 1111, in processContent
    return LargeFileSystem.processContent(self, cloneDestination,
git_mode, relPath, contents)
  File "/home/ldiamand/git/git/git-p4.py", line 1004, in processContent
    (git_mode, contents, localLargeFile) =
self.generatePointer(cloneDestination, contentTempFile)
  File "/home/ldiamand/git/git/git-p4.py", line 1068, in generatePointer
    oid,
  File "/usr/lib/python2.7/posixpath.py", line 70, in join
    elif path == '' or path.endswith('/'):
AttributeError: 'NoneType' object has no attribute 'endswith'


The test cases work fine, t9823 and t9824.

Thanks
Luke
