From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Cannot fetch whole history from Perforce
Date: Tue, 8 Mar 2011 10:09:55 -0800
Message-ID: <AANLkTik6fxHUJbp6dWdAgV-wr=P=FxK1K-vGAGy8ruBd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, pw@padd.com
X-From: git-owner@vger.kernel.org Tue Mar 08 19:10:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px1MB-0000tA-VU
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 19:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab1CHSJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 13:09:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40582 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1CHSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 13:09:57 -0500
Received: by fxm17 with SMTP id 17so5368470fxm.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=f4zb5wO63pqcG6ztTZ0qjJuxfslWZx58j4Ob75ufS5o=;
        b=J0xN4FJbVZVqWca3WIHG9S3qSBin0AqgSb3seSWEk7/XymmsEfcY+k5u3L90ljx8TN
         GVLaavdvB+11ze2YfABoWFhXY8ORTjEAF7gmR3FiVzBAhfxoZXPOqPvpDT9Jks/kTsuT
         bCbM5+9bc4q6JY+f/iHVyvQVfUJh34wmlqReo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=IewGKFm2wejubFmberrMvjGRrsFOmMBLyxOnRKrmnQN9+CtM65cski4XEFq926JoO+
         p9W+ZWOeW2EV6yKjYaqm9F6VM+1lW9dVpO4CysFibaFh4KQciIta0ue2mzWELOylDMhh
         DGXCKjM7k1j+6e/PvcxLHGIj3O5ZobBL582Hk=
Received: by 10.223.63.212 with SMTP id c20mr4466703fai.37.1299607795595; Tue,
 08 Mar 2011 10:09:55 -0800 (PST)
Received: by 10.223.124.196 with HTTP; Tue, 8 Mar 2011 10:09:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168670>

Hi, I am using HEAD version of the git and I have an issue with git-p4
tool (p4 to git importer).

git-p4 works fine when I import HEAD version of my project

$ git p4 clone //depot/foo/bar --verbose
Importing from //depot/foo/bar into bar
Reinitialized existing Git repository in /home/anatol/tmp/bar/.git/
Reading pipe: git config git-p4.useclientspec
Doing initial import of //depot/foo/bar/ from revision #head into
refs/remotes/p4/master
Reading pipe: git config git-p4.user
Reading pipe: git config git-p4.password
Reading pipe: git config git-p4.port
Reading pipe: git config git-p4.host
Reading pipe: git config git-p4.client
p4 -G files //depot/foo/bar/...#head
Opening pipe: p4 -G files //depot/foo/bar/...#head
commit into refs/remotes/p4/master
p4 -G users
Opening pipe: p4 -G users
p4 -G -x - print
Opening pipe: p4 -G -x - print
...A bunch of files...
executing git branch master refs/remotes/p4/master
executing git checkout -f


But it fails with a cryptic error when I try to import @all revisions:

$ git p4 clone //depot/foo/bar@all --verbose
Importing from //depot/foo/bar@all into bar
Initialized empty Git repository in /home/anatol/tmp/bar/.git/
Reading pipe: git config git-p4.useclientspec
Traceback (most recent call last):
  File "/home/anatol/bin/git-p4", line 2033, in <module>
    main()
  File "/home/anatol/bin/git-p4", line 2028, in main
    if not cmd.run(args):
  File "/home/anatol/bin/git-p4", line 1904, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/anatol/bin/git-p4", line 1767, in run
    die("No remote p4 branches.  Perhaps you never did \"git p4
clone\" in here.");
  File "/home/anatol/bin/git-p4", line 59, in die
    raise Exception(msg)
Exception: No remote p4 branches.  Perhaps you never did "git p4 clone" in here.

Can it be related to Pete's changes?
http://permalink.gmane.org/gmane.comp.version-control.git/167281
