Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6391F453
	for <e@80x24.org>; Thu,  8 Nov 2018 18:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKIDiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 22:38:55 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45540 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeKIDiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 22:38:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so28015112qkc.12
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 10:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8dvQShlDW7zHVL6mSSfFeUC2AjR84kCW+NKB4BQ0j0=;
        b=kfl4jeGTQ6U+pfzyQ3/gS2jyNoMOPG0s/o5/pmwIqdiWmfT2FBc2wBwX2qL16OowRE
         LmQfB1N+KvUdW5gv3ZkIOszkxv20zctJY0GCuXRYkQOzWHZ11c2nxQkD3T18ahydHeC1
         mGdVKtywut4GLCXPy3+o4+s9omIPjDNPYDDn56dSRET+yrF3LId/SuxMCGDNtRmPZWO4
         7mYVKM/q8rVaUH1af9rX79X6SS11ZxrskTVP+BHvwOk9qMUc/bm7sHe17rxx66LqKZ3N
         oDYzYTraJMpOV0ivvl1uITTlLV81Z+3UjfhTY2lXjeQIQ5Gu6jjatHyWGn36eWBvUCy5
         imnA==
X-Gm-Message-State: AGRZ1gKKWOyyjG9kuCGLpAxIysQTip6yGXMircU9uXjKdf7mE/soRdib
        9t2QHUyKy1YJDuPezer1sm7ZkHCVA6tFWup4ZVc=
X-Google-Smtp-Source: AJdET5dUStQ7uyQKjHMXptlncgYVNo0TPmLQ12i7ItzINuwf2aLk/bcHtjPDCm82vDMnXakvaStueOldSrQaH3yCe0w=
X-Received: by 2002:a37:9584:: with SMTP id x126mr5220982qkd.36.1541700135265;
 Thu, 08 Nov 2018 10:02:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.69.v5.git.gitgitgadget@gmail.com> <pull.69.v6.git.gitgitgadget@gmail.com>
 <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
In-Reply-To: <93fda67198441c159bfcf1dfa467ad76f3ecba76.1541660405.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Nov 2018 13:02:04 -0500
Message-ID: <CAPig+cRpH0k-qams+_1LK9p8hYzBhD-bG3waNLeCSzYWNY41rg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] http: add support selecting http version
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        charlieio@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 8, 2018 at 2:00 AM Force Charlie via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In order to give users the freedom to control the HTTP version,
> we need to add a setting to choose which HTTP version to use.
>
> Signed-off-by: Force Charlie <charlieio@outlook.com>
> ---
> diff --git a/http.c b/http.c
> @@ -284,6 +285,9 @@ static void process_curl_messages(void)
>  static int http_options(const char *var, const char *value, void *cb)
>  {
> +       if (!strcmp("http.version",var)) {

Style: space after comma

> +               return git_config_string(&curl_http_version, var, value);
> +       }
> @@ -806,6 +834,16 @@ static CURL *get_curl_handle(void)
> +    if (curl_http_version) {
> +               long opt;
> +               if (!get_curl_http_version_opt(curl_http_version, &opt)) {
> +                       /* Set request use http version */
> +                       curl_easy_setopt(result, CURLOPT_HTTP_VERSION,opt);

Style: space after comma

> +               }
> +    }
