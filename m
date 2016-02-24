From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 15:27:30 -0800
Message-ID: <CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
References: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:27:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiqG-0006mB-Os
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbcBXX1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:27:31 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37116 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcBXX1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 18:27:31 -0500
Received: by mail-ig0-f173.google.com with SMTP id z8so2112500ige.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 15:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NqDZvznlZLJ4qXVqc1MjKlyOB9zLbzcD+Qg+xJT4sGw=;
        b=bhovFfz3nBVQQ6ouOjyxzQVwQL7jXuXRgrIqLjiRxaw5Mg4TcYoRMUPV4wxq2njZwB
         PLdxbWPWaYu3tPpTQa0BK5NoiR70yUPSEgiSTFVlpAPPfjecX9TEuDuzFOnSk/Vb70uX
         BK1cO8gszQ8fh/R5rygkXNSp0oD/jMXJleI6T5Srg44U6ngaQb7M8poRXIg9ybXGKnuT
         x1Atyk1mjJVlG0QGsxoKrsTsLZvgzKbSq3ZUNTqg0zByTKqe/ny17jF2A0rORIMLYQsR
         gxJQUbdcAyIJdcgs1F+04rhrVG+St9cj1A6upKK+or9qfg7GOb0vR0tvn7i6Rqa1k+eV
         5SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NqDZvznlZLJ4qXVqc1MjKlyOB9zLbzcD+Qg+xJT4sGw=;
        b=lOQUCSbPgt/BN7TjwhlNAp1r46gVwEZgKjMWmYE2/aABfx7e8JFAqfMIrUgIb2yCa/
         Z2ZLgoVsv7j7LlJIJ88M4cHulzGUHwhyN1K9Oj2WSbgerCItVO7FK4Kv4WJ2PeTAUt9F
         9kFnFjJMF1miFAS1F8zqTeUBhCgNuIozPZ+mK9VkE0YUSW1AtercoF5GpwvJchlji6Ck
         2haxUFuafG2Asg7RE8uqIxN8a9vbmdY3Q7kFMJbpIBTEEYsE03HacvxuqAjmo+X/HPrc
         emQD2gRHp747IHYmCWsCnZMH/tbXk4Dr7cAWI0BcYiTM6KOW+8V1VByio2EkxzCT/y79
         ot7w==
X-Gm-Message-State: AG10YOTsxu8yOd7FjLqIWDs585bJRq/3LmfoWRQmRMD4110gDaH1Ug7+m1ldTQ4u9FmEJRDVTztdwfouGkH6wrcA
X-Received: by 10.50.92.68 with SMTP id ck4mr318737igb.93.1456356450303; Wed,
 24 Feb 2016 15:27:30 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 24 Feb 2016 15:27:30 -0800 (PST)
In-Reply-To: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287279>

On Wed, Feb 24, 2016 at 12:09 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Due to the way that the git-submodule code works, it clears all local
> git environment variables before entering submodules. This is normally
> a good thing since we want to clear settings such as GIT_WORKTREE and
> other variables which would affect the operation of submodule commands.
> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
> preserve these settings. However, we do not want to preserve all
> configuration as many things should be left specific to the parent
> project.
>
> Add a git submodule--helper function which can be used to sanitize the
> GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
> restrict this to only credential.* settings.

I guess for now that subset is fine and will be expanded over time?

>
> Replace all the calls to clear_local_git_env with a wrapped function
> that filters GIT_CONFIG_PARAMETERS using the new helper and then
> restores it to the filtered subset after clearing the rest of the
> environment.

The patch looks good to me, we should have introduced the submodule--helper
test file earlier. I may migrate the test for the fix I send earlier
today to that
file eventually.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff179b5..8194d3b3d1d5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -255,6 +255,56 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>

Probably this will cause easy to resolve merge conflicts with
origin/sb/submodule-parallel-update

> @@ -264,6 +314,7 @@ static struct cmd_struct commands[] = {
>         {"list", module_list},
>         {"name", module_name},
>         {"clone", module_clone},
> +       {"sanitize-config", module_sanitize_config},

same here.

> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> new file mode 100755
> index 000000000000..376f58afe967
> --- /dev/null
> +++ b/t/t7412-submodule--helper.sh

Thanks for introducing such a file. I did not do it as I though it was
"too small"
and would not be enough to test to justify its own file.

> +
> +test_expect_success 'sanitize-config clears configuration' '
> +       git -c user.name="Some User" submodule--helper sanitize-config >actual &&
> +       test_must_be_empty actual

I usually keep my user.name in the global config, so no need to pass
it around like that,
but for testing purposes this looks good.
