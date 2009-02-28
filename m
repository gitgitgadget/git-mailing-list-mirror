From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Fri, 27 Feb 2009 17:25:48 -0800
Message-ID: <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org>
References: <cover.1235629933.git.gitster@pobox.com>
 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
 <49A88FA7.1020402@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 28 02:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdE0T-0001kS-3x
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbZB1BZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 20:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbZB1BZ5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:25:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZB1BZ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 20:25:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68A0617D6;
	Fri, 27 Feb 2009 20:25:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8A7417D0; Fri,
 27 Feb 2009 20:25:50 -0500 (EST)
In-Reply-To: <49A88FA7.1020402@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sat, 28 Feb 2009 02:13:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD8C253E-0536-11DE-A6E1-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111735>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> -
>> -	} else { /* Classic exact string match */
>> -		/* Yes, I've heard of strstr(), but the thing is *data may
>> -		 * not be NUL terminated.  Sue me.
>> -		 */
>> +	} else {
>> +		/* data many not be NUL terminated; we cannot use strstr() */
>
> That looks fishy to me.  regexec() expects data to be a NUL-terminate=
d
> string, so either the comment is wrong or the regexp case needs to ta=
ke
> better care to add a NUL at the end of the buffer.

Probably yes, but regexp side is not my code and I never use it, so... =
;-)

> In any case, there is also memmem(), which uses the same fast algorit=
hm
> as strstr() in recent glibc versions.  Like this?

Thanks; it would be nice to bench this change.
