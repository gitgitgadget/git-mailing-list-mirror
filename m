From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Sat, 01 May 2010 12:54:24 -0700
Message-ID: <7v7hnn4cun.fsf@alter.siamese.dyndns.org>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com>
 <7vhbmr5ym4.fsf@alter.siamese.dyndns.org> <4BDC63FB.7060202@grant-olson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: kgo@grant-olson.net
X-From: git-owner@vger.kernel.org Sat May 01 21:54:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Ilr-0004zi-34
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab0EATye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:54:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab0EATyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:54:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BC85AFA85;
	Sat,  1 May 2010 15:54:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZbfAST5NqQutD3PkWamA1d06vg=; b=MXIus+
	vjvjoZdi7tEDTIxylvZeob8c5SjusSFvVW0z8ulXpbPDFa+uA6ngSUdRr5Ht/RUW
	h97bN+hKP6Z3eD7mb2uPCwhLhKZl/tDhJ3LM5LplPmsc9ETTRB4WI7qAZ4TPQUMN
	BseOSu7/gvL7WfbH73mUxvSXg37Q+HM6sO/uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=efi8cLOd5pByPacrTQUQ1cuyw02jFHkY
	/EV5o+dVppktrDiTdwALKBvOc/kJ9i9nI1U1Va8OyI9Id6EsWysFuvqpiLabSka0
	gY1l8IcVhY9Jox1ySMr2IGg6fh8I0dKSQQ1FuZynbDjld80c6DLFWf53Jb3w1J+E
	AX5fzd7AIls=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB57DAFA84;
	Sat,  1 May 2010 15:54:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 369FEAFA83; Sat,  1 May
 2010 15:54:26 -0400 (EDT)
In-Reply-To: <4BDC63FB.7060202@grant-olson.net> (Grant Olson's message of
 "Sat\, 01 May 2010 13\:25\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5ADEDDD4-555B-11DF-8DD3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146116>

Grant Olson <kgo@grant-olson.net> writes:

> On 5/1/2010 1:18 PM, Junio C Hamano wrote:
>> A Large Angry SCM <gitzilla@gmail.com> writes:
>>>
>>> Why not fall back to just the email if the full lookup fails?
>> 
>> Thanks; I like that suggestion a lot better.  Grant's suggestion does not
>> make the lookup "less fragile", but actually makes it less reliable for
>> people with the same address with different spellings of name and want to
>> choose which one to use per project.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Unless I'm mis-understanding you, the does the opposite of that.  It
> finds your gpg key based on your git email, ignoring your git name, so
> that different spellings of the name between gpg and git become irrelevant.

If I have two keys like these:

    Junio C Hamano <gitster@pobox.com>
    Junio Hamano <gitster@pobox.com>

and I have the latter set in .git/config to use for the project I am
working on, your patch picks one at random, making the process less
reliable.

AFAIU, ALASCM's suggestion was to first try the current method (which
reliably picks what I told git to use by specifying user.name), and only
if that fails, i.e. if I do not have neither of the above two keys but
only have a key named like e.g.

    Git Panda <gitster@pobox.com>

then use only the e-mail as you wanted to, but do so purely as a
fallback.

Which I found quite reasonable.
