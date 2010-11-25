From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Breaking t1510-repo-setup.sh tests in pu
Date: Thu, 25 Nov 2010 10:56:42 +0100
Message-ID: <AANLkTim=_0WiphBv-RBhJ2i9rGzXvz8yKcZcm_7pYXFc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 10:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLYZO-0006Vf-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 10:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab0KYJ4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 04:56:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab0KYJ4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 04:56:44 -0500
Received: by fxm13 with SMTP id 13so599869fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 01:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=SWugL1p07Ah4ONeUC2kLuIYvI2DTmfg+rTehr7VQEjM=;
        b=nqvOHTy6JCjqyhzSV8q8Tug2+LAcirsRLy3Jvn4+aTXhthRKI4oZggZ8W5SlndRYFk
         bOEjIitt5zVTJLXDku97EHpQF5wqZ+ZZY8T2h/AitLcgHOE3HiismNAXYxO80RPzer1n
         5fRTsCsf/AT9ZUYv72vnlsCXxbljl17R6h+l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=xmkrzfUKxUuChAUyKp7m+Yn+A8msin0C1BkbX/jSF1SGb3H+4ikkHSWrVm2k2zeygT
         YmLIF9ooZ/t1T9iiB7Oj33lghiPpGOmT/KjiLLPi8exVIVniXjRwox4esiZHdMyzNLhr
         +TdQt17sMcRmkp9Vkq3j975AFs2B4PhtFZhKM=
Received: by 10.223.108.147 with SMTP id f19mr486825fap.68.1290679002793; Thu,
 25 Nov 2010 01:56:42 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 01:56:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162120>

I haven't investigated these. But that test is breaking in pu now:

    $ prove ./t1510-repo-setup.sh
    ./t1510-repo-setup.sh .. Dubious, test returned 1 (wstat 256, 0x100=
)
    Failed 244/376 subtests

    Test Summary Report
    -------------------
    ./t1510-repo-setup.sh (Wstat: 256 Tests: 376 Failed: 244)
      Failed tests:  8-9, 11, 15-36, 46-67, 71-92, 101, 103
                    113-128, 144-159, 169-184, 207-208, 211-234
                    256-279, 281-282, 284-307, 320-343, 351
                    353-376
      Non-zero exit status: 1
    Files=3D1, Tests=3D376,  8 wallclock secs ( 0.23 usr  0.02 sys +  0=
=2E85
cusr  5.26 csys =3D  6.36 CPU)
    Result: FAIL

All the breakages seem to be due to path differences:

    --- expected    2010-11-25 09:53:46.000000000 +0000
    +++ result      2010-11-25 09:53:46.000000000 +0000
    @@ -1,4 +1,4 @@
    -setup: git_dir: /home/avar/g/git/t/trash directory.t1510-repo-setu=
p/3/.git
    -setup: worktree: /home/avar/g/git/t/trash directory.t1510-repo-set=
up/3/wt
    +setup: git_dir: .git
    +setup: worktree: /home/avar/g/git/t/trash directory.t1510-repo-set=
up/3
     setup: cwd: /home/avar/g/git/t/trash directory.t1510-repo-setup/3
     setup: prefix: (null)
    not ok - 24 #3: GIT_DIR, GIT_WORK_TREE=3Dwt at root

This is probably due to Nguy=E1=BB=85n's recent work. But I'm not sure.
