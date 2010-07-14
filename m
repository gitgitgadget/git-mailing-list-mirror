From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use dev_t for device id (st_dev) from stat in
 setup_git_directory_gently()
Date: Wed, 14 Jul 2010 07:55:56 -0700
Message-ID: <7voceayuwz.fsf@alter.siamese.dyndns.org>
References: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
 <7voceb2jaw.fsf@alter.siamese.dyndns.org>
 <878w5elvk2.fsf@hariville.hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 16:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ3Ne-0002NL-9X
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 16:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238Ab0GNO4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 10:56:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab0GNO4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 10:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B41C4333;
	Wed, 14 Jul 2010 10:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4y3EQzo6roKiJDm2tsH8+M1kjA=; b=DIqvcx
	bGvem4e+F7+BKtLKAuiBsCJ5lIRxNIAui6CMnKLsVvOxDMXvHbUAmAObTfe9jSM7
	X2EgrAhA7POR/gOE9CKyBtWhvfSSodsj0AMzqJd+YbApvm8RfPsGQGLCdiZP16Ae
	fqRQroUkhtMA3wrOchEA/uIWiHnvchOlf8Fbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/qUMzMbsY8T8QWVXHvapIVbVcFn6SxV
	/DKQptd0pCVTp0W8N58CYjUqpds7+Bkr9Xn58pLjUrVuBZl5X8oMuVWjFLuz8s3t
	BpsxKeaPj/tNJLK70UcAn/b4bDnornxriQfB+CkIzy5Bni2hqPuYODBLp0O86L2D
	0+KS7ln5/Rk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BECB6C4332;
	Wed, 14 Jul 2010 10:56:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF651C4331; Wed, 14 Jul
 2010 10:55:57 -0400 (EDT)
In-Reply-To: <878w5elvk2.fsf@hariville.hurrynot.org> (Raja R. Harinath's
 message of "Wed\, 14 Jul 2010 06\:38\:13 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EABB24A4-8F57-11DF-945E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150993>

Raja R Harinath <harinath@hurrynot.org> writes:

> Hi,
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Raja R Harinath <harinath@hurrynot.org> writes:
>>
>>> The original declaration was int, which seems to cause trouble on my
>>> machine.  It causes spurious "filesystem boundary" errors when running
>>> the testsuite.  The cause seems to be
>>>
>>>   $ stat -c%d .
>>>   2147549952
>>>
>>> which is too large for a 32-bit int type.
>>>
>>> Using the correct type, dev_t, solves the issue.  (Because I'm
>>> paranoid and forgetful, I checked -- yes, Unix v7 had dev_t.)
>>>
>>> Other uses of st_dev seem to be reasonably safe.   fill_stat_cache_info
>>> truncates it to an 'unsigned int', but that value seems to be used only
>>> to validate the cache, and only if USE_STDEV is defined.
>>> ---
>>
>> Makes sense; thanks.
>>
>> Sign-off?
>
> Signed-off-by: Raja R Harinath <harinath@hurrynot.org>
>
> Do I need to resend?

No.  Again thanks for a fix.

>>>  setup.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/setup.c b/setup.c
>>> index 7e04602..87c21f0 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -323,7 +323,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>>  	const char *gitdirenv;
>>>  	const char *gitfile_dir;
>>>  	int len, offset, ceil_offset, root_len;
>>> -	int current_device = 0, one_filesystem = 1;
>>> +	dev_t current_device = 0;
>>> +	int one_filesystem = 1;
>>>  	struct stat buf;
>>>  
>>>  	/*
>>> -- 
>>> 1.7.2.rc2.11.g03e33
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
