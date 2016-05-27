From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: dynamic "auto" date formats
Date: Thu, 26 May 2016 23:21:07 -0700
Message-ID: <xmqq1t4ot418.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 27 08:21:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6B91-0006sX-UF
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbcE0GVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:21:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754102AbcE0GVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:21:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFE6E1B9BC;
	Fri, 27 May 2016 02:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AjeD/GHmY6T6Dck0oI9Pv5dPDio=; b=K/nmOo
	PtXqVnlg5J0BrIbT8f2jBhSeaPTnXIHxtOavWBVzSfg4ow/DmFVEjcFIuwBpgAVg
	WrgQmc9vYde1GuXMVjUkf0UkOsSTOV/IImqeQsqrmuBgAFFvVpkIdQThfSuHEswT
	GfZBdRKl5jj/6unjVFbg+fAcLWmIydOKuCwzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jo0GbFyu479zAvH7isAvIUgCy5b6NVPX
	G95KGYpitoVScyrbVHSGtbznQB1s5HBAm7VvQW7voFLKVsA5rnNR2sA1JfJJQPYN
	blhcnhJpflGNRe0UpNkZi8pdNH/PglvjZizZCYzHpU/VZ3rhThxy8xk0zjMrl9fU
	evwvl1+ph4Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A74C61B9BB;
	Fri, 27 May 2016 02:21:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EEB41B9BA;
	Fri, 27 May 2016 02:21:09 -0400 (EDT)
In-Reply-To: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 26 May 2016 20:36:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 338DB032-23D3-11E6-82A7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295735>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And no, I'm not at all sure that the 24-hour cut-off is the right
> thing, but it didn't seem completely crazy either. I tend to like the
> relative date format when it is "19 minutes ago" vs "2 hours ago", at
> some point it's long enough ago that it's more useful to know "Tuesday
> at 3pm" than about how long ago it was.
>
> (And yes, it would be even better to have the "short term relative
> date" turn into a "medium-term 'day of the week at time x'" and then
> turn into "full date" when it's more than a week ago, but this patch
> only has the two modes of "short term" and "long term" and nothing in
> between).

While I do not think this has much to do with "auto", other than
that it changes the representation depending on how far back the
time is to match the taste of Linus automatically, I think the
observation you made about the relative uselessness of "relative in
the long past" is real.  "6 years ago" that does not say if it was
in the morning and that does not even say if it was in the summer
is losing a bit too much information.

Your message made me realize another thing I feel while viewing
"relative in the long past" output.  In "git log --date=relative"
output (especially when the log is "limited" in some way, like with
a pathspec, --grep, -S, etc.) that shows multiple commits, all of
which are labeled "6 years ago", they make me wonder how they are
related to each other chronologically.  Perhaps I am seeing 6
commits, but the earlier four was made all within 20 minutes, and
the fifth one three days later, and the final one a month later,
which may indicate that the first four was the initial round of a
topic, with two "oops, this is a fix" follow-up patches that are
related in one area.  All of them being labeled "6 years ago" would
not give such a clue.

Which makes me wonder if another variant is useful (or at least
"interesting").  What if we chose format according to this rule?

    0. Set the "reference time" to the current time.

    1. Do get_revision() to grab one commit to show.

    2. Show that commit, using timeformat determined as:
       a. if its time is close to the "reference time", then use
          "N hours M minues before that" format;
       b. otherwise, use the default time format;

    3. Update the "reference time" to the timestamp of the commit
       we just showed.

    4. Go back to 1.
    
