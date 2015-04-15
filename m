From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: provide cmdline args to git hooks
Date: Wed, 15 Apr 2015 11:18:56 -0700
Message-ID: <xmqqk2xdl0fj.fsf@gitster.dls.corp.google.com>
References: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
	<xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
	<CAM-hpQcowcRaRMnYcZD8oUDep-nSw1e4Sy3CHjCojpQd=238Ug@mail.gmail.com>
	<xmqq4moi1dej.fsf@gitster.dls.corp.google.com>
	<CAM-hpQf2hzjufYxmc2uGUhoqn3JVnwwcoOPOnya4MJbCnjkg3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Chris O'Kelly" <chris@mapcreative.com.au>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiRu1-0007eK-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 20:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbbDOSTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 14:19:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756442AbbDOSS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 14:18:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CA7548181;
	Wed, 15 Apr 2015 14:18:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rXuLo4ECrJfFc2aC74iEXZA2I1A=; b=ZjRfor
	dLsPsGfwMr4vQcCShzPIk9QbuFoY29Uzxlq7mhFbUd/l2SRe+r/19+GOHA5xYQuR
	h0KkoFOaxEmSsze9C66L7oBKD0AR1zU+mcA1HavaI+9c2wscbiFw46CAMWe+ZxYz
	4IJDaIwKSkVrstg6+nzAiDe4pZBVik+HqfBE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODCUWvFSwa06SmigCbSYtQhhDRg9Cx9e
	mDgelaGoJQeAQagt7y7AG8D31FMznIdyA73eUewsRXlKZXZeo670V7o5EyyAHW1m
	nOCor/LCX3hW5mAtMQwSfIbB8MKrftng9KcTG2zKsQj16VSMPL3m5zSktMhML14S
	yDgD97mw+90=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4390C48180;
	Wed, 15 Apr 2015 14:18:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB57C4817F;
	Wed, 15 Apr 2015 14:18:57 -0400 (EDT)
In-Reply-To: <CAM-hpQf2hzjufYxmc2uGUhoqn3JVnwwcoOPOnya4MJbCnjkg3A@mail.gmail.com>
	(Chris O'Kelly's message of "Wed, 15 Apr 2015 10:21:39 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1E310BA-E39B-11E4-AD1B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267226>

"Chris O'Kelly" <chris@mapcreative.com.au> writes:

> To reiterate and clarify I'm not saying the undesirable behavior
> is a built in part of git, just a feature of our hosting
> platform's Git deployment mechanisms, although if what you mean is
> that the post-receive hook on the receiving end shouldn't be
> getting passed pushed tag refs that the local git believed to be
> already up to date on the remote (as of most recent fetch), then
> yeah... that is weird because it seems to be the behavior in this
> case.

I just checked.

    $ rm -fr new && mkdir new && cd new
    $ git init src && git init --bare dst
    $ cd src
    $ echo "(date;cat) >pushlog" >.git/hooks/pre-push
    $ chmod +x .git/hooks/pre-push
    $ git commit -m 'initial' --allow-empty
    $ git tag -m 'initial' initial

Push only the branch:

    $ GIT_TRACE_PACKET=1 git push ../dst master 2>&1 | grep 'push>'
    11:07:26.... packet: push> 0000... 66ba... refs/heads/master\0report-st...
    11:07:26.... packet: push> 0000
    $ cat pushlog
    Wed Apr 15 11:07:26 PDT 2015
    refs/heads/master 66ba... refs/heads/master 0000...

In the packet trace, we can see that we told the remote to update 'master',
and the pre-push logger also records the same.

Then push with --follow-tags:

    $ GIT_TRACE_PACKET=1 git push --follow-tags ../dst master 2>&1 | grep 'push>'
    11:09:53.... packet: push> 0000... 30fa... refs/tags/initial\0report-st...
    11:09:53.... packet: push> 0000
    $ cat pushlog
    Wed Apr 15 11:09:53 PDT 2015
    refs/tags/initial 30fa... refs/tags/initial 0000...

We can see that we told the remote to store the tag, which matches
what the pre-push saw.

And then an empty push:

    $ GIT_TRACE_PACKET=1 git push --follow-tags ../dst master 2>&1 | grep 'push>'
    11:11:23.... packet: push> 0000
    $ cat pushlog
    Wed Apr 15 11:11:23 PDT 2015

We tell them to do nothing, and pre-push saw nothing.

For a good measure, let's advance the branch and push it out:

    $ git commit --allow-empty -m second
    $ GIT_TRACE_PACKET=1 git push --follow-tags ../dst master 2>&1 | grep 'push>'
    11:13:43.... packet: push> 66ba... e711... refs/heads/master\0report-st...
    11:13:43.... packet: push> 0000
    $ cat pushlog
    Wed Apr 15 11:13:43 PDT 2015
    refs/heads/master e711... refs/heads/master 66ba...

We notice that the tag is up to date and do not tell them to do
anything to it, and pre-push did not see the tag either.

As far as I can see so far, the behaviour of the underlying push
(i.e. what we decide to tell the remote to update) is sensible,
and what pre-push is told we are doing by the command is consistent
with what is really pushed.

So....

> Anyway it sounds like the answer here is that it really isn't a
> feasible task in a client side hook, and we should stick with the
> current solution of "Don't use the GUI to push to Live" for now, which
> is fine; I should probably stop trying to script around every single
> problem anyway (https://xkcd.com/1319/).

It appears that your "GUI" is a broken implementation of Git, that
tells the other side to update what it did not even send, and that
is what is causing the trouble, perhaps?
