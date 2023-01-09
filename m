Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30516C54EBC
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 02:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjAICiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjAICiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 21:38:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09AA45E
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 18:38:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c4so8071560plc.5
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4HcC3oEHPiRDE45FWMrCRUMI/icrygecYvoPiFLTCA=;
        b=ZWZz+21jYDO6+olT5k5p3deYMxhN5vHWwOesxqhpR1hGPIni5suNN3N0ThjfyByFEo
         7J6mU5Uq1mBg20uB9iVLyPGHJ5+u3I3Ryjnh8wa9LbECE5aKLKereUX/aiGK2sOI5mCC
         ydqZ7+sUrJ1Hv32mKVezl5qzdETfOkQYe1hUMLiueH1uER0Q4PiKsjXfsYAqQ4hIoMkb
         cEg7k7fl8wnvGk5AKJyflM1Jeji5lM5p+Z6uEMDPmZ1JKgmXw3A5KD9MAInJo6XjG/YB
         g9n03/ZcdHnf/Nah4ysahJlM6dFoRYm+D8NmI0zJzDpj1DtDnfLv3SHJG1Cg+jfLPJAx
         lRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4HcC3oEHPiRDE45FWMrCRUMI/icrygecYvoPiFLTCA=;
        b=QxzU3YkstG2mgMB/buWQgOa5eewzjAgHcjtNLM8vfVtKVKey34x1cwQvEKjH1Gvh2Q
         cflQNcWa6MXfu2CPDonCypzTw+Pb7RXG8z9c2cNnH+7iyWpoFojuffJMpJfd+E9hhyMr
         RtOlpY4Gw2Tx59ccBWdZX+KN2rEG+iGfL6gRXsVVBrzz+u8vttl0zVgXs0J60Evwp52S
         BWX4Mp5LekzaD9GgJvS2AMKl8sluu74SDmWZLU9XKSqwcXPZ6QXbyJ5r0kwDy3f3P0ub
         cgOomi8sgGT5nVeRU/YwkpGZt684Y9Ehj+S4Lf2C/ip+/KTjlSzMcxomyF4AcTHwgB7D
         ImfA==
X-Gm-Message-State: AFqh2kr4u2S/zX/b+dqUW+vpxn/2QrQ3M+NbQWR9vWYTHF0AexGOkp5t
        IE9Pir6Y1i/QJK12ljAUfqg=
X-Google-Smtp-Source: AMrXdXs8Sm/Iy1DrMC6NBUshV85c6VOKIC//vmOZncQqc+wDi9VBxo2NyOgYdTy38t92/7TTkOX3ew==
X-Received: by 2002:a17:903:26c4:b0:192:f6d0:602e with SMTP id jg4-20020a17090326c400b00192f6d0602emr15222592plb.22.1673231888042;
        Sun, 08 Jan 2023 18:38:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z18-20020a63e112000000b004767bc37e03sm4196347pgh.39.2023.01.08.18.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 18:38:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/8] bundle-uri: parse bundle.heuristic=creationToken
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 11:38:07 +0900
In-Reply-To: <9007249b9488c23f00c2d498ffd520e4af8b37a4.1673037405.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 06 Jan 2023
        20:36:39 +0000")
Message-ID: <xmqqilhgxwj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static const char *heuristics[] = {
> +	[BUNDLE_HEURISTIC_NONE] = "",
> +	[BUNDLE_HEURISTIC_CREATIONTOKEN] = "creationToken",
> +};

Ideally it would require the least amount of maintenance if we could
define BUNDLE_HEURISTIC__COUNT as ARRAY_SIZE() of this thing, but it
being a file scope static, it might not be easy to arrange that.  As
a lessor altenative, would it make it safer to size this array more
explicitly using BUNDLE_HEURISTIC__COUNT macro?

	static const char *heuristics[BUNDLE_HEURISTIC__COUNT] = {
		...
	};

or is it more-or-less moot point to aim for safety because nobody
enforces that these [indices] used to define the contents of this
array are dense?

That is ...

> @@ -142,6 +150,19 @@ static int bundle_list_update(const char *key, const char *value,
>  			return 0;
>  		}
>  
> +		if (!strcmp(subkey, "heuristic")) {
> +			int i;
> +			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
> +				if (!strcmp(value, heuristics[i])) {
> +					list->heuristic = i;
> +					return 0;
> +				}
> +			}

... this strcmp() will segfault if heuristics[] array is sparse, or
BUNDLE_HEURISTIC__COUNT is larger than the array (i.e. you add a new
heuristic in "enum bundle_heuristic" before the __COUNT sentinel,
but forget to add it to the heuristics[] array).

"You are worrying too much.  Our developers would notice a segfault
and the current code, which may look risky to you, is something they
can live with", is a perfectly acceptable response, but somehow I
have this nagging feeling that we should be able to make it easier
to maintain without incurring extra runtime cost.

> diff --git a/bundle-uri.h b/bundle-uri.h
> index d5e89f1671c..ad82174112d 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -52,6 +52,14 @@ enum bundle_list_mode {
>  	BUNDLE_MODE_ANY
>  };
>  
> +enum bundle_list_heuristic {
> +	BUNDLE_HEURISTIC_NONE = 0,
> +	BUNDLE_HEURISTIC_CREATIONTOKEN,
> +
> +	/* Must be last. */
> +	BUNDLE_HEURISTIC__COUNT,
> +};

The only reason to leave a trailing comma is to make it easy to
append new values at the end.  By omitting the trailing comma, you
can doubly signal "Must be last" here (not suggesting to remove the
comment; suggesting to remove the trailing comma).

Thanks.

