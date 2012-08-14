From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Tue, 14 Aug 2012 07:56:37 -0700
Message-ID: <7vipcl8qu2.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <000f01cd79eb$2a0b6e00$7e224a00$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1IY9-0004iu-VX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 16:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349Ab2HNO4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 10:56:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330Ab2HNO4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 10:56:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE32765B;
	Tue, 14 Aug 2012 10:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i6xN3bG64LvvzW5I0ZkStK1hf9E=; b=OqkoyT
	KkqsZ6zJtOYtIhxMA6O0QG0L7K4aUBZfZ9UDS+ZSMtxtDiUlgnXuNsVZB4n9tNSU
	UzAkZaaB0lTsUZCek6QRVsJSDF7bvTYA3oS98/g/2KMppqT0u/FQJCB4yu9OqT+z
	0/T47DRTn67sQkrlLLHnIvgNinQlgH1S1ZUhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ru73keH4ft4LEuSLiYsGYqk6BVhTaTa5
	V9UOWldtl5omGiYSTNT6PxcGBrVEm1QPQRQGwtlbnlCKoasbzuh2g6pSCeL3p/gx
	GtIyt0qJl9G/mwxs/2XahdZ2SFuRdHv8US9s1AK427tlS+k9UAmV5FlxpoTxaTtD
	UJuXlSwPXCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A50A765A;
	Tue, 14 Aug 2012 10:56:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBA937659; Tue, 14 Aug 2012
 10:56:38 -0400 (EDT)
In-Reply-To: <000f01cd79eb$2a0b6e00$7e224a00$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 14 Aug 2012 09:05:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 402B85C0-E620-11E1-AB7B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203403>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> /usr/local/bin/diff -EBbu ./git-compat-util.h.orig ./git-compat-util.h
>> --- ./git-compat-util.h.orig    2012-07-30 15:50:38 -0500
>> +++ ./git-compat-util.h 2012-08-10 09:59:56 -0500
>> @@ -74,7 +74,8 @@
>>  # define _XOPEN_SOURCE 500
>>  # endif
>>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__)
>> && \
>> -      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
>> +      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) &&
> \
>> +      !defined(__TANDEM)
>>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
>> needs 600 for S_ISLNK() */  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L
>> needs this */  #endif @@ -98,6 +99,11 @@  #include <stdlib.h>  #include
>> <stdarg.h>  #include <string.h>
>> +#ifdef __TANDEM
>> +# include <strings.h> /* for strcasecmp() */
>> +  typedef long int intptr_t;
>> +  typedef unsigned long int uintptr_t;
>> +#endif
>>  #include <errno.h>
>>  #include <limits.h>
>>  #include <sys/param.h>
>
> This one still stands though, unless someone can come up with a better idea?

This hunk looks unobtrusive and obviously will not impact other
platforms, which is good.
