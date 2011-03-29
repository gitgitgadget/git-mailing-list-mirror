From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove "bashism" from
 contrib/thunderbird-patch-inline/appp.sh
Date: Tue, 29 Mar 2011 00:09:14 -0700
Message-ID: <7vei5qtnc5.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
 <4D9103D3.5010403@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=81ngel_Gonz=C3=A1lez?= <ingenit@zoho.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4T3S-0008Cp-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab1C2HJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:09:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1C2HJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:09:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D7152631;
	Tue, 29 Mar 2011 03:11:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yvm9lJL/bwFq
	hGKHz9OfCh0wrMU=; b=m8QzuT6V6ONCzW07QMfZRV7ImUfNn8oHVYGdWj4693u/
	beEB9kj/cY9BRY54z9fQQ6daY1i6THB82UEF3zi5Eg8tBj8cElsYq8UdHjLQFm8l
	f9Z1/rVRdAEXtG7UrORVk9xP4eRT1zwNMXkokgmSn0GPITm+/rds8PmTrTQ3RjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sDLmt8
	XDSFrIrmPiQZKONYj/MPTs/9LZGkruWQuDD6XVBUQEY/4wrzaomAvE91OzPIQMAf
	pd7Lh1ZbB5NmYbfM1ff5pA3qDzhLAU1qNV68Mx6XXrCBFEirlN6K+QVDql1XQxnm
	lrylgu/5r5qxVIrzvCQ1C9hmvyBQW+yTalPAw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF530262F;
	Tue, 29 Mar 2011 03:11:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CC4432621; Tue, 29 Mar 2011
 03:11:03 -0400 (EDT)
In-Reply-To: <4D9103D3.5010403@zoho.com> (=?utf-8?Q?=22=C3=81ngel_Gonz?=
 =?utf-8?Q?=C3=A1lez=22's?= message of "Mon, 28 Mar 2011 23:55:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B748A474-59D3-11E0-8167-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170237>

=C3=81ngel Gonz=C3=A1lez <ingenit@zoho.com> writes:

> This is wrong.

Not really.

> You are replacing bash with sh:
>> -#!/bin/bash
>> +#!/bin/sh
>
> but the script still uses bash-specific syntax (aka. bashishms):

Do you mean some of the parts you quoted are bashism?

>>  PATCH=3D$(zenity --file-selection)

Even though ancient shells I grew up with did not have $(), it is a way
backticks should have been written by Bourne from day one.  Historicall=
y,
handling nesting and interraction between double-quotes and backticks
correctly was a nightmare to get right, and different implementations o=
f
shells got them always wrong.  If you use $(), the headaches go away.

These days, we don't know of any POSIX shell that is widely used and do=
es
not understand $().  As such, the above construct is perfectly safe and
even preferred over ``.  Welcome to the 21st century ;-)

>>  if [ "$?" !=3D "0" ] ; then

While I personally do not like this style (I am old fashioned) and woul=
d
probably write:

	if test $? !=3D 0
        then
        	...

or make it even more readable by writing it together with the previous
statement, i.e.

	PATCH=3D$(zenity --file-selection) ||
        ...

myself, it is definitely not bash-ism to use [] for conditionals.  Some
people seem to find it more readable than traditional "test" (not me).

The only major platform that didn't have a reasonable shell was Solaris=
,
but we already have written its /bin/sh off as broken and unusable, and
suggest people to use xpg4 or xpg6 shell (see the Makefile).
