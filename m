From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Tue, 03 Jan 2012 10:45:28 -0800
Message-ID: <7vlipovd4n.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
 <CABURp0pdvf9Eo_pM2UCYUBANOJOGON6pQS-SXuCWQE=s2XNOfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 19:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9Me-0002Tg-OR
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 19:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab2ACSpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 13:45:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab2ACSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 13:45:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8097B37;
	Tue,  3 Jan 2012 13:45:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GHot6HDpgfgY3ogBSQIVJFTEk0Q=; b=qpmj3Q
	Ua/tSpF19eOFBiayg3FhYqeZ0f1br1DUsTgsmtUlbI2v/G5VIyM2Hu7F2VuRGjfd
	ms2yRiSpzhOYknItlE51OL2IvjFbmAc6Zw0K3az5WDfsBVoqjOHevTPHh/gd34Ot
	0jAISnkB1a8Ly1ODMChGOFuDxzZK8+Ip92e1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=esvprZAR4qNSwYTs9UTQubmiJVgCvNn4
	4EcwwOkpcTIdUv1/48VIJO7/cWT2Uwu9aW+BLkKgNfPxzES5gaPuXAegrnlYRINQ
	oDLu+lw7bN4LrcLLdkGZRZ7Rv6vzvkLiEoxntxK09MjYDHKzyyDo8zsFlQLcWXE2
	RKB27ilngrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 468F17B36;
	Tue,  3 Jan 2012 13:45:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD5167B35; Tue,  3 Jan 2012
 13:45:29 -0500 (EST)
In-Reply-To: <CABURp0pdvf9Eo_pM2UCYUBANOJOGON6pQS-SXuCWQE=s2XNOfQ@mail.gmail.com> (Phil
 Hord's message of "Sat, 31 Dec 2011 16:28:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BFF728C-363B-11E1-B2FC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187872>

Phil Hord <phil.hord@gmail.com> writes:

>> Again, who said that you are allowed to move the superproject directory in
>> the first place? I would understand that it might be nicer if it could be
>> moved but I haven't thought this through thoroughly yet---there may be
>> other side effects from doing so, other than the relativeness of "gitdir".
>
> Previously it was accepted practice to clone a local repo with rsync.
> This method continues to work well even with submodules before
> git-files became the norm.  But now it breaks because of the absolute
> paths.

You are utterly mistaken.

There are 47 million things you can do to your repository outside of the
control of git, and obviously we do not exhaustively enumerate everything
that ought to work (or not work). Anything that is not explicitly allowed
in the documentation is, ehh, not allowed.

Many such things may happen to work, either by accident or as a natural
consequence of the design. Some things needs adjustments after you do them
without telling git. There is a difference between what is not allowed and
what is explicitly forbidden.

Copying with rsync (or cp for that matter) is one good example. Doing so
will cause the cached stat information in the index and the working tree
files go out of sync, and diff-files will give you false differences after
that. You would adjust to that by running "update-index --refresh". So we
do not say "you are allowed to cp and git will guarantee everything will
work as-is", but it is not explicitly forbidden. As long as you make
necessary adjustments, you can keep using the copied repository.

> So, who said you were NOT allowed to move the superproject directory
> directory in the first place?

See above.

And the extent of the design of

    echo "gitdir: $there" >.git && git config core.worktree "$(pwd)"

is to work with the locations of these two places as they are set up.
Moving one or the other or both may or may not work without adjusting to
what you did. If you "mv $there $newlocation" (the repository) behind
Git's back, you may need to update .git to point at the new location of
the repository.  If you move your working tree woth "mv", you may need to
update core.worktree to point at the new location of the working tree.
And until you do so things may not work. That is why we do not explicitly
say "you can move them to arbitrary places without telling git and things
will work"---because that is not the case.

> This doesn't explain why one path is absolute and one is relative.

Exactly. Because absolute/relative does not come into play as the scope of
the design did not include supporting "moving" one, the other, or both to
arbitrary places without telling git.
