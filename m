From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] commit: reload cache properly
Date: Thu, 30 May 2013 08:07:57 -0500
Message-ID: <CAMP44s2_q6-bfxw-3jTQA_aiXynGc7adE_-GebP=D5FY-ou_wg@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-2-git-send-email-felipe.contreras@gmail.com>
	<87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s1O=VTu8EZi+yOfGMccCpS+pozvZJuDW1mK95U8-YEquA@mail.gmail.com>
	<8761y0k4ja.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 15:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2aX-0002TL-H2
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab3E3NIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:08:06 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62307 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab3E3NH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:07:59 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so521418lbi.11
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nQYNwDTVq9ui4kHSXxCY54E5YsOJgHxBqXOj7THndzg=;
        b=C+KkMwh6YJUfw1CsLW+z43JdIcCUoOjMAGhzqrEQz560X5FbQguqxreTQPLPQpkmxm
         l39mg4K4Mm4sI/NC4m3xmVZBFDzkbnK5FGxtMQKf2sfeYR5luSVm+20Szk6KeLUMGulV
         8KfokwrvRdngNqe3xkhr8RByIfXSm3ufm8VC6vwm0XYJ6wtJfjvXintdhNfnQHJG5DQe
         zg/TSnxT/6zZDV5mIWMxxv4jGDDo72xiOCkgFT3OtTtF1lB5ymsZbAQ5D606Qa5Xt3i1
         nXWcKWELPkf7fvY384kma2w7ITLlwFmypPJuJmwcDZKS1wCgWEF+c911EVQTL9mHIyYS
         iSJw==
X-Received: by 10.152.3.65 with SMTP id a1mr3508575laa.40.1369919277387; Thu,
 30 May 2013 06:07:57 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 06:07:57 -0700 (PDT)
In-Reply-To: <8761y0k4ja.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225981>

On Thu, May 30, 2013 at 7:58 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 30, 2013 at 7:17 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> We are supposedly adding files, to to which cache if 'the_index' is
>>>> discarded?
>>> [...]
>>>>       if (!current_head) {
>>>>               discard_cache();
>>>> +             if (read_cache() < 0)
>>>> +                     die(_("cannot read the index"));
>>>>               return;
>>>>       }
>>>
>>> It is not obvious to me that this is a correct change.  discard_cache()
>>> without subsequent reloading could also legitimately be used to empty
>>> the index.  So if you are fixing a bug, please justify the change and
>>> provide a testcase to guard against it in the future.
>>
>> So istate->initialized is false, yet somebody can still add entries to
>> the cache? What happens when somebody else tries to initialize this
>> cache? All the entries there will be lost, even though nobody
>> discarded it afterwards.
>
> And yet it works, and your patch breaks it.

It might work, but the API doesn't make any sense.

-- 
Felipe Contreras
