Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B52BC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D4461421
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDUX3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhDUX3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:29:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2045C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 16:28:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 31so149177pgn.13
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7ZQbpMLs2/vrEQBcHSMWzn/+k62LZoUf+IO6u/4piHs=;
        b=esOP1NLtQbSbSPLTyRl56PiudJpJgB1J1tgqizacyAxLrtsTMsZyJA/aLT8tx5D5V4
         pUU6HMkIUqmEugVcGBvF7ZLWqFtlwsW02fO9WZQ2WlO8bzzY7Bk/cwDLwcfJDE8cD2O6
         6HgJhkGh7thNN0NG5LWCJvLVAW4NRF89Gkmbk9Yk38wTuMwwp9iJJHNk7LQ8Whc0tPlL
         R5yT6u2EPM2WrTiut8ggh2BoBs659I34kOBf+BkwFMYzbf1PHhPEhVXyWT1Y7bNJy4nb
         9YwcSo5SAuaogC/0D8QYwoOEU8oyyBLqfJL9NurxLQxBwWnC+0pz5qkQO+zPxm5mmuwl
         w+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7ZQbpMLs2/vrEQBcHSMWzn/+k62LZoUf+IO6u/4piHs=;
        b=I+rHBQHXuvNCyFXQwCG9kw/pOyLAmAE7WhKG8+ZUY4RPzrIm0H8AS+k7U8lbqMWuBV
         gw2dosvnga2uI0Vj2VahGI/cunJV6XDRDa+vgd5W4Zf/+utbvYQq0HMOxXjFvgeJZe8z
         e6sbE+5Kc3wooDA2hD9Z8M250HlcNCNixxHb139/+cAp9eeyi86BcifGUJUkk2p93HQH
         LuemUIbYEcvKfbPAyb+tAAvz52TTP0BY1jNPYBGd000K8wcDfYbpMB04kL3gAUhRlhK3
         RT0emfB7ELovugUEXfuNK5Ni0zaYgEAOvOKmO1heRc/UvuMWK9sy0oWEjPXus6BuqDuu
         4D9g==
X-Gm-Message-State: AOAM531PRhTFar9VFY1BxQ5zm4XOrxr4rU2VJj88s1JhUVS5nyztXhOs
        GRKDZ+SqTqdR2Roxv0vDeQW0hg==
X-Google-Smtp-Source: ABdhPJz4tzCyIC1ceAFlfzSoksp+ZSYZ2vbAthW8p/Rm87UjU3yUJuPzvZPlyq1ZwpkXjQ7vZwby5w==
X-Received: by 2002:a17:90a:ea0f:: with SMTP id w15mr13943521pjy.31.1619047720332;
        Wed, 21 Apr 2021 16:28:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6d58:26e3:155c:4476])
        by smtp.gmail.com with ESMTPSA id x22sm386717pgx.19.2021.04.21.16.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 16:28:39 -0700 (PDT)
Date:   Wed, 21 Apr 2021 16:28:33 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/8] object.c: add and use oid_is_type_or_die_msg()
 function
Message-ID: <YIC1IcpKCXh3qoun@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
 <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
 <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.8-22e7d9a3db-20210420T133218Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.04.20 15:36, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/object.c b/object.c
> index 9e06c0ee92..0f07f976fb 100644
> --- a/object.c
> +++ b/object.c
> @@ -176,6 +176,18 @@ int oid_is_type_or_error(const struct object_id *oid,
>  		     type_name(want));
>  }
>  
> +char* oid_is_type_or_die_msg(const struct object_id *oid,

It's kind of a nitpick, but I found the function name to be confusing.
It sounds like you're going to die with a custom message. Maybe
something like "get_oid_type_mismatch_msg()" would be more
straightforward.
