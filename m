From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: On using receive.denyNonFastForwards and
 advice.pushNonFastForward
Date: Mon, 9 Jul 2012 01:13:15 -0400
Message-ID: <20120709051315.GA62124@gmail.com>
References: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So6Hg-000302-0I
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 07:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab2GIFNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 01:13:15 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54110 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab2GIFNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 01:13:14 -0400
Received: by qcro28 with SMTP id o28so6482199qcr.19
        for <git@vger.kernel.org>; Sun, 08 Jul 2012 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1eCelYJBuNfGRHTv16+W9LBCf5C9ganrwopMANoWfbc=;
        b=WfXyXuYWoDOJOAQ6tmuxq5mUl1vd4X7NuvXVFprJXUvZngA3gkMPYHFINgVKCwE1wF
         LFsCPd4jU033VlCoc5jiTnNqG5K3CK6xy16CIscQV+EYnyFaTu3zWZ7CCXL/mwwLNGdc
         F65HhlDyYq4SMkF01N8SBzI6dqNfc2SfgGuZggV9XGKtbRAtcVARkknsM3ROUx3FYtPk
         ers4lkCIOZAvZRiwGNHU0Wy9IMvMza8N+NwMBeFbaW6I5zRm3Pb25lzlwf7kBlcWayDl
         7q03EmccI9Uv5jU3m9SQtzE7+AHRXsqRHhDTDcyA9hL4tt2JmgK0oHJKCT/DpbmOBK46
         g3uw==
Received: by 10.224.138.147 with SMTP id a19mr69420597qau.84.1341810793632;
        Sun, 08 Jul 2012 22:13:13 -0700 (PDT)
Received: from gmail.com (cpe-74-68-118-106.nyc.res.rr.com. [74.68.118.106])
        by mx.google.com with ESMTPS id ea5sm19665378qab.2.2012.07.08.22.13.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jul 2012 22:13:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201194>

From: Christopher Tiwald <christiwald@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc: Git Users <git@vger.kernel.org>
Bcc: 
Subject: Re: On using receive.denyNonFastForwards and
 advice.pushNonFastForward
Reply-To: 
In-Reply-To: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>

On Sun, Jul 08, 2012 at 02:26:50PM -0700, Hilco Wijbenga wrote:
> I was wondering how hard it would be to make "git push" more adamant
> about not pushing non-ff updates. So I wanted to see the effects of
> receive.denyNonFastForwards and advice.pushNonFastForward. (By the
> way, why is one plural and the other singular? That doesn't seem
> consistent?)

'advice.pushNonFastForward' doesn't control whether or not
the remote accepts non-fast-forward updates. Rather, it controls whether
or not advice displays when 'git push' errors because the user attempted
a non-fast-forward update. As of 1.7.11 (f25950f3), it was supplemented
with 'advice.pushNonFFCurrent', 'advice.pushNonFFDefault', and
'pushNonFFMatching'. Setting the original 'advice.pushNonFastForward'
config option to 'false' will disable all three of these situational
hints. None of them will affect the actual operation of 'git push'.

As for this series of commands, none of these are non-fast-forward
updates (i.e. a situation where a pushed branch tip is behind its remote
counterpart):

> HERE=$(pwd) &&
> git init --bare remote-repo &&
> cd remote-repo/ &&
> git config --add receive.denyNonFastForwards true &&
> cd .. &&
> git clone file://$HERE/remote-repo local-repo &&
> cd local-repo/ &&
> git config --add advice.pushNonFastForward true &&
> echo "1" > one.txt &&
> git add -A . && git commit -m 1 && git push origin master &&

This is the inital push to the remote:

$ git log --graph --oneline
* 32bbda2 1

$ git diff master origin/master ;# noop

> git checkout -b next &&
> echo "a" > two.txt &&
> git add -A . && git commit -m 2 &&
> git checkout master &&
> echo "2" > one.txt &&
> git add -A . && git commit -m 3 && git push origin master &&

This is a standard fast-forward update to the remote:

$ git log --graph --oneline
* 0176f87 3
* 32bbda2 1

$ git diff master origin/master ;# noop

> git merge next &&
> git push

This is also a standard fast-forward update to the remote:

$ git log --graph --oneline
*   b881618 Merge branch 'next'
|\
| * 843a285 2
* | 0176f87 3
|/
* 32bbda2 1

$ git diff master origin/master ;# noop

If you want to see a true non-fast-forward error from this point, try
this:

git reset --hard HEAD~1 &&
echo "non-ff" > one.txt &&
git add . && git commit -m 4 && git push origin master

You should get something like this (the advice will change based on your
version of git):

[master cf28ce8] 4
1 file changed, 1 insertion(+), 1 deletion(-)
To /tmp/remote-repo
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to '/tmp/remote-repo'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for
details.

The "hint" lines at the end are configured by the 'advice' options
described above.

--
Christopher Tiwald
