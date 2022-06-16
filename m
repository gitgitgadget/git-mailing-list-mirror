Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC1C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376865AbiFPSJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiFPSJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:09:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278F4CD54
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:09:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j4-20020a170902da8400b00168b0b2341dso1211575plx.5
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iE3iW8GKpe6tdYPk7A26TFYxV4F1eI3ZIaxlXCcgeEg=;
        b=eONMtPOtxpl8MD4W+EBchwvw+6nOjbzSLIVuc7zS8vLV6D+ZGcOa73vTsQaMbvvuO/
         AKc5kYkkBtIBc4r/fUhtO/RLdH1nhis586yvsPuWHWwd9L1QMSZ+g4jRTmOcE36rrDNC
         3uJX6k9wYYzfEZasu56MKL16QjwZal42rMa+LtrBJpTZEbyi4iwd1/cR2i/qwKJQYLR0
         qUhkZmRj92pwdFaQi/gSUM+Dx0BSNBiuUqyh28Z2SgWxtaFJqQOytumuWsZBtQMN32dN
         m+JzRPVZq0U7iWiE91IX2YKZPfna2+7n3Y/IMu9N0rQz2DaUT7NBVEPYs07yF6QwdVzE
         pvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iE3iW8GKpe6tdYPk7A26TFYxV4F1eI3ZIaxlXCcgeEg=;
        b=ceaOjPxAkgxpLEFoaBNz4Qic5kBhnUy6RQJqZ9AuY5XpJmMW3h1fv2M54lrVZwUsuI
         H6OrDmRoZMlL0WCHH2rgQqlMnX3AUJp3e9Yoh/aWK9AC1lIXPVHsVhN3XUuXuyO/+Aa4
         22eA/ONBk5zfoEeESc9DBV8MNODf4C5w0qLXXuArhcEr+XmQGSjQ/kfE+kaD0XWfbgLf
         AOke6+KtKrt3qTzK51Bk4g5BZxEE/51k3O7JuxmWIf46ZxvdQt/0fnyObDSypkojBulb
         6OR8etGlQ2f0sD5P0ib6vX4bg7uvSffWahJ59m8Vxb2F6RZr93FpyklBYy/IONX3OE0f
         uIgg==
X-Gm-Message-State: AJIora93njiyk5kPYoDiDaLu8Z+bXIAVvIbnYjNX4tBF0hU21Hk5TCO3
        lTtBft0HU9FfcpSmxFM5ikEzl3CaFGWi6g==
X-Google-Smtp-Source: AGRyM1vSfwdmcWQR1hVDiAr2Gz9OjB/xjQxVm1i2yfImic7qrpDxU4t8JOAnSOAjfc757Ul/uDyrC40W1lFkmQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2405:b0:520:6b82:646b with SMTP
 id z5-20020a056a00240500b005206b82646bmr5970952pfh.24.1655402949141; Thu, 16
 Jun 2022 11:09:09 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:09:07 -0700
In-Reply-To: <xmqqmtedw7fm.fsf@gitster.g>
Message-Id: <kl6lpmj84h18.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
 <591166e07d87fdb5efc2769d3e2963e3f0412720.1655336146.git.gitgitgadget@gmail.com>
 <xmqqmtedw7fm.fsf@gitster.g>
Subject: Re: [PATCH 05/11] submodule-config: avoid memory leak
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> In 961b130d20c9 (branch: add --recurse-submodules option for branch
>> creation, 2022-01-28), a funny pattern was introduced where first some
>> struct is `xmalloc()`ed, then we resize an array whose element type is
>> the same struct, and then the first struct's contents are copied into
>> the last element of that array.
>
> Sigh.  The original is butt ugly, with this strange pattern and
> structure assignments etc.  I wonder how something like this slipped
> through our reviews.

Gah, I have no excuses for bad code I've already written, I can only
strive to write better code next time.

Thanks Johannes for spotting and fixing this.

> I wonder if it would help for me to stop trusting reviews by less
> experienced reviewers too much, and instead give sanity checks to
> more patches myself from now on, but I certainly cannot afford the
> time and my mental health to do so for all the patches X-<.

I seem to recall that this was reviewed by fairly experienced folks. I'm
guessing it slipped through due to reviewer fatigue, which might be a
good argument for adding more tooling to lighten reviewer load/patch up
the gaps.

>
> Will queue.
>
>>  		if (S_ISGITLINK(name_entry->mode) &&
>>  		    is_tree_submodule_active(r, root_tree, tree_path)) {
>> -			st_entry = xmalloc(sizeof(*st_entry));
>> +			ALLOC_GROW(out->entries, out->entry_nr + 1,
>> +				   out->entry_alloc);
>> +			st_entry = &out->entries[out->entry_nr++];
>> +
>>  			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
>>  			*st_entry->name_entry = *name_entry;
>>  			st_entry->submodule =
>> @@ -766,9 +769,6 @@ static void traverse_tree_submodules(struct repository *r,
>>  						root_tree))
>>  				FREE_AND_NULL(st_entry->repo);
>>  
>> -			ALLOC_GROW(out->entries, out->entry_nr + 1,
>> -				   out->entry_alloc);
>> -			out->entries[out->entry_nr++] = *st_entry;
>>  		} else if (S_ISDIR(name_entry->mode))
>>  			traverse_tree_submodules(r, root_tree, tree_path,
>>  						 &name_entry->oid, out);
