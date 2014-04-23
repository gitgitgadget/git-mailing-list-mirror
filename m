From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 13:28:39 -0700
Message-ID: <xmqqsip3yemg.fsf@gitster.dls.corp.google.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
	<1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3mi-0005r0-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbaDWU2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:28:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbaDWU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:28:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 307D47E92B;
	Wed, 23 Apr 2014 16:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lPWQwP8LQ6U7pyxVX2gojEl5uUY=; b=CPZOoH
	Vr2KdOpqmv9G6Tuw/V8BiDOWCgnU+1bzJtGSCWWVagWf7sXKviojzQ9vGy1weg+W
	jlSpVSELoEGh6ICubI9qmv/cL2cwka+Upky/uztoXArTvw/Z5WYC/LMuORHo4qqT
	kZUKWL1W/1MMnY8SE97K/eOLPUMGEDRAlLlRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GYXYkjQhkUQ9ckTkzfjFE+cPNoSHDkf2
	ced9FoeaBb9a+J40LueYDX6TTvLjmPk6HlatT6TCCCFzwDaupyUiaxLJiSUDwgJQ
	djGs311NBm9XecuH2LBY+Ho1hiRTwzFe4on3dIv89VrOwyxdX+Z2iQVlw3fIyJIG
	dT6wcnTOB7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A1CB7E92A;
	Wed, 23 Apr 2014 16:28:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37C8C7E926;
	Wed, 23 Apr 2014 16:28:41 -0400 (EDT)
In-Reply-To: <1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 23 Apr 2014 14:42:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBC89E00-CB25-11E3-9B84-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246889>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This hook is invoked before a branch is updated, either when a branch is
> created or updated with 'git branch', or when it's rebased with 'git
> rebase'.  It receives three parameters; the name of the branch, the
> SHA-1 of the latest commit, and the SHA-1 of the first commit of the
> branch.
>
> When a branch is created the first and last commits of the branch are
> the same, however when a branch is rebased they are not. If the SHA-1 of
> the first commit of the branch is not available (e.g. git reset) a null
> SHA-1 (40 zeroes) would be passed.
>
> The hook exit status can be used to deny the branch update.
>
> It can be used to verify the validity of branch names, and also to keep
> track of the origin point of a branch, which is otherwise not possible
> to find out [1].

Please call it pre-update-branch at least, unless you want to make
sure that time spent on others in the discussion thread for the
previous round becomes wasted.

> +update-branch
> +~~~~~~~~~~~~~
> +
> +This hook is invoked before a branch is updated, either when a branch is
> +created or updated with 'git branch', or when it's rebased with 'git rebase'.

Does "git checkout -B aBranch" count?

Does "git reset $there" count?

I guess "git commit" or "git merge" on a branch to advance its tip
in a usual way would not count (and I can think of good reasons why
they should not count), but it is only a weak "guess".  The above
two lines does not give readers enough hint to determine if "branch
and rebase will be the only two and no other command will ever
trigger" or "branch and rebase are only examples---for others, guess
on your own" (and if the latter, enough clue to use in guessing).
I cannot guess if "git fetch $there $that:refs/heads/master" should
trigger the hook, for example.

To put it another way.

How does one, who is adding a new command that causes a branch tip
to be updated, to decide if it should trigger this hook?  What are
the common things among commands that can update branch tips that
this hook gets called that are missing from commands that update
branch tips that this hook does not get called?
