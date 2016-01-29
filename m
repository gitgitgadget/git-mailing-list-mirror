From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Gitignore file exceptions are not applied to untarcked files
Date: Fri, 29 Jan 2016 20:54:30 +0000 (UTC)
Message-ID: <n8gji4$bf1$1@ger.gmane.org>
References: <CAMrYpX5n1LHBnr+bMhV=8Eu1K2npKctVZrHxJcStBhSVC70OBg@mail.gmail.com> <xmqqd1skjkyp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 21:55:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPG4Q-0006YM-8F
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 21:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbcA2Uys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 15:54:48 -0500
Received: from plane.gmane.org ([80.91.229.3]:41646 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbcA2Uyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 15:54:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aPG45-000674-31
	for git@vger.kernel.org; Fri, 29 Jan 2016 21:54:45 +0100
Received: from fokus169149.fokus.fraunhofer.de ([194.95.169.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 21:54:45 +0100
Received: from anatoly.borodin by fokus169149.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 21:54:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fokus169149.fokus.fraunhofer.de
User-Agent: tin/2.3.1-20141224 ("Tallant") (UNIX) (Linux/4.2.0-25-generic (x86_64))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285094>

Hi Junio,


I've tested it with many older versions of git, as well as with the rec=
ent
v2.7.0 - it seems like this feature has been never working properly.

The script https://gist.github.com/anatolyborodin/9c581b50c584534fff28

#!/bin/sh

set -e

# a
# b
# c
# D/a
# D/b
# D/c
# E/F/a
# E/F/b
# E/F/c

mkdir -p D E/F
touch a b c D/a D/b D/c E/F/a E/F/b E/F/c

echo && echo '.gitignore' && echo '----------'
echo '*\n!b\n!D/b\n!/D/b\n!/E/*/b' > .gitignore
cat .gitignore

echo && echo 'With `--ignored`' && echo '----------'
git status --ignored

echo && echo 'Without `--ignored`' && echo '----------'
git status


The output:


=2Egitignore
----------
*
!b
/D/b
!/D/b
!/E/*/b

With `--ignored`
----------
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        b

Ignored files:
  (use "git add -f <file>..." to include in what will be committed)

        .gitignore
        D/
        E/
        a
        c

nothing added to commit but untracked files present (use "git add" to t=
rack)

Without `--ignored`
----------
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        b

nothing added to commit but untracked files present (use "git add" to t=
rack)



All files in the subdirectories are ignored, no matter what.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
