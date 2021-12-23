Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE5CC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 21:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbhLWVwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 16:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLWVwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 16:52:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F9C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:52:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w24so5290308ply.12
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=di5x17uWCRuB02c7Zv3ANMHs62Il1mmHuMNYRiGq19E=;
        b=kj0CgF1kh0wHWjxK5shLFTfgJzgqLa0kidj/+Kkk51Sq87QVDG+kOGeSh2emfGdp3S
         +mozLIHvuA5P9fWboZ/ZMCI/h3I/gAjJSc72bWzp5wmUtCNJOmIaLvatrl5T6Sp0X3sT
         NHbO6x7g0CmfjVXY5dfn6tllIpWImBnOJ5IHgeAaJqL7WayjC6SIr82yuVk0YEM2s8Xe
         +Q9WW5SwdX25Dh0DUlHWllb7m27uUzW27p1PBBNPvb+EfZeVYVn+t32vK9tCXPjSRuan
         hNsQuDW05UwzOs+3mkXYkIplymEbKayXBRp5kxH9IulVyAUsbWaVHTvAs+WFaqim9Ryu
         EOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=di5x17uWCRuB02c7Zv3ANMHs62Il1mmHuMNYRiGq19E=;
        b=LCJNn5JmuyTVyRSyfXTh8ltr2DXdRY6G4t9C027pnvNE70DrI8YgDNr2SypJG4tWH6
         FQaDUWYOJE1o6znLIOVQV0/4s6YVBKYNpO/SVg1doaGsAm3J9aLGmFYI1uyivWr0SSGC
         yfXfK32TiBo6Cq63cAo+MKrQG8KyR83CcQMUY20tpvC9Q0uPas4UvAVgHWsBV+phUrS9
         2iMCZMH6htqGm5L5n0dMwjzV7d9GQ9VPvQTbRApHS9n/YuUGZrBN8zJVaJKIWPbqe3FX
         Se6Hpu7Vybhb6RKdHdKg1jYqBagkkkywYW+QtpwUpv7zw+hvDMGtIiVMaLxxj1T8ctfi
         Hy/w==
X-Gm-Message-State: AOAM533ciKBvo5KZCEya1svYmBUKC7KsRmeoSpy793JRMPpKiRBAnYW7
        KD7TB8cMThMyXTQilTpftMA6Ug==
X-Google-Smtp-Source: ABdhPJyrL5Yi7lIOyJaIOTYD52btF38CzusRuzU9oymU6+cPPPjfPa1FwCw+/kIMgBwErNLzNYh96w==
X-Received: by 2002:a17:90a:e501:: with SMTP id t1mr4638000pjy.241.1640296325506;
        Thu, 23 Dec 2021 13:52:05 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3d09:6204:5070:ab7a])
        by smtp.gmail.com with ESMTPSA id y11sm6497442pfn.7.2021.12.23.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 13:52:04 -0800 (PST)
Date:   Thu, 23 Dec 2021 13:51:58 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 2/6] object-name: explicitly handle OBJ_BAD in
 show_ambiguous_object()
Message-ID: <YcTvfgxYc7U7bodg@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
 <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
 <patch-v5-2.6-ee86912f1c1-20211125T215529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-2.6-ee86912f1c1-20211125T215529Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.11.25 23:03, Ævar Arnfjörð Bjarmason wrote:
> Amend the "unknown type" handling in the code that displays the
> ambiguous object list to assert() that we're either going to get the
> "real" object types we can pass to type_name(), or a -1 (OBJ_BAD)
> return value from oid_object_info().
> 
> See [1] for the current output, and [1] for the commit that added the
> "unknown type" handling.
> 
> We are never going to get an "unknown type" in the sense of custom
> types crafted with "hash-object --literally", since we're not using
> the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag.
> 
> If we manage to otherwise unpack such an object without errors we'll
> die() in parse_loose_header_extended() called by sort_ambiguous()
> before we get to show_ambiguous_object(), as is asserted by the test
> added in the preceding commit.
> 
> So saying "unknown type" here was always misleading, we really meant
> to say that we had a failure parsing the object at all, if the problem
> is only that it's type is unknown we won't reach this code.

Are there situations other than repo corruption where this could happen?
Maybe it would be more useful to just die() at this point and give the
user advice on how to investigate / fix the corruption, rather than
trying to disambiguate the objects involved.


> So let's emit a generic "[bad object]" instead. As our tests added in
> the preceding commit show, we'll have emitted various "error" output
> already in those cases.
> 
> We should do better in the truly "unknown type" cases, which we'd need
> to handle if we were passing down the OBJECT_INFO_ALLOW_UNKNOWN_TYPE
> flag. But let's leave that for some future improvement. In a
> subsequent commit I'll improve the output we do show, and not having
> to handle the "unknown type" (as in OBJECT_INFO_ALLOW_UNKNOWN_TYPE)
> simplifies that change.
> 
> 1. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
>    then SHA-1, 2018-05-10)
> 2. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
>    2016-09-26)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  object-name.c                       | 14 ++++++++++++--
>  t/t1512-rev-parse-disambiguation.sh |  2 +-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/object-name.c b/object-name.c
> index fdff4601b2c..9750634ee76 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -361,6 +361,16 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  		return 0;
>  
>  	type = oid_object_info(ds->repo, oid, NULL);
> +
> +	if (type < 0) {
> +		strbuf_addstr(&desc, "[bad object]");
> +		goto out;
> +	}
> +
> +	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
> +	       type == OBJ_BLOB || type == OBJ_TAG);
> +	strbuf_addstr(&desc, type_name(type));
> +
>  	if (type == OBJ_COMMIT) {
>  		struct commit *commit = lookup_commit(ds->repo, oid);
>  		if (commit) {
> @@ -374,9 +384,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
>  			strbuf_addf(&desc, " %s", tag->tag);
>  	}
>  
> -	advise("  %s %s%s",
> +out:
> +	advise("  %s %s",
>  	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
> -	       type_name(type) ? type_name(type) : "unknown type",
>  	       desc.buf);
>  
>  	strbuf_release(&desc);
> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
> index ae1c0cf2b21..f1948980dff 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -100,7 +100,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
>  	error: unable to unpack cafe... header
>  	error: inflate: data stream error (incorrect header check)
>  	error: unable to unpack cafe... header
> -	hint:   cafe... unknown type
> +	hint:   cafe... [bad object]
>  	hint:   cafe... blob
>  	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
>  	Use '\''--'\'' to separate paths from revisions, like this:
> -- 
> 2.34.1.838.g779e9098efb
> 
