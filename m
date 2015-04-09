From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] grep: correctly initialize help-all option
Date: Thu, 9 Apr 2015 15:45:29 -0400
Message-ID: <CAPig+cQQVO0RqZrAkLxS3v-iPf4LFsDOVz_fPDhofvLvs7tFyA@mail.gmail.com>
References: <1428586916-22679-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgIOO-0004b8-8s
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 21:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333AbbDITpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 15:45:32 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34759 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbbDITpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 15:45:31 -0400
Received: by lbcga7 with SMTP id ga7so49599976lbc.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/AnXQzUtBY9/LOjAJnap8dTW0hrciG43RA5smu/3lVU=;
        b=OZ9T6dyfjGxFncf4BBqx1JCgB2Odnmd8uF8CXGkDDh5l4GMHolSkV59isr1cAIDKDC
         +PI3F/zRrk6a29rZ4ecnIFeFcG/KewsGe29/5EeEuY4sSgkPsXeUeGV2WePwWkG8O0Ch
         bIp9jxYisD03QA3G1KV1TExwdnp3Fd5cCHidIMj01xfEatgPLkXg3sraVmOMdigxzOF8
         WeqkNeBV8JRTYuAy1BYtn72MKScZI6EgQzDy4HqN5ka+HUXKe1l9Yk6h8PP40ET7uHVn
         wTr2Fh5A3D7MKYxJm2zYd8JVt8QyFChb9P2lT5Higg0m71i67DC+FNcSdynFN7x/GJ1T
         HCpw==
X-Received: by 10.112.168.102 with SMTP id zv6mr6667168lbb.45.1428608729716;
 Thu, 09 Apr 2015 12:45:29 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Thu, 9 Apr 2015 12:45:29 -0700 (PDT)
In-Reply-To: <1428586916-22679-1-git-send-email-ps@pks.im>
X-Google-Sender-Auth: sw9BEx85ey60KcSko5lNDlYCy1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267000>

On Thu, Apr 9, 2015 at 9:41 AM, Patrick Steinhardt <ps@pks.im> wrote:
> The "help-all" option is being initialized with a wrong value.
> While being semantically wrong this can also cause a gcc
> segmentation fault on ARMv7 hardfloat platforms with a hardened
> toolchain. Fix this by initializing with the correct value.

Missing sign-off.

> ---
> diff --git a/builtin/grep.c b/builtin/grep.c
> index abc4400..c0bf005 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -738,7 +738,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                         PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
>                 OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
>                          N_("allow calling of grep(1) (ignored by this build)")),
> -               { OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
> +               { OPTION_CALLBACK, 0, "help-all", &opt, NULL, N_("show usage"),

This dates back to 3e230fa1 (grep: use parseopt; 2009-05-07).

builtin/show-ref.c just passes NULL for that argument in the same situation.

>                   PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
>                 OPT_END()
>         };
> --
> 2.3.5
