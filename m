From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Wed, 14 May 2014 14:40:02 -0700
Message-ID: <xmqqtx8shwel.fsf@gitster.dls.corp.google.com>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
	<xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
	<20140513230201.GA32562@debian>
	<xmqqy4y5l1c7.fsf@gitster.dls.corp.google.com>
	<20140514213206.GA12228@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:40:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkguQ-0003Al-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbaENVkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:40:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50028 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbaENVkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:40:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F113E18084;
	Wed, 14 May 2014 17:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pgq1iAJGWD3rVnhX6GUYvslJ9rI=; b=DdVvYM
	AQV4ykUCzLcjsxVJkF2f1Apz6Wu487gPTqe6Bug8JzjfiRrAOMs1D7GsptxkejJd
	4F9y2f//ZZ1wQ6BGaBUfAN0l0x6Y8KQ6JZ353CT20pYoqVYG7mg+Y1a7sCuBKatF
	rzZX0LN6mJjr5QwMLgCWLhh6lip52M6A+wh1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ih1N0JlBYdzeJSXIAYeKbjnkCc6i4I//
	nB8HnwRpdTZ2X5BNEtc9dLIRhAokZOBrdtJkK0zfM+V0jizYgl421gnLFOI8Ox3j
	hkOLC3mMREJFejSIYhi7hqllEjWMoaUWWBPlhSklpxxfuwfENZN2QFdLuN2tNyBx
	mw1e5fz53UY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6E7818079;
	Wed, 14 May 2014 17:40:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5668B1806D;
	Wed, 14 May 2014 17:40:04 -0400 (EDT)
In-Reply-To: <20140514213206.GA12228@debian> (James Denholm's message of "Wed,
	14 May 2014 21:32:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F6049EA-DBB0-11E3-93B9-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249000>

James Denholm <nod.helm@gmail.com> writes:

> On Tue, May 13, 2014 at 04:12:56PM -0700, Junio C Hamano wrote:
>> James Denholm <nod.helm@gmail.com> writes:
>> 
>> > I'm not sure that can actually happen - peel_committish is essentially
>> > implemented as `rev-parse $arg^0` (though with a bit of bling, of
>> > course), and to my understanding FETCH_HEAD will always parse to a
>> > committish - I could have missed something, of course.
>> 
>>  $ git fetch git://repo.or.cz/alt-git junio-gpg-pub
>>  $ git rev-parse FETCH_HEAD^0
>
> That would be a problem... Sadly I doubt I'll have time to develop a
> solution into subtree's overall design before the end of June. As that
> eventual change would probably involve altering the inclusions of this
> fix, and that users have a workaround in adding either squashed commits
> or referencing lightweight tags, would you rather drop the patch and
> wait for that?

Sorry, I am lost.  What would be a problem exactly?

A FETCH_HEAD can be pointing at an object that is not committish,
and users involved, both at the originating end who controls the
repository you fetched from and at the receiving end who wanted to
fetch the object, are *not* expeting to be able to make a merge of
such an object anyway.  My suggestion was not to ask you to come up
with a sane behaviour when the user told us to add a single blob
with "subtree add"; it was merely to detect such unintended use as
an error.

To me, it looks like all that is necessary is to accept your patch
but with a three-byte tightening to detect such a pathological case
and signal an error, which is what " &&", which I added to your new
line that sets revp=$(peel_committish ...), is about.

This patch, with or without these extra " &&" three bytes, will not
be part of the upcoming 2.0 release anyway, so we have enough time
to iron it out.
