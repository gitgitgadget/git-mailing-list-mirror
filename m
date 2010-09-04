From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Fri, 03 Sep 2010 22:22:57 -0700
Message-ID: <7vlj7ixetq.fsf@alter.siamese.dyndns.org>
References: <4C761EA2.2060904@viscovery.net>
 <OFF09696E1.DC0D98D7-ONC1257793.0070A82E-C1257793.00758522@DCON.DE>
 <AANLkTikqWap4nUamS=bx6oJ7mhUTEkFWpf7Hf=Mv1Ek=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: karsten.blees@dcon.de, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	johannes.schindelin@gmx.de
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 07:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrlDw-0007jM-9o
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 07:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811Ab0IDFXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 01:23:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0IDFXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 01:23:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B117D33C7;
	Sat,  4 Sep 2010 01:23:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yAK6emjns0e9
	5MSGRwMrN8ky+yg=; b=NBDX/mzBQY9zDZ27jg2tX5j1fjFjHUgNEPChk4KhKFn0
	wJ9MMdzNFbwGLbnpcURTnhBEPZkeutQ2b7n4oF8R8b+i2BEvzWITgwOj00nlkPBY
	V+rftY5PZ9TclmqDcLBZrEtjElgVUDl8h5guqHuF/a75V8ebUaqgm2hSVaxOO+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Fo3n7s
	UpVQQi+RNEXbpWW5e/myr6scnSd11U7S2IfEzpmx5aMl9b022ZfDUGce7McpEqUe
	C0+V4e8Tkndos4G2KAn58bcDo4MvdJzov2hTCBxEHRxd33zRNTjug9u/VEUrY5rK
	LeyszcSur8c/3korYQyILVbOTx463F3TXc8UY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01497D33C5;
	Sat,  4 Sep 2010 01:23:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E416BD33C4; Sat,  4 Sep
 2010 01:22:58 -0400 (EDT)
In-Reply-To: <AANLkTikqWap4nUamS=bx6oJ7mhUTEkFWpf7Hf=Mv1Ek=@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 3 Sep
 2010 22\:21\:36 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F40B3FA-B7E4-11DF-983D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155303>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yeah, wasn't the only reason they were ANSI-fied because Junio had
> some script in the todo branch that explicitly used -Werror in
> conjunction with a warning for k&r declerations/

As a matter of principle, I'd really want my compilation to pass withou=
t
any warning, so -Werror is likely to stay.

Having said that, the codepath in question is not something I'd be
compiling myself very often, so I am not in a good position to vetting =
and
maintaining the particular ANSIification patch.  Personally I think the
change to move "internal_function" to the front (which Karsten mentione=
d
is consistent with the way how the same issue is handled elsewhere in
msysgit port) would be cleaner than the change to remove it.

I'd ask folks involved in Windows port to decide.  Sorry for the troubl=
e.
