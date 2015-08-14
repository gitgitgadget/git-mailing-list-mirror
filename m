From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 1/4] notes: document cat_sort_uniq rewriteMode
Date: Fri, 14 Aug 2015 15:53:48 -0700
Message-ID: <CA+P7+xoSB0um3FkhRAXGF1t0ZoYk0zaxAvAOvFcwn+CWQ-gyfg@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
 <1439586835-15712-2-git-send-email-jacob.e.keller@intel.com> <xmqq4mk1h66i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, Git List <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNrc-0001AX-IZ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbbHNWyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:54:09 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33831 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbHNWyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:54:07 -0400
Received: by iodb91 with SMTP id b91so99356472iod.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p8XEzJA6uFt/OXg9Lf/KxQM9YH+pDkoZHs9Qs3nlQyo=;
        b=X7zvcYpTcp/LasyLaLv9Bxeqt0zHUoXe3OLzC34G2qV9iOOyrwdov/Bh2Zi5Dw1sp6
         5BzUxjIh4zUcZbg+cKSvBjINDpXROdLjlOt05DGUtv31Hlo06D/1KDdOoSmQ/2RuxBy0
         Q9M+cT1J5Ikbn9CYNv45pq9dU6vUti7yDEfNPM/lVPvT3wne6JWbGFXdG6ZpF63CKJJ3
         qjNnO9EQsXLnBA6b5rNmj52BBiv0aj9Wg0WTh03q12R2pMW4fArWBCctVKXaIT57vAed
         aNU6gU+rDG9QE3e6wlC5V0Sf1oAij9PDtSZUmTQakcx+nwVlD4S2XnD9gE2/m3G6Rgle
         pkkw==
X-Received: by 10.107.154.67 with SMTP id c64mr3770053ioe.0.1439592847334;
 Fri, 14 Aug 2015 15:54:07 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Fri, 14 Aug 2015 15:53:48 -0700 (PDT)
In-Reply-To: <xmqq4mk1h66i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275973>

On Fri, Aug 14, 2015 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 75ec02e8e90a..de67ad1fdedf 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1947,8 +1947,8 @@ notes.rewriteMode::
>>       When copying notes during a rewrite (see the
>>       "notes.rewrite.<command>" option), determines what to do if
>>       the target commit already has a note.  Must be one of
>> -     `overwrite`, `concatenate`, or `ignore`.  Defaults to
>> -     `concatenate`.
>> +     `overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
>> +     Defaults to `concatenate`.
>>  +
>>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>>  environment variable.
>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> index 851518d531b5..674682b34b83 100644
>> --- a/Documentation/git-notes.txt
>> +++ b/Documentation/git-notes.txt
>> @@ -331,7 +331,8 @@ environment variable.
>>  notes.rewriteMode::
>>       When copying notes during a rewrite, what to do if the target
>>       commit already has a note.  Must be one of `overwrite`,
>> -     `concatenate`, and `ignore`.  Defaults to `concatenate`.
>> +     `concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
>> +     `concatenate`.
>>  +
>>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>>  environment variable.
>
> This obviously is not a problem introduced by this patch, but I
> wonder why we have two similar but different set of modes for
> rewrtie and merge.  Isn't 'overwrite' like 'ours', 'ignore' like
> 'theirs', and 'concat' like 'union', and if these are similar
> enough, perhaps it would be helpful to the end user if we unified
> the terms (or accepted both as synonyms for backward compatibility)?
>
> Also I notice that you cannot manually reconcile while rewriting;
> don't we want to have 'manual' there, too, I wonder?
>
> [jc: Cc'ed Thomas who invented rewrite back when merge was not even
> there, and Johan who added merge]
>

I was not sure. I believe that re-write doesn't do the same thing as
merge? I think we could make all of them handle the "overwrite", which
is basically a synonym of, I think "theirs" depending on the direction
of the "merge".

I don't know if re-write actually supports manual mode at all!

Maybe we could make merge support the other names as synonyms, and
then code re-write in terms of merging?

I wasn't sure so I chose only to document the mode that was missing.

Regards,
Jake
