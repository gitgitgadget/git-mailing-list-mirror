From: Simeon Maxein <smaxein@googlemail.com>
Subject: git filter-branch can "forget" directories on case insensitive filesystems
Date: Fri, 3 Sep 2010 18:36:17 +0200
Message-ID: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 18:36:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrZFq-0000vH-K1
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 18:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815Ab0ICQgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 12:36:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64402 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab0ICQgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 12:36:31 -0400
Received: by pzk9 with SMTP id 9so618196pzk.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BtzRo2k/fjdMdpMnWu33YtKhchNBx3HoDmewBdshHTs=;
        b=tE/WglDJ/5PQheOB0Atz1BR72srvUN6jeLKNacRPEeQsypsTFLOIyLW93LF+sqmtE9
         poabJcP9htwPnWeaYW8X2haQO/dhYUiaKBiZi7+VazTNkabK9G7by6RAs8j3H8hhHnME
         +7pjlThgKcVn1eX5f/jPjiJlmLKlZe9w7V/bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=w/aVep21mCCAsYeX0B1fsdL/IUAU0r+p8QjCQBHl2grmQlM/oh4BAbGY6N7Dj8a2yH
         80y16n6HMc8kqnNWp+35tvtqOuo5rutQHh+123xNxmu4Fnsy0n+vN8yRiuNOvJqxbWCD
         QHux1QyzohsnLc43WGIZd/CvpfIwEPHfoDns0=
Received: by 10.114.133.11 with SMTP id g11mr20287wad.213.1283531777640; Fri,
 03 Sep 2010 09:36:17 -0700 (PDT)
Received: by 10.220.164.137 with HTTP; Fri, 3 Sep 2010 09:36:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155250>

When running git filter-branch on a case insensitive filesystem, the
working tree checked out for filtering is missing a directory in my
project. This is probably related to the problem discussed here:
http://article.gmane.org/gmane.comp.version-control.git/154662

In contrast to that report, this one affects repositories on
case-insensitive filesystems, regardless of the setting of
core.ignorecase.

To reproduce the problem, follow the steps below. I tested them with
git 1.7.0.4 on a laptop running Ubuntu, with the repository on a Fat32
USB drive.

mkdir gittest
cd gittest
git init
mkdir testdir
echo 'abc' >testdir/testfile
git add testdir
git commit -m foo
git rm -r testdir
mkdir testDir
echo 'abc' >testDir/testfile
git add testDir
git commit -m bar

Now, check out master^1 and master to ensure the commits look as
expected. Then, run this:

git filter-branch --tree-filter 'ls' master

You will notice that the directory vanishes when the second commit is filtered.

The problem occurs whether core.ignorecase is set to true or false. It
doesn't occur on case sensitive filesystems.

Simeon
