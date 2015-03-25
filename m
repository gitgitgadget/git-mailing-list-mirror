From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH RFC] init-db: introduce new -c/--config option
Date: Wed, 25 Mar 2015 16:30:17 -0400
Message-ID: <CAPig+cREbg0VZyzL7na6QfOpBK3_Ydw3u-rdNOpcs4DG3=RbOw@mail.gmail.com>
References: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:30:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YarwW-0008OM-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbCYUaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:30:20 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35436 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbCYUaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:30:19 -0400
Received: by lahp7 with SMTP id p7so10710708lah.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EBoersbcgdHrwgBidaIDRJnppxBbTWHWAKwZhma0744=;
        b=sBaSKkZl90fXp9JAgEjcyd7YvN3oCYv3zcURxyEgndcU9vrJ9EWQIlYXIY8Oi2dOF2
         xhIMKjJGpApLuC0NMKWt2/TE+NFM+MIxJ58bI46aIP27dUD0mOR8AXe3xEO9lK/ZkR+r
         WSc15oXkDJRIDTBcwNFBK094C8zOOeHQbj+OsbrKxi/e0BS6TJcuaM2Y2dXlJDEk2QSd
         Wk/29GF+aLcbAFN3tLyLsMekrRWqADsGuQXELBAG50HZTCAdiG76yLkd90Z0jQcn2tX5
         WPLSTRbYB8rM+CGbaC/T40v7zM+vecs8CQv51eJgbRueFgaJ7+3wb4F93lk7JLY1GIls
         Iouw==
X-Received: by 10.112.92.198 with SMTP id co6mr10236252lbb.101.1427315417536;
 Wed, 25 Mar 2015 13:30:17 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 25 Mar 2015 13:30:17 -0700 (PDT)
In-Reply-To: <1427307759-18679-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: EtgRb58wvpbDBkKGigEl7C2kcow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266300>

On Wed, Mar 25, 2015 at 2:22 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> For now we can clone repository with the `git clone` command and pass
> -c/--config with configuration option to it and these configuration
> options will be set in the clonned repository config.

s/clonned/cloned/

> This patch provides the same functional, but for the `git init` command.

s/functional/functionality/

> It allows to pass -c/--config option to the `git init` command and
> given configuration option will be added to the newly created repository,
> after it will be created.
>
> This option can be used multiply times. If given configuration option

s/multiply/multiple/

> is the same that in the default config, given option will overwrite.
>
> Main purpose of this option is to get rid of the manual editing of
> the config.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..3ecbf2a 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -111,6 +111,15 @@ into it.
>  If you provide a 'directory', the command is run inside it. If this directory
>  does not exist, it will be created.
>
> +--config <key>=<value>::
> +-c <key>=<value>::
> +Set a new configuration option in the new repository. The <key> expected in
> +the same format as linkgit:git-config[1] (e.g., `core.eol=true`). If

"If" what?

> +This option can be used multiply times. If multiply options are given with

s/multiply/multiple/g

> +the same keys, each value will be written to the config. If given key is
> +the same that used in the default configuration file, previous value
> +will be overwritten.
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 7de8d85..8ce3537 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -339,4 +339,20 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
>         test_path_is_dir realgitdir/refs
>  '
>
> +test_expect_success 'git init -c key=value' '
> +       rm -rf newdir realgitdir &&
> +       git init -c core.foo=bar newdir &&
> +       echo bar >expect &&
> +       git --git-dir=newdir/.git config core.foo >actual &&

Maybe "git -C newdir ..." instead?

> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'git init -c key=value override default value' '
> +       rm -rf newdir &&
> +       git init -c core.filemode=false newdir &&
> +       echo false >expect &&
> +       git --git-dir=newdir/.git config core.filemode >actual &&
> +       test_cmp expect actual

git-init automatically detects an appropriate value for core.filemode,
so this test may not be telling us anything useful on some platforms.

> +'
> +
>  test_done
> --
> 2.3.3.611.g09038fc.dirty
