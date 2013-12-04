From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Wed, 04 Dec 2013 10:11:20 -0800
Message-ID: <xmqqeh5slc53.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-4-git-send-email-krzesimir@endocode.com>
	<CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 19:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGv2-0008BK-GE
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553Ab3LDSLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 13:11:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab3LDSLX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 13:11:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 616AA56443;
	Wed,  4 Dec 2013 13:11:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ET5EISJ56fjG
	j3zpYs9p8kE4R5Y=; b=O2vX5WqhuliTPfNU+TyLJkcIsx7dGp5QKi0jhT95+1Me
	YGld6DRc0Zl468YUxSx0onDo7buHtZYHvgHd/5xKySRIfM0MA5MtxgdyqGuVcmRF
	MSb8Yn4uww6D+OaJg/bO3FUwpEshNn7W2bNg5VW1mMuyNR5M1Eyxt19mNaPP7sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P76hzp
	wIbAqJCqr7IctgiG9swAxJAFnwlYfPmmXhrcVYkZonn9SpInhwjWM8g3H1czeDvt
	0tu0nR57j3yWrYZc3uIgNb1gSgLBfCulShDWDeAgO8arE+Dgt9mlR8JR8WlouS5Z
	8RFKUDLMubI0j+bLuROwMXiQjx+oQgDUEoj7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED9D56442;
	Wed,  4 Dec 2013 13:11:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27E6E56440;
	Wed,  4 Dec 2013 13:11:22 -0500 (EST)
In-Reply-To: <CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 4 Dec 2013 17:07:08
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B0F58BC-5D0F-11E3-A696-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238798>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
>
>> Users of validate_* passing "0" might get failures on correct name
>> because of coercion of "0" to false in code like:
>> die_error(500, "invalid ref") unless (check_ref_format ("0"));
>
> I would say that the problem was that validate_sth() subroutines retu=
rned
> value of parameter if it was valid, which could be a problem if said =
value is
> false-ish (e.g. validate_refname("0"), or validate_pathname("0")).
>
> Returning undef on invalid data newer was a problem, using 'return $i=
nput;'
> on valid input was, especially that validate_sth() functions were eve=
r used
> in a conditional:
>
>   if (!validate_sth($param)) {
>       die_error(...)
>   }

Correct, and I think that is exactly what the above three lines in
the proposed log message says.

> While at it validate_sth() is not a best name for boolean predicate:
> is_valid_sth() would be better, I think.

Yeah, I tend to agree.  As we are doing a whole-sale API clean-up in
this patch, we might as well do that at the same time.

>> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
>> ---
>>  gitweb/gitweb.perl | 45 +++++++++++++++++++++++++------------------=
--
>>  1 file changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 67415b9..3434602 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1419,63 +1419,68 @@ sub href {
>>  ## validation, quoting/unquoting and escaping
>>
>>  sub validate_action {
>> -       my $input =3D shift || return undef;
>> -       return undef unless exists $actions{$input};
>> -       return $input;
>> +       my $input =3D shift;
>> +
>> +       return 0 unless defined $input;
>> +       return 0 unless exists $actions{$input};
>> +       return 1;
>>  }
>
> The only change that needs to be doe is replacing
>
>            return $input;
>
> with
>
>            return 1;
