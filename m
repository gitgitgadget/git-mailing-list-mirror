From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/10] ce_compare_data() did not respect conversion
Date: Wed, 04 May 2016 00:23:06 -0700
Message-ID: <xmqqfutyjnhh.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1461942126-16296-1-git-send-email-tboegi@web.de>
	<xmqqvb30w29z.fsf@gitster.mtv.corp.google.com>
	<a571e222-68db-3dc1-1a94-d6b47feaf84d@web.de>
	<xmqqtwigtjfg.fsf@gitster.mtv.corp.google.com>
	<xmqqpot4s1ap.fsf@gitster.mtv.corp.google.com>
	<55d60bb1-8626-4c97-630c-1a9f114c46b4@web.de>
	<xmqqbn4nngci.fsf@gitster.mtv.corp.google.com>
	<57297579.6060805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 04 09:23:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axr9b-00080R-CH
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209AbcEDHXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 03:23:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751501AbcEDHXK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 03:23:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 815E8FB63;
	Wed,  4 May 2016 03:23:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c31wE9V6NZfx
	Tm7+p5OPJ8bm1Io=; b=naCk4GK9DFyNI8WfrS/3lk4yfOmkVaei/7L3hVjGm7HL
	TOHX5lXC7VVppeYIlljDun2pvJvcoxMMvV7k+DvHPNpOZU2z5YAsYPXaE6K7ZudC
	JjOpDv/uQJNt26fppzFWbKTVJVXwbJ8xnAnGuWoQpzSHAdrFfmFdX9Vw0BYfy94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IOhwRU
	aJOEmc/O2NslrBEBpFKyzKB2KlLDSzY1i67B75VU/kyQZa4Og1Zr41hc5JZpSOxJ
	DkKx815LdYclcaJSytlauGTUyK0d3yEw7XCbLOZ25Ty/BiTVhLVXZYa6k96EzKPs
	BYhB7njVrDpS2MDnIFcv+HxYzXb4/i883n15k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 790AAFB61;
	Wed,  4 May 2016 03:23:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA5E4FB60;
	Wed,  4 May 2016 03:23:07 -0400 (EDT)
In-Reply-To: <57297579.6060805@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 4 May 2016 06:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C9C8000-11C9-11E6-845D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293503>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Sure, I wasn't saying 1-4 looked wrong at all.  I was wondering why
>> the ones in the middle, especially 7, shouldn't be moved forward
>> together with them.
> The main reason is, that 7 breaks t6038 under Windows.
> (And I discovered that too late :-(
> And as Windows is the platform being most interested in CRLF handling=
,
> I need to re-do some work.

OK.

Let's separate 01-04/10 into a different topic and give it its own
name; tb/convert-eol-autocrlf was the name I picked primarily for
07/10 but 01-04/10 are not about that fix.  Both 02 and 04 are about
autocrlf (the former is "core.eol is irrelevant when core.autocrlf
is there", the latter is "fix core.autocrlf used in conjunction with
ident conversion"), so how about tb/autocrlf-fix or something?

And then we can merge that to 'next' and to 'master' while we find
solution to 07/10 which is really the more important bit.

As to (the inverse of) 10/10, I am starting to suspect that the
correct solution (which may not be the "right" one, though) would
involve teaching write_entry() that not everything it writes out can
be marked up-to-date in the index.  A naive implemention would be to
pass what it writes out to the filesystem through convert_to_git()
and see if the result matches the blob in the index, and if it does
not match, make sure ce_mark_uptodate() is not called, perhaps by
not calling fill_stat_cache_info(), or manually dropping CE_UPTODATE
bit at the end of the function.

A naive implementation however may turn out to be way too expensive
to use as-is, I am afraid.  Possible ways to speed up would be to
skip this "refrain from marking up-to-date" hackery when conversion
is known to be well behaved.  For example, with the EOL handling
updated with your series, we may be able to say that the stock
to-git and to-working-tree pair is guaranteed to roundtrip even with
EOL conversion, ident conversion as long as there is no end-user
defined clean/smudge filters.  With such an optimization, the result
might perform with acceptable performance penalty in common cases.
