From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] GSoC 2014 Microproject 1 rewrite skip_prefix() as loop
Date: Thu, 27 Feb 2014 17:10:48 +0530
Message-ID: <CAFbjVcmbF4MYj1t2v1_dxQ0z4mqMfFChK2HdCFiEqWL6Wo2vGg@mail.gmail.com>
References: <1393433195.4629.4.camel@dj-pc>
	<530F2238.4090303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:41:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzKo-0001Xo-7u
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbaB0Lkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:40:51 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:53464 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaB0Lkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 06:40:49 -0500
Received: by mail-lb0-f194.google.com with SMTP id l4so272548lbv.5
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 03:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/bSkyoOeWs/yXvpmUdzzYpMmeV/f+zixlNJ9vZDgexA=;
        b=uLnFNKd8mru4Jb7FqyWE4Qkj0alarmqtrQIPBV+Ehxt9fRfqlxu1tXs27HYAllSbn0
         8CM3V+athJnHze1Cbpsbg1VKGwgd851ZWC1cAPtvGVGLIufOzJC3crDcJqGapNkU0m4F
         rIkKPSP2v7qvg2t4FLfNEfgTFVl7H09r10WW1VcvYU9NGj1XRzcdxm0YXdqtflcActZ0
         6wOWeu30AMgjoTgUXBgz9sWl10+09oXV2Q0rl9TxMMOdpp3cHWqPXw+2t+467yhVp4ua
         RniF3WThntuOzDY6EgiODGrex5sPGPGm2M8sB9M8nrZFo5Ag1pixvnoeQs/SjMWLlzpI
         mdtQ==
X-Received: by 10.152.120.201 with SMTP id le9mr860956lab.68.1393501248666;
 Thu, 27 Feb 2014 03:40:48 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Thu, 27 Feb 2014 03:40:48 -0800 (PST)
In-Reply-To: <530F2238.4090303@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242809>

Thanks for the reply,
I was unable to get git send-email working. Now its working, I'll
resend the patch.
I ran all the tests, they are working properly.
About the comment, I meant, there is a similar function
strbuf.c:starts_with() which does the exact same job, but it returns 0
or 1.
I just changed it to return a (const char *) accordingly.

On Thu, Feb 27, 2014 at 5:02 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/26/2014 05:46 PM, Faiz Kothari wrote:
>> I am Faiz Kothari, I am a GSoC aspirant and want to contribute to git.
>> I am submitting the patch in reponse to Microproject 1,
>> rewrite git-compat-util.h:skip_prefix() as a loop.
>>
>> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
>
> The subject of your email plus the part above the "---" line will be
> taken directly to be used as the commit message.  So it should not
> include information that is inappropriate for a commit message.
>
> You can put such information directly below the "---" line.
>
> Please also see my comments below.
>
>> ---
>>  git-compat-util.h | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index cbd86c3..bb2582a 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char
>> *suffix);
>>
>>  static inline const char *skip_prefix(const char *str, const char
>> *prefix)
>
> The line above seems to have been broken by your email program.  It is
> important for efficiency reasons that patches be readable directly out
> of emails (e.g., by using "git am").  Please practice by sending the
> patch to yourself different ways until "git am" works on it correctly.
>
>>  {
>> -     size_t len = strlen(prefix);
>> -     return strncmp(str, prefix, len) ? NULL : str + len;
>> +     for (; ; str++, prefix++)
>> +             if (!*prefix)
>> +                     return str;//code same as strbuf.c:starts_with()
>
> We don't use "//" for comments, and please space things out the way
> other code does it.  But actually, IMO this particular comment doesn't
> really belong permanently in the code.  It rather belongs in the commit
> message, or in the discussion (under the "---"), or maybe it should be
> taken as an indication of a deeper problem (see below).
>
>> +             else if (*str != *prefix)
>> +                     return NULL;
>>  }
>>
>>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
>>
>
> The code itself looks correct.
>
> But, considering your comment, would it be appropriate for one of the
> functions to call the other?
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
