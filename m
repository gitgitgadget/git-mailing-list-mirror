From: Ashwin Jha <ajha.dev@gmail.com>
Subject: Re: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
Date: Sat, 22 Mar 2014 01:26:42 +0530
Message-ID: <532C997A.1070202@gmail.com>
References: <CADi-0_PN=jV4TmS=_SH2rebHvE9zEveG6Eo8zrJt_43=b-_Ryw@mail.gmail.com> <CAPig+cRhiuQ1HQ5H6Wd6iMdQ3vAO7AdqfKL3Vf8gdh3-gGemDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR5ZN-0006zw-RR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 20:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbaCUT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 15:57:29 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51464 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaCUT52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 15:57:28 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so2779162pdj.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=16vu4fJfAtRhkY2I+qlcl5pvdU+Wckk0xMeLscffi1s=;
        b=l8Sm1/v0TrJHu8IaVy6NytZDhCnj3zphyMopxSBscwUbC+HLlbBzd6rdSekIi+XRix
         mMSwhGzDiZl+hjHXQFNT2smhuv3rvQLZjfTpGRUbyfex9ag+pWgfUflhUIL4mSfZogdf
         7OFCkmR5Tf6ggARDsLMxY7H509dT3rXWtMrSzy3HkmaxuWAj8Wsoccu4ScsXZMRVlqBq
         50rewC/TlsNm61765lqmvxPMtKe8DfHE4hS0YddlYz5tPgiV29xbCIi3v0EwJIPPP2XD
         5Yom52rSzr7ZwCiBG9W+/69WoPhS/4Sf0B+jxOst8SJpLSysbbwsU9+7RSbnKnkdduHH
         K70w==
X-Received: by 10.68.137.136 with SMTP id qi8mr55647973pbb.79.1395431848140;
        Fri, 21 Mar 2014 12:57:28 -0700 (PDT)
Received: from [192.168.23.7] (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id y4sm11447689pbk.76.2014.03.21.12.57.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 12:57:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAPig+cRhiuQ1HQ5H6Wd6iMdQ3vAO7AdqfKL3Vf8gdh3-gGemDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244730>


On 03/22/2014 12:11 AM, Eric Sunshine wrote:
> On Fri, Mar 21, 2014 at 5:18 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
>> On Fri, Mar 21, 2014 at 9:03 AM, Eric Sunshine <sunshine@sunshineco.com>
>> wrote:
>>> On Thu, Mar 20, 2014 at 9:54 PM, Ashwin Jha <ajha.dev@gmail.com> wrote:
>>>> Subject: [PATCH] GSoC Miniproject 15. Rewrite fsck.c:fsck_commit()
>>>> starts_with() seems much more relevant than memcmp(). It uses one less
>>>> argument and its return value makes more sense.
>>> As a justification, "uses one less argument" falls flat, and really
>>> has nothing to do with the decision to make the change. The bit about
>>> the return value is a slightly better but is still weak.
>>>
>>> You might instead justify the change by pointing out that the name
>>> starts_with()
>>> does a better job of conveying the intention of the code, which is to
>>> check the string for a prefix, than does memcmp().
>> Actually, from the line "starts_with() seems much more relevant than
>> memcmp()" my intention was to say that "starts_with() does a better job of
>> conveying the intention of the code, which is to check the string for a
>> prefix, than does memcmp()" as mentioned by you.
> Good to hear. When you resubmit (if you do), perhaps use that wording
> or something similar to justify the change.
>
>>>> skip_prefix() is not used as it uses strcmp() internally which seems
>>>> unnecessarily
>>>> for current task. The current task can be easily done by providing
>>>> offsets to the
>>>> buffer pointer (the way it is implemented currently).
>>> Not sure what this means. What is the "current task", and what is
>>> implemented where currently?
>>  From current task, I meant to say the task of offsetting the buffer pointer
>> to get the correct substring as in:
>> get_sha1_hex(buffer+5, tree_sha1)
>>
>> Please forgive me for this. I should have written this in a better way.
> Thanks for the clarification.
>
>>>> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
>>>> ---
>>>>   fsck.c |   11 ++++++-----
>>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fsck.c b/fsck.c
>>>> index 64bf279..82e1640 100644
>>>> --- a/fsck.c
>>>> +++ b/fsck.c
>>>> @@ -6,6 +6,7 @@
>>>>   #include "commit.h"
>>>>   #include "tag.h"
>>>>   #include "fsck.h"
>>>> +#include "strbuf.h"
>>>>
>>>>   static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void
>>>> *data)
>>>>   {
>>>> @@ -290,12 +291,12 @@ static int fsck_commit(struct commit *commit,
>>>> fsck_error error_func)
>>>>          int parents = 0;
>>>>          int err;
>>>>
>>>> -       if (memcmp(buffer, "tree ", 5))
>>>> +       if (!starts_with(buffer, "tree "))
>>>>                  return error_func(&commit->object, FSCK_ERROR, "invalid
>>>> format - expected 'tree' line");
>>>>          if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
>>> One of the benefits of starts_with() and skip_prefix() is that they
>>> allow you to eliminate magic numbers, such as 5 in the memcmp()
>>> invocation. However, if you look a couple lines below, you see in the
>>> expression 'buffer+5' that the magic number is still present. In fact,
>>> the code becomes less clear with your change because the 5 in
>>> 'buffer+5' is much more mysterious without the preceding
>>> memcmp(foo,"bar",5). It is possible to eliminate this magic number,
>>> but starts_with() is not the answer.
>>>
>> I considered this point while making the changes. But, I thought that since
>> all that is required is a constant offset to the buffer pointer, using
>> skip_prefix() will only add to the overhead of function calling.
>>>>                  return error_func(&commit->object, FSCK_ERROR, "invalid
>>>> 'tree' line format - bad sha1");
>>>>          buffer += 46;
>> And as you can see here (buffer +=46) will still be a problem even if I
>> replace the buffer+5 code.
>> I think a more better way would be to define these magic no. as macros.
>>
>> But, I guess you are right. The current changes do make it a bit unclear.
> I understand your argument: since magic numbers remain elsewhere, then
> little is gained by eliminating only a few of them via skip_prefix().
> A counterargument might be that even that small gain can be a
> maintenance bonus, since it reduces the number of potential places
> where errors can be made when modifying the code. (But you are welcome
> to counter that argument if you feel strongly about it.)
>
>> To summarize, I can think of two ways:
>> 1. skip_prefix() can be used, in place of both starts_with() and memcmp().
>> The return value of skip_prefix can
>>      be checked against NULL to determine whether correct format is used or
>> not.
>>      Though, even this change will left some of the magic no (as shown
>> above). ;-)
>> 2. Define macros for all the magic no. (and tags like "tree", "parent"
>> etc.). This way the code will be more clear
>>      and any future changes to these magic no. (or tag names) will be much
>> easier to handle.
> Perhaps provide an illustration to explain what you mean.
I think you want some explanation on point 2. What I have suggested here 
is that
all the keywords (like "tree", "parent") and magic no. (which are 
nothing but suitable
pointer offsets, used to fetch these keywords) be defined as macros.
This will serve two purposes:
1. The code will be more readable in the sense that each magic no. will 
have a meaningful name.
2. Following scenario will be avoided:
     In the event of change in a particular keyword string, all 
occurrences of that keyword as well as
     the magic no. associated with it (string length) will have to be 
changed.

But, since these changes will be very rare, I think skip_prefix will be 
a good choice.
I will submit a patch after doing the necessary changes.
>
>> In my opinion, 2 will be a better option. But, I can understand that I may
>> have overlooked some potential flaws in this method.
>> Please guide me to the correct approach. :-)
> There isn't necessarily one correct approach. Judging from reviewer
> responses to submissions by other GSoC hopefuls who tackled this
> microproject, one may conclude that skip_prefix() would be a welcome
> improvement, even if it doesn't eliminate all magic numbers in the
> code.
>
>>>> -       while (!memcmp(buffer, "parent ", 7)) {
>>>> +       while (starts_with(buffer, "parent ")) {
>>>>                  if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
>>> Ditto here with magic number 7 in 'buffer+7'.
>>>
>>>>                          return error_func(&commit->object, FSCK_ERROR,
>>>> "invalid 'parent' line format - bad sha1");
>>>>                  buffer += 48;
>>>> @@ -322,15 +323,15 @@ static int fsck_commit(struct commit *commit,
>>>> fsck_error error_func)
>>>>                  if (p || parents)
>>>>                          return error_func(&commit->object, FSCK_ERROR,
>>>> "parent objects missing");
>>>>          }
>>>> -       if (memcmp(buffer, "author ", 7))
>>>> +       if (!starts_with(buffer, "author "))
>>>>                  return error_func(&commit->object, FSCK_ERROR, "invalid
>>>> format - expected 'author' line");
>>>>          buffer += 7;
>>> And again with 7.
>>>
>>>>          err = fsck_ident(&buffer, &commit->object, error_func);
>>>>          if (err)
>>>>                  return err;
>>>> -       if (memcmp(buffer, "committer ", strlen("committer ")))
>>>> +       if (!starts_with(buffer, "committer "))
>>>>                  return error_func(&commit->object, FSCK_ERROR, "invalid
>>>> format - expected 'committer' line");
>>>> -       buffer += strlen("committer ");
>>>> +       buffer += 10;
>>> Again with 10 (newly introduced).
>>>
>>>>          err = fsck_ident(&buffer, &commit->object, error_func);
>>>>          if (err)
>>>>                  return err;
>>>> --
>>>> 1.7.9.5
Regards,
Ashwin
