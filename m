From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Wed, 11 Jun 2014 11:12:10 +0200
Message-ID: <53981D6A.3090604@gmail.com>
References: <20140605060425.GA23874@sandbox-ub> <20140605060640.GB23874@sandbox-ub> <5391FFC3.5010001@gmail.com> <20140610101744.GA23370@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 11:12:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WueaK-0006Y4-E4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 11:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbaFKJMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 05:12:40 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55190 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbaFKJMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 05:12:12 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so3300287wib.6
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DMF0feIJ9CyYQezUsl+66JpIeZe1zwc3RxSixssxi60=;
        b=sQImteianc93uU5PjPAVHqB9J6gyvM/RayeKHB5arGhatSLhuTzwiRLdauxXyXuflQ
         fcQhmuGE8GerO4kanCuJyIwnImc4kCiIcl0yKYFSpMmVweiB5tD45eORtO1zz7tlO7i4
         fK9pXarSeZsSnDl68N5KFUHVYRO4zVPihO36tLZZDodyts/FSWfDonZzHd4KtN0l0zmY
         Pu+e79kqRe5uMqkHngw1LeOxL2+EuAWuaG4aDh6jhxl7yvZ9Q9abQyqyKZNMLEUwlx+H
         QJ7fRPxUkxrGAfgQHUmkyuAdDY6x7ItpVXdt3XXvk6l4vL0y0oGgdRMATNvSAGgfK/By
         b3TQ==
X-Received: by 10.180.11.9 with SMTP id m9mr37270497wib.51.1402477930415;
        Wed, 11 Jun 2014 02:12:10 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b44sm39575003eem.45.2014.06.11.02.12.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 02:12:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140610101744.GA23370@t2784.greatnet.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251347>

Am 10.06.2014 12:17, schrieb Heiko Voigt:
> On Fri, Jun 06, 2014 at 07:52:03PM +0200, Karsten Blees wrote:
>> Am 05.06.2014 08:06, schrieb Heiko Voigt:
>>> This allows a reader to immediately know which options can be used and
>>> what this parameter is about.
>>>
>> [...]
>>> -void hashmap_free(struct hashmap *map, int free_entries)
>>> +void hashmap_free(struct hashmap *map, enum hashmap_free_options free_entries)
>> [...]
>>>  
>>> +enum hashmap_free_options {
>>> +	HASHMAP_NO_FREE_ENTRIES = 0,
>>> +	HASHMAP_FREE_ENTRIES = 1,
>>> +};
>>
>> This was meant as a boolean parameter. Would it make sense to have
>>
>> enum boolean {
>> 	false,
>> 	true
>> };
>>
>> or similar in some central place?
> 
> The intention of Jonathans critique here[1] was that you do not see what
> this parameter does on the callsite. I.e.:
> 
> 	hashmap_free(&map, 1);
> 
> compared to
> 
> 	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
> 
> A boolean basically transfers the same information and would not help
> the reader here.
> 
> Cheers Heiko
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/243917
> 

There are languages where you can have e.g. 'hashmap_free(..., free_entries: true)'. In C, however, you do not see what a parameter does at the call site. This is a general language feature, reducing redundancy and keeping it short and concise. IMO there's no reason to treat boolean parameters differently.

Using an enum suggests that there is more to the parameter than a simple yes/no decision, underpinned by naming it '...options' (plural). I find this rather confusing.

Finally, enums share a global namespace, which means long identifiers, provoking additional line breaks and thus reducing readability. Not a problem with hashmap_free per se, but if you do the same for e.g. 'free_util' in string-list.[ch] or 'icase' in name-hash.c, I suspect it'll get pretty ugly.

So please lets not spoil the global namespace with a thousand different names for 0/1. Using enums for >= tristate values and bit flags is fine, but inventing enums for every simple boolean in the system is bound to end in chaos.

Just my 2c
Karsten
