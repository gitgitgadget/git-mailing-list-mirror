Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96085C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B6C60F70
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhJHToZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhJHToY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:44:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1599AC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:42:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so40349607edv.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Jt3/htRqXbQ1ooi07OzeI7Nx/t77ttxKjeS+bj9+gk0=;
        b=AxysWRJghpN2nWVPIfsZ+1UrRELuyC4ODtrsCcVrC+96isYtnjh7eolZRi14yXiZVZ
         LG6y3Gsy6fe46c3urSkaQRy00H08XtUo2SM7edC1s3FTmnlnf5758ddTmEAsKZd4AFAk
         3tAbb2HHZ01UzxIqEl6BCCeRXj3um/HHW0rNUwwUR1LAJNm1tZgOy3dCeuIXbY+oorpM
         aJXcFL65uvJV6cy+5+4YtiS5oRzs7J7rWMQXUTaFSisz+dZKbB8VK3wWnmBddVNEDVML
         /yWaM2vk3+o0qdCTL16fzhCGWTnvnC//QGiXj1aeid2wc7Ba1EXmqIMqLM/AZvO9lLK3
         dTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Jt3/htRqXbQ1ooi07OzeI7Nx/t77ttxKjeS+bj9+gk0=;
        b=D5ugxlWfMjROIwk6/611v7yEstaNwW9I1zdcFlmCZxP13NxcFRFY+DErwgZVBcx56O
         oTyfWysGdXmKDW7qRMHcQs0B/OQcZanepw6EnRkRw8vttzEyQsi6gve6xftQTBogPRUg
         rsZ9rB9ar5FsEEGnXroFSjEdt5Ew/l15LTY7OPEKuDPDKC+K+FEZGd0UIV1qjBxtpKBk
         e6VLdtwF7ApVsyl9V3GSqxvs3eckQFZ7wQ1VjuAskNmh/s2e0enT43xpMviJhQo7pN/g
         4EsNUuXsLn5/0CYh2yxQnfHPfIjpw1olB/48Qr/Q0PwfNCfGApzEmIQULhXRkAbB783P
         g7rA==
X-Gm-Message-State: AOAM533eCasF++fONBV0fZvg5jDfE6iLgkaUgyBDYFMtdiWm3v3MB4+p
        rht1aTbLXmCp+Dkzb6UG4P4/3MnHcEtnPA==
X-Google-Smtp-Source: ABdhPJyg1m2YrKDiZYWe6508P8B9+tfuruebfGxe+WqQBh02AAwLh+zL7H0tOv4XtnneqXy3ZVOPVw==
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr17839499edw.337.1633722147494;
        Fri, 08 Oct 2021 12:42:27 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p7sm125838edr.6.2021.10.08.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:42:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH 1/2] fetch-pack: redact packfile urls in traces
Date:   Fri, 08 Oct 2021 21:36:37 +0200
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
 <b473f145a87a22db99734c6a21395f0d24c3da3c.1633708986.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <b473f145a87a22db99734c6a21395f0d24c3da3c.1633708986.git.gitgitgadget@gmail.com>
Message-ID: <87zgrjmhgd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Ivan Frade via GitGitGadget wrote:

> diff --git a/http-fetch.c b/http-fetch.c
> index fa642462a9e..d35e33e4f65 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -63,7 +63,9 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
>  	if (start_active_slot(preq->slot)) {
>  		run_active_slot(preq->slot);
>  		if (results.curl_result != CURLE_OK) {
> -			die("Unable to get pack file %s\n%s", preq->url,
> +			int showUrl = git_env_bool("GIT_TRACE_REDACT", 1);
> +			die("Unable to get offloaded pack file %s\n%s",
> +			    showUrl ? preq->url : "<redacted>",
>  			    curl_errorstr);
>  		}
>  	} else {

Your CL and commit message just talk about traes, but this is a die()
message.

Perhaps it makes sense to redact it there too for some reason, but that
seems to be a thing to separately argue for.

This message is shown interactively to users, and I could see it be
annoying to not have the URL that failed in your terminal output, even
if it has some one-time token.

Which is presumably different from the use-cases you're thinking of, I'm
assuming some logging of detached processes, or central logging of user
actions.

> +test_expect_success 'packfile-uri redacted in trace' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	configure_exclusion "$P" my-blob >h &&
> +
> +	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
> +	git -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \
> +		clone "$HTTPD_URL/smart/http_parent" http_child &&
> +
> +	grep -A1 "clone<\ ..packfile-uris" log | grep "clone<\ <redacted>"

We don't rely on GNU options like those for the test suite, it'll break
on various supported platformrs.

In this case the whole LHS of the pipe looks like it could be dropped,
why not grep for "^clone< <redacted>"?

Also you don't need to quote the space character in regexes, it's not a
metacharacter.
