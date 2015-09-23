From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 10:18:52 +0200
Message-ID: <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 10:19:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZefGb-0000kb-7e
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 10:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbbIWIS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 04:18:59 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37340 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbIWIS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 04:18:56 -0400
Received: by wicfx3 with SMTP id fx3so57444416wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ViejStX6LFCgInjAbRIwKyMvTCHLMtxOq2Ot36YyBes=;
        b=Y9C7/+4aI+sL+RYtery54j/+mhbwjjxxvg48QWSkp7VGgWvHbwRa9gGkJALVR98+nn
         i9s6JaZq65itrAlw397w+oa3BXFYusfsp8uX8ekDmp6ff6i4xd+9BcvupjpbeOfprKt5
         bOKXnU0ccXnpD1D/UN5hA66PkdstMEt/B92gTbV+U0wKSGhGlaUAG5lZgaXJ+iKKXQs3
         BcAIkhcCnvlu5H5rKLyn9UhtuahqHKj8ul5iBEogS5uL1njNRCxyvxxZDkF1An2GYBAR
         NJ7Y4Q+2OuPQpqzXS63lL5G1rC7ufgN6SUzND8dQcVAivpds1FFgw8DEntlkUBLpGBUw
         xxcg==
X-Received: by 10.180.108.112 with SMTP id hj16mr2420011wib.41.1442996334836;
        Wed, 23 Sep 2015 01:18:54 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc8sm7266810wib.2.2015.09.23.01.18.53
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 01:18:54 -0700 (PDT)
In-Reply-To: <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278476>


On 23 Sep 2015, at 09:58, Luke Diamand <luke@diamand.org> wrote:

> On 21 September 2015 at 23:41,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> diff to v6:
>> * fix spaces in .gitattributes for Git-LFS files (old "[:space:]", n=
ew "[[:space:]]")
>> * generated patch on top of next (95c4325) to resolve merge conflict=
s
>=20
> Trying this out by hand (rather than using the test cases) it crashes
> for me. Am I doing something wrong?
>=20
> - I've got the version of git-p4.py from
> ef93b8df71f6d8a7936786c989714868c2d3540c in Junio's ls/p4-lfs branch.
> - I have git-lfs v0.60 (just downloaded the binary distribution).
>=20
> Then I created a p4 repo, and added two files in Perforce, small.txt
> and bigfile. bigfile is 400k.
>=20
> Doing a regular git clone works fine:
>=20
> $ mkdir depot
> $ cd depot
> $ git init .
> $ git p4 sync //depot
> $ git checkout p4/master
>=20
> (I'm using git init + git sync rather than git clone so that I can
> setup the git config variables I need in the next step).
>=20
> Doing a clone with LFS support though doesn't work:
>=20
> $ mkdir depot2
> $ cd depot2
> $ git init
> $ git config git-p4.largeFileSystem GitLFS
> $ git config git-p4.largeFileThreshold 100k
> $ git p4 sync //depot
> Doing initial import of //depot/ from revision #head into refs/remote=
s/p4/master
> Traceback (most recent call last):
>  File "/home/ldiamand/git/git/git-p4.py", line 3624, in <module>
>    main()
>  File "/home/ldiamand/git/git/git-p4.py", line 3618, in main
>    if not cmd.run(args):
>  File "/home/ldiamand/git/git/git-p4.py", line 3298, in run
>    self.importHeadRevision(revision)
>  File "/home/ldiamand/git/git/git-p4.py", line 3085, in importHeadRev=
ision
>    self.commit(details, self.extractFilesFromCommit(details), self.br=
anch)
>  File "/home/ldiamand/git/git/git-p4.py", line 2651, in commit
>    self.streamP4Files(new_files)
>  File "/home/ldiamand/git/git/git-p4.py", line 2565, in streamP4Files
>    cb=3DstreamP4FilesCbSelf)
>  File "/home/ldiamand/git/git/git-p4.py", line 501, in p4CmdList
>    cb(entry)
>  File "/home/ldiamand/git/git/git-p4.py", line 2559, in streamP4Files=
CbSelf
>    self.streamP4FilesCb(entry)
>  File "/home/ldiamand/git/git/git-p4.py", line 2501, in streamP4Files=
Cb
>    self.streamOneP4File(self.stream_file, self.stream_contents)
>  File "/home/ldiamand/git/git/git-p4.py", line 2451, in streamOneP4Fi=
le
>    (git_mode, contents) =3D
> self.largeFileSystem.processContent(self.cloneDestination, git_mode,
> relPath, contents)
>  File "/home/ldiamand/git/git/git-p4.py", line 1111, in processConten=
t
>    return LargeFileSystem.processContent(self, cloneDestination,
> git_mode, relPath, contents)
>  File "/home/ldiamand/git/git/git-p4.py", line 1004, in processConten=
t
>    (git_mode, contents, localLargeFile) =3D
> self.generatePointer(cloneDestination, contentTempFile)
>  File "/home/ldiamand/git/git/git-p4.py", line 1068, in generatePoint=
er
>    oid,
>  File "/usr/lib/python2.7/posixpath.py", line 70, in join
>    elif path =3D=3D '' or path.endswith('/'):
> AttributeError: 'NoneType' object has no attribute 'endswith'
>=20
Confirmed. This is a bug!

Can you try the following sequence of commands?

$ mkdir depot2
$ cd depot2
$ git init
$ git config git-p4.largeFileSystem GitLFS
$ git config git-p4.largeFileThreshold 100k
$ git p4 clone --destination=3D. //depot

I=92ve always used =93clone=94 and all test cases uses =93clone=94. I w=
ill fix it for =93sync=94.

Thanks for reporting,
Lars
