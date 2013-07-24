From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Wed, 24 Jul 2013 12:01:26 -0700
Message-ID: <D8BC48D1-195D-4F08-876C-FA592802A12C@gmail.com>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79> <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79> <20130724065933.GC30074@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 24 21:01:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24Jb-0000M3-C2
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab3GXTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 15:01:31 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:32856 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3GXTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:01:30 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so10084886pbc.32
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=wZwvzpgvrdtAWk8taF15m0tRTL2k/S4YqAcbrRlQE/U=;
        b=GFEBr/mLFFU6SFugZn315FLG9cP2B0cm3h6iWGDoFO19YPIdDHOMozyLeEVV28UuQr
         4sNGL9ZYRKbEMBi/eJe6xKmBY70kB+x39qHU9hKdojK8/+NEpgPjjZ5KMUIkbHIcVrOq
         QQr+vQe/+RU//g5e1zXTfn0o+GpbdY6CT7wxiWV0RG2sy78jo37drryA07E/LA8VsKuT
         1CLnABdc8MNl5A0uPwSOz8WCuvFWOsySeQLQHDSjDxChQVBKBOlbY8gNuBwSNSbTRAZo
         hOmkZAEAtQNfpt+Zohaw6r7SN9LtprwuRJrhxIV9GS9NoL0O+YKuGQfLqNZrqVZe43//
         Nulg==
X-Received: by 10.66.144.230 with SMTP id sp6mr41037639pab.64.1374692489740;
        Wed, 24 Jul 2013 12:01:29 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id om2sm49349777pbb.34.2013.07.24.12.01.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 12:01:28 -0700 (PDT)
In-Reply-To: <20130724065933.GC30074@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231110>

On Jul 23, 2013, at 23:59, Jeff King wrote:

>> diff --git a/test-url-normalize.c b/test-url-normalize.c
>> new file mode 100644
>> index 0000000..f18bd88
>> --- /dev/null
>> +++ b/test-url-normalize.c
>> [...]
>> +	if (!strcmp("sslverify", opt_lc.buf))
>> +		printf("%s\n", curl_ssl_verify ? "true" : "false");
>> +	else if (!strcmp("sslcert", opt_lc.buf))
>> +		printf("%s\n", ssl_cert);
>> +#if LIBCURL_VERSION_NUM >= 0x070903
>> +	else if (!strcmp("sslkey", opt_lc.buf))
>> +		printf("%s\n", ssl_key);
>> +#endif
>> +#if LIBCURL_VERSION_NUM >= 0x070908
>> +	else if (!strcmp("sslcapath", opt_lc.buf))
>> +		printf("%s\n", ssl_capath);
>> +#endif
>> [...]
>
> Do we need to have the complete list of options here, including curl
> version limitations? It seems like this will eventually get out of  
> date
> with the list of options. Would it be sufficient to test just one (or
> even just handle a fake "http.$URL.foo" variable)?

Right now, the values are only available as various strings, ints,  
longs etc. which have to be formatted differently for output.  The  
original string value they were converted from is gone.  The snippet  
shown above only shows some of the "%s" formatters.

Either the original value will have to be kept around or a  
reconstituted string depending on what:

git config --file=foo --url http noepsv $URL

should output.  If the original value was 0 or 1, should it output  
that or "false" or "true"?  The test-url-normalize code for "-c"  
normalizes the output to "false" or "true" for all boolean values and  
reconverts ints/longs to strings.
