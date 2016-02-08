From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/25] transport-helper.c: do not send null option to remote helper
Date: Mon, 08 Feb 2016 12:53:59 -0800
Message-ID: <xmqqziva7wk8.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-4-git-send-email-pclouds@gmail.com>
	<xmqqh9hof4bx.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Az9rx_D0V+p2fEdNi64YJb2g_o0npUk2=wqCL2_moBPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsp1-0008Sg-QL
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbcBHUyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 15:54:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754956AbcBHUyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 15:54:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF75942938;
	Mon,  8 Feb 2016 15:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zSJSMb/Y1Nvw
	2kxHkNWdGtczwko=; b=mVFytTx6K3rZb6TCe6JU7JnBry0nyqyokRHqAyphmQ/0
	G0yH8UctszxwkYE33jUUsPFYKZsI7G4/LHVLHSrLxtj9m4j03O4aKRZJU8OqfaRS
	tOi1x7VfUqxoVMyXIQc2hMyw7TuM3hM62+jqti+xwinuhFpCkDVyIMXPgeGi+hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kklVUn
	JZnk7PHQRn4wdlhmJfhsWcLEh9EIWlWywCvqL4Yv9fZYpTbkU7wEmDVyFqwDTlyA
	kdvahFgcei9eWu5iKRJx3GEz/yMxoYQ9wxlor0WR2xScZVWSBYjKefHy0Y/6znA/
	hA0U0pP3RrvDh/eYsACfNxeNgwth8Q8Ggv0J8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C587D42937;
	Mon,  8 Feb 2016 15:54:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4472A42936;
	Mon,  8 Feb 2016 15:54:02 -0500 (EST)
In-Reply-To: <CACsJy8Az9rx_D0V+p2fEdNi64YJb2g_o0npUk2=wqCL2_moBPQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 6 Feb 2016 16:38:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 155CAFB4-CEA6-11E5-BE4F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285804>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 5, 2016 at 6:22 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>
>> This is even more strange.  Are the current callers broken and some
>> sends value=3D=3DNULL for an option that is not is_bool, resulting i=
n
>> a call to quote_c_style() with NULL?  I somehow find it hard to
>> believe as that would lead to an immediate segfault.
>>
>> Assuming that no current caller passes NULL to value when is_bool is
>> not in effect, there needs an explanation why future new callers may
>> need to do so.  An alternative for a valueless option could be to
>> send "option name\n" instead of the usual "option name value\n", but
>> without such an explanation, readers cannot tell why not sending
>> anything about "name", which is what this patch chooses to implement=
,
>> is a better idea.
>
> The source is backfill_tags() which, in future, resets some transport
> options back to defaults. The current set_option() in there only deal=
s
> with booleans or number (depth). But in future it resets deepen-since=
,
> which is a string.
>
> I think the main reason is, we do not have a way to reset (or unset) =
a
> transport option. Should I keep this commit and explain about this, o=
r
> have a new transport API to reset option?

Addition of new API is OK, but if this commit remains in the
history, it itself has to explain why it is necessary.
