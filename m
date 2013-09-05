From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 07:01:03 -0400
Message-ID: <CAEBDL5VfHObeWZWvj0bnv5x+QF1_DACdU+Ehds6fHUioziHWrQ@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 13:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHXJP-0003nP-9G
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 13:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170Ab3IELBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 07:01:08 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:62851 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964843Ab3IELBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 07:01:05 -0400
Received: by mail-we0-f172.google.com with SMTP id w61so495564wes.31
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+SDdAeo3PfVUuMMBMCAmUJ+XxganN+RAMZbAY0zqKZM=;
        b=LvqYxdznvaLdIJ4wo6nUhPVovpL+9ugl5woWryBZV+mTv4yijVezhpWnEk096QjeT4
         U8hrxf8u7EMHl6N1qukWrx5obb/H0jNFrdU0PEYsUPYZmvOOBFaTqIfpLoNXSy51AlY7
         SYWCFzNa0AfoN6Mr0uLwftHr4M6Fswsw+sN8QYkDEAvXzSjqed1CffZalrMcNbQ5Lned
         aXsjtQx7oaYr9SDFoj/w4vJEYN9h4uqWi7AiidHLoW4L4uzQsvdHeZyLIM45EHEneA6b
         HGO7bpwNBQOerY2VSMeXv7zJXRW1IjcEwWdO7vnoE31suTQIqMzJGtcYwqZrlqLR3WE3
         kl5Q==
X-Received: by 10.180.38.98 with SMTP id f2mr5865258wik.39.1378378863986; Thu,
 05 Sep 2013 04:01:03 -0700 (PDT)
Received: by 10.180.90.105 with HTTP; Thu, 5 Sep 2013 04:01:03 -0700 (PDT)
In-Reply-To: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: rpNVo2WSQ-gKjez1zOx45ZmVw5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233952>

On Wed, Sep 4, 2013 at 6:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> When "git pull" stops because what was fetched in FETCH_HEAD does
> not fast-forward, then what did _you_ do (and with the knowledge you
> currently have, what would you do)?  In a single project, would you
> choose to sometimes rebase and sometimes merge, and if so, what is
> the choice depend on?  "When I am on these selected branches, I want
> to merge, but on other branches I want to rebase?"

Our team isn't quite proficient enough yet to have a completely rebase
workflow... though we might have less of a problem if we did.  So,
several interesting points.  Most of the time, `git pull` would be a
fast-forward merge.  We typically perform the merges of topic branches
server-side--we have a build server who checks to make sure the result
would be successful--and we just hit the big green button on the Merge
button for the pull request (we use GitHub Enterprise at the moment).

However, nearly as often, we just merge the branch locally because
someone on the team is doing some manual testing, and it's just
convenient to finish the process on the command line.  What
occasionally happens is that you merge the topic locally, but someone
else has introduced a new commit to master.  We try to preserve the
mainline ordering of commits, so `git pull` doing a merge underneath
the hood is undesirable (it moves the newly introduced commit off to
the side).  Rebasing your current master branch is not the answer
either, because it picks up the commits introduced by the topic branch
and rebases those to--at least with the -p option, and without it, the
results are just as bad).  Instead, we want to unfold our work,
fast-forward merge the upstream, and the replay our actions--namely
remerge the topic branch.  It often ends up translating to this:

   $ git reset --hard HEAD~1
   $ git merge --ff-only @{u}
   $ git merge topic
   $ git push

So what I really want isn't quite rebase.  I'm not sure any of the
proposed solutions would work.  It'd be really nice to replay only the
mainline commits, without affecting commits introduced from a topic
branch.

At any rate, this preserves the ordering we desire, but feels like a
less than optimal process.

-John
