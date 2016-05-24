From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 24 May 2016 11:24:15 +0530
Message-ID: <CAFZEwPN3L5Y-7wNj6TMjg-jPb_oDQYjukBj1uL6OJ8rWAoqjcQ@mail.gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 07:54:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b55IO-00086P-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 07:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbcEXFyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 01:54:17 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33521 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbcEXFyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 01:54:16 -0400
Received: by mail-yw0-f195.google.com with SMTP id y6so956380ywe.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=OhKyElWholU380XcXzPfxitnYjINQcNlJJrG+JhvlCU=;
        b=ivxdCtGx/dqmc8cRaOc6EnPRZf629CWN3U2iOjr0ZpfcBoqM2HapedktJgf3agzTIw
         qytJ3L1Nx5zx9t2cALNAx+qkPDQVpq3U66kBOQKHJ5QUBereeuEmUDt4qig6mdYJ3YiO
         nylRMNMepQ5IP31jGRojNmu0i3WLFCNaCT0RVpPT9H55Z5Zb0WozNUsswxU3NXcFVuwh
         BOQ/1R7/28lBXO5vpxY/qHP29CQnWyz4C7g0/GGz7tatlhH0oDnlq/qCeJdfxJ4y+1Oc
         iY96Q+j2E1WgLh9xT8E+KPJZy+q01Rp5noKYxjHkD/q2Whtjos5qwNhjKHHqY/mL6u4b
         OqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OhKyElWholU380XcXzPfxitnYjINQcNlJJrG+JhvlCU=;
        b=SmT+b+cuBw07piSGv0ITcDSDVmSlhZJYCfjEiqSuQ0KQKCvNrvH61UMjqmQNoerBIY
         YzSMuVM08pL7c89bCA+TimiYZWyGvUkD+HH0mAqCNHrogkF96TgEyBEZzA3qxLm86J/r
         ysb8ek0ZU/GZeHj88mpw83k7aJoiZWeQuRvGgyCAJmE8kOli9cI52LuNQgxcqvWNDvCF
         Ab6KMKE9Bdv9hdOfNiYmj8FSbbbnXAVltHqwkmLjjho7Dqw7ZZW2KxQJWNwoh1Jr85/E
         9FtvyJJ/SyC4WdMIQ0AgQLHtkQdNfy4UlGZclaQwTWGkvlTDfOLBH8J7Guw0dQNSsPWS
         wnnA==
X-Gm-Message-State: ALyK8tIOrnZ/BXHwnaWEbGgCUVuqzorQLR5nNVQ/eUtiEv1D5Q1PinvGXiezLBoSl1+iecebcDqmumUsxM7qzw==
X-Received: by 10.37.215.86 with SMTP id o83mr1420158ybg.131.1464069255126;
 Mon, 23 May 2016 22:54:15 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 23 May 2016 22:54:15 -0700 (PDT)
In-Reply-To: <xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295417>

Hey Junio,

On Tue, May 24, 2016 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> This is a follow up commit for f932729c (memoize common git-path
>> "constant" files, 10-Aug-2015).
>>
>> It serves two purposes:
>>   1. It reduces the number of calls to git_path() .
>>
>>   2. It serves the benefits of using GIT_PATH_FUNC as mentioned in the
>>      commit message of f932729c.
>
> All of that is a good idea, but I have huge doubts about its use.
>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 391126e..ffa242c 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -92,8 +92,10 @@ N_("If you wish to skip this commit, use:\n"
>>  "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
>>  "the remaining commits.\n");
>>
>> +static GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
>> +
>>  static const char *use_message_buffer;
>> -static const char commit_editmsg[] = "COMMIT_EDITMSG";
>> +static const char commit_editmsg_path[] = git_path_commit_editmsg();
>
> The function defined with the macro looks like
>
>         const char *git_path_commit_editmsg(void)
>         {
>                 static char *ret;
>                 if (!ret)
>                         ret = git_pathdup("COMMIT_EDITMSG");
>                 return ret;
>         }
>
> so receiving its result to "const char v[]" looks somewhat
> suspicious.
>
> More importantly, when is this function evaluated and returned value
> used to fill commit_editmsg_path[]?  In order for git_pathdup() to
> produce a meaningful result, it needs to know where .git/ directory
> is, which (roughly) means setup_git_dir() must have been called from
> a callchain from main() somewhere already.
>
> But I do not think the linker knows that fact.

I think otherwise. git_pathdup() calls get_worktree_git_dir() which
calls get_git_dir() which if uninitialized calls setup_git_env(). So
technically the code gets to know the .git/ directory quite early.
Though I am not very sure whether this one is a desirable fact. There
would be later instances which would in turn call to know where the
.git/ directory.

>
>> @@ -771,9 +773,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>               hook_arg2 = "";
>>       }
>>
>
> Instead, what you could do is to call git_path_commit_editmsg() when
> you refer to that global variable whose initialization is suspect.
>
>> -     s->fp = fopen_for_writing(git_path(commit_editmsg));
>> +     s->fp = fopen_for_writing(commit_editmsg_path);
>
> i.e.
>
>         s->fp = fopen_for_writing(git_path_commit_editmsg());
>
> As you can see in its definition, when the original code used to
> call git_path(), it is safe to call git_path_commit_editmsg(),
> because for the original git_path() to be correct, the code should
> already have established where $GIT_DIR is, so it is safe to call
> git_pathdup(), too.  Also, as you can see in its definition, calling
> the function many times would not cause git_path() called many
> times.  The first invocation will keep its value that is constant
> within the program that works with a constant $GIT_DIR.

I agree that it is actually not required to again compute the location
of .git/ directory and can only return the value.

Overall I agree to your idea of just using git_path_commit_editmsg()
instead of git_path() so as to not disturb any previous
implementations which can lead to some complications. Also if I am
changing some internal semantics there should be a valid reason which
there isn't really as I don't see any benefit in getting the location
of .git/ early in the program.

> And you do not free its return value.
This is one of the thing that bugging me with GIT_PATH_FUNC. Wouldn't
not freeing the memory lead to memory leaks?

Regards,
Pranit Bauva
