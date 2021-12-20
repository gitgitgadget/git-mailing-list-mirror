Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D638C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhLTSma (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbhLTSm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 13:42:29 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A56C06173E
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:42:29 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so13602217oto.13
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gQY/vJbuqAaHuhTQUOo9iEQ0bLwdsdUOfQ5GWY0+Pks=;
        b=aPvd0T4chM0dUA+R6OWh+D5EmPjCS/MPzruCJg93HFzktVM7MZuk41TwOLMGv+qKPn
         OLm8raAi4je04L7MOHzfz8qeTgfiEnO+1/w3cYZvNKSp8eZWOiGgl9RmjL2c4oIghpfX
         Js7UIB64SJDrNTPFR8Y6CNeCapjPx+35f+ByiX9miO7NKiWumH05Ogu5eHVIrVM2Dlgn
         t6LmqIDQdNg0fy40rmBu4LkY0ub5kE7ffmbUQO3aFTgiR7JBUOFYx/Bu9JYKLCny38ar
         GfHqtAdrXJw35ovtVMnAnaJ6hR2eVVky8HRi461WD7PXyNlaBAQx5479k0r+7rWjb9N2
         15Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gQY/vJbuqAaHuhTQUOo9iEQ0bLwdsdUOfQ5GWY0+Pks=;
        b=jrSkWMEFP6ZWgbjRMuJf/8iWV5reEuRHRmduEBOdjP6SH8bLkfer+2r7dHcFmp6UDg
         x6mG/IJDrnFv1AS65V+AbUt0T1/eP3L/cFxtKW5jPr9VP+N2kG8Jiy5P5vZVJ6d2kCse
         EKVk4ku5mwSZ14QmWoTTRXdW8QKk7TA6EfIHRwvJLoqoiDAOC95mdIw9ElHBHGxd/5Q2
         346koz9JVnFAi2dYD7xXUgQ9FRAG+HDvIODtn5Scbouw0p163BGVfMSWKRpUGnOgg3lG
         85/QlvXxJYZ+xT+cmqVz7W0HKlYo9vXDYcREzP5XPeXzt3swbWCnRRl3MPY1jrKAXE83
         +F3A==
X-Gm-Message-State: AOAM533awYqmcoX+omxYwJ3d70hiNx5jhUKQcp1oTkjRAeWut54/7UxT
        Lg/jELYcBfifZNdwrLf91RDbqHToB6E=
X-Google-Smtp-Source: ABdhPJz9u3Q8f2DWtqF/jWf6fkTfY9nj7QJ1FlBCrbDzPLwHvpp3kP2YPqexEa3zOcaZh3+S+tYJvw==
X-Received: by 2002:a9d:7758:: with SMTP id t24mr12555961otl.264.1640025748624;
        Mon, 20 Dec 2021 10:42:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id o11sm3608653oiv.10.2021.12.20.10.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 10:42:28 -0800 (PST)
Message-ID: <92d50859-ecfa-e7c5-d68b-d90a11579cd0@gmail.com>
Date:   Mon, 20 Dec 2021 13:42:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 8/8] midx: read `RIDX` chunk when present
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <993bfa8dd8480e74d64f657539b0c518ad155e5c.1639446906.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <993bfa8dd8480e74d64f657539b0c518ad155e5c.1639446906.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2021 8:55 PM, Taylor Blau wrote:
...
> Note that we have two knobs that are adjusted for the new tests:
> GIT_TEST_MIDX_WRITE_REV and GIT_TEST_MIDX_READ_RIDX. The former controls
> whether the MIDX .rev is written at all, and the latter controls whether
> we read the MIDX's RIDX chunk.

...

> +	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
> +		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
> +

Skip reading if GIT_TEST_MIDX_READ_RIDX=0 (do read if true or unset). Good.

> -	if (flags & MIDX_WRITE_REV_INDEX)
> +	if (flags & MIDX_WRITE_REV_INDEX &&
> +	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
>  		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);

Only write if GIT_TEST_MIDX_WRITE_REV=1 (skip if false or unset). Good.

> +	if (m->chunk_revindex) {
> +		/*
> +		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
> +		 * the reverse index instead of trying to load a separate `.rev`
> +		 * file.
> +		 *
> +		 * Note that we do *not* set `m->revindex_map` here, since we do
> +		 * not want to accidentally call munmap() in the middle of the
> +		 * MIDX.
> +		 */
> +		trace2_data_string("load_midx_revindex", the_repository,
> +				   "source", "midx");
> +		m->revindex_data = (const uint32_t *)m->chunk_revindex;
> +		return 0;
> +	}
> +
>  	trace2_data_string("load_midx_revindex", the_repository,
>  			   "source", "rev");

A natural way to do this.

>  
> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index 0a35daf939..f5eaa9cf68 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -291,7 +291,7 @@ test_rev_exists () {
>  }
>  
>  midx_bitmap_core () {
> -	rev_kind="${1:-rev}"
> +	rev_kind="${1:-midx}"
>  
>  	setup_bitmap_history
>  
> @@ -435,7 +435,7 @@ midx_bitmap_core () {
>  }
>  
>  midx_bitmap_partial_tests () {
> -	rev_kind="${1:-rev}"
> +	rev_kind="${1:-midx}"

And I'm glad we can just update the default here.

> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 100ac90d15..8c92acb0ce 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -9,6 +9,11 @@ test_description='exercise basic multi-pack bitmap functionality'
>  GIT_TEST_MULTI_PACK_INDEX=0
>  GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
>  
> +GIT_TEST_MIDX_WRITE_REV=0
> +GIT_TEST_MIDX_READ_RIDX=1
> +export GIT_TEST_MIDX_WRITE_REV
> +export GIT_TEST_MIDX_READ_RIDX

Technically, we could unset these variables, right? ("...=")

> diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
...
> +# We'll be writing our own midx and bitmaps, so avoid getting confused by the
> +# automatic ones.
> +GIT_TEST_MULTI_PACK_INDEX=0
> +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> +
> +# Unlike t5326, this test exercise multi-pack bitmap functionality where the
> +# object order is stored in a separate .rev file.
> +GIT_TEST_MIDX_WRITE_REV=1
> +GIT_TEST_MIDX_READ_RIDX=0
> +export GIT_TEST_MIDX_WRITE_REV
> +export GIT_TEST_MIDX_READ_RIDX
> +
> +midx_bitmap_core rev
> +midx_bitmap_partial_tests rev
> +
> +test_done

Nice that now we get the payoff of the test refactor. This new script exists
only to verify that we can still read the old .rev files, which is important
for compatibility.

Forgive me for "speaking out loud" throughout this patch. I don't see any
need for changes but it is the crux of making this series work.

Thanks,
-Stolee
