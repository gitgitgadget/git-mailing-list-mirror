From: Hiroyuki <sh19910711@gmail.com>
Subject: Re: [PATCH v3][GSOC] fsck: use bitwise-or assignment operator to set flag
Date: Fri, 21 Mar 2014 08:27:51 +0900
Message-ID: <CA+gKU0fZ=Le3iLhyqX2s0rf-292yh7mA-_Zo6AkJBrzN1=XakQ@mail.gmail.com>
References: <1395270124-2242-1-git-send-email-sh19910711@gmail.com>
	<xmqqtxasybnk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:27:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmNR-0001IW-91
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537AbaCTX1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:27:53 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:47442 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759160AbaCTX1w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:27:52 -0400
Received: by mail-yh0-f41.google.com with SMTP id v1so1666747yhn.14
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nu4J8JnIoxDEfnJtOb4+95BJwU0Kpzd83iI/k3xgHO0=;
        b=M3adl1jyNEdg10esR1KSE9QvOMlgO9rTOvAOF1DpBq7aWQ4e5Oxwu1osqMIIc7pt6a
         iu6R1uW5mYvNx5gEPNsgRFv6qdE8JRpSv3Wx7oliCshl2i2V6xvDyZuiIBIMUYwPO53T
         XuIk3C8uCJT82VIHCEtwITOJvfN3RU98O8Ps0IZWyvTCuP7CEKQbYVStbjzDYCN8E5WR
         dYNZ8+o3xrKOa+3u4WaTZ4prO6aUvyWfDL2zwMGf4yOmEkKLu7VHN5ESatUzhxFfau+H
         DjWXCWuW+8yagwBJQeJ8Mh5OmC1aT/4HKYYpP682f81C9ork4/q1GzbZlwtMBhrXufzW
         7sRg==
X-Received: by 10.236.24.196 with SMTP id x44mr22499031yhx.92.1395358071944;
 Thu, 20 Mar 2014 16:27:51 -0700 (PDT)
Received: by 10.170.171.7 with HTTP; Thu, 20 Mar 2014 16:27:51 -0700 (PDT)
In-Reply-To: <xmqqtxasybnk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244616>

Junio and Eric,

Thank you for the reviews and helpful advice.
I should have read more past commit messages before send patch.


Regards,


2014-03-21 3:20 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> Hiroyuki Sano <sh19910711@gmail.com> writes:
>
>> fsck_tree() has two different ways to set a flag,
>> which are the followings:
>>
>>   1. Using a if-statement that guards assignment.
>>
>>   2. Using a bitwise-or assignment operator.
>>
>> Currently, many with the former way,
>> and one with the latter way.
>>
>> In this patch, unify them to the latter way,
>> because it makes the code shorter and easier to read,
>> and it is brief and to the point.
>
> Two issues:
>
>  * "In this patch," is redundant.
>
>  * "it is brief and to the point" are equally applicable to both
>    styles, so that is not a *reason* to choose one over the other.
>
> If a condition were *not* brief and to the point, then a rewrite to
> the latter style will make the resulting code worse:
>
>         if (a very complex condition
>             that potentially have to consume a
>             lot of brain-cycles to understand) {
>                 has_that_condition = 1;
>         }
>
> is a lot easier to extend than
>
>         has_that_condition = (a very complex condition
>                               that potentially have to consume a
>                               lot of brain-cycles to understand);
>
> because it is a lot more likely that we would need to later extend
> such a complex condition is more likely than a simple singleton
> condition, and we could end up with
>
>         if (a very complex condition
>             that potentially have to consume a
>             lot of brain-cycles to understand) {
>                 futher computation to check if
>                 the condition really holds
>                 will be added here later
>                 if (does that condition really hold true?)
>                         has_that_condition = 1;
>         }
>
>
> which may be harder to express in the latter form.
>
> In other words, "it is brief and to the point" merely _allows_ these
> statements to be expressed in the latter form; it does not say
> anything about which is better between the former and the latter.
>
>> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
>> ---
>>  fsck.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index b3022ad..abed62b 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -165,18 +165,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>>
>>               sha1 = tree_entry_extract(&desc, &name, &mode);
>>
>> -             if (is_null_sha1(sha1))
>> -                     has_null_sha1 = 1;
>> -             if (strchr(name, '/'))
>> -                     has_full_path = 1;
>> -             if (!*name)
>> -                     has_empty_name = 1;
>> -             if (!strcmp(name, "."))
>> -                     has_dot = 1;
>> -             if (!strcmp(name, ".."))
>> -                     has_dotdot = 1;
>> -             if (!strcmp(name, ".git"))
>> -                     has_dotgit = 1;
>> +             has_null_sha1 |= is_null_sha1(sha1);
>> +             has_full_path |= !!strchr(name, '/');
>> +             has_empty_name |= !*name;
>> +             has_dot |= !strcmp(name, ".");
>> +             has_dotdot |= !strcmp(name, "..");
>> +             has_dotgit |= !strcmp(name, ".git");
>>               has_zero_pad |= *(char *)desc.buffer == '0';
>>               update_tree_entry(&desc);



-- 
Hiroyuki Sano
sh19910711@gmail.com
