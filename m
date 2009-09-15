From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 14:46:16 +0200
Message-ID: <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
	 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
	 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
	 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
	 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 15 14:46:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnXQa-000696-5n
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 14:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbZIOMqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 08:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZIOMqP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 08:46:15 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:47980 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZIOMqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 08:46:15 -0400
Received: by ewy2 with SMTP id 2so418728ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=a9XPJRpmnnSCvxbzjSxNLSetOLmc6zboc+9+NJXfulw=;
        b=fa9KaXePv5uFOFfV+NC/qcdg9Ixo4d2lJwTyWE41r0sexjro4TudW9e4/LxCs6pAx6
         8Ivt/ZLS6DHuJCprtJP15mHmGmMIQDKExgEoFYU6agCzic09Ol24YDSH+anND/whQO0d
         njnkrmEO+uiOQ8M/2vpA5dQgkuK3DEZl2mny4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kdsm30BEzhL2SghJ5if+aIcPoFQz7dfBoM0G9/6NqWf5oAwiHyz5A8/afLrTbRZFgj
         CUBDFNgbJUVbWGMl5nRPVUCTjX0zs6NHVV/aZSZKUa1psKw1if9a6LAJbWbpUN6m90ZR
         zFj5SulHkSw0GpXX1k2aTCn7o1s7Q7qgTE+y8=
Received: by 10.211.132.36 with SMTP id j36mr8459995ebn.51.1253018776713; Tue, 
	15 Sep 2009 05:46:16 -0700 (PDT)
In-Reply-To: <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128536>

On Tue, Sep 15, 2009 at 2:10 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> Martin,
>
> Looked at gitk - yes there is definitely one more commit still on the
> current (wrong) branch.
>
> I deleted the offending file and have now successfully switched to the
> other (correct) branch.

ok!

so you have

A - The commit you undid, and have in the temp patch. Note that this
patch file is missing the file you've rm'd.

B - A commit you haven't "undone" on the "wrong" branch X.

 and you are on branch Y

so now...

1 - git format-patch Y^..Y  # will export that patch B into a file for you.
2 - git am 0001-whatever-the-name-of-the-file.txt # patch B
    this may need conflict resolution - read the notes it prints! If
it refuses to apply the patch, do "git am --skip" to indicate you
won't use git-am no more for this, and try applying it with the patch
utility.
3 - patch -p1 < your-patch-A.patch
4 - find and readd the file you rm'd earlier -- if you don't have
another copy, we can get it from git reflog but that'll take extra
steps :-)
5 - git commit # you're committing your patch A here

Now, review with gitk to see that you have what you want to have
there. If it's all ok...

 6 - git checkout X
 7 - git reset --hard # unstich that last stray commit
   --

hope the above helps. Git pros will see that the process could be much
shorter :-) I chose this specific path because in exporting your
patches and applying them again you can see each step.

If we were to start again, and the branches are reasonably close to
eachother (not 19_STABLE vs cvshead :-) ) then you can say

 - X has 2 bad commits that belong to Y, then
 1 - gitk X & # open gitk to visualise the commits, send it to the background
 2 - git checkout Y
 3 - git cherry-pick X^ # takes the next-to-last commit from X and
tries to apply it here - conflict resolution may be needed
 4 - git cherry-pick X # same with the very last commit on X
 5 - gitk # check that is all as you want it
 6 - git checkout X
 7 - git reset --hard X^^ # "rewind 2 commits"

hth,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
