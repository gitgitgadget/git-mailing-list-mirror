From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: add stashes for gitk
Date: Thu, 12 Mar 2015 11:40:43 -0700
Message-ID: <xmqqioe62h5g.fsf@gitster.dls.corp.google.com>
References: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
	<xmqq1tku3x3c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 19:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW82M-0003XT-HB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbbCLSkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:40:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751376AbbCLSkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:40:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1FF93F633;
	Thu, 12 Mar 2015 14:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t6aNBmOUwr3CFc84xau8PhE6DF4=; b=bbSO8U
	iPavcu3LYVOMkc+VmeGy/TMrb7ZLVpFVookLjyqcjQhu44LNFV322RxsmXEvZtX6
	7azuO+kClrAjaHL/FBSfzYWkTaq2rFdVDQBdduIKw3SPe4Ro99atbcrUKmeRFDec
	MJiALyQNk9ZLEXKamVMxriWYaxLUaiWUb6VyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCsgnTy7vsuczYKmww5gR0xcB/1LpRwK
	Wxg84pXX2wi3PVkmTQkwVcmFV0tI2QiH8K4UsdH8rsuMs57aarAjiQZzdZvOtuKg
	BtFj8HNqnfrm7CMu46a9CCAe8o2KAePhWp3Qoynl03pu7ucdqRLNyu9giSh3MK95
	VIOl3T8tve0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3EB13F632;
	Thu, 12 Mar 2015 14:40:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 417653F62E;
	Thu, 12 Mar 2015 14:40:44 -0400 (EDT)
In-Reply-To: <xmqq1tku3x3c.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 12 Mar 2015 11:11:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A9E2768-C8E7-11E4-9E47-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265366>

Junio C Hamano <gitster@pobox.com> writes:

> ...  Also, when you have no ref that is named es-tee something,
> "gitk st<TAB>" completes to "gitk stash@{", as if the problem the
> change tries to cure is "it is unnecessarily hard to type at-mark
> open-brace".
>
> I do not have to be the target audience, though.  Maybe this is
> useful for some people.

There is another thing your patch made me notice, which is not a
problem that is introduced by your desire to include stash entries
to the completion.

The way in which the users can name a stash entry is not very
descriptive.  I often cannot offhand remember what stash@{2}
contains, for example, in my tree.  So it is not very useful to be
offered a choice among stash@{0} stash@{1} stash@{2} and stash@{3}
by a TAB completion.

If there were a way for users to say "The one I made to stash away
that change" from the command line (I do not mean "git stash list |
grep 'that change'"), it would be good.  A new syntax to name a
stash entry by pattern matching with the message given to "stash
save" could be something like (just thinking aloud, not suggesting
that this has to be our final design of that syntax):

    $ git log stash@{/$pattern}

and then it mould make a lot of sense for a completion request

    $ git log stash@{<TAB>

to result in something like this:

    "stash@{/avoid unnecessary negation}"
    "stash@{/style fix t4122}"
    ...
