From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Thu, 07 Aug 2014 21:35:48 +0200
Message-ID: <vpq61i4nld7.fsf@anie.imag.fr>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<vpqy4v1vdui.fsf@anie.imag.fr>
	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFTUt-00026w-QD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 21:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbaHGThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 15:37:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50712 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbaHGThF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 15:37:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s77JZktN014414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 21:35:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77JZmaA004786;
	Thu, 7 Aug 2014 21:35:48 +0200
In-Reply-To: <xmqq8un0ktqu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Aug 2014 12:03:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Aug 2014 21:35:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77JZktN014414
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408044951.81052@K0h5pclXJohkD9yFdmDbvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254991>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> --- a/cache.h
>>> +++ b/cache.h
>>> @@ -1406,8 +1406,14 @@ extern int git_config_get_bool(const char *key, int *dest);
>> [...]
>>> +struct key_value_info {
>>> +	const char *filename;
>>> +	int linenr;
>>> +};
>> [...]
>>> diff --git a/config.c b/config.c
>>> index cf9124f..427850a 100644
>>> --- a/config.c
>>> +++ b/config.c
>>> @@ -1224,11 +1224,6 @@ int git_config_with_options(config_fn_t fn, void *data,
>>>  	return ret;
>>>  }
>>>  
>>> -struct key_value_info {
>>> -	const char *filename;
>>> -	int linenr;
>>> -};
>>> -
>>
>> Why is this needed? Are you now using key_value_info outside config.c?
>> Or is it a leftover from a previous experiment?
>
> Has this been resolved in the new round?

Tanay explained in another subthread why this was needed. For callers
iterating over the string_list who want to get the file/line info, they
need to be able to cast the void * pointer to struct key_value_info *.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
