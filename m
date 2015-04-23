From: Michal Pomorski <misieck@gmail.com>
Subject: git clone --depth: shallow clone problems
Date: Thu, 23 Apr 2015 16:53:04 +0200
Message-ID: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 16:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlIVP-000296-Q0
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 16:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965511AbbDWOx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 10:53:27 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34723 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbbDWOx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 10:53:26 -0400
Received: by lbcga7 with SMTP id ga7so15174123lbc.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=IqlT9G+DJBqBegkTjRdCAyfQi/QfAof5dZ4emWzsj6M=;
        b=IKnPtdjhVkqjKn31yRHps7tzTVj2fvvyxaINMNDj48eVl53vp1yZjTY2ogJbrlsLZE
         JdVrTbsz0L9AXw1P7nGwzg6XcifMfoIGOaQ/+0YhbHJzMOacE1Mf4cXDSPVvtnTMhNzu
         3H4+8ERHN2u1Fy9/fmckKTPfWiTz+tb0gZtnHuMAHJYfQj4q8Dv8HexLKpBIGQz0eCfi
         tMg6wkf8wYtL5vDebkSvaIyWr04rBxAMyCCE18KHOSJK5XZp1zcg20DziKNH4pj86NjW
         KJ7k5DvcrxTROyP685oCZ1yMxcmPS6vQHEufeeu+cSYhHolH7C/P1Ah9bQMJrVOC/YUr
         T6+g==
X-Received: by 10.113.10.134 with SMTP id ea6mr2745119lbd.29.1429800804754;
 Thu, 23 Apr 2015 07:53:24 -0700 (PDT)
Received: by 10.25.24.89 with HTTP; Thu, 23 Apr 2015 07:53:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267692>

tl: skip to the second paragraph

So here is what I just experienced:
We had an emergency error in an application at work and as the
responsible developer was unavailable, I was asked to check it out and
look into it.
We are a small branch of a bigger company and our connection to the
company's source servers is really slow, so just to quickly start it
up, I decided to take a shallow clone (that's what it is for, right?).
After a while we realized, the clone I have made was not sufficient
and was missing some newest work done on the project.
I did "git fetch --unshallow" which finished surprisingly quickly, and
it did not bring any newer commits.
Unaware of the fine print hiding in the documentation of git clone, I
blamed the repo (and in extension the person who provided me the
address to it). After coming to a realization, a process which cost me
time and embarrassment, I understood what is supposed to be the
"correct" behaviour:
"--single-branch
Clone only the history leading to the tip of a single branch, either
specified by the --branch option or the primary branch remote's HEAD
points at. When creating a shallow clone with the --depth option, this
is the default, unless --no-single-branch is given to fetch the
histories near the tips of all branches."
Of course, the new commits were put on a custom branch, and I knew
that all the time, but I expected the branch to show up eventually, at
least after git fetch --unshallow.


I hope you can see the faults in the usability of the commands I was exposed to:
1) git clone --depth  should:
   -warn about only fetching the current HEAD (name it by a real name
if applicable)
and/or
   -require the --branch option so that it is not left to chance
(current HEAD could be anything; is it really meaningful to talk about
the current HEAD on a server?)
and/or
   -make the --no-single-branch the default...
and maybe
   -have the option to clone the most recent commits.

2) git fetch --unshallow should convert the clone into an actual
equivalent of a normal, not shallow clone.

3) The documentation should be improved. The behaviour of --shallow is
described partly in the description of --no-single-branch. This is the
documentation equivalent of the infamous "come from" control flow
structure.

Regards,
Michal Pomorski
