From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Wed, 04 Mar 2015 12:14:26 -0800
Message-ID: <xmqqbnk88qql.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>
	<xmqq385nb2yg.fsf@gitster.dls.corp.google.com>
	<54F5D869.4010104@drmicha.warpmail.net>
	<xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com>
	<54F6D20D.903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTFgg-0005Op-9t
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758744AbbCDUOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:14:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757686AbbCDUO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:14:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B154E3CAF4;
	Wed,  4 Mar 2015 15:14:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FXC5JONQ0DBpxOUS0CYMUrQOYuw=; b=VX1sXV
	W5zf8Ck5dWMI0EaMoo5O4pUGJ2VKZ+YAnrgO4bEBhMctRtDQGEpbis6qZEy+S5R6
	8NQQXFl8PyHlcZLN+BQh+mOxMAKLGx5J4jEw0w4QBo5QQXGJRQdmOQNYPPmYnbEd
	PYkU7ccR5wWuk8F52gxhk2tc+J6wQUaoWvdYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eySxL4nyzbdN3XTFm6lELcXpuOXwya/r
	R4qyl0l01QhamJxO/fQqKR6qv7W5qPIdCT6HX1el7CNDcPqdGS79/jNbIp8whEHU
	g9i8b3yuT8ZTPZ1uU9z7Je4twidAu5NnFxH8JMkzZ4b+atuFhI+R6YnAzMUM7u3E
	3Z0xws7iuus=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A767C3CAF3;
	Wed,  4 Mar 2015 15:14:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11E513CAF0;
	Wed,  4 Mar 2015 15:14:28 -0500 (EST)
In-Reply-To: <54F6D20D.903@drmicha.warpmail.net> (Michael J. Gruber's message
	of "Wed, 04 Mar 2015 10:36:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F5EDA5E-C2AB-11E4-9622-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264773>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> I am not sure how the intention of the commit 1c2eafb8 (Add
>> url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07),
>> which introduced the behaviour verified by this test, interacts with
>> the desire to redefine what URL and pushURL mean in our recent past,
>> what e.g. e6196ae1 (remote: add --fetch and --both options to set-url,
>> 2014-11-25) wanted to do, though.  Thoughts?
>> 
>
> Wow. That looks strange to me on first read. Sorry I didn't catch it
> back then. "--fetch" sets both url and pushurl??

Yeah, sounds crazy, no?  Taken in isolation without consideration
around the InsteadOf rewriting, the change sort-of makes sense,
though.

But I do not know if the combined whole makes much sense.

> So, for definiteness sake, I'll use "url" and "pushurl" for the config
> names and struct members (which the config values end up in), and I'll
> use "URL for fetch" and "URL for push" for the URLs that git will use
> for fetch resp. push.
>
> If there is no "pushurl":
>   "url" will be used as the "URL for fetch" and as the "URL for push".
>   if we are pushing and there is "pushinsteadof" for (part of) "url"
>     subsitute that within "url"
>   else if there is "insteadof" for (part of) "url"
>     substitute that within "url"
>
> If there is a "pushurl":
>   "url" will be used as the "URL for fetch" and "pushurl" as the "URL
> for push".
>   if we are pushing and there is "insteadof" for (part of) "pushurl"
>     substitute that within "pushurl"
>   else if we are fetching and there is "insteadof" for (part of) "url"
>     substiute that within "url"

These make sense to me.

> I don't know what "remote set-url" does, I think the whole remote
> command as it is does not fit in well with our UI, but that applies to
> other commands with non-option subcommands as well (or bad). I would
> have hoped it is set-url and set-pushurl to set those two config
> options.

I would have hoped so, too, but I don't use "git remote" myself (as
you said, it is an odd man out and there is nothing it and only it
can do that is essential for my everyday workflow), so... ;-)

> I rarely use pushurl, but could use it to override url, or to do the
> above magic on a case by case level, such as if I need to specify
> different usernames for the same host.
>
> So, that's my understanding of how these things are supposed to work and
> why it is useful.

Yes, I am not questioning the usefulness of insteadof magic.  I am
wondering if that "--fetch sets both?" breaks the expectation of
those who rely on it.
