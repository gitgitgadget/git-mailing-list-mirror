From: demerphq <demerphq@gmail.com>
Subject: Bogus error: Untracked working tree file '....' would be overwritten
 by merge. Aborting
Date: Tue, 16 Nov 2010 11:26:19 +0100
Message-ID: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 11:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIIk7-0000n6-Pk
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 11:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934172Ab0KPK0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 05:26:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33344 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571Ab0KPK0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 05:26:21 -0500
Received: by wyb28 with SMTP id 28so526598wyb.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 02:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=wpQM3qeq/i0UfJaTr5VUmXcV6RwjkcvTV1zlf7YJK+w=;
        b=nGnkXSACS3a91Wy/xkBURrTmD3vdlcmdJUUfBFB0AB4h411x41R557eZ/slz3H/QqI
         hPWciWX9WCKjpXPrWiPWFSI0we1oVncSWmRrIzLPzLLpNWLt55zpySgGhmxSIEL0CVqk
         vLp6zpyI4Ld84hd0RGaQGzU027QHH9h/PeIYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=DulsRaIGcylvl4w+tEtNtQe3+6ZT8XsPJ2oQO/D5xtwfFRlAxfd/R9po2rQyU9mygZ
         bMUIb/mrCIn7Rla8mRkeZWVk0MHIcayqbuq9WMwinLpP3fjyjzwRVheR0QIOYftL4yVe
         K5cBi76V6my1o3ZQq4LMmeFRFC4jDRmm7mJJ8=
Received: by 10.216.173.79 with SMTP id u57mr6447300wel.40.1289903179441; Tue,
 16 Nov 2010 02:26:19 -0800 (PST)
Received: by 10.216.159.11 with HTTP; Tue, 16 Nov 2010 02:26:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161553>

The error in the subject line is generated if one has a git repo
checked out to a commit that adds a new file and one does something
like:

git reset HEAD^

and then a merge operation that involves going forward onto or past HEAD.

Why is this error generated when the file is *exactly* the same as the
file that would overwrite it?

Obviously it makes sense to throw this error when data would be lost,
but when they are identical what is the point?

In my experience when this happens they are almost always identical,
and that this is one of the most common sources of frustration and in
my shop a real source of confusion for my colleagues.

I think fixing it to detect they are identical and ignore them when
they are would really improve things for the uninitiated.

The following demonstrates the problem:

$ mkdir exp
$ cd exp
$ git init
Initialized empty Git repository in /home/demerphq/exp/.git/
$ echo woohoo > t.txt
$ git add t.txt
$ git commit -m'add t.txt'
[master (root-commit) dbe3cec] add t.txt
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 t.txt
$ echo boohoo > b.txt
$ git add b.txt
$ git commit -m'add b.txt'
[master 15a72ea] add b.txt
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b.txt
$ git checkout -b other
Switched to a new branch 'other'
$ git reset HEAD^
$ git merge master
Updating dbe3cec..a61413d
error: Untracked working tree file 'b.txt' would be overwritten by merge.

Are there any reasons why this cant be changed?

Cheers,
yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
