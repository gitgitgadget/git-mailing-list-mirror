Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A8F1F406
	for <e@80x24.org>; Fri, 11 May 2018 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeEKWsF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 May 2018 18:48:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32927 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeEKWsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 18:48:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id e8-v6so9141036qth.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 15:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YXR72mjmh2xNBB+1vMp1+AhbINmCj2UyW0xL3bLy1Oo=;
        b=iUn9O+RPjLZddnkKIOmbuUxW89tQqgpYAFS2e37mWEkUg5utvhnLrzQAeBzkcDkPl/
         mkcKhJFxRPNMKerdjvI+aOCnHGgBWkbFRLM4+jYD8209FHm16NrfwwNbNuEObpLZRo38
         X+9smJBPKxEgyUWRFV1Ak3D8ZNirTWJ/IbkJ81z9fkhLmfj4QxssUx1JQ3l3A+8lmz/t
         K3VhtQ6Qit2VU3wKjmAG3wYs+vhQ0sZxGy9E1IGse40b3FWK9Eb+g1r/AYvanqa+8ilV
         6GUqb37hyeSGJGy7w70Ze8ZU5KluGwPxlB1RZ29gr4FnDN3mYUWvzq5Y7xiRuoCSQQSP
         98FQ==
X-Gm-Message-State: ALKqPwcZ+gGvqehFO5Ws6vFcWbFHYcdKO/ZYdbz0SFHgihrExJ/duxPs
        A66wwtH/t8pRGFw1f+n62yHG+uzlROwjoX8J9/A=
X-Google-Smtp-Source: AB8JxZrtISHLBQ0oD9fHCGv9FYB02fipBp1Ii0nsQclOdqnZ9A5qmMLqkdP+A+ZNN1HdO2oHQrvQGGS4Tq5mMHAxZkQ=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr7248717qtg.69.1526078883875;
 Fri, 11 May 2018 15:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-8-pclouds@gmail.com>
In-Reply-To: <20180510141927.23590-8-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 May 2018 18:47:52 -0400
Message-ID: <CAPig+cSndzXM+FD4bD5axn-QxOjowycDtD_JOoa4ra3sdnWXFQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] completion: drop the hard coded list of config vars
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:19 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
wrote:
> The new help option --config-for-completion is a machine friendlier
> version of --config where all the placeholders and wildcards are
> dropped, leaving only the good, completable prefixes for
> git-completion.bash to consume.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/builtin/help.c b/builtin/help.c
> @@ -446,9 +447,13 @@ int cmd_help(int argc, const char **argv, const char
*prefix)
> +               int for_human = show_config == 1;
> +
> +               if (for_human)
> +                       setup_pager();
> +               list_config_help(for_human);
> +               if (for_human)
> +                       printf("\n%s\n", _("'git help config' for more
information"));

Simpler to read, perhaps:

     if (!for_human)
         list_config_help(0);
     else {
         setup_pager();
         list_config_help(1);
         printf(...);
     }
