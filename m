From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement
 rebase_options_load() and rebase_options_save()
Date: Wed, 16 Mar 2016 10:10:15 -0700
Message-ID: <CAGZ79kZYOkeeujSQ16LOSQukDOBEhuqOq_C9qeXMaT9vn+RqHA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
	<CACRoPnS7WWWVay9hAjXYgyeB=1A1gfARerKJe25APa-6u5cGaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:10:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agExm-0005EK-QI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbcCPRKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:10:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36381 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbcCPRKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:10:16 -0400
Received: by mail-io0-f172.google.com with SMTP id g184so9909970ioa.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=P6psQiuYgeHW652WsGT0U+maqkm3As/KnSwrIHZOOJ0=;
        b=MuKdPgeDN0oWmrouO8x+POib3ofF6N3341wWPsCM5QzJikrhrrylI8n4BlxBg63u0Z
         BH8chBORHI80ZLiI4a5fLYyNdCmCtNCn9UcJxnltrm0TnmcKaezsH7IoC/xY7x2rtOoG
         z/boai4Hdf3TQUC+AD7pnz6kiv+GbYFOBJ3DxUB+JY96pSUiBpSbY2LJ9qvlVSwNyGqW
         OPvAUbWxUqk6ifFVs+Yew7TrlziGdN/LHzwiNCY7YlFKC3ngViOkW4NcVHpLE4QLL00H
         OBqwdoI0dIJkOjdkPqD3zcDUki0uF6i3g4VQlS3O6Ek3y0OkGDTU3sZh7YTLfit5pK6O
         4jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=P6psQiuYgeHW652WsGT0U+maqkm3As/KnSwrIHZOOJ0=;
        b=ioMWEBqOg/rNxAEwSKaLsL+CJMLeeLRK7JuP7MuTzF2WNK9oNgIRMI65J+9GMRtL3s
         03wpvjNddNJJ+ZuE4b3JtXblGW+2uzbltWx9PFgsQItnji96FwzU+TY8Sr6GTygbQDdy
         OsQ3Ro8YJbsxh3X8ettlWN8GhfdlIcydsu9HykObJNuu+Q8JSTY1b7Heurp9jIVj2u/4
         5NArLiNL9s54bX/1NrmAKWZlFoOnO5WoWvmBxvHtrU6wypbV2urYPhqV15Eg+dmm7Y05
         PG8jn4mNqh7f/hj2mar9YHrVq9PF6XgUbR5TRQku42UaRwOr1NwGWawcgn6t/cCFDTkz
         NgLg==
X-Gm-Message-State: AD7BkJIvu7rRlXAk2KaN7e/8dXoXEr9khqRVm1DBFoGTlYGIqZzRsIcm8mMM8Qjb128QVry65jkhW7cXMBGEFWGT
X-Received: by 10.107.167.80 with SMTP id q77mr5675291ioe.110.1458148215283;
 Wed, 16 Mar 2016 10:10:15 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 10:10:15 -0700 (PDT)
In-Reply-To: <CACRoPnS7WWWVay9hAjXYgyeB=1A1gfARerKJe25APa-6u5cGaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288995>

On Wed, Mar 16, 2016 at 5:04 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>
>> How is this specific to the state file? All it does is create the
>> leading directory
>> if it doesn't exist? (So I'd expect file_exists(concat(dir, file)) to
>> have the same
>> result without actually creating the directory if it doesn't exist as
>> a side effect?
>
> I don't quite understand, AFAIK mkpath() does not create any
> directories as a side-effect. And yes, I just wanted a short way to
> say file_exists(concat(dir, file)) or file_exists(mkpath("%s/%s", dir,
> file)) without cluttering up the code.

My bad. I should not assume functions doing stuff as their name might suggest.
(It "makes the path" but only in terms of creating the right string, not on the
file system, where you'd use functions like safe_create_leading_directories.
I thought all that was implied in mkpath).

>
>> If the dir doesn't exist it can be created in rebase_options_load explicitly?
>
> I don't intend to create any directories if they do not exist.
>
>>> +
>>> +static int read_state_file(struct strbuf *sb, const char *dir, const char *file)
>>> +{
>>> +       const char *path = mkpath("%s/%s", dir, file);
>>> +       strbuf_reset(sb);
>>> +       if (strbuf_read_file(sb, path, 0) >= 0)
>>> +               return sb->len;
>>> +       else
>>> +               return error(_("could not read '%s'"), path);
>>> +}
>>> +
>>> +int rebase_options_load(struct rebase_options *opts, const char *dir)
>>> +{
>>> +       struct strbuf sb = STRBUF_INIT;
>>> +       const char *filename;
>>> +
>>> +       /* opts->orig_refname */
>>> +       if (read_state_file(&sb, dir, "head-name") < 0)
>>> +               return -1;
>>> +       strbuf_trim(&sb);
>>> +       if (starts_with(sb.buf, "refs/heads/"))
>>> +               opts->orig_refname = strbuf_detach(&sb, NULL);
>>> +       else if (!strcmp(sb.buf, "detached HEAD"))
>>> +               opts->orig_refname = NULL;
>>> +       else
>>> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "head-name"));
>>> +
>>> +       /* opts->onto */
>>> +       if (read_state_file(&sb, dir, "onto") < 0)
>>> +               return -1;
>>> +       strbuf_trim(&sb);
>>> +       if (get_oid_hex(sb.buf, &opts->onto) < 0)
>>> +               return error(_("could not parse %s"), mkpath("%s/%s", dir, "onto"));
>>> +
>>> +       /*
>>> +        * We always write to orig-head, but interactive rebase used to write
>>> +        * to head. Fall back to reading from head to cover for the case that
>>> +        * the user upgraded git with an ongoing interactive rebase.
>>> +        */
>>> +       filename = state_file_exists(dir, "orig-head") ? "orig-head" : "head";
>>> +       if (read_state_file(&sb, dir, filename) < 0)
>>> +               return -1;
>>
>> So from here on we always use "orig-head" instead of "head" for
>> interactive rebase.
>> Would people ever rely on the (internal) file name and have e.g.
>> scripts which operate
>> on the "head" file ?
>
> This backwards-compatibility code is just a straight port from the
> code in git-rebase.sh.
>
> The usage of orig-head has been around since 2011 with 84df456
> (rebase: extract code for writing basic state, 2011-02-06), so I guess
> if people had issues with it, it would have been reported.

I did not read the rebase shell code, but commented on the C code only.
If this is already in there, let's keep it.
Sorry for the confusion.

Thanks,
Stefan
