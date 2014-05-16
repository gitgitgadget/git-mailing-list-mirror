From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: switch core.commentChar if it's found in existing commit
Date: Fri, 16 May 2014 11:53:54 -0700
Message-ID: <xmqqbnuxa725.fsf@gitster.dls.corp.google.com>
References: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
	<1400237982-5842-1-git-send-email-pclouds@gmail.com>
	<xmqqzjihab2b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michal Stasa <michal.stasa@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 21:04:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNQS-0002g5-69
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 21:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbaEPTEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 15:04:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50768 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932431AbaEPTEF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 15:04:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B1D313745;
	Fri, 16 May 2014 15:04:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9vIVhC7ooTtS
	A66dtTCd/uU6lMs=; b=EfFmhK2PmGiZQ3jkjyX5qNwNTFSu3TjTS18dxJKj0O/e
	jYKKKgbAtHAeHNp+SUJe8DlVt0YVo+6LedOGOrwgl5GusMt0EPAcsY/e8cNV7P+E
	Vh6pThWGo37tAkbueP4/Un7WnsYuydJDZaL1b29qr80jFUIfrog9C+6Cmkdy6yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EmVIgX
	qg0t8aRXJGncSLfRR35j5aGi25G5hQq0e6nQXDUJWOzGxGfcVGfseuQ6fyn3JWpa
	uOwLjUDZ7HzfQndt5Er9R6dRalJyfaxcJ4ifPPdxs8hPmpum6/Z2xqqec366QTHg
	bg9SM3+WW3wgwlvr9dInnIwU95M5Roq5wxoKQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EACB13744;
	Fri, 16 May 2014 15:04:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EA17617FBF;
	Fri, 16 May 2014 14:53:55 -0400 (EDT)
In-Reply-To: <xmqqzjihab2b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 16 May 2014 10:27:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E9299EA-DD2B-11E3-9463-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249413>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> If we need to use core.commentChar and it's already in the prepared
>> message, find another char among a small subset. This should stop
>> surprises because git strips some lines unexpectedly. Of course if
>> candicate characters happen to be all out, this change does not help=
=2E
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  On Fri, May 16, 2014 at 5:28 PM, Duy Nguyen <pclouds@gmail.com> wro=
te:
>>  > But maybe git should detect that the
>>  > current commit message has leading '#' and automatically switch t=
o
>>  > another character..
>>
>>  Something like this. Lightly tested.. I know there's a small bug..
>>
>>  builtin/commit.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 6ab4605..70ceb61 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -593,6 +593,32 @@ static char *cut_ident_timestamp_part(char *str=
ing)
>>  	return ket;
>>  }
>> =20
>> +static void adjust_comment_line_char(const struct strbuf *sb)
>> +{
>> +	char candidates[] =3D " !@#$%^&|:;~";
>
> Did you really mean to add a SP to the candidates?

Please ignore this noise.  I realized that the SP is there only to
be overwritten in the meantime, and this is an old message sent out
before that realization, just emerging from my mail provider's
outbox.
