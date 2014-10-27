From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Mon, 27 Oct 2014 13:59:18 -0700
Message-ID: <xmqqsii9qleh.fsf@gitster.dls.corp.google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
	<xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
	<xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
	<20141026185909.GC18144@peff.net>
	<xmqqegttfmg0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 22:01:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XirPO-00082W-FK
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 22:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbaJ0VAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 17:00:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752158AbaJ0VAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 17:00:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E03EF1A1D7;
	Mon, 27 Oct 2014 17:00:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bew9IiswSBP46pfhLiFRctr5Vdo=; b=lOGXYB
	AVkuQ0zIc218zHqAIoEsM/6Cb1rKSImy5SIBbC1cdswGYrIA9Jug/wsZRrj4rxaz
	IJ+0XVlTbM2r02M5OaW0fOjRZfFbcsQx0lMqTxqH9yWNkCfNjVg5nBfuvHgIXsSb
	qmHoBJhovio45Ua6EfQGbRhc/6DyGg4e8BiuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XT+r/5dVXvDDRVZl7bxII6YWgz51pG8u
	8rx2cBdMGsgSncsm7mPuRWlzd/hYe8sb5AZBUCBOMwezFxNEEOnqcXPRlNqR0qBP
	6um5MVb/Zu/2vxjpYuuCj7qHxgJxQ2W1adNx33DpSaYcqTQX5GePXRwpg1kKv9Sm
	wUErgxcL2jo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D78691A1D6;
	Mon, 27 Oct 2014 17:00:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 131C51A153;
	Mon, 27 Oct 2014 16:59:19 -0400 (EDT)
In-Reply-To: <xmqqegttfmg0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Oct 2014 10:32:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F0B7780-5E1C-11E4-A1BE-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> diff --git a/sequencer.c b/sequencer.c
>>> index 0f84bbe..1d97da3 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -291,13 +291,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
>>>  {
>>>  	int i;
>>>  
>>> -	strbuf_addstr(msgbuf, "\nConflicts:\n");
>>> +	strbuf_addch(msgbuf, '\n');
>>> +	strbuf_commented_addf(msgbuf, "Conflicts:\n");
>>>  	for (i = 0; i < active_nr;) {
>>>  		const struct cache_entry *ce = active_cache[i++];
>>>  		if (ce_stage(ce)) {
>>> -			strbuf_addch(msgbuf, '\t');
>>> -			strbuf_addstr(msgbuf, ce->name);
>>> -			strbuf_addch(msgbuf, '\n');
>>> +			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);
>>
>> This ends up adding a space followed by a tab. Besides being redundant,
>> it makes my editor highlight it as a whitespace error. I realize this is
>> a pretty minor nit, though.
>
> Interesting ;-)
>
> I do not think it is too hard to teach strbuf_commented_addf() about
> the leading HT, but that would be a separate topic; if squashing the
> SP-HT to HT is worth doing for this codepath, doing it at that helper
> would benefit all callers.

-- >8 --
Subject: [PATCH] strbuf_add_lines(): avoid SP-HT sequence

The strbuf_add_commented_lines() function passes a pair of prefixes,
one for a line that has some meat on it, and the other for an empty
line.  The former is set to a comment char followed by a SP, while
the latter is set to just the comment char.  This is to give a SP
after the comment character, e.g. "# <user text>\n" and to avoid
emitting an unsightly "# \n" in its output.

Teach the machinery to also use the latter space-less prefix when
the payload line begins with a tab; otherwise we will end up showing
"# \t<user text>\n" which is similarly unsightly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 0346e74..88cafd4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -229,7 +229,8 @@ static void add_lines(struct strbuf *out,
 		const char *next = memchr(buf, '\n', size);
 		next = next ? (next + 1) : (buf + size);
 
-		prefix = (prefix2 && buf[0] == '\n') ? prefix2 : prefix1;
+		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
+			  ? prefix2 : prefix1);
 		strbuf_addstr(out, prefix);
 		strbuf_add(out, buf, next - buf);
 		size -= next - buf;
