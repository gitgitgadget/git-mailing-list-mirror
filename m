From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] tree-diff: remove special-case diff-emitting code for empty-tree cases
Date: Tue, 25 Mar 2014 10:45:01 -0700
Message-ID: <xmqq8urymaua.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<dad40b2cf785e5951c105cac936d86a7bc6db8a3.1393257006.git.kirr@mns.spb.ru>
	<xmqqior3pa7h.fsf@gitster.dls.corp.google.com>
	<20140325092040.GA3777@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSVSI-0004uD-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbaCYRpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 13:45:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070AbaCYRpI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 13:45:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF721769C8;
	Tue, 25 Mar 2014 13:45:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MLRoDDC4Fm/6
	Azpmu4qrYtaS4tc=; b=AyhwVCDsLFxih+/dRrseK5cupxX3mgmTX/6JZBwNvZOC
	DeCmlbEpRcCWng/w7rJQa1Rx5eWmAtHPPcuL2YbisjTToueLFgmUEKMLphPChIdH
	jVsHiANWvVwIO9sjGGPTl/2GBNeqyzD0wnGu4CouguB7AZJEbFh8p9Nw37Jf9Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HhaxHW
	1u4noJlhO8g8ojOozrE8+C0KCz6s3g0R8p0zy/Xwk9XLF245kfgrOVFmlqRiOpls
	kTplwZI2rQOMiEMPXeepnJy+BJUaQ7s8qqOf0MWe7CHEQ393tZ3a+AbLP9woP+nc
	5ZNLKQ769+T9FRPEPDXHDiJDy3RMtCFmdvjc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DE0B769C5;
	Tue, 25 Mar 2014 13:45:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCC1C769BF;
	Tue, 25 Mar 2014 13:45:06 -0400 (EDT)
In-Reply-To: <20140325092040.GA3777@mini.zxlink> (Kirill Smelkov's message of
	"Tue, 25 Mar 2014 13:20:40 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33E7A15A-B445-11E3-BBC0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245143>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

>> >  static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_d=
esc *t2)
>> >  {
>> >  	struct name_entry *e1, *e2;
>> >  	int cmp;
>> > =20
>> > +	if (!t1->size)
>> > +		return t2->size ? +1 /* +=E2=88=9E > c */  : 0 /* +=E2=88=9E =3D=
 +=E2=88=9E */;
>> > +	else if (!t2->size)
>> > +		return -1;	/* c < +=E2=88=9E */
>>=20
>> Where do these "c" come from?  I somehow feel that these comments
>> are making it harder to understand what is going on.
>
> "c" means some finite "c"onstant here. When I was studying at school =
and
> at the university, it was common to denote constants via this letter =
-
> i.e. in algebra and operators they often show scalar multiplication a=
s
>
>     c=C2=B7A     (or =CE=B1=C2=B7A)
>
> etc. I understand it could maybe be confusing (but it came to me as
> surprise), so would the following be maybe better:
>
>         if (!t1->size)
>         	return t2->size ? +1 /* +=E2=88=9E > const */  : 0 /* +=E2=88=
=9E =3D +=E2=88=9E */;
>         else if (!t2->size)
>         	return -1;	/* const < +=E2=88=9E */
>
> ?

Not better at all, I am afraid.  A "const" in the code usually means
"something that does not change, as opposed to a variable", but what
you are saying here is "t1 does not have an element but t2 still
does. Pretend as if t1 has a virtual/fake element that is larger
than any real element t2 may happen to have at the head of its
queue", and you are labeling that "real element at the head of t2"
as "const", but as the walker advances, the head element in t1 and
t2 will change---they are not "const" in that sense, and the reader
is left scratching his head seeing "const" there, wondering what the
author of the comment meant.

"real" or "concrete" might be better a phrasing, but I do not think
having "/* +inf > concrete */" there helps the reader understand
what is going on in the first place.  Perhaps:

        /*
         * When one side is empty, pretend that it has an element
         * that sorts later than what the other non-empty side has,
         * so that the caller advances the non-empty side without
         * touching the empty side.
         */
        if (!t1->size)
                return !t2->size ? 0 : 1;
        else if (!t2->size)
                return -1;

or something?
