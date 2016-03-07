From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: show reference pointed by new tags
Date: Sun, 06 Mar 2016 17:05:57 -0800
Message-ID: <xmqqwppfrtai.fsf@gitster.mtv.corp.google.com>
References: <1457303694-16153-1-git-send-email-eric@engestrom.ch>
	<xmqq60wzta2s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
X-From: git-owner@vger.kernel.org Mon Mar 07 02:06:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acjcd-0006sx-41
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 02:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbcCGBGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 20:06:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751221AbcCGBGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 20:06:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DBD54A28B;
	Sun,  6 Mar 2016 20:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Wu+CLbIxgRPcX+/H3/QjKgTjM4=; b=HoByL1
	i05ZUPfvUhFlbEHnISixt+H2jWmAPYTMNi3DmI3FykuCTyB2bLgVSaijnwtn269k
	LE0mSIioqw/V+Mgxfl6HR2zDmU9EfsUl6YMfiPrS80IU/HX9bZH+0kbeyr5u8Gl6
	ydciSgb8+tYVtt7ejUTlbvROz+EEXYRuBRKbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MWnIaZuaI/SaNU18U8UmgFWhuI9MS56h
	uwg9qKlJLfP5DTR9lGmAOHvgle24rXruLe9iiqa8F43RrHlQx+yc2nD/verRMHEL
	KGCQBwyHHIjeGqW+jByBoTWdIytwP+pUBVBSD51oYsfnB0lEA0IlVCs+njsaIRf4
	jzqccHi0jBs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55CE34A288;
	Sun,  6 Mar 2016 20:05:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF4454A286;
	Sun,  6 Mar 2016 20:05:58 -0500 (EST)
In-Reply-To: <xmqq60wzta2s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 06 Mar 2016 16:18:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0A6C9F8-E400-11E5-9532-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288374>

Junio C Hamano <gitster@pobox.com> writes:

>> This is my first dive into git's code, so it's likely I'm not doing things
>> right. The first candidate for that is the literal `7`,...

Actually, the first candidate is not related to any code, but that
you did not explain "why" in your log message.

I raised two issues with your change in my response, which are (1)
loss of convenience (i.e. why would a user want to type fc77dbd when
v4.5-rc6 is easier to remember) and (2) loss of information
(i.e. renaming fetch loses the assurance from the report that v1.0
did indeed copied to his/v1.0).  Both of these things tell us that
the change only makes the result worse.

But I am sure you didn't make this change to make the resulting
system worse.  That is why I asked "why is this an improvement?" and
that is _not_ a rhetorical question (i.e. I wasn't making a
statement: "this cannot possibly be an improvement").  You must have
thought that the user would benefit in some way if the report showed
a raw abbreviated object name there.  But you failed to say what
exactly that benefit is, and I couldn't guess, and that is why I
asked.

Because a raw abbreviated object name alone is a fairly useless
piece of information (i.e. to get anything meaningful, the user
needs to give it to some Git command like "git log", "git show",
etc.), and the resulting local tag name is equally usable as a raw
object name is if the user is going to use these Git commands to
learn more about the object anyway, the only semi-sensible
justification I can think of offhand for this change is that the
user somehow already has a list of raw object names for the refs
expected to be updated available and showing the raw object name in
the update-local report may serve as an assurance that the right
object was fetched.  Perhaps there was an announcement e-mail
message that said fc77dbd is the object name of the v4.5-rc6 tag,
and the user can see that object was fetched without having to run
extra Git command, or something like that.

But I am merely guessing from the your patch text what the reasoning
behind the change was and you are the one who had the original
reason why you needed this change, so your "why" may be a lot more
useful use case than the one I made up and called "semi-sensible"
here.  The proposed log message needs to explain your "why".

And if you explained "why", you may have heard other people agreeing
with you that this new piece of information is nice to have.  They
may even have helped you by suggesting to add this extra information
somewhere in the output, instead of replacing existing information
in the output (which would lead to loss of convenience and
information).

Anyway, welcome to Git development community.
