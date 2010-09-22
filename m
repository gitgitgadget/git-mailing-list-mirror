From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Thu, 23 Sep 2010 02:10:27 +0400
Message-ID: <AANLkTi=4qdjicBZs=yPWmAu5B+GePQeTpOr80PBi3+29@mail.gmail.com>
References: <1285080133451-5555023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 00:10:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyXWN-0005bb-2O
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 00:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0IVWK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 18:10:29 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34409 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab0IVWK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 18:10:28 -0400
Received: by qyk33 with SMTP id 33so1369708qyk.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sa2zerO8AJLCFaQMEwTDz8T/Niv9NyDR3St/ee10y8E=;
        b=KdmB+dWIOqnACHAHsdnDTQjdTmuQHyXjGxyy6/IH2JwBuA238MNr/cfBMbGQCTtd0Y
         scV24z5bPkW1iftmPFONf4mhRfh8fhiYlQaXwoKovGTLxOeKn+qWqio/FE9cQo+7Tm91
         vFd9UuOh1HUXbc0U15xNI1xv7J0ZLIqs7BGO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dz+BoogsnAw3rvWBaoh82xsggoy/L5baq0iWdnRpN7h/ZWgE56euy6bJT4m9Dc9Yhu
         3gnupeRbtHwUxhYsCPJR3w3c3sn7hFYKLQBC1KR2qtHspFBfCfx/fHMcGcDVcTe+Zb9t
         SPE+q557JutmLPMEp1W+jm+lGzLghwmicFik8=
Received: by 10.224.62.199 with SMTP id y7mr580378qah.293.1285193427473; Wed,
 22 Sep 2010 15:10:27 -0700 (PDT)
Received: by 10.229.215.6 with HTTP; Wed, 22 Sep 2010 15:10:27 -0700 (PDT)
In-Reply-To: <1285080133451-5555023.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156837>

On Tue, Sep 21, 2010 at 6:42 PM, FernandoBasso
<FernandoBasso.br@gmail.com> wrote:
>
> Why do we merge, say a testing branch into the master branch ? What is the
> use of it ?

We usually don't do that, because it goes against recommended git workflows
http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

With Git, you typically merge your stable branch to to your main
development branch or you merge some feature branch to master if you
consider it to be mature enough to be included in the next release.

> When there is a conflict when merging branches (merging the testing into the
> current branch), should I edit the 'current' branch or the 'testing' branch

You edit files in your working directory to resolve conflicts, after
you commit the result to your current branch.

> Should both branches have exactly the same code so that they can be merged
> without conflicts ?

No... There are different merging strategies, and Git is flexible enough
to allow you to specify your own merging strategy for some files. The
default merging strategy relies on the context to find if there is any
conflict. It means that the same file has been edited around the same
place (around the same line), then it will generate a conflict.

There is one important thing to keep in mind when it comes to merges.
Merge conflict are your friends and not your enemies. In other words,
they warn you about changes to some files that can contradict each
other, so you need to use your brain to resolve them gracefully.
Usually, they do pretty good job at that, but in some rare cases, merge
without any merge conflict can produce unworkable code. So, after any
non-trivial merge, you should do testing. If testing reveals some
problem then you should correct them. Git allows you amend any last
commit (including the merge commit) using:

git commit --amend

If two branches are diverged a long time ago, it is very useful to look
at history of those branches to find what changes caused the conflict.
You can do that using the following command:

gitk --merge

or if you are interested only in one particular file then:

gitk --merge this-file


Dmitry
