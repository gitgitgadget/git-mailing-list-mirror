Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C60C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 19:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiHSTFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349713AbiHSTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 15:05:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7C109587
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:05:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so6189171wrq.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=XVhzq9CGBftkdK7GPO6Ui+IvJ6qDhJhpo/tKKudCtWM=;
        b=mWUVkjw1v0SFGWzvat4lk/jH+OhW82KlKeWDFgbUIiAFm39iTa97lk0NA3O40TFE8n
         rUE5w4DYaFckxythdSIvlO6UydjkW5NjCl9rIoaAykjB0D0iPSqIQ5fwArNcUNzsV2GP
         FCHe1a3cEoFedand3330q1FXvkD6dBBsQmrg7Q4hPteiZOlCCmmwpyJXUbpdkydUWwvr
         oGgv1Q7+AZB/XHEuCcjaux4yeegjL1cttJoN0ZZB4EJH5sNOk2KgM0h1BFCjK1mwlJsE
         2JIEoWgMbA7AM9c3LcfYpeQmVbnqhPyAjIWrTVCNpp98MxtjIEdYAwkk0vdTd+z1K0RF
         YFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=XVhzq9CGBftkdK7GPO6Ui+IvJ6qDhJhpo/tKKudCtWM=;
        b=RvSzaYtsHkcv5QoXe8EBcbzLQk03T4Icdq/JYn29makLtsrclwb4aiN5RnAjbJAvhv
         4jcH9y8wvc8qg3Xn4NuUBY4Q7l3UYU54uYuvADQhIPWwlvLY1eqNc+CQvFNWzVqrwrJe
         9teBHr5ypmvc6m34c19qC8IaN7thyg2VyzYlcFV7jC+yNflNQJv9YsyIx+a/PrfvLo3V
         G4hM/Q/6jyDSGjeRbdghTu5DArQA+AAE33sRj9O6CY6+znPG2C41FhdiVVFS40mn8SS+
         0ZBVpziSn/WKdsmYvFydpWH0S+7Du410AA2LEd4ggtsz9hhAAZpweCkgw6128xXP0HvH
         2t4w==
X-Gm-Message-State: ACgBeo0lJxdZ6i+HBEBEO05kwPbCca+Z6xa4jWrFzGvxiNLKck/TbRmc
        vc/wbZUiIwr4J2gmv+e5B+A=
X-Google-Smtp-Source: AA6agR6qy6LB3w89hLMYFWl2NdQrOUlURjH9k6uNE6aJTJuMNn39l4c28ggexZR7bnNAgTYJnyynkw==
X-Received: by 2002:a5d:47ab:0:b0:223:60ee:6c12 with SMTP id 11-20020a5d47ab000000b0022360ee6c12mr4882897wrb.315.1660935909796;
        Fri, 19 Aug 2022 12:05:09 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id bp25-20020a5d5a99000000b0021f0c0c62d1sm4560509wrb.13.2022.08.19.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:05:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP7Ip-000ryQ-1u;
        Fri, 19 Aug 2022 21:05:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/20] parse-options: add support for parsing
 subcommands
Date:   Fri, 19 Aug 2022 21:03:27 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-10-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-10-szeder.dev@gmail.com>
Message-ID: <220819.86h7285a1o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> @@ -885,7 +977,14 @@ int parse_options(int argc, const char **argv,
>  	case PARSE_OPT_COMPLETE:
>  		exit(0);
>  	case PARSE_OPT_NON_OPTION:
> +	case PARSE_OPT_SUBCOMMAND:
> +		break;

This amounts to the same behavior, because...

>  	case PARSE_OPT_DONE:
> +		if (ctx.has_subcommands &&
> +		    !(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
> +			error(_("need a subcommand"));
> +			usage_with_options(usagestr, options);
> +		}
>  		break;

...AFAICT we won't have PARSE_OPT_NON_OPTION *and* ctx.has_subcommands,
but it's really confusing that before we'd fall through from
PARSE_OPT_NON_OPTION to PARSE_OPT_DONE, but now we don't.'

