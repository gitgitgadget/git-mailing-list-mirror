Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 00:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2DD613A7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 00:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhHXAci (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhHXAch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 20:32:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775A2C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 17:31:54 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q70so21386598ybg.11
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAxAfFjcVS4Aqpuj6D/BaK0WvoUuz6lfdHgGD0h7MRM=;
        b=NyEzkMSNJatj/juoSdwId7ubVSWcOlXbjpJdmLxA7/DzVSu+lvnHnJ1DI2CE6kpLUe
         NSaqfMU2B9Vt6GVuLS4RYdQOqZhzTdDpC76AiImbmL/BL6nqbTVb6kzEAtU84emAr0CI
         8ssoUW1LsHNUXrlL5rG8qr8RAT/S0GE+eD3v5wMhAOhGtT2AVqWGIxlpmMzK43pEpuPZ
         cvcNR2f0/udMEE7EzWbXNDW+O2zPADINlKY+t+Al/OR0HxEQQ1T1wrhtbZ2Vk0L43FIe
         RJrVdF40TeYRBIdgqBhDNGA3TzoAQuF2b5kXIpoQQfnYpdDrfv0O1W6+xvRBi3vFjvkl
         qAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAxAfFjcVS4Aqpuj6D/BaK0WvoUuz6lfdHgGD0h7MRM=;
        b=ShWaYbmjsHP2trwq00+o6qmdtarUFnkKwyTI8u5LOOGz+iGJOo8//pRF5jAFOtGVb9
         q8fvD1cr4h6chE2XhFYbw2G4yvfxHmQtDPeMQjPJ5+HYE5YqgH553ZSVGDfuSqDTatI/
         Bxn3vHcSZXfLK+0HqwrjM473x2IgnkWi5BUJEJqfuyd2HTArdt8goOWoT5K14xrprcdW
         4AOoIkbi8eiXROv3kPzxk1IQ5bkqqgLZdx0/L3NE5DSwtSAqRkN80lyH+oU2FV/tA3af
         KVnpgOy/dRnnMY4sFQOjcaZgTbd3gGAY2Zd7CkmQYlzOywyEwsyhLSfuiAu4JrkymZfr
         wRlg==
X-Gm-Message-State: AOAM5339h+jukRlohhS6gX1gHjRfyDt7NpDStNUFlJiA51XZDwA3dl9k
        Nj8gpkx9rqbxh4J5QabGOIaPE4vVl5gczPoBALo=
X-Google-Smtp-Source: ABdhPJwQRXdWEU8Mzx5pB86MPbp0KzfvaZO5w1ct54jxc2KgJEAUh/V7iDrmYP8Ubcw6HZQX5I18nz9J79EQhXgi2Yg=
X-Received: by 2002:a25:a408:: with SMTP id f8mr47257329ybi.155.1629765113758;
 Mon, 23 Aug 2021 17:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com> <20210823160455.32397-1-chenan.xxw@alibaba-inc.com>
In-Reply-To: <20210823160455.32397-1-chenan.xxw@alibaba-inc.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 Aug 2021 08:31:42 +0800
Message-ID: <CANYiYbEL2T897jMZFg_F-AgomrEj3EcEC2ZTyBZMB550k_PPbQ@mail.gmail.com>
Subject: Re: [PATCH v2] http: add http.maxReceiveSpeed to limit receiving
 speed of "git-receive-pack"
To:     "chenan.xxw" <haoyurenzhuxia@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        chenan.xxw@alibaba-inc.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 12:05 AM chenan.xxw <haoyurenzhuxia@gmail.com> wrote:
>
> In order to avoid hogging all the available network bandwidth, users may want to
> limit the speed of receiving traffic for "git clone" or "git fetch".
>
> Add `http.maxReceiveSpeed` to limit receiving speed of `git-receive-pack`.
> Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` environment variable.
>
> The default is unlimited, same if the value is 0. The default unit is Bytes/s,
> common unit suffixes of k, m, or g are supported.
>
> This configuration is valid for `clone`, `fetch`, `pull` commands of the https
> protocol.
>
> Signed-off-by: chenan.xxw <chenan.xxw@alibaba-inc.com>

Your email address in the s-o-b is different from the "From" header.
That will generate a commit with a different author email. This is
because you use gmail as the SMTP, but the value of "user.email"
config variable is not a valid alias email of Gmail. A workaround is
use a different "user.email" config for git-send-email, and
git-send-email will add a "From: your <real@email>" as the first line
of the body. E.g.:

    git -c user.email="haoyurenzhuxia@gmail.com" send-email <patch-file>

BTW, use your real username (Xia Xiaowen) instead of the nickname "chenan.xxw".

    git config --global user.name "Xia Xiaowen"
    git commit --reset-author --amend


> ---
>  Documentation/config/http.txt |  4 ++++
>  http.c                        | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index 7003661c0d..9b9fb5e9c7 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -235,6 +235,10 @@ http.lowSpeedLimit, http.lowSpeedTime::
>         Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
>         `GIT_HTTP_LOW_SPEED_TIME` environment variables.
>
> +http.maxReceiveSpeed::
> +       Limit the speed of receiving traffic, defaults to unlimited. Can be
> +       overridden by the `GIT_HTTP_MAX_RECEIVE_SPEED` environment variable.
> +
>  http.noEPSV::
>         A boolean which disables using of EPSV ftp command by curl.
>         This can helpful with some "poor" ftp servers which don't
> diff --git a/http.c b/http.c
> index 8119247149..b12d192ffe 100644
> --- a/http.c
> +++ b/http.c
> @@ -83,6 +83,7 @@ static const char *ssl_pinnedkey;
>  static const char *ssl_cainfo;
>  static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
> +static long curl_max_receive_speed;

You can set default value -1 for curl_max_receive_speed, just like
curl_low_speed_limit does.
I wonder if you can rename the variable name to curl_max_speed_limit
for both upload and download.

>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static const char *http_proxy_authmethod;
> @@ -362,6 +363,13 @@ static int http_options(const char *var, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp("http.maxreceivespeed", var)) {

Can we use a better name, such as "http.maxspeedlimit" ?  And make
some changes to limit both upload and download over HTTP protocol.

> +               curl_max_receive_speed = (long)git_config_int(var, value);
> +               if (curl_max_receive_speed < 0)
> +                       die(_("negative values are not allowed for http.maxreceivespeed"));
> +               return 0;
> +       }
> +
>         if (!strcmp("http.noepsv", var)) {
>                 curl_ftp_no_epsv = git_config_bool(var, value);
>                 return 0;
> @@ -974,6 +982,10 @@ static CURL *get_curl_handle(void)
>                                  curl_low_speed_time);
>         }
>
> +       if (curl_max_receive_speed >= 0)
> +               curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
> +                                (curl_off_t)curl_max_receive_speed);
> +

You can also set "CURLOPT_MAX_SEND_SPEED_LARGE" to limit bandwidth for git-push.

>         curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
>  #if LIBCURL_VERSION_NUM >= 0x071301
>         curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> @@ -1105,6 +1117,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  {
>         char *low_speed_limit;
>         char *low_speed_time;
> +       char *mrs;
> +       static const char mrs_env[] = "GIT_HTTP_MAX_RECEIVE_SPEED";
>         char *normalized_url;
>         struct urlmatch_config config = { STRING_LIST_INIT_DUP };
>
> @@ -1197,6 +1211,13 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>         if (low_speed_time != NULL)
>                 curl_low_speed_time = strtol(low_speed_time, NULL, 10);
>
> +       mrs = getenv(mrs_env);
> +       if (mrs != NULL) {
> +               curl_max_receive_speed = strtol(mrs, NULL, 10);
> +               if (curl_max_receive_speed < 0)
> +                       die(_("negative values are not allowed for %s"), mrs_env);
> +       }

You introduced a new l10n message for translation. Why not make it as
simple as parsing env "GIT_HTTP_LOW_SPEED_LIMIT" or
"GIT_HTTP_LOW_SPEED_TIME" above?

--
Jiang Xin
