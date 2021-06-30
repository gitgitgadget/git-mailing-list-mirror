Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F2C11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A356B61452
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 23:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhF3XLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhF3XLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 19:11:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795C1C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 16:09:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z4so2446537plg.8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hEI+I3aLN7oqRTqNc64QAl92iVQ7V8PmgrKSRzJG9EU=;
        b=EeP4UiT2Kzw0+jkbYGSRxrsHugjeHBjQGTHoWYf9fnxw0ILPmMx3iCMwwIGDDxyqbf
         BeAUY+WbdJXtUF0AlfYO+p5veNubS47GBUuiQ/WOxai2EhkIBmo8iz4XOal8TALd9CFb
         YLce/XUzSyZmcNAuRs2CBQBetQkfj0XmHSCquK+ZFIXuxpwNS2k0jfkYuPHNzU28ztWe
         m3cAJJyGs03YRNc6K1v+VxkRi5DgAPjj0uLiYoJFStMXKtqPHVMEFnecsqze+sRj+7jp
         j0q91Qr/gGJPk6M9o0qWW441b8H/VyBJGSnBVFlXRPGeD9KRnERlQeZFKkkEPf+RP56b
         Njcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEI+I3aLN7oqRTqNc64QAl92iVQ7V8PmgrKSRzJG9EU=;
        b=T+e0/C+g/NU/g8F2JgFjqPlxwyscgsWMdxsLUd7qCE/f+w/7oU3j2J+X2X0G+mAQq8
         WTdNbR0wY7La3qIKYZmmALxte85+5VPP0q9h2tzjs+eBFaABT32YBBbH4/T3F5iF55le
         ge9TP/A1XqsRUgMppL4nx5X8ileT1CXqQsgNJmGZUSSuw4S19ZxZ1Nrddm7V5VRJldgx
         n8xIj+Fw9N3ubRIx6YtqnMClHr1l9QFvz44CGbDef0WO9FRVPYkgkfEiuAigiiU0d9jT
         vm74z+SxXErkdlvZ09RtBGWnhVvvP/Gokaju1XlgOrLGsffbZuoMMtfccH+hPFihTxky
         dDag==
X-Gm-Message-State: AOAM532M9jp8pXI2t0jrpEhfNNr/w7VoIn/n60ORZQoW+10xc7VP9liv
        d3Yx7DTOBJttkWFfQrnRcEqVtVrPEGk=
X-Google-Smtp-Source: ABdhPJzgLCkCz2tiCZmhavK89zT4XRQ0esI4if1V1jo0KJ7SP2sRFUT1x6r0ZYElPDcUcCUKgivWJg==
X-Received: by 2002:a17:902:7244:b029:f5:2ffd:37f9 with SMTP id c4-20020a1709027244b02900f52ffd37f9mr34302060pll.26.1625094546812;
        Wed, 30 Jun 2021 16:09:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:70f3:5946:a3a4:34a7])
        by smtp.gmail.com with ESMTPSA id w21sm9801515pge.30.2021.06.30.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 16:09:06 -0700 (PDT)
Date:   Wed, 30 Jun 2021 16:09:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH v2] fetch: show progress for packfile uri downloads
Message-ID: <YNz5kEs4ivfJdhP3@google.com>
References: <pull.907.git.1616007794513.gitgitgadget@gmail.com>
 <pull.907.v2.git.1618008249632.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.907.v2.git.1618008249632.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Albert Cui wrote:

> Git appears to hang when downloading packfiles as this part of the
> fetch is silent, causing user confusion. This change implements
> progress for the number of packfiles downloaded; a progress display
> for bytes would involve deeper changes at the http-fetch layer
> instead of fetch-pack, the caller, so we do not do that in this
> patch.
>
> Signed-off-by: Albert Cui <albertqcui@gmail.com>
> ---
>  fetch-pack.c           | 8 ++++++++
>  t/t5702-protocol-v2.sh | 8 ++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)

This is something that came up at the last in-person Git Contributor
Summit; I'm glad to see it being taken care of.

> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -23,6 +23,7 @@
>  #include "fetch-negotiator.h"
>  #include "fsck.h"
>  #include "shallow.h"
> +#include "progress.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -1585,6 +1586,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	struct fetch_negotiator *negotiator;
>  	int seen_ack = 0;
>  	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
> +	struct progress *packfile_uri_progress;

It seems to be more idiomatic to initialize this to NULL.

>  	int i;
>  	struct strvec index_pack_args = STRVEC_INIT;
>  	struct oidset gitmodules_oids = OIDSET_INIT;
> @@ -1689,6 +1691,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		}
>  	}
>  
> +	packfile_uri_progress = start_progress(_("Downloading packs"), packfile_uris.nr);

That way, we can respect a --quiet option by making this remain NULL
when progress is not enabled:

	if (!args->quiet && !args->no_progress)
		packfile_uri_progress = ...;

[...]
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -848,10 +848,12 @@ test_expect_success 'part of packfile response provided as URI' '
>  	configure_exclusion "$P" my-blob >h &&
>  	configure_exclusion "$P" other-blob >h2 &&
>  
> -	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
> +	GIT_PROGRESS_DELAY=0 GIT_TRACE=1 GIT_TRACE2_EVENT=1 \

This puts the trace in stderr mixed with other output.  Would it make
sense to put it in a separate file, like this?

	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" \
	GIT_PROGRESS_DELAY=0 GIT_TRACE2_EVENT="$(pwd)/trace2" \
	GIT_TEST_SIDEBAND_ALL=1 \
	git -c [etc]

[...]
> @@ -875,6 +877,8 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f hfound &&
>  	test -f h2found &&
>  
> +	test_i18ngrep "Downloading packs" progress &&

That way, this "grep" could check the trace2 file which would contain
output intended for machines, and we wouldn't have to worry e.g. about
ANSII control codes potentially affecting the output around the space
some day in the progress output intended for a terminal.

With whatever subset of the changes described above make sense, this is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
