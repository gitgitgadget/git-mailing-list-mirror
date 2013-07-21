From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 22:53:36 -0700
Message-ID: <7vr4essbkv.fsf@alter.siamese.dyndns.org>
References: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
	<51EA7D58.3050800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsunanet@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 21 07:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0mao-0006p1-W9
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 07:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab3GUFxn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 01:53:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970Ab3GUFxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 01:53:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30AB12A9A4;
	Sun, 21 Jul 2013 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YLbdZUVjHbxi
	Xgn2l+TTX8SE+5I=; b=WJcLg4PaDuFldKHb08JmBzZszP4IXawSEyzNTthepINq
	C72bmg1avE6LiRpHLXWK+UwoSUyXPMwc8C9QP7NNouVjO2QOzb2kr0GfPoH5e4kL
	jtD7IUEYJ/xAFsQmAz+KlMt0EcfcqgduKXSMJEv9lq2OnO5YP/Wp7eQJoarSP7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vj8wwX
	sGh5toUGHm26yali7DyafsGESOmHl+/HJNg2GEEP8O1EMbareINRWsRkUhmdDF1W
	yhXigZfNazav2dQxQc6LftKS2d6giaipANLLxlXq8V8E7IShPv1FUgeOjQoMF6DN
	nmgbul4SHgIQVm8L/Sc3L1WXoecNSrXKDs7vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BC62A9A3;
	Sun, 21 Jul 2013 05:53:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 861412A99F;
	Sun, 21 Jul 2013 05:53:38 +0000 (UTC)
In-Reply-To: <51EA7D58.3050800@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 20 Jul 2013 14:06:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3B558D2-F1C9-11E2-9801-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230916>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2013-07-20 09.49, Benoit Sigoure wrote:
>> +#ifdef __APPLE__
>> +// On OS X libc headers don't define this symbol.
>> +extern char **environ;
>> +#endif
>> +
> A more generic approach could be:
>
> In the file "config.mak.uname": Define a variable in the Darwin secti=
on like this
> NO_EXT_ENVIRON =3D UnfortunatelyYes

Actually, it is _wrong_ for us to rely on system header files to
define this symbol for us.  Declaring "extern char **environ" is
responsibility of the user programs (like us).

When _GNU_SOURCE is defined glibc header (I think it is unistd.h)
seem to define it for us.

Perhaps the correct fix is to revert ec535cc2 for everybody, and if
MinGW needs such a workaround, do it inside #ifndef MINGW?
