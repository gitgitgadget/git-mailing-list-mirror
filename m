From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 11:23:16 -0700
Message-ID: <xmqqwqaw2fe3.fsf@gitster.dls.corp.google.com>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
	<CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
	<20140729025940.GA8640@vauxhall.crustytoothpaste.net>
	<20140729092301.GA13134@peff.net>
	<xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
	<20140729174357.GA20042@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCC3d-0005qr-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbaG2SXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 14:23:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50782 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbaG2SXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 14:23:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DFBB2C81D;
	Tue, 29 Jul 2014 14:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R7BI7yettJXcGo5DA6q0qd64/aA=; b=DN1XQI
	JBkH+pC7g54KcPW/U0o9JIS+mh251MApCFbgFvT7Z3ydIInHjY5qgstpMIDfvY3I
	/RY/iTVHWC2tDmU7Q1aoqN3bQ3KBc3aGnGfC87pe91Se4mdYB5FSIKaLNeIHtJqK
	uQVKRz3C7sPfGoDrgM7DX+aj/n70u7HwJehSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fg7XshgJIt82Mgq4nFF4bc3yI2DDoozo
	aecaVSQ9PLd/Cbv8rmI9x+MbF90o9/+vk1IBw1oatheJTM16RkWHMK0LN3h2msPP
	93GpYr7gQLuQukX2dQHzczBjeFTlIS4tXoyrr0m57zzXtPkkflybLazJ6S6kZlbT
	c1yzWNOFygI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 557E62C81C;
	Tue, 29 Jul 2014 14:23:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E29972C817;
	Tue, 29 Jul 2014 14:23:17 -0400 (EDT)
In-Reply-To: <20140729174357.GA20042@peff.net> (Jeff King's message of "Tue,
	29 Jul 2014 13:43:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69975FD2-174D-11E4-A217-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254459>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 29, 2014 at 10:00:22AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So perhaps we could do something better on the viewing side, and
>> > "simplify" combined merges for files with all-identical parents.
>> 
>> Or you can ask to show the difference with the first parent, no?
>
> Yeah, though there is no way to do the other thing (--second-parent to
> show only the index side). I doubt anybody wants that, though. Just
> passing --first-parent would probably be fine (that would match "git
> stash show", too, though like that "stash show" it is impossible to
> override to see the index portion then).
>
> But...
>
>> I do not think giving a single-parent diff when --cc/-c is asked
>> for, which is a clear indication that the caller is aware that the
>> commit in question is a merge, is such a good idea.
>
> I think that is my point, though. The user is _not_ aware that the
> commit in question is a merge.

Oh, don't get me wrong.  I am not opposed to give better output from
"stash show -p".  I do not want to see us change what "git log --cc" 
does without being asked to do something different.

I see you added --simplify-combined-diffs to avoid breaking "log",
so that is not too bad, but I am still unsure what should happen
when the first parent and the result is the same and only the second
parent is different (i.e. you have changes in the index and your
working tree changes have been reverted---then you create a stash).
Should it show as "single source diff, with all changes reverted"?
Should it show as a normal "combined diff for a merge"?  Should it
show as "no changes whatsoever"?
