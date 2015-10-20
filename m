From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/12] git submodule update: Handle unmerged submodules in C
Date: Tue, 20 Oct 2015 14:21:30 -0700
Message-ID: <CAGZ79kZKZhE_LyM5yvjrGXcxQXmN0F_2Jnag2PsAXAboO6qdzw@mail.gmail.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-7-git-send-email-sbeller@google.com>
	<xmqqlhax6y9s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:21:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoeLg-0003by-SM
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 23:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbbJTVVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 17:21:32 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34871 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbJTVVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 17:21:31 -0400
Received: by ykaz22 with SMTP id z22so30359264yka.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CODLTlluOwQPPgV2rLCPj3zYVmSOPCnmqBET9w/XoTA=;
        b=TJfn8kMISH65U4LXd4GX52XHRT43Pg0YOQIaPfeFFJiXg0SyFgyQ3lOe2pO7j6LiRB
         2wmjMIwJLlQt3js9ZZ3hjeDweGcDWwD/AQWiI3x65zdGcmsaFQCTEsIt19MmaIeAMC1u
         B37BpfAIjjitZ2qL03HmAexe2DROwtwQG0EOyl7ozCjGR//jJZfCAC5jzDRG+b/wlaZ7
         AIPmAFaGSfH/F4Cpd0x5kZi2PUYRhwlsiFkp2Hgm3ZG2eIvpHDa/+iJwYLi9Azdox/nh
         iOt0FhStCAIw8HdiyiHgZIdxsEmwf//I/9ivktSZJ2iELE+Ld2WpZqPLebymjUeMSrH1
         eu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CODLTlluOwQPPgV2rLCPj3zYVmSOPCnmqBET9w/XoTA=;
        b=lRCqDKyMiAr5DG84iuXStFlGc3PQvpjAG6p6MgJjrQN69o5ss5U17mApBa47jcA721
         fqMs37ccoWmkrfBwCCtaB1xod6MJ2C7fIsCtjQhs1m05RXnEuM3NVQRJtu98rBFtLP8i
         XcJOvsYsLVp7dMrF5pG19nCAoz30F+fD9cycN25Y/8eMDsXeq33NGluHUKy2U4nOWDpk
         8DwOCU1j6bYFBT3ua0W0WEDcD7fg7gNO3Hy23CFF2D8zng9OHx0bdX5v9zuTSRzP9uCp
         AAu25IXvvdnjBRKlll4DejqBfT1JPUe3/Wrq28e1QlFGOIC/Rap8Zekxgdd16EZBEGA+
         l5uQ==
X-Gm-Message-State: ALoCoQmieo/qaqzfSLQ0mCdah2Q9IunSaQV/L4I8R2oJ5xUH3Tm64u7LJlcouODiovra+/5g80DL
X-Received: by 10.13.230.194 with SMTP id p185mr4575725ywe.320.1445376090642;
 Tue, 20 Oct 2015 14:21:30 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 20 Oct 2015 14:21:30 -0700 (PDT)
In-Reply-To: <xmqqlhax6y9s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279941>

On Tue, Oct 20, 2015 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/submodule--helper.c | 15 +++++++++++----
>>  git-submodule.sh            |  6 +-----
>>  2 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 47dc9cb..f81f37a 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -284,11 +284,18 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
>>       for (i = 0; i < list.nr; i++) {
>>               const struct cache_entry *ce = list.entries[i];
>>
>> -             if (ce_stage(ce))
>> -                     printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
>> -             else
>> -                     printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
>> +             char *env_prefix = getenv("prefix");
>

[Just checked the date, it's the old series. I am about to send out a new
series which collapses some patches in here, is on top of the fixes series and
off course fixes this issue ;) ]

> This somehow makes me feel dirty.  Do we really export such an
> environment variable that is named overly generically to communicate
> with our own helpers?

I agree that this is bad. It was the fastest way.
I should have taken the slower road. I think I'll replace this with
another argument.

>
> I can see why you need to be able to prefix leading paths (i.e. you
> would need to prefix path to the enclosing submodule to a path to
> obtain the "global view" from the very top-level superproject while
> recursing into nested submodules), but still...
>
>> +             if (ce_stage(ce)) {
>> +                     if (env_prefix)
>> +                             fprintf(stderr, "Skipping unmerged submodule %s/%s",
>> +                                     env_prefix, ce->name);
>> +                     else
>> +                             fprintf(stderr, "Skipping unmerged submodule %s",
>> +                                     ce->name);
>> +                     continue;
>> +             }
>>
>> +             printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
>>               utf8_fprintf(stdout, "%s\n", ce->name);
>>       }
>>       return 0;
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index d2d80e2..0754ecd 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -661,11 +661,7 @@ cmd_update()
>>       while read mode sha1 stage sm_path
>>       do
>>               die_if_unmatched "$mode"
>> -             if test "$stage" = U
>> -             then
>> -                     echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>> -                     continue
>> -             fi
>> +
>>               name=$(git submodule--helper name "$sm_path") || exit
>>               url=$(git config submodule."$name".url)
>>               if ! test -z "$update"
