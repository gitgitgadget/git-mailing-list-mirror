From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule helper list: Respect correct path prefix
Date: Wed, 24 Feb 2016 13:32:22 -0800
Message-ID: <CAGZ79kbbKnips12CU6KZX39rAZ_O-pYy20nsSGCCf+1w5LzgxA@mail.gmail.com>
References: <1456348502-4529-1-git-send-email-sbeller@google.com>
	<xmqqy4a9st2v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Caleb Jorden <cjorden@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:32:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYh2q-0007br-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbcBXVcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:32:24 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34994 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcBXVcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:32:23 -0500
Received: by mail-ig0-f177.google.com with SMTP id hb3so303470igb.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ecVh/5mVEYGMH/uUWpF0QiolqJyIIUbMnTZ4DuC8hNU=;
        b=BaTO3TuD+MpWSwLCZaMcSA0u4lOG6ZIXFvhx221xrtgC7alYn6N5snFu3w2uHzsqrA
         CbtjDPnD1x5jEwtzXws7pLolmSO7ZdfBeDUkYR1mabMCS/DYKruqHzfbX7Gy9HQeYHMF
         OqqV+TLiOeRn3BxtYO++tCYNSP9NwrhiOvK0gqQA5SURTSgGgN39gCuIui+XhPf08YzS
         xiN8MmiU/34bh5lHfBgtfLo65o51yT98pJ/0zQQX3Rv37wVTlpr9u52826TPLjXLvuIC
         h6/brucR5mwAMDqV042OybMSO8vA0ywBENhtUOHXGeXOgI7y3/o6N2h4sT/1PNciBjvI
         2f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ecVh/5mVEYGMH/uUWpF0QiolqJyIIUbMnTZ4DuC8hNU=;
        b=NZ+1HHuPnMGUyxphcPepvszOy9zgltjDJwpviROuwIe8aJ7Qv42Qu6ZudzMkBah3Cj
         K9lxcpFv2y8fKt2+3ZlaNmgWan3hB32R3slCj0pNPlXzcsTXU4smQSgtqNQtop3ag4WR
         P56p4VAMbRQS2kCsMJdu0nZrUwTri4y9krI4n8BA1Xx8t9jlEu/NJJn2IDSR2Rt5wx7r
         CnM60ASi1TWnajK9bvbXhr6xIMTfN+p4HD2HgcOzcIsW9H8a3Pj1/839wxCdtOCWpxly
         Va2g/gywUZRMrCaH5CKlE4iStgL5gEtgy134LW69lK/njrraOaWuBdtXBOz4yjtUKzyt
         6v4Q==
X-Gm-Message-State: AG10YOTslPVk7v5/tNjM7WRIkrb7y6UHfLWLqE/LQcZvzF8AuHLLclUrrvl1ThQPnCm+tLXXBwVZhvlIByGpjWEE
X-Received: by 10.50.155.37 with SMTP id vt5mr60632igb.30.1456349542382; Wed,
 24 Feb 2016 13:32:22 -0800 (PST)
Received: by 10.107.12.75 with HTTP; Wed, 24 Feb 2016 13:32:22 -0800 (PST)
In-Reply-To: <xmqqy4a9st2v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287233>

On Wed, Feb 24, 2016 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is a regression introduced by 74703a1e4d (submodule: rewrite
>> `module_list` shell function in C, 2015-09-02).
>>
>> Add a test to ensure we list the right submodule when giving a specific
>> path spec.
>>
>> Reported-By: Caleb Jorden <cjorden@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  I developed this on top of current origin/master, though I can backport it
>>  to 2.7 as well if desired.
>>
>>  I do not remember the cause why we started to ignore a common prefix.
>
> The code you are removing with this patch is probably an
> optimization you copied from builtin/ls-files.c.  When the
> optimization is used, the original also limits the list of paths to
> those that match the prefix by calling prune_cache(), but perhaps
> you didn't have a corresponding code in your copy?

I think that is a good explanation. So do we want to add the pruning
or use this patch to fixup the regression and wait until someone complains
about the speed penalty due to no optimization?

>
>>
>>  Thanks,
>>  Stefan
>>
>>  builtin/submodule--helper.c | 10 ++--------
>>  t/t7400-submodule-basic.sh  | 25 +++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index f4c3eff..ed764c9 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -22,17 +22,12 @@ static int module_list_compute(int argc, const char **argv,
>>                              struct module_list *list)
>>  {
>>       int i, result = 0;
>> -     char *max_prefix, *ps_matched = NULL;
>> -     int max_prefix_len;
>> +     char *ps_matched = NULL;
>>       parse_pathspec(pathspec, 0,
>>                      PATHSPEC_PREFER_FULL |
>>                      PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>>                      prefix, argv);
>>
>> -     /* Find common prefix for all pathspec's */
>> -     max_prefix = common_prefix(pathspec);
>> -     max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>> -
>>       if (pathspec->nr)
>>               ps_matched = xcalloc(pathspec->nr, 1);
>>
>> @@ -44,7 +39,7 @@ static int module_list_compute(int argc, const char **argv,
>>
>>               if (!S_ISGITLINK(ce->ce_mode) ||
>>                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> -                                 max_prefix_len, ps_matched, 1))
>> +                                 0, ps_matched, 1))
>>                       continue;
>>
>>               ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
>> @@ -57,7 +52,6 @@ static int module_list_compute(int argc, const char **argv,
>>                        */
>>                       i++;
>>       }
>> -     free(max_prefix);
>>
>>       if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
>>               result = -1;
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 540771c..be82a75 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -999,5 +999,30 @@ test_expect_success 'submodule add clone shallow submodule' '
>>       )
>>  '
>>
>> +test_expect_success 'submodule helper list is not confused by common prefixes' '
>> +     mkdir -p dir1/b &&
>> +     (
>> +             cd dir1/b &&
>> +             git init &&
>> +             echo hi >testfile2 &&
>> +             git add . &&
>> +             git commit -m "test1"
>> +     ) &&
>> +     mkdir -p dir2/b &&
>> +     (
>> +             cd dir2/b &&
>> +             git init &&
>> +             echo hello >testfile1 &&
>> +             git add .  &&
>> +             git commit -m "test2"
>> +     ) &&
>> +     git submodule add /dir1/b dir1/b &&
>> +     git submodule add /dir2/b dir2/b &&
>> +     git commit -m "first submodule commit" &&
>> +     git submodule--helper list dir1/b |cut -c51- >actual &&
>> +     echo "dir1/b" >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>>
>>  test_done
