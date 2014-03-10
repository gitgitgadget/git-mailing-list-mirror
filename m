From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/11] Add interpret-trailers builtin
Date: Mon, 10 Mar 2014 08:27:02 -0700
Message-ID: <xmqqa9cyrs55.fsf@gitster.dls.corp.google.com>
References: <20140306220029.29150.64594.chriscool@tuxfamily.org>
	<xmqq8uslu1bi.fsf@gitster.dls.corp.google.com>
	<loom.20140308T124447-78@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN27H-0003RK-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 16:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbaCJP1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 11:27:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbaCJP1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 11:27:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B01773794;
	Mon, 10 Mar 2014 11:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pAR4fFVvyzuW
	Jc1y+zxgEPMIxxQ=; b=bf4hClh6iLezaiF/7Xh0jr2Q63EAv9/hpADQvSNosMjv
	njGjgpkiOICpMZWOeNbWFtaZY6YQdYnAr62BhnaJs1plmJA0KRiBH2t2jYnw4w3u
	O5mMp+D7O/v1y2ujEexj+yTlQvtTtwJXpHtAD3TWkzLXhqj75QDBAQ/rln95U5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jv2EgU
	2sN2p4R8az+WBeJKXd9t0aRPOOo0u7wsiVgzruJMu4p1gkr7EzYf+tdmo5cpM3Yh
	HrRhzyQKE1g6LVW2+oMfT7FAoBXCAoPT3oBXpuPjzgnqUkm2i7ZmImzD01Ot/G1V
	4jejfTx7jbzPGZTKQ7PgPDnpa4MPH9H8Fm6eY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 123B073793;
	Mon, 10 Mar 2014 11:27:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5069873791;
	Mon, 10 Mar 2014 11:27:04 -0400 (EDT)
In-Reply-To: <loom.20140308T124447-78@post.gmane.org> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
	message of "Sat, 8 Mar 2014 11:54:14 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6EFD2942-A868-11E3-9A66-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243766>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Junio C Hamano <gitster <at> pobox.com> writes:
>
>>=20
>> 	...
>>=20
>> is easier to read and maintain if written like so (with using HT
>> properly---our MUAs may damage it and turn the indentation into
>> spaces):
>>=20
>> 	... &&
>> 	sed -e "s/ Z$/ /" >>expect <<-\EOF &&
>>         Fixes: Z
>>         Acked-by=3D Z
>>         Reviewed-by: Z
>>         Signed-off-by: Z
>> 	EOF
>> 	...
>>=20
>
> How about:
>
>    printf '%s: \n' Fixes Acked-by Reviewed-by Signed-off-by >> expect

Not really.

> This solution scores high marks in both readability and maintainabili=
ty
> in my mind.

I actually considered that approach while I was writing the message
you responded to, but discarded it because it forces us to commit to
the view that we forsee no need to test an output that does not end
with a trailing whitespace.  And I do not think that is a limitation
we want to place on this test.
