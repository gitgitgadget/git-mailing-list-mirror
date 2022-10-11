Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43443C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 10:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJKK5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJKK5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 06:57:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC965282B
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 03:57:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nb11so30546544ejc.5
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trSHM8Ak4huVIXGGR035DPtdPOfKIyAYX2HHl3nSOks=;
        b=QVt4MRhLFP0X2c72t274XFrl6TVgG5wPe/nWCUk7R+kHVn1Z6jmpOyd5k+uL/ni/Wx
         9ygDbLraBmO/N3uShNuFdsCb6IylYqdzrp5uq4wrl9ptTtMQevffRRBl58Kq/1o1ipcl
         Rfy+IPws21hxLzGTYOqXtYm1ksm6loP1XVpd5tT0CUnn5WqlIy7qRPMxiWMsbQzpUOcS
         RqrYDj19hslGJ9RRX/Zlf+atRKd9MiyiCc6+veBq3Etrpqmh/GMg04PA1G6SrWQOLMkh
         DwjgXIsFwmAvhUVhlcjU5zPFtm5wNnXUvRNSui/DDIvKCT2dirX9WVnwYMXr3Q5avPBG
         uStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trSHM8Ak4huVIXGGR035DPtdPOfKIyAYX2HHl3nSOks=;
        b=EVT2s5JskUx5VSXHGTMphEOnDP1J3vPGa2A7SgVBBuHsS9YGjDsN32KsifYIx1v/VV
         GMBaL7bNHrPOKqbp6pAp8OZ0w5Wy2meVQMdNjoaOSyY0pU366wHRonbkgX883+GvN5fZ
         wwcyReC6P7jIjIouED5Gcp8zbKBQXlWdTXgjydGWZYaa6aGDO5igUBHD2xajwrBjOv/N
         oX3R98aK0ZsWnyTnMp+fi4SrY3SYhi5m8b2tYPoBz/AY3Isz9gKml5X2+rE0ic/NQGxX
         n8nPPMDIsnMdbUQKMFCrXKK3Mb8yBazAj0G6raEjKlP5MpvLPpeI+W6fi/JkF/okZJ9b
         CHSg==
X-Gm-Message-State: ACrzQf2iZEzPHKkp29cMbc3DEdqrj576NDl4q8HZF+tPlwS3hWqEFpZ+
        QEdgfAjeYdjcHAyFpb8YfzQ2zleitpHTYA==
X-Google-Smtp-Source: AMsMyM4bcjSMXHNyvYE5Yj353/N/7orlfVuiP/zVKZPJ5r4jcAZgwoDAqEemP4XT1pYvbuucyKh5cQ==
X-Received: by 2002:a17:907:2bd5:b0:76f:591c:466b with SMTP id gv21-20020a1709072bd500b0076f591c466bmr17795591ejc.504.1665485818494;
        Tue, 11 Oct 2022 03:56:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906314300b0078d44511979sm6754431eje.138.2022.10.11.03.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:56:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiCwS-003p9F-15;
        Tue, 11 Oct 2022 12:56:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH 3/7] shortlog: extract `--group` fragment for translation
Date:   Tue, 11 Oct 2022 12:55:10 +0200
References: <cover.1665448437.git.me@ttaylorr.com>
 <c3f50465cba4430b2014a76c5e473b906db50059.1665448437.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c3f50465cba4430b2014a76c5e473b906db50059.1665448437.git.me@ttaylorr.com>
Message-ID: <221011.867d16pr0n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Taylor Blau wrote:

> The subsequent commit will add another unhandled case in
> `read_from_stdin()` which will want to use the same message as with
> `--group=trailer`.
>
> Extract the "--group=trailer" part from this message so the same
> translation key can be used for both cases.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/shortlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 53c379a51d..051c97bd5a 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -132,7 +132,7 @@ static void read_from_stdin(struct shortlog *log)
>  		match = committer_match;
>  		break;
>  	case SHORTLOG_GROUP_TRAILER:
> -		die(_("using --group=trailer with stdin is not supported"));
> +		die(_("using %s with stdin is not supported"), "--group=trailer");
>  	default:
>  		BUG("unhandled shortlog group");
>  	}

Rather than add another translation that you can use in 2x places here
(with 4/7) instead do:

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0e..59aef24f637 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -132,7 +132,8 @@ static void read_from_stdin(struct shortlog *log)
 		match = committer_match;
 		break;
 	case SHORTLOG_GROUP_TRAILER:
-		die(_("using --group=trailer with stdin is not supported"));
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--group=<trailer>", "--stdin");
 	default:
 		BUG("unhandled shortlog group");
 	}

Which as you can see with "git grep 'cannot be used together'" we
already use in a lot of places.

We should probably extract this to a:

	die_opt_2_incompatible("--group=<trailer>", "--stdin");

But that can all be done in some hypothetical future, but for now the
status quo is that we know of these common strings, and copy/paste them
in various files.
