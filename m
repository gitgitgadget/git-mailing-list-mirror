From: Andreas Ericsson <ae@op5.se>
Subject: Re: Workflow Help
Date: Tue, 21 May 2013 15:49:23 +0200
Message-ID: <519B7B63.3080304@op5.se>
References: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Quilkey, Tony" <trq@thorpesystems.com>
X-From: git-owner@vger.kernel.org Tue May 21 15:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UemwX-0004I7-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 15:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab3EUNt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 09:49:29 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:62803 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab3EUNt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 09:49:28 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so707494lab.35
        for <git@vger.kernel.org>; Tue, 21 May 2013 06:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=XAGF72Z3zyHhfNy1denhzVxB2b5GhtOkcNL+qk7avsg=;
        b=WsuUNq6d7JRqJ96smlE0z6dT2MxBXXrDw0+BkMHeCQV95X5wSLk9UjO+6UITQSpjYW
         jarewMS7/eNfWDMrUgXHj8M/ui/afEAiFKV3dqCUpMavLTdOtAOtyeSpIEivlLm0Jqr+
         TS3XRSQP0F+ZI4+lextOFwtaTxquEBdkDmBUaf8PDPUu7OS4E8GXHMhNDUrX4FTYsJ03
         5rMlJGsTVzUzClpOrc8Jus/30laNTXXttPuHLRHQtU8GTyOtwZaZrpXE7ZO86s1CzFHk
         YuTVd8kSsi7oknTsRLwHsNqXZEbC2EDrVJHR/B/D8GLrc0Pne5wXqstlEJuLcfg5DU88
         Q1Jg==
X-Received: by 10.112.201.131 with SMTP id ka3mr1539993lbc.113.1369144166887;
        Tue, 21 May 2013 06:49:26 -0700 (PDT)
Received: from lenix.dev.op5.com. (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPSA id l8sm1119925lae.4.2013.05.21.06.49.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 06:49:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkwirF5mLG0i6+lkxTLck3mt7rKIrGEVAmMv3HYZO0WrWsGxF/3HN2WAS/MQjbz/73laXWe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225031>

On 2013-05-21 02:59, Quilkey, Tony wrote:
> Hi,
>
> I am looking at formulating and then documenting our vcs workflow
> using Git at work. I have an idea of how I want things to work, but am
> a little hazy on some of the details.
>
> Our basic workflow will be based around:
> http://nvie.com/posts/a-successful-git-branching-model, with a few
> exceptions.
>
> We would like to create our release-* branches from the last release
> tag. From there, we would like the ability to cherry pick (or take the
> complete diff) commits from the develop branch.
>
> So, we are after is:
>
> 1) Create topic (feature) branches from develop, and merge back into
> develop when complete.
>
> 2) Once it is decided we are packaging a release, make a release-*
> branch from the previous release tag.
>
> 3) Cherry pick/merge/whatever any commits we want from develop into
> the new release-* until it is complete.
>

This will drive you crazy. If you have any sort of tempo on development
and separate your commits into small series, it will be close to
impossible to track all related changes. I know, as some colleagues
tried it not long ago.


A better workflow is to use topic-branches for pretty much everything.
If the branch is mainly a bugfix, although the bug has to be fixed by
refactoring or remodeling something, it gets merged to whatever "maint"
branch you have (in your case I'd imagine that would be "release-X"
something). Then you merge the release-branch into develop and take
the other topics directly into develop.


We do something like this:

* work, work, work (mostly on master)
* cut a release by setting a tag and creating a maint-branch for it
   (actually, it's a beta-release that goes off to QA, but whatever)
* maint branches are 100% test-driven development
* bugfixes (with their test-cases, as well as test-cases for other
   affected areas) go directly to maint (although possibly via a
   topic-branch if the change is bigger than trivial).
* maint is merged to master
* repeat as necessary

It works reasonably well and ensures a high code quality with very
little overhead. Sometimes people commit bugfixes to master by mistake.
In that case, we simply cherry-pick the fix to 'maint' and then merge
maint back to master as usual.

It does require some sort of stability between projects and the libs
shipped by and used by the project though, but assuming you haven't
done things horribly wrong at the design stage, this model should work
reasonably well while avoiding the whole "where are the bugfixes and
in which order do I need to apply them?" issue.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
