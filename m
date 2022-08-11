Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C765C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiHKLxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiHKLxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:53:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA99674E
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f22so22590246edc.7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=c3qtXMPU4UG8iS6zgtWdrzCSMAIFzDwzVAvRkyRhaX4=;
        b=KvK1WBFC+usYHLHEUuoFdJ6tof10DJj4sUc8lMB2tvVIXPvOXjospTywyVhh66m57h
         3qzinlV/C1inplsxxNwDVM0CMIhcTQnOGItnPIk7hDtn7BltAIhzSbvkcTe6pZgCh+nw
         XnKnKJ1uq8hPEtldtrdkE58fHQCLEUDDaXUQkpAxXtJ7CmPN7jX3wvPLieGjI00H2YFR
         ovcx/yI3/I70qftLC8Z2dgX0MZYMAWEatH8Che6b/XbVpluRXcVz/NzbL7WzNb5RIGx2
         xlkMpm2wyho2iPF+iCig+pLaoIrcmZDHGXVjb2eiS7CWDTlNkP16Kvbyv8XYd8qx8YjH
         oiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=c3qtXMPU4UG8iS6zgtWdrzCSMAIFzDwzVAvRkyRhaX4=;
        b=PiqH3Zbmbhwr2koGKLd6Nr8YTgnalA/N1hHu6s2wLqN0LPT7dVpG4I+qSgKJNtHbks
         X3ynUVLPzmgn9jzc/YrugoWTLHtMtvrEkkCII3+Ix3SQ+h2AZyZoDRsmtm2kpANypiVO
         W9Zpu8GyHg9f/rs4Aunerd1oYPHa7h6DExhlZHoSdjSIY1n77R7D0qP5GoEf3FHDsbwN
         bG4LWO+LEGwMjrihLT9lAxCKGYzQib71COQDwAU6MkroUNlvVqs+9eBsT3xr/b2HIDH3
         lxAMdbrP/hyZReciP8ooN44ezv7mrG2eDlQZh0bcLLSkQIZ+ueHtEaRj4S533Z9sMauT
         iwJg==
X-Gm-Message-State: ACgBeo392Gy/9d9JQwB5N65bI+AofTPHavPFB/yJFuy1jdxGOt9MCya1
        DwJXlk8t6NSbPDBvrSZ7XXPRET0fbZU=
X-Google-Smtp-Source: AA6agR7rkUqfL8nIyNUj0I6V9etyrgMpXyeP0nHHGTJeNVY2pZTqRDuufc8gxYFz8dll9lBHJlBwAw==
X-Received: by 2002:a05:6402:4407:b0:43f:68b8:3358 with SMTP id y7-20020a056402440700b0043f68b83358mr27202920eda.215.1660218819127;
        Thu, 11 Aug 2022 04:53:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ku19-20020a170907789300b0072abb95eaa4sm3415542ejc.215.2022.08.11.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:53:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM6kr-001Cl2-2n;
        Thu, 11 Aug 2022 13:53:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
Date:   Thu, 11 Aug 2022 13:52:23 +0200
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
Message-ID: <220811.86o7wrov26.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Taylor Blau wrote:

This change:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 24a811f0ef..3515350ed6 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  'git cat-file' (-t | -s) [--allow-unknown-type] <object>
>  'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all-objects]
>  	     [--buffer] [--follow-symlinks] [--unordered]
> -	     [--textconv | --filters]
> +	     [--textconv | --filters] [-z]
>  'git cat-file' (--textconv | --filters)
>  	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
>  
> [...]
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f42782e955..c3602d15df 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -31,6 +31,7 @@ struct batch_options {
>  	int all_objects;
>  	int unordered;
>  	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
> +	int nul_terminated;
>  	const char *format;
>  };

Is missing a corresponding change to the -h output here. Before this
they were the same, but now:
	
	+ diff -u txt help
	--- txt 2022-08-11 11:53:00.235221628 +0000
	+++ help        2022-08-11 11:53:00.239221594 +0000
	@@ -3,6 +3,6 @@
	 git cat-file (-t | -s) [--allow-unknown-type] <object>
	 git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]
	              [--buffer] [--follow-symlinks] [--unordered]
	-             [--textconv | --filters] [-z]
	+             [--textconv | --filters]
	 git cat-file (--textconv | --filters)
	              [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]

(Spotted with some local patches of mine which automatically check this)
