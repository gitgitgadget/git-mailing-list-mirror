From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Clone repositories recursive with depth 1
Date: Wed, 11 Nov 2015 11:19:15 -0800
Message-ID: <CAGZ79kbfFhCvQW=_7i4KxjWeh7uYRTTNvLzQUq+CJ641g3=UDg@mail.gmail.com>
References: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwavQ-0004po-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbbKKTTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:19:17 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36813 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbKKTTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:19:16 -0500
Received: by ykdr82 with SMTP id r82so65484017ykd.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DgV5fCQLnZMtkFDCbiQrWfKz9J40WbtZgVoVOT47Zio=;
        b=VjOlBHgofr35gLv+5CF1X1u+DYEoUKp+dZZ+fZVbe+GeeJJLPy1aMgoyXGXmjvWsr6
         SHjkx2dpj8Zs51R2aW8Zsj9p82mqjZG4WITD7h1zFofyK98J9ud3jjFXVjR04h/0nGpI
         RoeAyIowMHl4nnEI4e0NbNVslkfXUxiLEZ8odXqfXJk9pw/0qovQepWu6wpjUEt0RmVs
         wB764YbS1I3/94q/PbVZH9V3Ym/1D2UL4KEL94YRrnzCwWcfuu8wzQrNHvXy1S6uv/dm
         aawGGk3ZmmkCB/WKq1nyS6UXOgGHbZkgToAJJrU3WNjxoGzFBiQoZh8Am9AwBks1WfqG
         Bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DgV5fCQLnZMtkFDCbiQrWfKz9J40WbtZgVoVOT47Zio=;
        b=RNLYcQ4wLORQe6yFtuaW7hpYtRSmcrZ+qss4aSY4ot9NJ+piQtx20+E38+53LmOQft
         3xQPxYd9IfZkeEp9tbh16Ntj1Een9PgaZJsBVixUJT1wRdHhs8hPMyDQGQMYNzb7pkN9
         cSfaSWRvgMfDXnnPTQ9DpMp/BO+UzpjEctUWDSt2VUU3miYrYNXv7T+1a7eRsTamGhv7
         5zPxxwRtSEwM7Oo1GeKBUjytoKPwVOdH93FJlJuK6UMZogp+ZfwWslUaZ3FBdRoVHzrJ
         KqeAmSUAAHH+wdM3kzkELgr8DVfLPIXwOiii3PmTIk7h+rHYaxI68qxe3UOSyaqnAROv
         i0sw==
X-Gm-Message-State: ALoCoQlyIoNibRBItLCaP2aBXG8cqFiwYMIgh6VN3HcSbIOLrzacBQgNBgtFKmJVtruq6xcEofGK
X-Received: by 10.13.214.19 with SMTP id y19mr11793251ywd.63.1447269555735;
 Wed, 11 Nov 2015 11:19:15 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 11:19:15 -0800 (PST)
In-Reply-To: <DE5B8B46-B185-4258-A1C8-07E46072CD5D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281178>

On Wed, Nov 11, 2015 at 6:09 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> I have a clean build machine and I want to clone my source code to this machine while transferring only the minimal necessary amount of data. Therefore I use this command:
>
> git clone --recursive --depth 1 --single-branch <url>

That *should* work, actually.
However looking at the code it does not.

citing from builtin/clone.c:

    static struct option builtin_clone_options[] = {
        ...
        OPT_BOOL(0, "recursive", &option_recursive,
           N_("initialize submodules in the clone")),
        OPT_BOOL(0, "recurse-submodules", &option_recursive,
          N_("initialize submodules in the clone")),
        ...
    };
    ...
    static const char *argv_submodule[] = {
        "submodule", "update", "--init", "--recursive", NULL
    };

    if (!err && option_recursive)
        err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);

So the --depth argument is not passed on, although "git submodule update"
definitely supports --depth.

In an upcoming series (next version of origin/sb/submodule-parallel-update),
this will slightly change, such it will be even easier to add the
depth argument in
there as we construct the argument list in code instead of hard coding
argv_submodule.

This may require some discussion whether you expect --depth to be recursed.
(What if you only want a top level shallow thing?, What if you want to have only
submodules shallow? What is the user expectation here?)

>
> Apparently this does not clone the submodules with "--depth 1" (using Git 2.4.9). As a workaround I tried:
>
> git clone --depth 1 --single-branch <url>
> cd <repo-name>
> git submodule update --init --recursive --depth 1
>
> However, this does not work either as I get:
> fatal: reference is not a tree: <correct sha1 of the submodule referenced by the main project>
> Unable to checkout <correct sha1 of the submodule referenced by the main project> in submodule path <submodule path>

That seems like another bug to me.

I just tried to clone a project and populate with submodules later and
it works as expected without these error messages.
(I am running some kind of xxx.dirty development version, most likely
origin/sb/submodule-parallel-update,
I'll check some other versions, too)
