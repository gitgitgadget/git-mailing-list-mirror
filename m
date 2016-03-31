From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 2/5] submodule--helper clone: simplify path check
Date: Thu, 31 Mar 2016 17:23:10 -0400
Message-ID: <CAPig+cSk2kDEs7nCt39LoeBjjmo-+7WH4rNNh0x6ULfeeAwQ_w@mail.gmail.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alk3j-0000Mm-NL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbcCaVXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:23:15 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34432 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366AbcCaVXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:23:11 -0400
Received: by mail-yw0-f171.google.com with SMTP id h129so114429738ywb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=S0DUcRZeIIZZAN0F2+DYCdh1Q1BCkDYGRJ6sG3B/jRs=;
        b=m9dVTGCf0k2LTUK6R9OiXW3D4MfaTgOF1TSm9siWjYtziFwGQmXQmyEqqfDyXT/gus
         daHHs7/Tj5UAj4HcvMMdETudLz8gwsAtzeBdtr1cxolDy0CeSlg368784hbfkcwdqFmm
         241bXhjP3RiO51As3RiTVQe1byBd3kR3Im/RddT2k9dvL9F6Qha8J7xMLWnfhTt0FOKl
         N3jpTfdsl/N7kls/M2kWQWdSDJnnXogbphD+dCo+/XyEF7DKJWQhRnSRoF0yut1QcrUQ
         w09EiorNzpvBRel7om8wY8I7jiiv21PDWptbReBECVhjIUSG9JsIfXsZ3Yx7kGDOLl9h
         VJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S0DUcRZeIIZZAN0F2+DYCdh1Q1BCkDYGRJ6sG3B/jRs=;
        b=iGE30z3n1zZ9zjloL30raIion5WPhR6NHUUuKBKskdlsN76YAPkGCW/HxOO3Rr/xWr
         g0D+2uQtQiDSPqPT7hezUn7m3eEWcFwVlZQ4zr4xWZqxxaitKB43URribJOsNtGkEvxL
         nqLn7G6bqBvdO9fBlrm77JHi2KK4CvTc33C4q14KsNYtyagLblrL14vKgjwOhEuMSLCH
         JdlplNgrg5/fbpCZ+qUtbEEhdP4Xm3y8srhxC2zaV+fPcgyV6voXqoZ5v8V0UfOGpybB
         OrPbH9ZFpcZSnWpyeLuo+NiGlfS9OOBUQYzW9NcCPMHHi4deOhwlmJGC723BsoP5TDUX
         /Pgg==
X-Gm-Message-State: AD7BkJK638JpUm0JHaA+eaUA9CNROkI0E0z0cGyw72uu+oLZ9FfSeIGhZu38lD/RffIRGh1pkBuM+ne3CUWk7Q==
X-Received: by 10.176.6.193 with SMTP id g59mr2983555uag.67.1459459390145;
 Thu, 31 Mar 2016 14:23:10 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 14:23:10 -0700 (PDT)
In-Reply-To: <1459458280-17619-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: AYe-cNzd_krBJ9g-lNmhLpZ_B5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290474>

On Thu, Mar 31, 2016 at 5:04 PM, Stefan Beller <sbeller@google.com> wrote:
> submodule--helper clone: simplify path check

I don't see anything in the patch which simplifies a path check.
Instead, this version of the patch is now fixing a potential
NULL-dereference.

> The calling shell code makes sure that `path` is non null and non empty.
> Side note: it cannot be null as just three lines before it is passed
> to safe_create_leading_directories_const which would crash as you feed
> it null. That means the `else` part is dead code, so remove it.

The above description has very little if anything to do with what this
patch is addressing considering that this is now a crash-fix patch.
While it's true that the (current) shell code won't trigger this
crash, that's not particularly interesting or relevant.

> To make the code futureproof, add a check for path being NULL or empty
> and report the error accordingly.

Selling this as a future-proofing change is misleading; it's a crash
fix, plain and simple. I think the entire commit message could be
collapsed to something like this:

    submodule--helper: fix potential NULL-dereference

    Don't dereference NULL 'path' if it was never assigned. While
    here also protect against empty --path argument.

You don't even need to mention removal of the conditional in the
second hunk since, for anyone reading the patch, that's an obvious
consequence of adding the new check in the first hunk.

The patch itself looks fine.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -194,6 +194,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, module_clone_options,
>                              git_submodule_helper_usage, 0);
>
> +       if (!path || !*path)
> +               die(_("submodule--helper: unspecified or empty --path"));
> +
>         strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
>         sm_gitdir = strbuf_detach(&sb, NULL);
>
> @@ -215,10 +218,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         if (safe_create_leading_directories_const(path) < 0)
>                 die(_("could not create directory '%s'"), path);
>
> -       if (path && *path)
> -               strbuf_addf(&sb, "%s/.git", path);
> -       else
> -               strbuf_addstr(&sb, ".git");
> +       strbuf_addf(&sb, "%s/.git", path);
>
>         if (safe_create_leading_directories_const(sb.buf) < 0)
>                 die(_("could not create leading directories of '%s'"), sb.buf);
> --
> 2.5.0.264.g39f00fe
