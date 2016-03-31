From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 4/5] submodule--helper, module_clone: always operate on
 absolute paths
Date: Thu, 31 Mar 2016 15:59:29 -0700
Message-ID: <CAGZ79kaAs_ZwxfhLSTw3z8JY33vGToms2z6zYEiCmRpfS6SA+Q@mail.gmail.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-5-git-send-email-sbeller@google.com>
	<xmqqfuv6l1xf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:59:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allYw-0000tc-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760AbcCaW7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:59:31 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34284 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbcCaW7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:59:30 -0400
Received: by mail-io0-f179.google.com with SMTP id e3so132160124ioa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 15:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fj9Ha1BPI+NQWs6pJBEEUPBVJaSyMW0xVCjhJGwGDp8=;
        b=pkDCj4P1MD1+yL3NY/K8qOOcifG0gomXnTWCseM/gX9fQEhbL8Hjor08GzCzX1MTvC
         RInJkjbMqRI9zD4t6gxJ2vbz/7AK7n91KA8iCgrhJ1+wBKpXNZ+0N/KtNfeKOwvhTS5x
         G5OtkRwrmaU99PXDqk22N/kajG5P4qUcDSkWa0w3H6FBqyrinP2g6NSvR5MmnzMA1ggt
         Hfj5wvaV5cxf5xIvimcZTL2kE16S+WXYlLT/tYjROyckcJcIbDuMoZ1XOoH/vA5L+bl6
         M9HI6VnGakGcX80k4/scq06SOuBxqGekKl6yC2RuIOQB9MXnkdRZ9zsEBqW1G6p2NAYl
         HPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fj9Ha1BPI+NQWs6pJBEEUPBVJaSyMW0xVCjhJGwGDp8=;
        b=agXW9AkB17nv+TniSNwSHLQu/evaoJNV2OacZRpV1gNcwQvywiTV09aqkkE/nm38vW
         BFc78tflFyR1fuB4tJxI2aEZwl45x9h+40vnR13RVMJaMla53HSSdXbL6T9FsZZvU2aF
         m/YU81SQuP51++wHKPvkynDuBq+QWlLedDnUb8RfHNQZ69Uk4vQiEboOKx9t9YTCTvO6
         Ll7yjTV0StzH3iJexRKGo46DCP9+1AcN709Fp+g5PA0enQZ7eJhQ/s3w2twmgRgrcUcW
         VtBnYhqwZMRX6TjMVmRkTSA1HO5qfH2LlGmMTBS6TKbfn6TrtPIzSMlRiG1OnpoKXQJy
         iY5g==
X-Gm-Message-State: AD7BkJKBj3ElzwEAw0NY47LK5piUBORraFdMQANlRoqkcsNnjW68zloR+YJEMa9e9c18CEeEzcFGXyZiVZR/AcuA
X-Received: by 10.107.184.8 with SMTP id i8mr1462516iof.96.1459465169684; Thu,
 31 Mar 2016 15:59:29 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 15:59:29 -0700 (PDT)
In-Reply-To: <xmqqfuv6l1xf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290486>

On Thu, Mar 31, 2016 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     if (!is_absolute_path(sm_gitdir)) {
>> +             char *cwd = xgetcwd();
>> +             strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
>> +             sm_gitdir = strbuf_detach(&sb, 0);
>> +             free(cwd);
>
> It would be surprising that this would be the first codepath that
> needs to get an absolute pathname in the codebase that is more than
> 10 years old, wouldn't it?  Don't we have a reasonable API helper
> function to do this kind of thing already?
>
>     ... goes and looks ...
>
> Doesn't absolute_path() work here?

*reads absolute_path(...)*

    Yes that is great. But why is it written the way it is?
    I would have expected:

 const char *absolute_path(const char *path)
 {
        static struct strbuf sb = STRBUF_INIT;
-       strbuf_reset(&sb);
        strbuf_add_absolute_path(&sb, path);
-       return sb.buf;
+       return strbuf_detach(&sb);
 }

Further checking reveals any caller uses it with

    desired= xstrdup(absolute_path(my_argument));

We are loosing memory of the strbuf here. so if I we'd
take the diff above we can also get rid of all the xstrdups
at the callers. For now I will adhere to all other callers and use
xstrdup(absolute_path(...) here too.

I'll remove the unrelated changes as well in a resend.

>
>> @@ -221,7 +240,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>       submodule_dot_git = fopen(sb.buf, "w");
>>       if (!submodule_dot_git)
>>               die_errno(_("cannot open file '%s'"), sb.buf);
>> -
>>       fprintf(submodule_dot_git, "gitdir: %s\n",
>>               relative_path(sm_gitdir, path, &rel_path));
>>       if (fclose(submodule_dot_git))
>
> Looks like an unrelated change to me.
>
>> @@ -229,24 +247,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>       strbuf_reset(&sb);
>>       strbuf_reset(&rel_path);
>>
>> -     cwd = xgetcwd();
>>       /* Redirect the worktree of the submodule in the superproject's config */
>> -     if (!is_absolute_path(sm_gitdir)) {
>> -             strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
>> -             free(sm_gitdir);
>> -             sm_gitdir = strbuf_detach(&sb, NULL);
>> -     }
>> -
>> -     strbuf_addf(&sb, "%s/%s", cwd, path);
>>       p = git_pathdup_submodule(path, "config");
>>       if (!p)
>>               die(_("could not get submodule directory for '%s'"), path);
>>       git_config_set_in_file(p, "core.worktree",
>> -                            relative_path(sb.buf, sm_gitdir, &rel_path));
>> +                            relative_path(path, sm_gitdir, &rel_path));
>>       strbuf_release(&sb);
>>       strbuf_release(&rel_path);
>>       free(sm_gitdir);
>> -     free(cwd);
>> +
>
> This addition of blank, too.
>
>>       free(p);
>>       return 0;
>>  }
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index fc11809..ea3fabb 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -818,7 +818,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
>>       )
>>  '
>>
>> -test_expect_failure 'recursive relative submodules stay relative' '
>> +test_expect_success 'recursive relative submodules stay relative' '
>>       test_when_finished "rm -rf super clone2 subsub sub3" &&
>>       mkdir subsub &&
>>       (
