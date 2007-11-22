From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Authenticate only once in git-send-email
Date: Thu, 22 Nov 2007 11:07:25 +0100
Message-ID: <C0E02CFE-F6E6-4902-8BA1-D6AC02F1C04F@wincent.com>
References: <1195648505-21653-1-git-send-email-win@wincent.com> <7vwssa7jii.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8yq-0001sa-Ij
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXKVKHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXKVKHm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:07:42 -0500
Received: from wincent.com ([72.3.236.74]:57146 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXKVKHk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:07:40 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMA7QaM009952;
	Thu, 22 Nov 2007 04:07:27 -0600
In-Reply-To: <7vwssa7jii.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65770>

El 22/11/2007, a las 9:48, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> This commit teaches git-send-email to authenticate once and only =20
>> once at
>> the beginning of the series.
>
> Ok.  What does $smtp->auth() return?  Presumably a true value,

True on success, false on failure.

> but I do not find it the best coding style to hide a call made
> primarily for its effects not for its return value behind a
> conditional assignment to a boolean.  Eek.
>
>> 		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
>> -			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp-=20
>> >message;
>> +			$auth ||=3D $smtp->auth( $smtp_authuser, $smtp_authpass ) or die=
 =20
>> $smtp->message;
>> 		}
>
> Perhaps something along the lines of...
>
>> 		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
>> 			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp-=20
>> >message;
>> +			undef $smtp_authpass;
>> 		}
>
> ... or using a separate boolean variable "my $auth_happened"
> may be more appropriate.

Of the alternatives you suggest, I think an "$auth_happened" or =20
"$auth_done" flag is probably the nicest/cleanest.

> But I am just saying this; I do not care _too_ deeply about it.
> Will apply as-is.

Yes, I don't really care either. My reasoning for doing it the way I =20
did is that I'm not much of a Perl hacker so I basically wanted to =20
make the change as minimally invasive as possible (in this case =20
prepending "$auth ||=3D "). But above all, all that I really care about=
 =20
is that the problem gets fixed.

Cheers,
Wincent
