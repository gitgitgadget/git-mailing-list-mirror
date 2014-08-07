From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Thu, 07 Aug 2014 12:03:05 -0700
Message-ID: <xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<vpqy4v1vdui.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFSyS-0002ho-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 21:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbaHGTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 15:03:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57630 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbaHGTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 15:03:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D9F02E09E;
	Thu,  7 Aug 2014 15:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FqHP8jLEi/zrVaj6rk+0NzsT5kY=; b=nhDhwH
	gxnKjA7YSroO1KnZqA5cXEQJenwW+tZEQRrIIUbVjYHV90ocQPa05s/Jlj0sUsXZ
	jxMp7LsPlUa/ZBJx6E8gXok9dQF264ndtG94S74lXkEC0qA/lW+gf+eDY/K0Taeq
	BKoP0uYWVuI5Sj8x8MTsRKBqITlMptM4PZ/8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofZbm2U8oxaQ+xiq765vjIOROAFy5WIE
	K6FOy4vrevKelwvHHGU/AcWwNcZp5hVC4fUYo1Hxp50ThRITMGYEr810LJLdYB3w
	68uRDBMwJIlP38DLzf/w6TD4MRiiD8/gXL3JoQJPsmzoU7mk1RwBgDIXJ32juzly
	+rJXSU3mDw0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32AB12E09D;
	Thu,  7 Aug 2014 15:03:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D3AF2E08F;
	Thu,  7 Aug 2014 15:03:07 -0400 (EDT)
In-Reply-To: <vpqy4v1vdui.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	06 Aug 2014 17:26:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 776B043C-1E65-11E4-85E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254988>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1406,8 +1406,14 @@ extern int git_config_get_bool(const char *key, int *dest);
> [...]
>> +struct key_value_info {
>> +	const char *filename;
>> +	int linenr;
>> +};
> [...]
>> diff --git a/config.c b/config.c
>> index cf9124f..427850a 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1224,11 +1224,6 @@ int git_config_with_options(config_fn_t fn, void *data,
>>  	return ret;
>>  }
>>  
>> -struct key_value_info {
>> -	const char *filename;
>> -	int linenr;
>> -};
>> -
>
> Why is this needed? Are you now using key_value_info outside config.c?
> Or is it a leftover from a previous experiment?

Has this been resolved in the new round?
