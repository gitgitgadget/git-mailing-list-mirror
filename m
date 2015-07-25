From: "Adam Liter" <adam.liter@gmail.com>
Subject: Question about git filter-branch with signed commits
Date: Sat, 25 Jul 2015 15:17:28 -0500
Message-ID: <5085A037-0E20-4FA4-B553-E54345F4FAA5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 22:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ5uw-0006wz-UW
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 22:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbbGYURb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 16:17:31 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33867 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbbGYURb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 16:17:31 -0400
Received: by iecrl10 with SMTP id rl10so36513348iec.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=nXw8PbYa26hya+cf9pLbzvHaYDZ5crOINHB9PRTZ47c=;
        b=TqiAMXxV6E1THnKGgsjGYkUV9ygv0Z+II7cvXAhpQaKxa7NuZpRWuuUyzfgryxV2tb
         X3m5AtxDe4P8lA4eNdf30FFJYyvBOEeK+aH9g/HflL5bvkNugichJhz0ynAEvS/4Xk/y
         crHtPRZX1ehbg8LUboVvj0HsmeRrPsDZwXIoK6b4N/1mQnnoiXWfw8iEimOK+R/xVZLr
         AKcO4/jJkJDMDwjHjxajUgNvosfT4QB2i3ikSKCvGM3KQTCAMKRb5uAYMsyYS9zNHtlO
         hRRhMv8L08P0kysUskTq7P2XNKamHz1jNoRGl3IV/m/zAu1v/7UaCzflBAb/7OeSoAo0
         85uw==
X-Received: by 10.50.36.8 with SMTP id m8mr6704542igj.16.1437855450531;
        Sat, 25 Jul 2015 13:17:30 -0700 (PDT)
Received: from [128.135.230.146] (wireless-230-146.uchicago.edu. [128.135.230.146])
        by smtp.gmail.com with ESMTPSA id c20sm7972210ioc.40.2015.07.25.13.17.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 25 Jul 2015 13:17:29 -0700 (PDT)
X-Mailer: MailMate (1.9.1r5084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274617>

Hello,

I'm trying to clean up the commit history of a git repository by 
removing certain files. The repository contains signed commits, and when 
I try to use git filter-branch, the PGP signature is converted to the 
first line of the commit message.

Is this the expected behavior? If so, is there something that I can do 
to prevent this from happening?

I'm using git v. 2.4.6. I tried reducing the behavior to a simple case. 
I asked about this on Stack Overflow 
(http://stackoverflow.com/q/31552774/2571049), but the question hasn't 
really gotten any uptake, so I thought I would try asking here too.

In trying to reproduce the behavior in a minimal way, I did the 
following:

mkdir pgp-git-test
cd pgp-git-test
git init
touch a.txt
git add a.txt
git commit -m "Add a.txt" -S
touch b.txt
git add b.txt
git commit -m "Add b.txt" -S
git filter-branch --index-filter 'git rm --cached --ignore-unmatch 
a.txt' --prune-empty HEAD
git log --oneline --decorate
b4efdf0 (HEAD -> master)  iQIcBAABCgAGBQJVrvqHAAoJ [...] -----END PGP 
SIGNATURE-----
9f82e63  iQIcBAABCgAGBQJVrvp7AAoJ [...]  -----END PGP SIGNATURE-----

As can be seen after running git log --oneline --decorate, the PGP 
signature has become the first line of the commit. The rest of the 
commit message is still there, but it's on a line below the PGP 
signature.

How can I prevent this from happening when using git filter-branch?

Also, one thing that I was a bit surprised about when trying to create 
this minimal example is that the first commit is still there. Does 
anyone know why the commit history still contains the first commit, 
since the first commit only involved the file a.txt and since I passed 
--prune-empty to git filter-branch? Shouldn't this commit have been 
eliminated from the log?

Thanks in advance for the help! I'm relatively new to git, so apologies 
for bugging you all if this is a trivial error on my part. Thanks!

Best,
Adam Liter
