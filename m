From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFC: Should git gc/repack respect .git/refs/replace?
Date: Sat, 23 Jul 2011 18:39:17 +1000
Message-ID: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 10:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkXk4-0001an-4B
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 10:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab1GWIjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 04:39:20 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36377 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab1GWIjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 04:39:18 -0400
Received: by vws1 with SMTP id 1so2108573vws.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=EUhxsDn7UyAwhkcLLYngTCEBHAozYTvrULyW82ZFVQc=;
        b=meAVcReKDZ9rfpBkPZutNS1YCDbyptKJPO3quYqzcwQRZXubNa84ZVhDB3f0fQ5VNj
         YFSRWyXGdvLu4B5C1rDjvFFqoYBZtCbiRzC4cceL6LBAbjoVcOCJdswroiJe9ZJrLHpQ
         283FPgb8FoGB6PWDb9NDuCzpXhrbvcLlKP5/0=
Received: by 10.52.74.69 with SMTP id r5mr178645vdv.307.1311410358043; Sat, 23
 Jul 2011 01:39:18 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 23 Jul 2011 01:39:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177681>

I recently damaged a USB drive containing an archive of a finished project.

I am able to paper over a week of missing history by using the git
replace mechanism, so that git rev-list now works as expected.

When I run git gc or git repack, I get the following:

   error: Could not read 023a1d5d3977420ba041cb556c0eee17c326aeb6
   fatal: Failed to traverse parents of commit
44d578ea81f7a90989e2ee3c676f50e3aff7071f

where 0bbded9a764d9f4c8dc27b778f70d044df65f65f is one of the missing
commits I replaced with:

   git replace 023a1d5d3977420ba041cb556c0eee17c326aeb6
238d237db9137b4eaf96f1d554bf2668729b9b93

Is this expected behaviour? I had assumed that git repack would
respect the topology implied by git replace.

Some other differences:

    git cat-file commit 023a1d5d3977420ba041cb556c0eee17c326aeb6

produces the expected output (that is the same as git cat-file commit
238d237db9137b4eaf96f1d554bf2668729b9b93), but

   git cat-file commit -t 023a1d5d3977420ba041cb556c0eee17c326aeb6

fails with:

   error: unable to find 023a1d5d3977420ba041cb556c0eee17c326aeb6
   fatal: git cat-file 023a1d5d3977420ba041cb556c0eee17c326aeb6: bad file

In my view, it seems reasonable that git repack should tolerate repos
that have replace references in them otherwise you can never recover
unused space.

Thoughts?

jon.
