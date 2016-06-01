From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule operations: tighten pathspec errors
Date: Wed, 1 Jun 2016 13:55:09 -0700
Message-ID: <CAGZ79kbdfEJ1iSpOJ=HfHP=EvVxB9Sv+5Zk+goLSOJphh8ZZ+w@mail.gmail.com>
References: <1463793689-19496-1-git-send-email-sbeller@google.com> <xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:00:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DFV-0007Jt-DP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 23:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbcFAVAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 17:00:15 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36374 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcFAVAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 17:00:14 -0400
Received: by mail-qk0-f174.google.com with SMTP id i187so21775332qkd.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7ySsgGnAqxaemZx756daU/UMfv/wc+mx1EYALu6TYMQ=;
        b=BQJ6/FQhzzRfMOwBA76A/nuT2tgvYsg79eknuJcdek7kuyY6gQ23o+dFcbxdTDKOLd
         I8Hje5aipFmgwrJQWz2yDvJKF9Ppqp2BClXm5qDEusHVKixBtcxY3XQBpnrE8qjK2Trv
         CLJInbxjml5QuV4SPtlyf8aXPxIbqIwHAZ3lk76VqFJWzLUSqC8kYsrOamFnypMi5xm+
         u1p/n2nGg+kaB4WCC1ffFMjfI03g4LlM0L5elvQrRDQ4L/ptHNK998+/makVXDL4xyHF
         E9phcILclgDTwzJqAZhcDyuTzgkgb7USa+Totqz1zTcxmBPWDm4rjdduj68ug4wBcN67
         nHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7ySsgGnAqxaemZx756daU/UMfv/wc+mx1EYALu6TYMQ=;
        b=j/pJqqPSKfCIFNwzJVVHTpEWNehC013zXakeGLfzEkDIb/Vlxwmfe0/qUiS1LW/JqT
         3FLZTaHXJvbEau7e/V87x32OEn+8L3tzfUO/aUH3aMIJeiFPsvvixxgZtWKAmrR/eRrv
         w3TJMfr2C0kiIEQX2SouQ75RaPB5VCnTZp1wpgEeD3Ri9xHgUhqgK8uioyrdEcEScDpA
         tFltufWmwFhfpWDsWYUIPASIuVXE20E4eRzQhpEzDpysyVJ/UFs4neU9kltB+m5eYHNN
         fzW5fEi7Pwh0dVd7m4W2y2DYNol1j83nNB1FyT55ATNkm1ocxeHYUfjFQSPpKipuPLX0
         C6LA==
X-Gm-Message-State: ALyK8tKuGNROHXTfbwmMByruEf+fDfQQepZauPDc3dcHQCvxojgn9DjaSHbZZzgJZx1R8+HWEcUhkACFKC/vBe4J
X-Received: by 10.237.41.5 with SMTP id s5mr5853719qtd.71.1464814510051; Wed,
 01 Jun 2016 13:55:10 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 13:55:09 -0700 (PDT)
In-Reply-To: <xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296164>

On Thu, May 26, 2016 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> It's a first initial version with no tests (and probably conflicting with
>> some topics in flight), but I was curious how involved this issue actually is,
>> so I took a stab at implementing it.
>
> I take it to mean "This is s/PATCH/RFC/".
>
>> +--error-unmatch::
>> +     If the pathspec included a specification that did not match,
>> +     the usual operation is to error out. This switch suppresses
>> +     error reporting and continues the operation.
>
> The behaviour described is a total opposite of the option with the
> same name "ls-files" has, no?
>
> If there were no default, --error-unmatch would make an unmatching
> pathspec an error and --no-error-unmatch would make it a non-error.
>
> If the default is to error out, there is no need for --error-unmatch
> to exist, but you do want --no-error-unmatch aka --unmatch-ok.
>
> If the default is not to error out, --error-unmatch should make it
> notice and turn it into an error.
>
> I am guessing that you were debating yourself which should be the
> default and the patch ended up in an inconsistent state, the
> description assuming a more strict default, while the option name
> assuming a less strict default.

Yes.

>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 5295b72..91c49ec 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -19,7 +19,8 @@ struct module_list {
>>  static int module_list_compute(int argc, const char **argv,
>>                              const char *prefix,
>>                              struct pathspec *pathspec,
>> -                            struct module_list *list)
>> +                            struct module_list *list,
>> +                            int unmatch)
>
> What is "unmatch"?  "Catch unmatch errors, please?"  "Do not check
> and report unmatch errors?"
>
> My cursory read of a few hunks below tells me that you meant the
> latter, i.e. "unmatch_ok".
>
>> @@ -36,10 +37,9 @@ static int module_list_compute(int argc, const char **argv,
>>
>>       for (i = 0; i < active_nr; i++) {
>>               const struct cache_entry *ce = active_cache[i];
>> -
>> -             if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> -                                 0, ps_matched, 1) ||
>> -                 !S_ISGITLINK(ce->ce_mode))
>> +             if (!S_ISGITLINK(ce->ce_mode) ||
>> +                 !match_pathspec(pathspec, ce->name, ce_namelen(ce),
>> +                                 0, ps_matched, 1))
>>                       continue;
>
> OK, this is the crucial bit in this patch. pathspec matches are now
> done only against gitlinks, so any unmatch is "pattern or path
> given, but there was no such submodule".

right.

>
>> @@ -53,7 +53,9 @@ static int module_list_compute(int argc, const char **argv,
>>                       i++;
>>       }
>>
>> -     if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
>> +     if (!unmatch &&
>> +         ps_matched &&
>> +         report_path_error(ps_matched, pathspec, prefix))
>>               result = -1;
>
> If unmatch is not true, then check if ps_matched records "aw, this
> pathspec element did not get used" and complain.  If unmatch is
> true, we do not do that.
>
> Which confirms my earlier "'unmatch' here means 'unmatch_ok'".
>
> It is tempting to update report_path_error() return "OK" when its
> first parameter is NULL.

such that we can do a

    if (report_path_error(unmatch_ok ? NULL : ps_matched, pathspec, prefix)))
        result = -1;

That looks good and inside of report_path_error we would only need a

    if (!ps_matched)
        return 0;

at the beginning.

>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index fb68f1f..f10e10a 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -391,6 +391,9 @@ cmd_foreach()
>>               --recursive)
>>                       recursive=1
>>                       ;;
>> +             --error-unmatch)
>> +                     unmatch=1
>> +                     ;;
>
> So "--error-unmatch" does pass "--unmatch" which is "please ignore
> unmatch errors".  That is a bit strange (see above).
>
>> @@ -407,7 +410,7 @@ cmd_foreach()
>>       # command in the subshell (and a recursive call to this function)
>>       exec 3<&0
>>
>> -     git submodule--helper list --prefix "$wt_prefix"|
>> +     git submodule--helper list ${unmatch:+--unmatch} --prefix "$wt_prefix"|
>
> For this to work, somebody must ensure that the variable unmatch is
> either unset or set to empty unless the user gave --error-unmatch to
> us.  There is a block of empty assignments hear the beginning of
> this file for that very purpose, i.e. resetting a stray environment
> variable that could be in user's environment.
>
> The patch itself does not look too bad.  I do not have an opinion on
> which one should be the default, and I certainly would understand if
> you want to keep the default loose (i.e. not complaining) with an
> optional error checking, but whichever default you choose, the
> option and variable names need to be clarified to avoid confusion.

Ok I'll fix the variable names; I think for consistency with e.g.
ls-files --error-unmatch
we would want to be loose by default and strict on that option.

Thanks,
Stefan

>
