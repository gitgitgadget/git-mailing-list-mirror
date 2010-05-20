From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Need to change old commit (and regenerate tree)
Date: Thu, 20 May 2010 20:17:03 +0100
Message-ID: <AANLkTilTAknKPFv5AZBrwsITPsRlVSnsuX8TDXlUTWmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 21:17:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFBF4-0008I7-4x
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab0ETTRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:17:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39536 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0ETTRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:17:07 -0400
Received: by gwaa20 with SMTP id a20so92862gwa.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=gZ66qjPGqLgGrITBJKqJYeQ+2r3TVEN3+X02xOQ6IdQ=;
        b=Au21nKk1csTdXSOdV9z9tBd49Z59NZwGTGq47dMyb4eMioukQtQS/5H9H1IMYb3rc0
         CBgfXU6ZqWgQ3yjD5glwcdlir+OogiyxuZXbYJXKeNd5fD/TN3qLoM1aknzsfHZIy1WH
         4EIYHILQT202LXLLkwsuJThVM6+xxe1s4yun4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VE4xgdZmLfcIR/AlQjYsbVK0a+YWz4az14wD0TqAYFO6CSR7JadVTzB50kYEWATw+E
         OtzBR2ECdMPdpszCF3Z+6p6j71TYWfXBUCwT0a0CpAJmdP5gV+0dQG48vGRBpbQIQSJ/
         aNCMbQ0SvJ3Lhc+Mx6OZdQsINCXsDR4BC09HM=
Received: by 10.150.127.5 with SMTP id z5mr1908902ybc.275.1274383023902; Thu, 
	20 May 2010 12:17:03 -0700 (PDT)
Received: by 10.151.111.3 with HTTP; Thu, 20 May 2010 12:17:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147412>

Hi all

My question is this: I have two branches (say B and C) where one is
reachable from the other (say B is ancestor of C), and if they are
separately rebased about/onto the same point, why do B and C become
non-overlapping branches?

Let me explain with an example.

Say I have the following commit line:

A--------o--------o--------o--------B--------o--------o--------C

A, B and C are branches (so that B is reachable from C, and A is
reachable from B). [For ease, I am drawing the branches at the same
level since there are no real diverging branches here.]

I then realise that I want to change the commit A and have both B and
C rebased on this changed commit.

Now when I do a
  $ git rebase --onto A2 A C

This results in two parallel trees like these:

A--------o--------o--------o--------B--------o--------o--------o(old C)

A2--------o--------o--------o--------o--------o--------o--------C

Now I go about rebasing B. I can of course 'reset' B to C~3. But
alternatively, if I decide to do a rebase:
  $ git rebase --onto A2 A B

I will end up getting

A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)

A2--------o--------o--------o--------o--------o--------o--------C
   \
     ` -----o--------o--------o--------B

Instead of (what I initially expected):

A--------o--------o--------o--------o(old B)--------o--------o--------o(old C)

A2--------o--------o--------o--------B--------o--------o--------C


So what I am missing here? Aren't the new commits B~1, B~2, B~3
identical to C~4, C~5, C~6 (respectively) in all ways so as to have
gotten them the same SHA1 and hence appear as what I expected them to
appear?

I have taken a simple example here. In reality, I wanted to change a
not so new commit (on the main line), and there were many branches
diverging out from the main line after the (bad) commit. I initially
thought I could just write a simple script that would rebase all
branches that have the bad commit as an ancestor, and the new tree
would be a mirror image of the original. But that was not to be! There
is also the problem of resetting tags (and possible notes).


I am sorry if this has already been discussed, please point me to the
right resource if so.

My git version:
  $ git --version
  git version 1.7.0.5

Thanks
Antriksh Pany
