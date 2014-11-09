From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Sun, 09 Nov 2014 09:21:49 -0800
Message-ID: <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWBi-0006HC-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbaKIRVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:21:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751600AbaKIRVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:21:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F33FC1A99A;
	Sun,  9 Nov 2014 12:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=krVJ8OFZklMu9XUwXvjtYmBg704=; b=hpy3Sd
	9nQafnl8u+OqK/lfZ/gqnVh2DhxY4WjQR5L4Rz8HoAYyOUiebH7uLmqkiSfqLvXX
	edQbZgnQOTjRIoIXuBhytSS+XgWOoOtG2PDSOtfyzs8afk5a9KuWMODplYY2iz/m
	6U5jYRoYI2jTNlkHYmC25zeN9l8qZJZr3e9fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a1ac4VCh//cGqaglJR0xbf7XLK53Wv+W
	cek385L2CUgR0Aha2XnaMgku+09YPfv+ZBaDOyrpPXGp94CnVTgXFlEFidgNiR7e
	eX2E44jV0cI1zb/Zq+/qZnfOGJx48tKjSJL1Gz0SupVk3qiD2HbLYI1GGiM2Z5AI
	5mSaF3+/FZk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E924D1A999;
	Sun,  9 Nov 2014 12:21:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65B2C1A998;
	Sun,  9 Nov 2014 12:21:50 -0500 (EST)
In-Reply-To: <20141108083040.GA15833@peff.net> (Jeff King's message of "Sat, 8
	Nov 2014 03:30:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E435AA5E-6834-11E4-A190-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 07, 2014 at 11:35:59PM -0800, Junio C Hamano wrote:
>
>> I think that has direct linkage; what you have in mind I think is
>> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234935
>
> Thanks for that link.

It was one of the items in the "git blame leftover bits" list
(websearch for that exact phrase), so I didn't have to do any
digging just for this thread ;-)

But I made a huge typo above.  s/I think/I do not think/;

The original observation you made in this thread is that when "git
checkout $tree - $pathspec", whose defintion is to "grab paths in
the $tree that match $pathspec and put them in the index, and then
overwrite the working tree paths with the contents of these paths
that are updated in the index with the contents taken from the
$tree", unnecessarily rewrites the working tree paths even when they
already had contents that were up to date.  That is what I called an
"implementation glitch".

The old thread is a different topic.  It is about changing the
semantics of the operation to "make paths in the index and in the
$tree identical, and then update the working tree paths to also
match, all with respect to the $pathspec".  This, as Martin noted,
needs careful debate on the merit and transition plan if we decide
that it is worth doing.  The "do ignore paths that are not in $tree"
is a deliberate design choice.

I'd prefer that these two to be treated separately.  That is, even
if our plan did not involve changing the semantics of the operation,
we would want to fix the implementation glitch.  Compare the $tree
with the index using $pathspec, adjust the index by adding paths
that are missing from the index that are in $tree, but not removing
the entries in the index only because they are not in $tree (note:
when the index has a path A, the $tree has a path A/B, and the
$pathspec says A, we would end up removing A to make room for A/B,
and that should be allowed---it does not fall into the "only because
the path is not in $tree".  In such a scenario, we remove A not
because $tree does not have A but because A/B that the $tree has is
what we were asked to materialize).  And after updating the index
that way, do an equivalent of "git checkout -- $pathspec".  The
entries that were the same between the $tree and the index will have
the up-to-dateness kept and will not unnecessarily rewrite an
unmodified path that way, while things that are modified with the
operation will be overwritten, I would think.

And with that machinery in place, we could start thinking about
updating the semantics.  It will be a small change to the loop that
goes over the result from diff_index() and modifying the code that
used to do a "not remove only because not in $tree" to do a "remove
if not in $tree".

> So just to be clear, the behavior we want is that:
>
>   echo foo >some-new-path
>   git add some-new-path
>   git checkout HEAD -- .
>
> will delete some-new-path (whereas the current code turns it into an
> untracked file).

With the updated semantics proposed in the old thread, yes, that is
what should happen.

>   git checkout HEAD -- some-new-path
>
> do in that case?

Likewise.  And if some-new-path were a directory, with existing path
O and new path N both in the index but only the former in HEAD, the
operation would revert some-new-path/O to that of HEAD and remove
some-new-path/N.  That is the only logical thing we could do if we
were to take the updated sematics.

That is one of the reasons why I am not 100% convinced that the
proposed updated semantics is better, even though I was fairly
positive in the old discussion and also I kept the topic in the
"leftover bits" list.  The above command is a fairly common way to
say "I started refactoring the existing path some-path/O and
sprinkled its original contents spread into new files A, B and C in
the same directory.  Now I no longer have O in the working tree, but
let me double check by grabbing it out of the state recoded in the
commit".  You expect that "git checkout HEAD -- some-path" would not
lose A, B or C, knowing "some-path" only had O.  That expectation
would even be stronger if you are used to the current semantics, but
that is something we could fix, if we decide that the proposed
updated semantics is better, with a careful transition plan.

It might be less risky if the updated semantics were to make the
paths that are originally in the index but not in $tree untracked
(as opposed to "reset --hard" emulation where they will be lost)
unless they need to be removed to make room for D/F conflict issues,
but I haven't thought it through.

Thanks.
