From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 45/83] builtin/apply: move 'state' init into init_apply_state()
Date: Mon, 25 Apr 2016 03:32:15 -0400
Message-ID: <CAPig+cTx6jGwS12c8j_O+kT-f06o3E_yxrWZXmeU-XQ7fUY_9w@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-46-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 09:32:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aub0N-0002LX-BY
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 09:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbcDYHcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 03:32:20 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34576 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbcDYHcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 03:32:16 -0400
Received: by mail-ig0-f194.google.com with SMTP id qu10so9978483igc.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 00:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=oxaVeY9aA9NbwFc9PJfYHm860MEtoDjM2edU8SjAk7E=;
        b=EYIwWiYBbH2xHKD3VKVB6/7f7xsmpyixp9oMe3YPyUFGzM3s2I0tYi2+oOUosv4SWi
         +jOzpWd4S8EQM/PkJQDNIzUiywu/VjeUDxPgJWN3sj50dVVFCc6+Jiy1dLVhiL5kJ0ep
         1+XsphRYTPRICUr7+LLzSppy2D/Ob+qXEUAkRx91YAkmi9tgc7Md2m92LtjL2cvkuWWx
         xE4XwWmwUK8BtAaaZASAb2RukMWJ8kCeBfSSmv2aDyrbS1btbaLuqdvugILJUpAKS2rl
         1W2OrArid5cE3hHb91jUxMc8oiAwoVkcfLVt3cCvxJHeb8OjPlj+e9/sNO/NKtx+dNeq
         XR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oxaVeY9aA9NbwFc9PJfYHm860MEtoDjM2edU8SjAk7E=;
        b=kUuA22GD3pzPvQ5ZSSb/s/iJ33O/mZyvdeYBr28ldWsialK0+J4F+J3RPLnQN64mKF
         H8Y+ZAvxxqQI6HdI4muhsocBofCxReQx02k8TCPfYMzI837jxbNHxyS+Ru6LVRHQkGEB
         l/mJ5aiyF9AWqeqxhz0GMrVJvAXYF865rqNqikHC4bN9qSh0/eyPC30hglstzjcCwJZK
         1hJsgV7WplZwfp4DeI6vFtapOlDafXSWFev8c46V2+mqWiEle/Bx/bsg0boaCUIMcIdQ
         CdKsamQPpjN0A8ZqW8+F0beJPIbIwEQ9Z0viCWvebbNcEGMjiSK96SalhBzokX7vFyZT
         j9IA==
X-Gm-Message-State: AOPr4FX956fsOsZ+2WawtKUAYPwqaYkDtghSEyKduyI3QMHcAgEIejF6TzV+6SDuxd5G2q3rxF7a/5DJ69D7ew==
X-Received: by 10.50.6.15 with SMTP id w15mr10869290igw.91.1461569535756; Mon,
 25 Apr 2016 00:32:15 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 25 Apr 2016 00:32:15 -0700 (PDT)
In-Reply-To: <1461504863-15946-46-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: TfOPX-XIYI72v_yhqp3_jJFSXnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292452>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4670,6 +4670,28 @@ static int option_parse_directory(const struct option *opt,
> +static void init_apply_state(struct apply_state *state, const char *prefix_)
> +{
> +       memset(state, 0, sizeof(*state));
> +       state->prefix = prefix_;
> +       state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
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
> +       if (apply_default_whitespace)
> +               parse_whitespace_option(state, apply_default_whitespace);
> +       if (apply_default_ignorewhitespace)
> +               parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
> +}

Minor:

If factoring out this code from cmd_apply() into init_apply_state()
was done as a preparatory patch before introduction of 'apply_state',
then each new 'state->foo=...' line would already be at its final
location when added by its respective patch.

Doing so would also provide an obvious opportunity to name the
'prefix' argument to init_apply_state() "prefix" rather than the odd
"prefix_".

>  int cmd_apply(int argc, const char **argv, const char *prefix_)
>  {
>         int i;
> @@ -4749,24 +4771,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                 OPT_END()
>         };
>
> -       memset(&state, 0, sizeof(state));
> -       state.prefix = prefix_;
> -       state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
> -       state.apply = 1;
> -       state.line_termination = '\n';
> -       state.p_value = 1;
> -       state.p_context = UINT_MAX;
> -       state.squelch_whitespace_errors = 5;
> -       state.ws_error_action = warn_on_ws_error;
> -       state.ws_ignore_action = ignore_ws_none;
> -       state.linenr = 1;
> -       strbuf_init(&state.root, 0);
> -
> -       git_apply_config();
> -       if (apply_default_whitespace)
> -               parse_whitespace_option(&state, apply_default_whitespace);
> -       if (apply_default_ignorewhitespace)
> -               parse_ignorewhitespace_option(&state, apply_default_ignorewhitespace);
> +       init_apply_state(&state, prefix_);
>
>         argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
>                         apply_usage, 0);
> --
> 2.8.1.300.g5fed0c0
