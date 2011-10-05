From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 16:42:11 -0700
Message-ID: <7v1uur57l8.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
 <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
 <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
 <7v62k359ee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 01:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBb6g-0000SH-01
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 01:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553Ab1JEXm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 19:42:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934986Ab1JEXm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 19:42:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E47BB5F1B;
	Wed,  5 Oct 2011 19:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ZdsIGiOaztIZG+Fo2lCCtV5NYY=; b=rAvmQB
	fN9jkuFCfNoTC40DLXBgdRNhGdQoAbDF11GXHGlqsyDs6Iz+RY1tdVp/JKlDiKbC
	Et1E3W9wBG3ZbdiMCRk4q7CyW+Sjt4F/nboSkcaWpBUMjvPNINgHlugJrPMjDhAS
	qAOJ3X7sinXqgX9Cvl3jjmsOU5s7dn/Batf98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u4C/hcmV6QBJHOQZIeeXN+tcBwmEq7zE
	GxrdjwjNPZrUE88DVPUtrnn5VmSMHgHsxnhhR/ylVBp37PaRTWZwvwx19m59GRv5
	h5Ui/nNXMuS2PsldAYxHT9IOC6gHaLZ6VJHxontUrNYzXIg1assBYBx6jSXLL79/
	tzucd0R3CUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C2A5F19;
	Wed,  5 Oct 2011 19:42:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B1B45F0D; Wed,  5 Oct 2011
 19:42:13 -0400 (EDT)
In-Reply-To: <7v62k359ee.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 05 Oct 2011 16:03:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A679522E-EFAB-11E0-B2A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182903>

Junio C Hamano <gitster@pobox.com> writes:

> It's just the "commit --amend" message that says I cannot amend felt
> utterly out of place, immediately after seeing "cherry-pick" that tried to
> pick only one commit did _not_ even start.

After thinking about it a bit more, I am starting to think that it may
just be the error message given by "commit --amend".

If the sequence were like this:

    $ edit foo.c ;# I want to fix foo.c in the current branch "master"
    $ EDITOR=: git commit --amend ;# forgot to say "foo.c"
    $ git cherry-pick other~2 other
    [master 48882c9] frotz: update xyzzy
     Author: Jay Soffian <jaysoffian@gmail.com>
     1 files changed, 2 insertions(+), 2 deletions(-)
    error: Your local changes to the following files would be overwritten by merge:
            foo.c
    Please, commit your changes or stash them before you can merge.
    Aborting

Then at this point, amending the commit at HEAD^ is not possible anyway,
as it is not at the tip anymore.  It is perfectly fine that

    $ git commit --amend foo.c

fails at this point.

It is just that it initially felt irritatingly wrong if I was picking only
a single commit "other" that wanted to touch foo.c, like this:

    $ edit foo.c ;# I want to fix foo.c in the current branch "master"
    $ EDITOR=: git commit --amend ;# forgot to say "foo.c"
    $ git cherry-pick other
    error: Your local changes to the following files would be overwritten by merge:
            foo.c
    Please, commit your changes or stash them before you can merge.
    Aborting

At this point, as it says "Please commit your changes", and it is very
clear that cherry-pick _correctly_ errored out without touching any of my
work, it is natural for me to expect that I can "commit --amend" to fix
my eariler mistake.

    $ EDITOR=: git commit --amend foo.c
    fatal: You are in the middle of a cherry-pick -- cannot amend.

This can only worked around halfway:

    $ rm .git/CHERRY_PICK_HEAD
    $ EDITOR=: git commit --amend foo.c
    
Things look OK so far, but then restarting the cherry-pick I wanted to do
after I fixed foo.c would fail like this:

    $ git cherry-pick other
    error: .git/sequencer already exists.
    error: A cherry-pick or revert is in progress.
    hint: Use --continue to continue the operation
    hint: or --reset to forget about it
    fatal: cherry-pick failed

Perhaps it would be a possible solution to teach "cherry-pick --reset" to
remove CHERRY_PICK_HEAD and the sequencer state, so that the above
transcript would become:

    $ edit foo.c ;# I want to fix foo.c in the current branch "master"
    $ EDITOR=: git commit --amend ;# forgot to say "foo.c"
    $ git cherry-pick other
    error: Your local changes to the following files would be overwritten by merge:
            foo.c
    Please, commit your changes or stash them before you can merge.
    Aborting
    $ EDITOR=: git commit --amend foo.c
    fatal: You are in the middle of a cherry-pick -- cannot amend.
    hint: use "git cherry-pick --reset" to discard the previous cherry-pick.
    $ git cherry-pick --reset
    $ EDITOR=: git commit --amend foo.c
    $ git cherry-pick other
    [master 48882c9] frotz: update nitfol
     Author: Jay Soffian <jaysoffian@gmail.com>
     1 files changed, 2 insertions(+), 2 deletions(-)

At least, that looks like something we _could_ explain to the end users.
