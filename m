From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Tue, 17 Jun 2014 10:30:35 +0200
Message-ID: <539FFCAB.4060908@gmail.com>
References: <20140605060425.GA23874@sandbox-ub>	<20140605060640.GB23874@sandbox-ub> <5391FFC3.5010001@gmail.com>	<20140610101744.GA23370@t2784.greatnet.de>	<53981D6A.3090604@gmail.com> <xmqqegyu54cl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 10:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwomz-0001Jj-MB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 10:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbaFQIak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 04:30:40 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:46243 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbaFQIai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 04:30:38 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so6890108wes.13
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LYikkCzuO7dTySmaBybMygmujh5fU624xzIuQpa6huA=;
        b=VwmN/zZAbV8x+YvY+o8iitqlnLL+QuIrKlBXsJGZYT8S1QTHbGT29SG2ecschdp0jt
         praUoeAPlWQiembUzFf54quK8Fi8ow/HY9qhMCN8s8c13LQGyU636RAxzEL4JtwQUwv1
         4q/w5iPwxznIs6E375+whW/6xmx0kGU0U4ZJqGBCqMoS9DH4VNatRPCAXcAtETD6yove
         RkvwqARJAYGNl6f2TTH9BIb25K3kzQ9pykyoaSOS8DLi+37tDxFEtZZ4UYm/YodrAj0/
         DJ+VrqaZoP8phvzoP3DvcBhYtHBkKId3R4FuSiCPcqeILi3pNRj6jyMWRpwVQbwcXr7X
         cR0g==
X-Received: by 10.194.24.36 with SMTP id r4mr36178302wjf.39.1402993837548;
        Tue, 17 Jun 2014 01:30:37 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj5sm18887313wib.0.2014.06.17.01.30.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 01:30:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqegyu54cl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251852>

Am 12.06.2014 21:12, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 10.06.2014 12:17, schrieb Heiko Voigt:
>>> The intention of Jonathans critique here[1] was that you do not see what
>>> this parameter does on the callsite. I.e.:
>>>
>>> 	hashmap_free(&map, 1);
>>>
>>> compared to
>>>
>>> 	hashmap_free(&map, HASHMAP_FREE_ENTRIES);
>>>
>>> A boolean basically transfers the same information and would not help
>>> the reader here.
>>>
>>> Cheers Heiko
>>>
>>> [1] http://article.gmane.org/gmane.comp.version-control.git/243917
>>>
>>
>> There are languages where you can have e.g. 'hashmap_free(...,
>> free_entries: true)'. In C, however, you do not see what a
>> parameter does at the call site. This is a general language
>> feature, reducing redundancy and keeping it short and concise. IMO
>> there's no reason to treat boolean parameters differently.
> 
> But given that you are writing in C, is any of that relevant?  We do
> want to keep our call-sites readable and understandable, 

But in C, readable and understandable are opposite goals.
'Understandable' entails long, redundant identifiers, automatically
decreasing readability. The compiler doesn't care about either, so
we could just as well keep the C part short and use plain English
for understandability:

  /* free maps, except file entries (owned by istate->cache) */
  hashmap_free(&istate->name_hash, 0);
  hashmap_free(&istate->dir_hash, 1);

Note that this not only explains what we're doing, but also why.

> and 1 or
> true would not help, unless (1) you are the one who wrote the
> function and know that 1 means free the entries, or (2) the API is
> so widely used and everybody knows what 1 means free the entries.
> 

or (3) you need to check the function declaration or documentation
anyway, to understand what the non-boolean parameters do.

E.g. consider this (from remote.c:1186):

  dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);

vs.

  dst_value = resolve_ref_unsafe(matched_src->name, sha1,
                                 RESOLVE_REF_UNSAFE_FOR_READING,
                                 &flag);

That's three lines vs. one, "RESOLVE_REF_UNSAFE_" is completely
redundant with the function name, "FOR_READING" isn't particularly
enlightening either, and you still don't know what the other three
parameters do. IMO this would be much better:

  /* fully resolve matched symref to resolved ref name and sha1 */
  dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);

So veterans highly familiar with the code can stick to the C part
without being distracted by unnecessary line breaks and
SHOUTED_IDENTIFIERS, while everyone else may find the explanation
helpful.


As I said, using enums for hashmap_free isn't a problem on its own.
However, the accepted solution for booleans in the git code base
seems to be to use just an int and 0/1.

For consistency, we could of course change string_list*,
resolve_ref*, index_file_exists etc. as well.

...and in turn 'extern int ignore_case' (because it gets passed to
index_file_exists)?

...and in turn all other boolean config variables?

I don't think this would be an improvement, though.
