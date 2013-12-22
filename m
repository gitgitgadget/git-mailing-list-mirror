From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Sat, 21 Dec 2013 22:38:47 -0800
Message-ID: <7vvbyhjsp4.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
	<xmqq7gaze00k.fsf@gitster.dls.corp.google.com>
	<CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 07:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vuch2-0002l1-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 07:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab3LVGiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 01:38:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab3LVGit (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 01:38:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C85AA4D363;
	Sun, 22 Dec 2013 01:38:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OeLigGP9M54GV0o5g9IRBbSlH4Q=; b=e2cx2F
	o69NhI9pPJzb1SrNnKosTpty6QGcsu6lanHk1KCxJSxdIF5UuRlEDpKuCm62okl3
	d6b2LWPQJ247CQyebZzs/+GTjJHnGeZcfyRPRfeIw8j60Sg6KH1EhzTeJdJPSolk
	wi3tEE5ud8hCai/yAJbCOghwbD/H9QiE5JJa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c9QhXt+OwdMAFs8P41ICPRk72EW0cl52
	6zzMHCwm6oJnPYKiA6CN9dd/UW/ZOS6rKWKeMwpTHuoGtaZlwlv1jp437fenvjeD
	4XYnBTFLbJ/+VvYYB7NS/h7aSAWj4R5XBRl6XZRekeTFpVa+f4L0e7VyX8XYdFWV
	Yt63TXjQ9sE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69114D362;
	Sun, 22 Dec 2013 01:38:43 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A88EF4D361;
	Sun, 22 Dec 2013 01:38:42 -0500 (EST)
In-Reply-To: <CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 21 Dec 2013 09:00:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: B31E0826-6AD3-11E3-812A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239631>

Duy Nguyen <pclouds@gmail.com> writes:

>> I am not happy with the choice of "main/HEAD" that would squat on a
>> good name for remote-tracking branch (i.e. s/origin/main/), though.
>> $GIT_DIR/COMMON_HEAD perhaps?
>
> It's not just about HEAD. Anything worktree-specific of the main
> checkout can be accessed this way, e.g. main/index,
> main/FETCH_HEAD.... and it's not exactly "common" because it's
> worktree info. Maybe 1ST_ as the prefix (e.g. 1ST_HEAD, 1ST_index...)
> ?

Do we even need to expose them as ref-like things as a part of the
external API/UI in the first place?  For end-user scripts that want
to operate in a real or borrowing worktree, there should be no
reason to touch this "other" repository directly.  Things like "if
one of the wortrees tries to check out a branch that is already
checked out elsewhere, error out" policy may need to consult the
other worktrees via $GIT_COMMON_DIR mechanism but at that level we
have all the control without contaminating end-user facing ref
namespace in a way main/FETCH_HEAD... do.  You said

    This makes it possible for a linked checkout to detach HEAD of
    the main one.

but I think that is misguided---it just makes it easier to confuse
users, if done automatically and without any policy knob. It instead
should error out, while saying which worktree has the branch in
question checked out. After all, checking out a branch that is
checked out in another worktree (not the common one) needs the same
caution, so "main/HEAD" is not the only special one.

And if your updated "git checkout 'frotz'" gives a clear report of
which worktree has the branch 'frotz' checked out, the user can go
there to detach the HEAD in that worktree to detach with

	git -C $the_other_one checkout HEAD^0

if he chooses to.
