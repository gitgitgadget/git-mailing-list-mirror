From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 13:12:30 -0700
Message-ID: <xmqq61lzztxt.fsf@gitster.dls.corp.google.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
	<1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
	<38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3XD-0007hF-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988AbaDWUMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:12:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757969AbaDWUMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:12:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32D217E3AD;
	Wed, 23 Apr 2014 16:12:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4mzCtSxZqQcA4FrLR93CERrTgQU=; b=EcoTod
	4q7YD5yKz0oatXVxBkKO0iiFbaqTch1jn8aBIEvWwmHcOJcn0tZq7O9zacbQ4aZk
	iK25Aw6Ma20iCHcmpckw+c9Nk6Q825CUS7Yy8AjTWt8wI9umQUAyRtu4DXC3WbGD
	owEQD9pU2urzhYRLe4tfEReKsEL3bA3b7FFIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fGWvk6sTCw7uL29d0bdZkAhWEPT0HZNE
	DnOiSAdtDEyAzRC/KV9KGeJgAa8NUwbTd8F7G3CTYoh7UXXseNpUpVYweMFLu2OF
	XTOIJUC9qKC80fYUgNAafei0WDmubih1K9WWa2QbT/5E+6pzG7VY1MKIyMkyyamp
	Y5RLeH8Gam0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15A9D7E3A8;
	Wed, 23 Apr 2014 16:12:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210C57E3A6;
	Wed, 23 Apr 2014 16:12:32 -0400 (EDT)
In-Reply-To: <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de> (Max Horn's
	message of "Wed, 23 Apr 2014 15:10:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A23BA22-CB23-11E3-B924-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246883>

Max Horn <max@quendi.de> writes:

[Administrivia: please wrap your lines to reasonable length like 70-75].

> On 21.04.2014, at 22:37, Felipe Contreras <felipe.contreras@gmail.com>
> wrote:
>
>> The remote-helpers in contrib/remote-helpers have proved to work, be
>> reliable, and stable. It's time to move them out of contrib, and be
>> distributed by default.
>
> Really? While I agree that git-remote-hg by now works quite well for
> basic usage in simple situation, there are still unresolved bugs and
> fundamental issues with it.

As you mentioned later in your message, I agree that remaining bugs
are expected in an initial release.  I found that the above phrase
is exaggerating, but I think you are over-reacting [*1*].

> E.g. I recently showed you a reproducible use case involving
> git-remote-hg that puts the helper into a broken state from which it
> is difficult for a normal user to recover. Namely when ...
> ... prompting git fast-import to crash and trash the marks
> file. Afterwards, attempts to push or pull from the remote hg
> repository are answered with an error.
> There are other ways to trigger variants of this,...

Isn't the recent fc/transport-helper-sync-error-fix a reasonable
workaround for this issue?  The split-head in Hg fundamentally
cannot be expressed as a single ref on the Git side, and the series
attempts not to trash the marks file when the importer quits
abnormally for whatever reason to avoid rendering the resulting
repository unusable for future operations, which I thought was the
best you could do.

> It may be hard to deal with some of them, and admittedly I wouldn't
> necessarily expect that all of these are handled from the outset,
> i.e. "in version 1.0". But I think at the very least, users should be
> warned about these things.
>
> More broadly speaking, there is currently no documentation at all in
> git.git for those remote helpers, which I find worrisome.

I think your points regarding certain Hg features that do not map
well to Git data model are good ones; it would be good to have them
at least documented.


[Footnote]

*1* Personally I think it would have been better if it stopped at
somewhere around "some people in the field are using and reporting
success, let's give it wider exposure", without using words like
"proven", "reliable", or "stable" to make it sound like some
objective goodness has already been achieved.  People will call the
result of the project's work as "proven to be reliable and stable"
if it is so; the project does not have to claim and advertise its
ware by using such words---the code will prove itself given time,
and it is better to let others use these words, not ourselves.
