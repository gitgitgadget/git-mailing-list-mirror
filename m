Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83313C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12E206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3ydklTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA3QAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:00:51 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38383 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3QAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 11:00:51 -0500
Received: by mail-yw1-f68.google.com with SMTP id 10so2212584ywv.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=isMq2XbaznjGUvhxZwsrOLGhxyyvNhAGzPoOQb0B6XA=;
        b=X3ydklTHt7jgprinOMV2M4RCCFHRAv+Rn+dXW07Wks+a5OPVN0NnXwi4Y1SwqQMMmk
         OqVi+z0t44uBkMTf88pfk26RIav+LfA4Oj+1lh4NHpmMksuoyKu6H926vF/LV11jMXh/
         W1KX4o18CqkAyOFdjIhGFIhSaw8HYyavH9pcmdgquwMLvb4x6UYUMAi+V09pTiCXRdzn
         jiUtmUSMXSbTkxtD1e6fJRifP4R6i+MZ+V+afQHCxS1dVv3k3tTnGQNhpoAq39LHytLi
         rqukDMPn75iF2U6KIN9QSI4BAzVDdy84Kk4Lpc6dIf9ZF2YNU/n2s9reg7JMqnf3VAkT
         fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=isMq2XbaznjGUvhxZwsrOLGhxyyvNhAGzPoOQb0B6XA=;
        b=uUPFcXVAZsivxbwUwzT+4xuvx5aM8/2ebfzPTAlb/Ch++kNxy1EZb8C2CpXJnPivqC
         DgxqHRZlAELR5A1PNdkOCCsn+H/c6AFxj9D+P3sj64xWApGDby/gttEqlTWXoof8t0vj
         PAF9ox9JzbPlJxOi1yHCNY4sUClJgQCpP/qJ+WPtFs2ON83Ovo22BCW9FiRY7gsGMyI/
         UHVbFcsburkh85SQAtQpKj+cjPgFINVsgdPfJfqS/C/xkT8KyDZQ8ju2eyVfAQ4KwBmC
         pUfSYi7GACx4Y8ytkThGonv/SPN7nRfEHV7CC2XRiiUZSERr+Xht51i9gZr9ox4UXROT
         wXJg==
X-Gm-Message-State: APjAAAU8pRjy+6eZT1Pqo/BPnN03IznTLblfQhDIl/RwOVi+azqH4asB
        31lDDj8EZB/PKrI/Z0J6CUM=
X-Google-Smtp-Source: APXvYqwsc7JePYY60N7LXqj910Et2wRksGo+73qkP9l9SOC+yH43/CwoErHQD2BOeCuA0tEWTR+cfQ==
X-Received: by 2002:a81:2b0b:: with SMTP id r11mr3515348ywr.282.1580400049709;
        Thu, 30 Jan 2020 08:00:49 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d66sm2606263ywc.16.2020.01.30.08.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:00:49 -0800 (PST)
Subject: Re: [PATCH 4/6] dir: move setting of nested_repo next to its actual
 usage
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
 <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com>
 <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1bc41d94-5d4d-4157-fc00-08b97fb20738@gmail.com>
Date:   Thu, 30 Jan 2020 11:00:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 10:45 AM, Elijah Newren wrote:
> On Thu, Jan 30, 2020 at 7:33 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 1/29/2020 5:03 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>  dir.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/dir.c b/dir.c
>>> index 225f0bc082..ef3307718a 100644
>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -1659,7 +1659,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>>       const char *dirname, int len, int baselen, int excluded,
>>>       const struct pathspec *pathspec)
>>>  {
>>> -     int nested_repo = 0;
>>> +     int nested_repo;
>>>
>>>       /* The "len-1" is to strip the final '/' */
>>>       switch (directory_exists_in_index(istate, dirname, len-1)) {
>>> @@ -1670,6 +1670,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>>               return path_none;
>>>
>>>       case index_nonexistent:
>>> +             nested_repo = 0;
>>
>> I had to look at this code in-full from en/fill-directory-fixes-more to
>> be sure that this case was the only use of nested_repo. However, I found
>> that this switch statement is unnecessarily complicated. By converting
>> the switch to multiple "if" statements, I noticed that the third case
>> actually has a "break" statement that can lead to the final "fourth case"
>> outside the switch statement.
>>
>> Hopefully the patch below is a worthy replacement for this one:
>>
>> -->8--
>>
>> From b5c04e6e028cb6c7f9e78fbdd2182383d928fe6d Mon Sep 17 00:00:00 2001
>> From: Derrick Stolee <dstolee@microsoft.com>
>> Date: Thu, 30 Jan 2020 15:28:39 +0000
>> Subject: [PATCH] dir: refactor treat_directory to clarify variable scope
>>
>> The nested_repo variable in treat_directory() is created and
>> initialized before a multi-case switch statement, but is only
>> used by one case. In fact, this switch is very asymmetrical,
>> as the first two cases are simple but the third is more
>> complicated than the rest of the method.
>>
>> Extract the switch statement into a series of "if" statements.
>> This simplifies the trivial cases, while highlighting the fact
>> that a "break" statement in a condition of the third case
>> actually leads to jumping to the fourth case (after the switch).
>> This assists a reader who provides an initial scan to notice
>> there is a second way to approach the "show_other_directories"
>> case than simply the response from directory_exists_in_index().
> 
> Wait, I'm lost.  Wasn't that break statement the only way to get to
> the "show_other_directories" block of code after the switch statement?
>  I can't see where the second way is; am I missing something?

Ah, I guess I didn't realize that exist_status didn't have a fourth
mode. I was assuming that normally the switch would not hit any of
the case statements was the way you would _assume_ to hit the block
after the switch.

So yes, my statement is incorrect, but the intention is correct:
the flow of this method is very confusing.

> That is, unless directory_exists_in_index() suddenly starts returning
> some value other than the three current possibilities.  Perhaps we
> should throw a BUG() if we get anything other than index_directory,
> index_gitdir, or index_nonexistent.
> 
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  dir.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index b460211e61..e48812efe6 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1659,17 +1659,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>         const char *dirname, int len, int baselen, int exclude,
>>         const struct pathspec *pathspec)
>>  {
>> -       int nested_repo = 0;
>> -
>>         /* The "len-1" is to strip the final '/' */
>> -       switch (directory_exists_in_index(istate, dirname, len-1)) {
>> -       case index_directory:
>> -               return path_recurse;
>> +       enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
>>
>> -       case index_gitdir:
>> +       if (status == index_directory)
>> +               return path_recurse;
>> +       if (status == index_gitdir)
>>                 return path_none;
>>
>> -       case index_nonexistent:
>> +       if (status == index_nonexistent) {

Since exist_status only has three options, this "if" is redundant.

>> +               int nested_repo = 0;
>>                 if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>>                     !(dir->flags & DIR_NO_GITLINKS)) {
>>                         struct strbuf sb = STRBUF_INIT;
>> @@ -1682,7 +1681,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>                                 (exclude ? path_excluded : path_untracked));
>>
>>                 if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>> -                       break;
>> +                       goto show_other_directories;

It would be better to nest the rest of this block in an 
if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES))

>>                 if (exclude &&
>>                         (dir->flags & DIR_SHOW_IGNORED_TOO) &&
>>                         (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
>> @@ -1711,7 +1710,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>>         }
> 
> I'd say we'd want to add a BUG("Unhandled value for
> directory_exists_in_index: %d\n", status); right here.
> 
>>
>>         /* This is the "show_other_directories" case */
>> -
>> +show_other_directories:

...allowing us to drop this.

>>         if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
>>                 return exclude ? path_excluded : path_untracked;
>>
>> --
>> 2.25.0.vfs.1.1
> 
> Otherwise, the patch looks good to me and I'll be happy to replace my
> patch with this one.
 
Let me send a v2 of this patch now that you've pointed out my error. It
is worth making this method clearer before you expand substantially on
this final case.

Thanks,
-Stolee
