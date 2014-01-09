From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: Print full url in header
Date: Thu, 09 Jan 2014 12:07:38 -0800
Message-ID: <xmqqwqi8aph1.fsf@gitster.dls.corp.google.com>
References: <1389235158-21902-1-git-send-email-jackerran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 21:07:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LtL-00064r-8c
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 21:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbaAIUHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 15:07:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbaAIUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 15:07:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A79916194B;
	Thu,  9 Jan 2014 15:07:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cT4M5JLY5Ne5AzwMQs17MBsUhgI=; b=PeAtsL
	2C0GJ+AcBg0wPavL9kTWUADnngJfe0tqXuqttrq5TEKnAYwfsesWf9kc0fjMMGhT
	lqp8BJ7Uz0jG/i5rlqVb3EWwelh1edJf15wKiBWwmWUZu1S7J3TEnuMFhpn9/Xaa
	N8FNnfT2N2+UxUSke7IvPv2X5Ln8aNaclISkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODlmyc76lQ75MgpYUemU4jYcQI+lX06s
	9WgE6PPybUgwcKjvzH54Z/ucl8KtrzaVv9f8A1Lku4T5Z4urufdAoHZDjtpZcLSG
	aRCWTuvquwq2nKXOQYd4hKTgzQLdPi63UqU0tGpndCq2CSZQqHkYNNoDdZboJYu6
	W54ib8w4lRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94FC96194A;
	Thu,  9 Jan 2014 15:07:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED58661946;
	Thu,  9 Jan 2014 15:07:40 -0500 (EST)
In-Reply-To: <1389235158-21902-1-git-send-email-jackerran@gmail.com> (Tom
	Miller's message of "Wed, 8 Jan 2014 20:39:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1A089B6-7969-11E3-8C18-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240270>

Tom Miller <jackerran@gmail.com> writes:

> After reading this and trying different things with the code. I believe
> it would make sense to continue to anonymize the url for output to the
> terminal.

Yes.  That is what the "anonymize" bit is all about.

> I also chose to continue to strip the trailing characters for the
> FETCH_HEAD file.  I wanted the input of the mailing list to see if we
> should also stop striping the trailing characters off of the url written
> to FETCH_HEAD? If so, I'll do it as a seperate patch.

These strings are used to come up with the log subject line for
merges, and there is a value in keeping them as short as possible by
removing unnecessary bits.

I wouldn't mind, and actually I suspect that it is more preferrable,
to make the consistency go the other way, that is ...

> Do not remove "/" and ".git" from the end of the header url when
> fetching. This affects the output of "fetch" and "fetch --prune"
> making the header url more consistent with "remote --verbose".

... to make "remote --verbose" abbreviate to match what you see from
"fetch".

Having said all that, the difference between the full URL shown by
"remote --verbose" (which is used to interact with the remote in
this repository) and the abbreviated URL (which is shown by "fetch"
and is designed to be sharable with others with a simple cut&paste)
matters only when there are a pair of ambiguously configured
repositories (e.g. there are two repositories "git://host/a.git/"
and "git://host/a/.git") that serve different things and you are
debugging the situation.  And to me, "remote --verbose" looks more
or less a debugging aid, nothing more.  So another alternative that
may be to leave everything as-is.

Thanks.
