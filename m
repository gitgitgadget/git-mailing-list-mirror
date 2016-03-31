From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/4] submodule--helper: use relative path if possible
Date: Thu, 31 Mar 2016 12:22:05 -0700
Message-ID: <CAGZ79kb9sRDuCvJw=S8_BLy7hej_YqE9Y-NbnQhQmafsZuEpwg@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-5-git-send-email-sbeller@google.com>
	<xmqqd1qapore.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:22:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliAX-0002VG-UO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbcCaTWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:22:09 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33379 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099AbcCaTWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:22:07 -0400
Received: by mail-io0-f176.google.com with SMTP id a129so118121069ioe.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=r30mklIcoZwShqY/kW/mpE/vhLkE8wFT3FtS+wx5G+E=;
        b=R9+RIsz0VEWIIhsyocGyr3gMv6pz8xrIhqkkfabXVzHit53rCw+NJaqQvYUaSHJIKP
         7DPwgA4kn9HU5rN3jzc7t15AQ7SuMSb3y7Njr/jAnvGb+7IJhjd1hSgp5BRQJ5aCeayS
         jaeBFzll+Zcc1KxgEjD1+GyZ6udV/cLBfQh0nmEzp7WZsvoWAbwNYR88APOkaQrwihPB
         kXBnEuI5qr5+LJGiTC7z7ifoiA0H66kofmClxLR207ONEKVKh4xqSUihk9mtyajExw9Y
         QS5mzo30e5WCfOZPskeE+12kusCBIpQeXmMfGZD9w7NhOtrpW/wdpcGtSFzJ5KXEIptb
         Nw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=r30mklIcoZwShqY/kW/mpE/vhLkE8wFT3FtS+wx5G+E=;
        b=NvV14DTGHeY0FCxyQOkrgGdURERi2j1qasRLU+68mdBKk9PiWfB1gzXOXNd7YFHe9z
         opJFKJ8jUiwnEOu/hT8tG4PmCONl7fegfbfS0Xzd7bgYzu0+ziRnIrOHL5Kl1BJhl6yP
         RpKmWvkv1wNRRmyQvZcGD3HN3zIp160abpQkXMDlPovnxPtMJJaJRLUkxylH+F4VxTH3
         mWXXeJXsIx4sX+JLKaxkvJrZrUAI/NbNT89YN6P/W3vDOR2/Z2Aw0XUe5Nr8eS8M1j4Z
         oBULVYsmJbM7xPnqljlFKdP6MSLR+REmk5EbkXca6Ji9vnAqhKZAT4M2n8/38jPuv7Pl
         ug3w==
X-Gm-Message-State: AD7BkJKFC3nUgZ7WADTLOnAvP5Z1cddHwzJFPOSJnN5lgPrR+FI1BsqoqK6+pZ7/VT6+RhZYEo9fbIkSY860389c
X-Received: by 10.107.184.8 with SMTP id i8mr644163iof.96.1459452125305; Thu,
 31 Mar 2016 12:22:05 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 12:22:05 -0700 (PDT)
In-Reply-To: <xmqqd1qapore.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290451>

On Thu, Mar 31, 2016 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As submodules have working directory and their git directory far apart
>> relative_path(gitdir, work_dir) will not produce a relative path when
>> git_dir is absolute. When the gitdir is absolute, we need to convert
>> the workdir to an absolute path as well to compute the relative path.
>>
>> (e.g. gitdir=/home/user/project/.git/modules/submodule,
>> workdir=submodule/, relative_dir doesn't take the current working directory
>> into account, so there is no way for it to know that the correct answer
>> is indeed "../.git/modules/submodule", if the workdir was given as
>> /home/user/project/submodule, the answer is obvious.)
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/submodule--helper.c | 7 +++++++
>>  t/t7400-submodule-basic.sh  | 2 +-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 914e561..0b0fad3 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -159,6 +159,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>       FILE *submodule_dot_git;
>>       char *sm_gitdir, *cwd, *p;
>>       struct strbuf rel_path = STRBUF_INIT;
>> +     struct strbuf abs_path = STRBUF_INIT;
>>       struct strbuf sb = STRBUF_INIT;
>>
>>       struct option module_clone_options[] = {
>> @@ -219,7 +220,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>       if (!submodule_dot_git)
>>               die_errno(_("cannot open file '%s'"), sb.buf);
>>
>> +     strbuf_addf(&abs_path, "%s/%s",
>> +                 get_git_work_tree(),
>> +                 path);
>
> The "path" is assumed to be _always_ relative to work tree?

In the code prior to this patch, that was assumed, yes.
(e.g. later in the code:

    /* Redirect the worktree of the submodule in the superproject's config */
    cwd = xgetcwd();
    strbuf_addf(&sb, "%s/%s", cwd, path);
    ....
    relative_path(sb.buf, ...
)

>
> I am wondering if it would be prudent to have an assert for that
> before doing this, just like I suggested assert(path) for [2/4]
> earlier [*1*].
>
> On the other hand, if we allow path to be absolute, this would need
> to become something like:
>
>         if (is_absolute_path(path))
>                 strbuf_addstr(&abs_path, path);
>         else
>                 strbuf_addf(&abs_path, "%s/%s", get_git_work_tree(), path);
>
>>       fprintf(submodule_dot_git, "gitdir: %s\n",
>> +             is_absolute_path(sm_gitdir) ?
>> +             relative_path(sm_gitdir, abs_path.buf, &rel_path) :
>>               relative_path(sm_gitdir, path, &rel_path));
>
> It seems that the abs_path computation is not needed at all if
> sm_gitdir is relative to begin with.  I wonder if the code gets
> easier to read and can avoid unnecessary strbuf manipulation
> if this entire hunk is structured more like so:
>
>         if (is_absolute_path(sm_gitdir)) {
>                 ...
>         } else {
>                 ...
>         }
>         fprintf(submodule_dot_git, "gitdir: %s\n",
>                 relative_path(sm_gitdir, base_path, &rel_path));
>
>>       if (fclose(submodule_dot_git))
>>               die(_("could not close file %s"), sb.buf);
>
> [Footnote]

I just simplified the code to be

  if (!is_absolute(path))
    path=make_absolute(...);
  if (!is_absolute(sm_gitdir))
    sm_gitdir=make_absolute(...);
  ...
 /* rest operates under absolute path only, no
   conditions any more! */


And I'd think that is cleanest to read and understand.

Having absolute path for both path and gitdir all the time
leaves no exceptions for relative_path to spew errors because
one of both is relative and not connected to the other absolute.

>
> *1* BTW, I tightened the assert for 2/4 to "assert(path && *path)"
> to match the assumption in its log message, i.e. "The calling shell
> code makes sure that path is non-NULL and non empty".
>
