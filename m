Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5432C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C05F6134F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhFNUPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:15:14 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:34461 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhFNUPN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 16:15:13 -0400
Received: by mail-ej1-f54.google.com with SMTP id g8so18654691ejx.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 13:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQj26PDEIavTh//PU/E41tsruVnQ85afrQGivPX8rtU=;
        b=p+VsNmSU9IhFCCqgNrdjiVEa8MJB8IJ15EMNyJtX3KOg9q7ltUN3uTJ6KkuGXGUE6Z
         Z0ir53zverHUr+N5QgqD6z2Q716eqbacctRI5kNk9sHq1OHfLu00n41bgrW/LgO+OiRx
         BPzYqbTpdsGW+81W0/sasexoIrbxlHamvJwkG5t/gN5PA2GYua9X2XpWQ+Khfx9lSEaB
         mW1+GJvEXpr4vzsZoUGzN3oDD45mH7jRLXdyiUWMX+l7mCM6PZkbJGa21Pf5je+qRBQM
         gYkj6DQvwJ3/Noq9ZURvdb6PC0WjrTeu5iesEOA6wQQSiCd5l6akOeKpxxyrRe4Li4eD
         vmPw==
X-Gm-Message-State: AOAM530ET7GyoAfaxY8aa50XD6E4Co2qucnvv31vt3T8w5jlw6bs2ZaV
        3NonI21SfNhdXuDAycF62xTyfYWZ7xbCsHVLvPM=
X-Google-Smtp-Source: ABdhPJxZP/oFvmANRXRpEszBtwpWkJVH+vugZ4QqX5orM04PeU33E7kBRSBn2Olkcz6tETdci2HueSp8FH8Df7iTcpM=
X-Received: by 2002:a17:907:207c:: with SMTP id qp28mr75053ejb.311.1623701577793;
 Mon, 14 Jun 2021 13:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210610083916.96243-1-raykar.ath@gmail.com> <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210614125157.99426-4-raykar.ath@gmail.com> <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
In-Reply-To: <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 14 Jun 2021 16:12:46 -0400
Message-ID: <CAPig+cQQXEU2QvP6PGB7v=RGQDiu_s0kctFyqSHWvLe2ep0w9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] submodule--helper: introduce add-config subcommand
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 3:53 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Just as an example, here's a diff to demonstrate the argument:
> -- >8 --
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -2934,6 +2934,14 @@ static int add_clone(int argc, const char **argv, const char *prefix)
> +void add_config_in_submodules_file(const char *keyfmt, const char *submodule,
> +                         const char *value)
> +{
> +       char *key = xstrfmt(keyfmt, submodule);
> +       config_set_in_gitmodules_file_gently(key, value);
> +       free(key);
> +}

The new function should be `static`, of course.
