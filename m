From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Fri, 22 May 2015 18:16:36 +0530
Message-ID: <555F252C.2060601@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>	<vpqr3qagvv6.fsf@anie.imag.fr> <555E1CE7.8090507@gmail.com> <vpqbnhd157k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 22 14:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvmLe-00084x-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 14:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbbEVMql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 08:46:41 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34697 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865AbbEVMqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 08:46:40 -0400
Received: by pdbnk13 with SMTP id nk13so18960372pdb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wnp4Yqh7Nky4+cgNenaGaSxI76J+z3LzzyL4FVoHI+c=;
        b=h/TFa3LDiaUs94LGVMVLb0ROvNSwZ+jfYhyil/2Sq2f2L2Otx4Nice9R5iYfLoDK1I
         slaMHmoa6E+aHbad7beooSWohaTDoleixdiYQxrt3ZvoMMv/zFCymADmR4onH6mxEr4Y
         2D9O2Tpnol6vu1Z+UzWgzGcSc8g5eCIWm1J3cbLaLAllHzn5QOUCF7p32iPoIVc4Z7ph
         r3elVUp1jrp/1Ia6p49cvLbBXbpwJR2nOMCBtULJjWXgWZhdp7LrAhcUWlAiPDndUKxY
         fDmcMq/ZSdbOpBZMAe6JGf5JsYXKT0PkvbjxVFkW5H0wY4v4SnF5n6bMHYHRwSNRq8gd
         nleQ==
X-Received: by 10.70.38.195 with SMTP id i3mr15504811pdk.82.1432298800480;
        Fri, 22 May 2015 05:46:40 -0700 (PDT)
Received: from [192.168.0.104] ([106.51.130.23])
        by mx.google.com with ESMTPSA id f1sm2117995pdp.24.2015.05.22.05.46.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 05:46:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqbnhd157k.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269708>



On 05/22/2015 12:14 PM, Matthieu Moy wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>>> I miss a high-level description of what the code is doing. Essentially,
>>> there's the complete repository list of refs, and you want to filter
>>> only some of them, right?
>>>
>>>   From the name, I would guess that ref_filter is the structure describing
>>> how you are filtering, but from the code it seems to be the list you're
>>> filtering, not the filter.
>>
>> Reading this again, A bit confused by what you're trying to imply.
>> Could you rephrase please?
>
> At some point, I'd expect something like
>
>    filtered_list_of_refs = filer(full_list_of_refs, description_of_filter);
>
> That would remove some refs from full_list_of_refs according to
> description_of_filter.
>
> (totally invented code, only to show the idea)
>
> If there's a piece of code looking like this, then you need a data
> structure to store list of refs (full_list_of_refs and
> filtered_list_of_refs) and another to describe what you're doing with it
> (description_of_filter).
>
> The name ref_filter implies to me that it contains the description of
> the filter, but looking at the code it doesn't seem to be the case.
>

But it does just that, doesn't it?

strict ref_filter {
	int count, alloc;
	struct ref_filter_item **items;
	const char **name_patterns;
};

If you see it does contain 'name_patterns' according to which it will 
filter the given refs, but thats just the start, as 'for-each-ref' only 
supports filtering based on the given pattern, eventually as I merge the 
functionality of 'git tag -l' and 'git branch -l' it will contain more 
filters like, 'contains_commit', 'merged' and so on. Eventually becoming 
more of a filter description as you put it. I hope that clears out things :)

Regards,
Karthik
