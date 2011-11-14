From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git: Unexpected behaviour?
Date: Mon, 14 Nov 2011 12:55:35 -0800
Message-ID: <7vr51aifug.fsf@alter.siamese.dyndns.org>
References: <1321044904175-6986736.post@n2.nabble.com>
 <4EBD9428.3030506@gmail.com> <4EBDBCA2.7070603@gmail.com>
 <7vlirlp1y6.fsf@alter.siamese.dyndns.org>
 <CAOeW2eEUbvd0eJHjNfbvi9QnDiUO=mFA9rrKsjv8Yu0_QiPgSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.V." <jvsrvcs@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ3ZB-0004TJ-KY
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354Ab1KNUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:55:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756313Ab1KNUzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:55:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F092569CD;
	Mon, 14 Nov 2011 15:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6caqVUCOKUiVh4JOn6gqFadCfCA=; b=SciTTJ
	GOVG+vGkG0ctE1tY/SjaUzBLtu/5jGOpfSNEWnrHT8RdVs3ilko1YrtjvLyckrRP
	B4OKvmUZ7UHEPX4h7k/wfSew0Ee6GlucV8pyFJ+kS2FE+Kt7cJnX4Vvl8Ux/vuDz
	6kXjhGrKoyOcyAtSIfByyfR2+aDOmaa+vKfA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayfLxUClYSAD6Vj3t0x6ROOyCJOJKEmp
	J+K0wYZLlyaigjCwAL7gyKg1UDy9ejcPJLqRDAnELovMNaZtIu3/LA0rSx6y2CQk
	XfhbsBdErc/QEEvlc/csXt5bW1Rnj/fpgYwQcHykIWHSFM3D0kOEU1wG+2+PABR/
	PvbsNnQWh2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E779E69CC;
	Mon, 14 Nov 2011 15:55:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CDC469CB; Mon, 14 Nov 2011
 15:55:36 -0500 (EST)
In-Reply-To: <CAOeW2eEUbvd0eJHjNfbvi9QnDiUO=mFA9rrKsjv8Yu0_QiPgSw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 14 Nov 2011 09:20:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 007B44C8-0F03-11E1-9818-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185403>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Either you want the modifications to stay on the branch, or you want
> them to carry over to the branch you are checking out. In the former
> case, you would want Git to fail if there are modifications (that you
> might have forgotten you made). In the latter case, you would want
> "git checkout -m". The current behavior is somewhere in between. It is
> not clear to me if there is a use case where the current behavior is
> better (from the user's point of view) than either failing or
> "checkout -m".

Current behaviour is deliberately made safe because "checkout -m" may end
up forcing you to resolve a 3-way conflict you may not be prepared to do
correctly at your first attempt. Stopping and refusing to check out the
other branch gives you the choice to create a temporary stash-away commit
either on a current branch, or a temporary branch you create with "git
checkout -b temp && git commit" before switching to the target branch to
attempt to port the change over with "git cherry-pick @{-1}", which you
_can_ redo if you screw up conflict resolution and want to start over.
If you are confident that your local changes are trivial that you can
reproduce it even if you screw up your conflict resolution attempt, then
you can choose to run "checkout -m". If we made it the default, you will
lose this safety.

On the other hand, if you do *not* want to carry over the change when
checking out a different branch, you can easily stash-away the changes.
