Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDCCE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 22:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjISWRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjISWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 18:17:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3357C4
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:16:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so6282460276.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695161817; x=1695766617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRC0+ClLN+7ov7HgHWIHVG0u3Uju5blXeEuFNx2bdyg=;
        b=IQ33ebKdyhZXPfkBj4qK7dQ4HrZwSuLp0sQU8o+Bw8kyEuStHyOPmtqtFtUQ+Ta74B
         bfiIvUZEX5ZI7nlpQJRntF2ef+Nt0s/sj36PCVIR+VNYyZAVijTM3xLli1V1nJWhwXCB
         fwl9Y9yIi/muhppaDSASODX1y866qbG4+Wn7tcA0qCNxw+QYh3XMWRRqlzWeXY7YdHVt
         9UxNNP9665BqejlWy1ImMLnNlBawhe/mf8eyfEdr9IHEiD9k7SxaGlIaZtttHn3Vjfxa
         1G681N/Ps1kNDUqSK/i28Xxpp0seEudQTX9P+TLyomtsemjiK7auS0YV99yTGylZlDco
         lxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695161817; x=1695766617;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRC0+ClLN+7ov7HgHWIHVG0u3Uju5blXeEuFNx2bdyg=;
        b=cFtxoNTIlX8LUDzVpzq8/Deh5DDskqnMdZ4p/96XEM3TA/nXjGIhh2qY9UrDP1r9O1
         JEo5MCtajOilkpbsnNQFfP829MtsETSNWnNBJQ2YVGHJ3U7yCo+nsCxEn+wE47U/yEt9
         IWZW3642ff4dK6/yQ4wV6l8ezmxwEdtuqSICzEK7dqk9hy9j9ZOJlrQOBtod6MUEeIM9
         wWcY0WRe9s8sO8rqt2vh7TpdArKISJ/naAiIx6AbsLt0YOS1cnkDrruoL3wp9gMy1uJq
         FDqcBq+HCLzmVQundncRQ4Jbtcs9MfrXlrEmiRq7xTOzSTM8ccxss/G6yNwyIW4Je+Ux
         qWHw==
X-Gm-Message-State: AOJu0YyYqG630CRH0UGt9mGchV0p+xc86qCRCzC7ap72L267ccdusmp3
        yO07zLuIU0twMJmUhQ1l6DzMtPWeA8Unxmn/hDwN
X-Google-Smtp-Source: AGHT+IFfahL54jxi1A5Wd/BNQyu3r85+Wic171lsmMy4n2XYLNIxjvlpx/B513Wy8hgXzPYkauW1WVR98gjB+Ika9Mod
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:def5:f709:d6a:7375])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ac1f:0:b0:d78:a78:6fc7 with SMTP
 id w31-20020a25ac1f000000b00d780a786fc7mr12472ybi.6.1695161817259; Tue, 19
 Sep 2023 15:16:57 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:16:54 -0700
In-Reply-To: <d1780a0127a749902d60249b531869ee9cd1a5f6.1694125210.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919221655.2178777-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 07/13] trailer --parse help: expose aliased options
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index a7623dbfb2e..5f3e1a38eee 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -107,7 +107,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
>  		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
>  		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
> -		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
> +		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
>  		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
>  		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),

Indeed, parse_opt_parse() sets the 3 options described in the commit
message. Looks good.
