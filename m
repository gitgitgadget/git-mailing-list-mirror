From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/11] Support showing notes from more than one notes
 tree
Date: Mon, 22 Feb 2010 16:21:35 -0800
Message-ID: <7vzl30u7hs.fsf@alter.siamese.dyndns.org>
References: <cover.1266797028.git.trast@student.ethz.ch>
 <d51082ad62153e182298242a2e4b7c3c76000a2e.1266797028.git.trast@student.ethz.ch> <7v1vgc26zd.fsf@alter.siamese.dyndns.org> <201002230025.57975.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:21:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjiXE-0004Ih-HI
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0BWAVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:21:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0BWAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:21:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B26D9CDCE;
	Mon, 22 Feb 2010 19:21:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=quNE7vJ1v3EErkWUFw4a/Ndux94=; b=L9L0140J5jkZSlr3LTSG8U4
	l05WbleeVqlOxW9umXWmxJYMAxOsdK594fhOinmBiVvVeKRUB9938mIrUID/AT8C
	L1piUgbPoi9O5w8WBbTkOLHoovZhQ/ptq3QDiKFQVE8LHf4pEHi+IGB5jgsgWHOu
	RdvWSTExkWfv4pcxz32A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Kc7W4mQwsl7rerDb/YNja9uvZVHwni2InsPndHyoaFtI4BCew
	nKRHMig/Tpuco887ihQUsxZZn4gEAtjQSzFIpm4avoSJCoHmFy/0ySzdCnc7jIZE
	GiHKR/ZzYdgrprdXOSwDajlXZ/FfAkQK1QHgO0Og9u+ok0HJfztBBDxVpc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF39A9CDCD;
	Mon, 22 Feb 2010 19:21:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D976C9CDCA; Mon, 22 Feb
 2010 19:21:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A9AA89A-2011-11DF-B6D8-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140744>

Thomas Rast <trast@student.ethz.ch> writes:

> Umm, since I'm currently working on another reroll that has pretty
> args to add notes refs for display...
>
> On Tuesday 23 February 2010 00:20:06 Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> > +	if (flags & NOTES_SHOW_HEADER_WITH_REF && t->ref) {
>> > +		const char *ref = t->ref;
>> > +		if (!strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
>> > +			strbuf_addstr(sb, "\nNotes:\n");
>> > +		} else {
>> > +			if (!prefixcmp(ref, "refs/"))
>> > +				ref += 5;
>> > +			if (!prefixcmp(ref, "notes/"))
>> > +				ref += 6;
>> > +			strbuf_addf(sb, "\nNotes (%s):\n", ref);
>> > +		}
>> > +	} else if (flags & (NOTES_SHOW_HEADER|NOTES_SHOW_HEADER_WITH_REF))
>> >  		strbuf_addstr(sb, "\nNotes:\n");
>> 
>> It is not clear what the distinction between NOTES_SHOW_HEADER and
>> NOTES_SHOW_HEADER_WITH_REF.  Does anybody still call this function with
>> NOTES_SHOW_HEADER alone without NOTES_SHOW_HEADER_WITH_REF?
>
> No.

Meaning nobody will go through the latter "Notes:\n" codepath?  Then what
is that else clause for?

Perhaps I am not reading your code right in which case this part needs a
bit more commenting?

>> I expected to see "Notes:\n" regardless of the mode if the notes is coming
>> from the default refs/notes/commits tree, but it probably is better to say
>> "Notes (commits):\n" like your patch does.
>
> I special-cased GIT_NOTES_DEFAULT_REF (which is "refs/notes/commits")
> above *at your request* to not change the output in the default case.

> So which way do you want it?

I don't have strong preference anymore with the above code.

If some caller called the latter "always show Notes:" codepath, i.e.
SHOW_HEADER is given but without HEADER_WITH_REF, then my preference would
have been more clear.  A caller that gives HEADER_WITH_REF clearly wants
to show more than one notes (perhaps the user used displayref mechanism)
and it would be better to always say which one in order to disambiguate,
and the special case would not be a good idea.  A caller would not give
HEADER_WITH_REF when the user has refs/notes/commits hierarchy and nothing
else, and the user didn't ask for multiple notes trees shown; in such a
case we should show the good-old "Notes:".

But if everybody calls with HEADER_WITH_REF, no matter what the end user
preference is, then it becomes unclear what the right answer would be.
