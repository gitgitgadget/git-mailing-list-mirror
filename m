From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] blame: Odd -L 1,+0 behavior
Date: Fri, 16 Jul 2010 15:33:10 -0700
Message-ID: <7vmxtrqcpl.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-6nck9aVKPTwOy_PmrGUs1iS8ruqzIORbf8jb@mail.gmail.com>
 <7vy6dbqghl.fsf@alter.siamese.dyndns.org>
 <AANLkTinSO3S4hjuvzSOfEBwBEL8_amk7uM2-_LKMtE8k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 00:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZtTB-0003vS-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 00:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab0GPWdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 18:33:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0GPWdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 18:33:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8706CC34E0;
	Fri, 16 Jul 2010 18:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3oIEn6wL6a6T
	yLBPekh5k/B8TII=; b=BC6EGJk+mawFYhmwcF9CJdymHzlN+zOZ17YeE8UO24Xa
	mMHHy100KfqEYxAzLYRlcDLIP+bjzbHHYaSXV30TWtauC5W/NSWdfNHrhwNqQ+fK
	jHZHn5h3iTO0Tlv5hbO4cElo2d5VeUighZRCBuu1c6pcce1kfiDvC0lYPH6XK6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G2Q3Z7
	lZIy1TyIucA/ReflAr2HYxCzFRaHTSQeBlkPiRWqZAAOXjZVnPHGTAfTVOQM1Jpy
	Jyivp+6WyhDkhyKC1Gv9O7gfeSVi/qH8cw/FHI4Q/W38Q3LTafjh8VWvvvXy7sWN
	vHr9STquH5/taMbUK+X6oxKEUjfZxxgw25MM8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 655C1C34DD;
	Fri, 16 Jul 2010 18:33:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40664C34DB; Fri, 16 Jul
 2010 18:33:12 -0400 (EDT)
In-Reply-To: <AANLkTinSO3S4hjuvzSOfEBwBEL8_amk7uM2-_LKMtE8k@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 16 Jul
 2010 21\:25\:58 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FE0A450-912A-11DF-8CD8-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151176>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> As a side effect of the internal implementation of this logic -L 5,3
>> means the same thing as -L 3,5 but that is not an intended nor
>> documented behaviour.
>
> How should L 5,3 and 3,5 work? Should the former give an error?

"-L 3,5" would choose "lines 3,4, and 5" (both ends inclusive).  Curren=
tly
"-L 5,3" does the same thing but as I said, that is not an intended nor
documented behaviour, and if you are tackling this area to tighten the
parsing and error diagnosis, I think it is reasonable to error it out.

>>> Shouldn't this either print nothing, er be an error:
>> (multiple)
>>
>> The parsing code is lax in the sense that rejecting nonsensical inpu=
t like
>> "-L 10,-100" and "-L 2,+0" as an error was not considered a primary =
goal.
>> The only error checking it does is to make sure it does not parse nu=
mbers
>> that it cannot use (i.e. start from line 30 in a file that does not =
have
>> that many lines).
>
> Do you want a patch to make it less lax?

Be my guest ;-)  Thanks.
