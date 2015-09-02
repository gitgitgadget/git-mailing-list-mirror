From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 08:01:19 -0700
Message-ID: <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	<xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9XT-00066J-9G
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbbIBPBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:01:23 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33764 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbbIBPBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:01:22 -0400
Received: by pacex6 with SMTP id ex6so9179311pac.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kmTTwPwapOZ+SveuSZ2qrLfmq4asS5n5IuK8gSDWbVM=;
        b=Q//5M5eno+Wwv1ZVIvVaUouk/PRfqV5zGv1reL7Vo387boM0hMkWmzkUloq/9vMueW
         +vjNTA/QFU88614afmabqIGKbhvJsGWTvOik2Oy1kxpriH5U0r4fo4FP9ZQ5Ff9BSj7M
         FoP7dQmFjXg2yFkMgkedbjOoVXyct8uSqykPIpEDT+bnFfe7A7YJvEqaefsG77FO3kYB
         aAKG0a0mWou7oOgJWq6We1TdTgaOmIhRC7revQVMjTcoodaiTEIf4RpFGMsgn0hCBEAb
         YnhmpXOAz85qjTgqS5H0LAiH/UVOyYlflHC8aupjNhhMtixlUiWCbFlPlJ3cXfJNMaDb
         MJ4A==
X-Received: by 10.66.102.71 with SMTP id fm7mr55716496pab.5.1441206082082;
        Wed, 02 Sep 2015 08:01:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id c2sm22003699pds.56.2015.09.02.08.01.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 08:01:20 -0700 (PDT)
In-Reply-To: <CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 17:21:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277093>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +             die(_("format: `end` atom used without a supporting atom"));
>>
>> Not a show-stopper, but we may need some wordsmithing for "a
>> supporting atom" here; an end-user would not know what it is.
>
> Probably something like "format: `end` atom should only be
> used with modifier atoms".

Between "supporting" and "modifier" I do not see much difference,
though.

>>> +             } else if (skip_prefix(name, "align", &valp)) {
>>
>> This looked as if you are willing to take %(align) in addition to
>> %(align:...), but...
>>
>>> +                     struct align *align = &v->align;
>>> +                     struct strbuf **s;
>>> +
>>> +                     if (valp[0] != ':')
>>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>>
>> ... apparently that is not what is happening.  Why not skip "align:"
>> with colon as the prefix, then?
>
> Cause we wanted to provide an error for usage of "%(ailgn)" without any
> subvalues as such.

Wouldn't it be something that would be caught in the same codepath
as what catches %(unrecognized) in the format string?
