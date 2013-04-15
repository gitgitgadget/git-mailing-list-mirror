From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 02:45:32 -0700
Message-ID: <7vfvys160z.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfym-0005L4-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab3DOJpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:45:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab3DOJpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:45:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2579149B8;
	Mon, 15 Apr 2013 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ezuh57ikdmsndQ8qf0K64rBFPyU=; b=CwXOJ+
	VXFsr9kMRHtsyVyjRf6ROCkekGZM7z88N8Qvo1kv3yZHDjaRKXgK4Rn0kuq8NzFA
	ChMUP4u66hO0rQee9e1WsYvm5x7sAu+qo+73DRuFqkWwqNLBnGuDsKmHciBBtIB0
	bmEvKtdpryo0t7Q5A28Vi4a+uzwIXFSLoa+zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=koGuiQ6EjJEAPqh3o9IzKWMWBUibB+67
	mmibL3pMLjB0si6Dj4s40929HiOlrp1/fIpHIcvQ0xuJkkFUA9t5uFHgOS5GiSaU
	gKjACoPXeLJ/hKJ/4nkELO19ounw/PuQ7E+dkd4ZeZ4aOxV1UecQ9svslF90/iK8
	NgOoN5G948M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9D3F149B7;
	Mon, 15 Apr 2013 09:45:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4687F149B5; Mon, 15 Apr
 2013 09:45:34 +0000 (UTC)
In-Reply-To: <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 13:49:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3811AD6E-A5B1-11E2-877A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221213>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Any new configuration variable brings its own problem by forcing
>> existing users to countermand it explicitly from the command line.
>> If the --separate-git-dir would not work for your application, you
>> need a new feature and you can achieve the same by adding a new
>> command line option (say, --submodule-git-dir), that would be more
>> preferrable.
>
> I'm getting a little tired of your first instinct to oppose every new
> addition to git. (Ofcourse I understand your attitude as the
> maintainer, but still)

It was purly about "do not add anything that makes no sense." and 
not about "oppose all new addition."

When you add a submodule with the current system, bypassing "git
submodule add", you can either

    (1) "git clone $URL here" and then "git add here"; or
    (2) "git init here" and then "git add here".

Because you didn't say what you are aiming for in the grander
picture, I thought you were "making the UI simpler" by making it
unnecessary for the users to say "git clone" himself as a separate
step before doing "git add". In such a world, "add" would internally
run "clone". If that were the case (I now know it is not), then the
configuration _is_ unnecessary, and it is perfectly valid to
question why you thought it is needed.

If your plan is instead to keep "git clone" followed by "git add" as
the pattern for use case (1), teaching "clone" to automatically use
the --separate-git-dir mechanism to point at the right place inside
the $GIT_DIR of the superproject does make sense to help the use
case.

But if that is the direction you are aiming for, would it be
possible that the same configuration variable can and should cover
the use case (2) as well?  After all, between "git init here" and
"git add here", the user may say (cd here && git pull $URL) and the
expected end result would be the same as (1), no?

I do not recall the details of the codepaths involved offhand, but
when you "git clone $URL [here]", after running "mkdir here", it
would create a $GIT_DIR for the "here" repository in "here/.git"
(and with --separate-git-dir, it would create it elsewhere and drop
gitfile at "here/.git").  When you "git init here", after running
"mkdir here", the same thing happens.

How common are these two implementations?

If "clone" just calls init_db(), I would imagine that it might be
trivial to cover both cases by telling init_db() to pay attention to
the configuration, without doing much in the "clone" itself.
