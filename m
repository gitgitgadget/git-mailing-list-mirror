From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 59/94] builtin/apply: move init_apply_state() to apply.c
Date: Sun, 15 May 2016 23:16:18 -0400
Message-ID: <CAPig+cSWPYx9o-fnzXqUN4KR8h+15nBAX8CHhbiCxd5QcyOJLg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-60-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 05:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b291D-0002kW-U9
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbcEPDQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:16:20 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35457 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbcEPDQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:16:19 -0400
Received: by mail-ig0-f194.google.com with SMTP id jn6so5876512igb.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kmAuXMbqVs/028KRTCegrXId1CFRYJYv/pVZDhPk7Zc=;
        b=S2MsmSsaxKBVQtgvUhCxTT9RcXwAeGWF7HZXw4Se3hIIAa9LWNfB+AojKKvghdH1Jt
         gOMKLXF2+s3bkN39Ny0cPGz5iDxuSOITEdKiEwmqzt8DWK+LNqNroZ8sz3COhD453PWa
         hrQgIQmdtddhtqqLoj7ZKmKllRyu+EgnoaNsoPYEP8IjLBY9UIVyaoCFGxuOvfQ5FHNg
         i2GneyyYOUSJy7y65+Jr25oqJH+bxgLINbZKWoo7YRahNH/Ry1vFWIf3Z+FYZjRnzTlc
         WVgVpnNKXbYIuDUEH4imxlA5pqde48543erTMURDxGEZZsj9eC2lHonWGTc3VHOq++Ga
         IejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kmAuXMbqVs/028KRTCegrXId1CFRYJYv/pVZDhPk7Zc=;
        b=hvAMGXVn02yGNGSlvJ4KzhAjiP8omCwAeB3j40iF/Na3DBapzGJJNFmSWQgVG48M9Z
         GWrLxC6HMSp+vBfj7XunHLHQgrmYImEyviG1IJNNm6MekJ2Cq1WOsLG6e4jMj3bk5/oA
         0lBa6Z8XDCFzLsrCQu3c86wCp3ykOmkIYC5eC+0+gO5kshOjuyYsd+CL/ukbktE9vsp+
         nW9k0Kt+NBmS+qkNNmbRTijnPuKQVcaT+AEEb+7fgSSth7igQyqTaLkyDZNTAWhWaNZp
         IQjxpZPwixRuCN7dBdplUzouQk69+IgkQSNWQeLss2EunLvWwmDy7DJVYRdW8nSmw2LO
         N+4w==
X-Gm-Message-State: AOPr4FU8gCS2suq27LxsbTHVXiFnlirKP1fbXVEhWLcLNQ3y/KUIrGVu4BB9vj6V5pVR0v+hjrTyn1T3+64Dpg==
X-Received: by 10.50.0.233 with SMTP id 9mr4346311igh.17.1463368578239; Sun,
 15 May 2016 20:16:18 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:16:18 -0700 (PDT)
In-Reply-To: <20160511131745.2914-60-chriscool@tuxfamily.org>
X-Google-Sender-Auth: VAY-vEEtwRft7QPg2PUbYJOo0YI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294718>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we must make init_apply_state()
> usable outside "builtin/apply.c".
>
> Let's do that by moving it into a new "apply.c".

Similar to my comment about apply.h and 'struct apply_state', I can
easily see apply.c introduced very early in the conversion. In fact,
I'd imagine apply.c and apply.h being introduced by the same patch,
with that patch placing init_apply_state() in apply.c and 'struct
apply_state' in apply.h. However, I see that you're moving other
functions, as well, which already existed in builtin/apply.c, so I
guess that's why introduction of apply.c waited until this step.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/apply.c b/apply.c
> @@ -0,0 +1,83 @@
> +#include "cache.h"
> +#include "lockfile.h"
> +#include "apply.h"
> +
> +static void git_apply_config(void)
> +{
> +       git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
> +       git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
> +       git_config(git_default_config, NULL);
> +}
> +
> +int parse_whitespace_option(struct apply_state *state, const char *option)
> +{
> +       if (!option) {
> +               state->ws_error_action = warn_on_ws_error;
> +               return 0;
> +       }
> +       if (!strcmp(option, "warn")) {
> +               state->ws_error_action = warn_on_ws_error;
> +               return 0;
> +       }
> +       if (!strcmp(option, "nowarn")) {
> +               state->ws_error_action = nowarn_ws_error;
> +               return 0;
> +       }
> +       if (!strcmp(option, "error")) {
> +               state->ws_error_action = die_on_ws_error;
> +               return 0;
> +       }
> +       if (!strcmp(option, "error-all")) {
> +               state->ws_error_action = die_on_ws_error;
> +               state->squelch_whitespace_errors = 0;
> +               return 0;
> +       }
> +       if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
> +               state->ws_error_action = correct_ws_error;
> +               return 0;
> +       }
> +       return error(_("unrecognized whitespace option '%s'"), option);
> +}
> +
> +int parse_ignorewhitespace_option(struct apply_state *state,
> +                                 const char *option)
> +{
> +       if (!option || !strcmp(option, "no") ||
> +           !strcmp(option, "false") || !strcmp(option, "never") ||
> +           !strcmp(option, "none")) {
> +               state->ws_ignore_action = ignore_ws_none;
> +               return 0;
> +       }
> +       if (!strcmp(option, "change")) {
> +               state->ws_ignore_action = ignore_ws_change;
> +               return 0;
> +       }
> +       return error(_("unrecognized whitespace ignore option '%s'"), option);
> +}
> +
> +void init_apply_state(struct apply_state *state,
> +                     const char *prefix,
> +                     struct lock_file *lock_file)
> +{
> +       memset(state, 0, sizeof(*state));
> +       state->prefix = prefix;
> +       state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
> +       state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
> +       state->newfd = -1;
> +       state->apply = 1;
> +       state->line_termination = '\n';
> +       state->p_value = 1;
> +       state->p_context = UINT_MAX;
> +       state->squelch_whitespace_errors = 5;
> +       state->ws_error_action = warn_on_ws_error;
> +       state->ws_ignore_action = ignore_ws_none;
> +       state->linenr = 1;
> +       strbuf_init(&state->root, 0);
> +
> +       git_apply_config();
> +       if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
> +               exit(1);
> +       if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
> +               exit(1);
> +}
> +
> diff --git a/apply.h b/apply.h
> index aa11ea6..0f77f4d 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -112,4 +112,13 @@ struct apply_state {
>         enum ws_ignore ws_ignore_action;
>  };
>
> +extern int parse_whitespace_option(struct apply_state *state,
> +                                  const char *option);
> +extern int parse_ignorewhitespace_option(struct apply_state *state,
> +                                        const char *option);
> +
> +extern void init_apply_state(struct apply_state *state,
> +                            const char *prefix,
> +                            struct lock_file *lock_file);
> +
>  #endif
