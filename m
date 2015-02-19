From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Git Scaling: What factors most affect Git performance for a large repo?
Date: Thu, 19 Feb 2015 16:26:58 -0500
Message-ID: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 22:27:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOYcj-0005F1-0o
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 22:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbbBSV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 16:27:00 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52240 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbBSV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 16:26:59 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so12157268wiv.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qlmWs/Zrm3Q9hEb7f7qKJa6Hd7xVUWJe/mY6zEza4jg=;
        b=NwfgMhCAUtBrsORI3jSpvhxXmeOfh6nk2WXjtDxmrjfjpUIPIU5kU4E5C/ES9OZhTp
         maJ0amCrpdXlwOiAyOR2P9R31buDZ6QsaLIHtN9A750bQ4M3Pq/IzEptwv54efl+nUFn
         m+2+qFqAtDPuqUvR+/407QjUVQl2r2byyADdQ0GZ4/ouWPUPciOpbtpB7SvMTIZmifKy
         e09xaBYXVgbTAh30kzFZ3Wsyq+RQWJjK4mWntu1KnmDMhfwtn3jBIvl5KH8znfgqbCi4
         WfddjBgz+ItDeNGMsqlTY3MFnnAXgEiZyh4I7NzZ5cU/VJmEJsNH/iGp+xJen4WY1EOs
         QTDQ==
X-Received: by 10.180.10.131 with SMTP id i3mr14209729wib.54.1424381218084;
 Thu, 19 Feb 2015 13:26:58 -0800 (PST)
Received: by 10.194.239.228 with HTTP; Thu, 19 Feb 2015 13:26:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264114>

I posted this to comp.version-control.git.user and didn't get any response. I
think the question is plumbing-related enough that I can ask it here.

I'm evaluating the feasibility of moving my team from SVN to git. We have a very
large repo. [1] We will have a central repo using GitLab (or similar) that
everybody works with. Forks, code sharing, pull requests etc. will be done
through this central server.

By 'performance', I guess I mean speed of day to day operations for devs.

   * (Obviously, trivially, a (non-local) clone will be slow with a large repo.)
   * Will a few simultaneous clones from the central server also slow down
     other concurrent operations for other users?
   * Will 'git pull' be slow?
   * 'git push'?
   * 'git commit'? (It is listed as slow in reference [3].)
   * 'git stautus'? (Slow again in reference 3 though I don't see it.)
   * Some operations might not seem to be day-to-day but if they are called
     frequently by the web front-end to GitLab/Stash/GitHub etc then
     they can become bottlenecks. (e.g. 'git branch --contains' seems terribly
     adversely affected by large numbers of branches.)
   * Others?


Assuming I can put lots of resources into a central server with lots of CPU,
RAM, fast SSD, fast networking, what aspects of the repo are most likely to
affect devs' experience?
   * Number of commits
   * Sheer disk space occupied by the repo
   * Number of tags.
   * Number of branches.
   * Binary objects in the repo that cause it to bloat in size [1]
   * Other factors?

Of the various HW items listed above --CPU speed, number of cores, RAM, SSD,
networking-- which is most critical here?

(Stash recommends 1.5 x repo_size x number of concurrent clones of
available RAM.
I assume that is good advice in general.)

Assume ridiculous numbers. Let me exaggerate: say 1 million commits, 15 GB repo,
50k tags, 1,000 branches. (Due to historical code fixups, another 5,000 "fix-up
branches" which are just one little dangling commit required to change the code
a little bit between a commit a tag that was not quite made from it.)

While there's lots of information online, much of it is old [3] and with git
constantly evolving I don't know how valid it still is. Then there's anecdotal
evidence that is of questionable value.[2]
    Are many/all of the issues Facebook identified [3] resolved? (Yes, I
understand Facebook went with Mercurial. But I imagine the git team nevertheless
took their analysis to heart.)


Thanks,
Steve


[1] (Yes, I'm investigating ways to make our repo not so large etc. That's
    beyond the scope of the discussion I'd like to have with this
    question. Thanks.)
[2] The large amounts of anecdotal evidence relate to the "why don't you try it
    yourself?" response to my question. I will I I have to but setting up a
    properly methodical study is time consuming and difficult --I don't want to
    produce poor anecdotal numbers that don't really hold up-- and if somebody's
    already done the work, then I should leverage it.
[3] http://thread.gmane.org/gmane.comp.version-control.git/189776
