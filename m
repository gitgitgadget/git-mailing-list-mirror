From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/14] pull: pass verbosity, --progress flags to fetch
 and merge
Date: Thu, 21 May 2015 17:59:09 +0200
Organization: gmx
Message-ID: <f90387a786c1e0f4287c9fee405f8e2f@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-3-git-send-email-pyokagan@gmail.com>
 <4213f4fa8fb52fb020c2e9b5d78fbf7b@www.dscho.org>
 <CACRoPnRVcjcegRU8J6a=X6uN=b7fhJyD9=js4LqJ7ORX6gT=jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 17:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvSsT-0003Uw-KP
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 17:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617AbbEUP7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 11:59:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:51330 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756401AbbEUP7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 11:59:12 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LjZhg-1ZSblW2CtM-00baxW; Thu, 21 May 2015 17:59:10
 +0200
In-Reply-To: <CACRoPnRVcjcegRU8J6a=X6uN=b7fhJyD9=js4LqJ7ORX6gT=jg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:DxtRz+7k3GJSidG/JaqKVLoZcYYeQcY5+ixKxHdmk6R2Q4IKZa5
 QBAUzdpyxarDlzy5+ljSaUfJtPf3wI6HFey7nzzkRkglGqTAUDWgs1i/QnCr6XYfP+mqwel
 FUbvy83vEAEl556zvXB8O0dgKQtLVSgVd0w+Fdq/HSjD94+DedVhJ/DXWEpq3cHVT843ifx
 mzRPT/w5/imV9tjLn6dag==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269600>

Hi Paul,

On 2015-05-21 11:48, Paul Tan wrote:
> 
> On Tue, May 19, 2015 at 1:41 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> On 2015-05-18 17:05, Paul Tan wrote:
>>> diff --git a/builtin/pull.c b/builtin/pull.c
>>> index 0b771b9..a4d9c92 100644
>>> --- a/builtin/pull.c
>>> +++ b/builtin/pull.c
>>> @@ -11,16 +11,64 @@
>>>  #include "argv-array.h"
>>>  #include "run-command.h"
>>>
>>> +/**
>>> + * Given an option opt, where opt->value points to a char* and opt->defval is a
>>> + * string, sets opt->value to the evaluation of "--$defval=$arg". If `arg` is
>>> + * NULL, then opt->value is set to "--$defval". If unset is true, then
>>> + * opt->value is set to "--no-$defval".
>>> + */
>>> +static int parse_opt_passthru(const struct option *opt, const char
>>> *arg, int unset)
>>
>> Implied by my suggested description, I also propose to put the re-recreated command-line option into a strbuf instead of a char *, to make memory management easier (read: avoid memory leaks).
> 
> Unfortunately, the usage of strbuf means that we lose the ability to
> know if an option was not provided at all (the value is NULL). This is
> important as some of these options are used to override the default
> configured behavior.

Would this not be implied by the strbuf's len being 0?

>> You might also want to verify that arg is `NULL` when `unset != 0`. Something like this:
> 
> Hmm, would there be a situation where arg is NULL when `unset != 0`?

I forgot to say that my suggestion was purely meant as defensive coding. Yes, `arg` *should* be `NULL` when `unset != 0`. Should ;-)

By the way, just to make sure: My comments and suggestions are no demands; you should feel very free to reject them when you feel that your code is better without the suggested changes. I am just trying to be helpful.

Ciao,
Dscho
