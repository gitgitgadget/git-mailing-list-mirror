From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/13] revert: Propogate errors upwards from
 do_pick_commit
Date: Tue, 21 Jun 2011 13:18:10 -0700
Message-ID: <7vei2n6irh.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-5-git-send-email-artagnon@gmail.com>
 <20110621162232.GI15461@elie> <7viprz8018.fsf@alter.siamese.dyndns.org>
 <20110621193217.GA17390@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 22:18:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7Ot-0002AP-U5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab1FUUSO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 16:18:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab1FUUSN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 16:18:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACCD64F31;
	Tue, 21 Jun 2011 16:20:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L2f8KpZHWcss
	cmse9NweDEqfEaM=; b=WDjwfTMZQYWUCyQ/pFmzUzlT8t7IipaU2cmTPtR/OZnF
	//jleO5w9Ijoc/TtefNZGTjvGQgbnbwmXMTVVaJuXcAXtV153brtHyaNuvizLzP1
	oq+3MjgW3EWkLR/TG4nD/D7uM9NEygTz9CZ4n4O8pZsLkZB8t3pqYOW/l4qep8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H88SrI
	Qzd1doEvU78BtlplpDLBuwZ/R07178Aln7LPkGRk3gyZ79AZX6MyNg1ugju26rmJ
	ez+sRv6DPnTHXPhyUcP+9X3EIbIMMFi1OdLT9VV617dsqCY+3Ep+4kBwwDbk1ihD
	oLyJjBPR83iX0n6bqAWH8OtMNQcjKcZAd4r+I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4D644F30;
	Tue, 21 Jun 2011 16:20:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E076A4F2F; Tue, 21 Jun 2011
 16:20:23 -0400 (EDT)
In-Reply-To: <20110621193217.GA17390@elie> (Jonathan Nieder's message of
 "Tue, 21 Jun 2011 14:32:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4F7D298-9C43-11E0-819B-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176196>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jun 21, 2011 at 12:19:47PM -0700, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>>> +	if (res < 0)
>>>> +		die(_("%s failed"), me);
>>>> +	return 0;
>>>
>>> Should the "revert" or "cherry-pick" here be part of the message
>>> marked for translation?  A translator might want to paraphrase to
>>>
>>> 	fatal: failed to cherry-pick
>>>
>>> if that is more natural in the language at hand.
>>
>> Wouldn't such a message file simply say
>>
>> 	msgid "%s failed"
>>         msgstr "failed to %s"
>>
>> IOW, I am not sure what problem you are seeing.
>
> Ah, sorry for the lack of clarity.  What I meant is that the noun
> and verb will be different words in many languages.  There can also b=
e
> problems of subject/verb agreement.  Also "me" is used elsewhere to
> hold the command name as typed on the command line even when LANG
> points to a language other than English if I remember correctly.

Yes, "me" is the name of the command as the user types, so to whatever
language you are translating, it can only be usable as the name of the
command in the message.  Even if your language has a single verb to
express the act of "running the cherry-pick command", say, "distim", yo=
u
cannot translate the message to "failed to distim".  Your message has t=
o
say something like "Sorry, I got a failure while running the 'cherry-pi=
ck'
command", and in English (which is msgid is in) "%s failed" would be go=
od
enough to convey that meaning.

BUT.

> If the message were in revert_or_cherry_pick instead of having two
> identical copies in cmd_revert and cmd_cherry_pick, it would have bee=
n
> less striking (but still a potential problem).

The effort by =C3=86var to switch among totally different message strin=
gs
depending on "action" was going in the direction to actually allow you =
to
translate one of these messages to "failed to distim", and it was lost
earlier in this patch (error-dirty-index). We may want to fix that in
addition to this one.
