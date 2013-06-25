From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Tue, 25 Jun 2013 14:17:20 -0700
Message-ID: <7vtxkl28m7.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
	<CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UracD-0000bN-O6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab3FYVRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jun 2013 17:17:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab3FYVRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jun 2013 17:17:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B2F72B8A4;
	Tue, 25 Jun 2013 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CB24IVpyH1GU
	t1UVUSub5V+Xl4I=; b=c8NolHeBzzOesLI8s1bMchRwFw4dsB0lgrMKcQUq1C1a
	fcatXW3YZ7ttpe/16QBQDfYfev14vgwInERNoaOkLzbnsYnzrfKieMaD+byq61FQ
	I8ELrI3OUs0LCaEWIYU8/98B0OHmjyITrmxs5JOHTu5m7ZKUKISz+Zyb6hffk9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VzpQvr
	30P3IVpn0XuTs4lfuGnbrayZDD255I5Z2JxFIlEVtJATOLdbH2Cgxfzx5KWyyz5I
	o084avWIqB/i1kR306WBsPYYN89WIF3WqmzdxU46rx6OjyZnItlOROuiiSqH3OPj
	1+rF17sWTPgm6c/Z07gdgM9aYtV2HQjQiohp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7034D2B8A3;
	Tue, 25 Jun 2013 21:17:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C037B2B8A1;
	Tue, 25 Jun 2013 21:17:21 +0000 (UTC)
In-Reply-To: <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
	("Vicent =?utf-8?Q?Mart=C3=AD=22's?= message of "Tue, 25 Jun 2013 21:33:11
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FCB3FFC-DDDC-11E2-BAAB-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228991>

Vicent Mart=C3=AD <tanoku@gmail.com> writes:

>>> +               There is a bitmap for each Git object type, stored =
in the following
>>> +               order:
>>> +
>>> +                       - Commits
>>> +                       - Trees
>>> +                       - Blobs
>>> +                       - Tags
>>> +
>>> +               In each bitmap, the `n`th bit is set to true if the=
 `n`th object
>>> +               in the packfile index is of that type.
>>> +
>>> +               The obvious consequence is that the XOR of all 4 bi=
tmaps will result
>>> +               in a full set (all bits sets), and the AND of all 4=
 bitmaps will
>>> +               result in an empty bitmap (no bits set).
>>
>> Instead of XOR did you mean OR here?
>
> Nope, I think XOR makes it more obvious: if the same bit is set on tw=
o
> bitmaps, it would be cleared when XORed together, and hence all the
> bits wouldn't be set. An OR would hide this case.

What case are you talking about?

The n-th object must be one of these four types and can never be of
more than one type at the same time, so a natural expectation from
the reader is "If you OR them together, you will get the same set".
If you say "If you XOR them", that forces the reader to wonder when
these bitmaps ever can overlap at the same bit position.

> To sum it up: I'd like to see this format be strictly in Network Byte
> Order,

Good.

I've been wondering what you meant by "cannot be mmap-ed" from the
very beginning.  We mmapped the index for a long time, and it is
defined in terms of network byte order.  Of course, pack .idx files
are in network byte order, too, and we mmap them without problems.
It seems that it primarily came from your fear that using network
byte order may be unnecessarily hard to perform well, and it would
be a good thing to do to try to do so first instead of punting from
the beginning.

> and I'm going to try to make it run fast enough in that
> encoding.

Hmph.  Is it an option to start from what JGit does, so that people
can use both JGit and your code on the same repository?  And then if
you do not succeed, after trying to optimize in-core processing
using that on-disk format to make it fast enough, start thinking
about tweaking the on-disk format?

Thanks.
