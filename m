From: Jan-Philip Gehrcke <jgehrcke@googlemail.com>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Wed, 17 Jun 2015 19:07:48 +0200
Message-ID: <5581A964.4000500@googlemail.com>
References: <557E91D2.3000908@googlemail.com> <xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 19:08:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Goj-0003Aa-D8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbbFQRH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 13:07:57 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37769 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbFQRHz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:07:55 -0400
Received: by wifx6 with SMTP id x6so60594056wif.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9xbfCzHmX6X6ZO7FnuxNY5eEnylyNibyD4XrmFFxXy8=;
        b=IAXr8DQZ/HRWE2YNXY18vy5RVmyH4u3ztOC49oaJACOQ3Zo4D1A00eao/QmtmagJKj
         UGNeHYAqmSXMcr1KYgyQsX703MF0Z0KnfTp+SRAr+ao0qFXvVCuYK6ObG1PxWyaKc1fF
         oVtISeJvK6dapgwlVRWK/W4otoMaJHmwEy8GOEsFL6oaitPOoEBo+Q33yiWWc9S7ljZD
         SZh11m6OUeL0X1pEQIQnJj5uksxIvkSMxQoElEi+vLQiEBxXWCa7XMbrFgRC8ib5Yfcv
         vDURZCj5rNgPsWqa1l6KMZmG0f41JO0gzNySx5nmSPaRdYogtpG84psfMn/SYlthF0u3
         bWjA==
X-Received: by 10.195.11.168 with SMTP id ej8mr7666213wjd.150.1434560874317;
        Wed, 17 Jun 2015 10:07:54 -0700 (PDT)
Received: from [192.168.178.11] (ip92342367.dynamic.kabel-deutschland.de. [146.52.35.103])
        by mx.google.com with ESMTPSA id df1sm26929615wib.12.2015.06.17.10.07.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2015 10:07:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271872>

On 17.06.2015 18:42, Junio C Hamano wrote:
> Jan-Philip Gehrcke <jgehrcke@googlemail.com> writes:
>
>> I was surprised to see that the output of
>>
>>      git log --encoding=utf-8 "--format=format:%b"
>>
>> can contain byte sequences that are invalid in UTF-8. Note: I am using
>> git 2.1.4 and the %b format specifier represents the commit message
>> body.
>
> Yeah, if the original was bad and cannot be sanely expressed in
> UTF-8, you have two options.  You can show the contents as raw bytes
> recorded in the object with a warning so that the user can use it as
> such (e.g. perhaps the original was indeed an iso8859-2 but was
> incorrectly marked as UTF-8, or something like that, and a human
> that is more intelligent than a tool _could_ guess and attempt to
> recover).  Or you can error out and refuse to produce output.

The two-option scenario is totally clear. Although one must stress that 
the "error-out" option can, as discussed, be kept minimally invasive: it 
is sufficient (and common) to just skip those byte sequences (and 
replace them with a replacement symbol) that would be invalid in the 
requested output encoding. This would retain as much information as 
possible while guaranteeing a subsequent decoder to retrieve valid input.

> We deliberately made a design choice to take the former option.

I totally support this design choice in general, especially when 
invoking `git whatever` without options. This here is, I think, mainly 
about documentation and the semantics of "--encoding". From my point of 
view, `--encoding=utf-8` semantically suggests that the output *is* 
valid UTF-8. But it is not, not always. May initial question was: what 
do you think about this? Should we

* just make this more clear in the docs and/or
* should we adjust the behavior of --encoding or
* should we do something entirely different, like adding a new command 
line option or
* should we just leave things as they are?

Thanks and cheers,


Jan-Philip
