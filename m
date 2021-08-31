Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C69C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAC3610A2
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhHaRSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhHaRSa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:18:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35EC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:17:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u21so119922qtw.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHHxYjn2/hQGRYF8eKWCvDVLH+u4TSh8xhqWjzOZ680=;
        b=FnWZ0H+4BwBMhFns7evRJq9cfsN1gO4OfowbJOseHDd1GP10bqCmD3IRob7S+oqiGt
         8QgMoGfGij1VphcpvqmtleLLku6/fjPcMx6Fvz+ULiEkmoX05eC2cnHgv3ji2/64evjG
         MBsbEhIt2EefnUfd7gK7JgjTZ89eQU2NcOrYueIW9t5Onuzag1O+uNqaB4yX6SpzH9ao
         XwdTr7EMDSFdpJXLEbd1DoxmDRMhVKRUDM14KGZWdLxF5rDoj7+5XjLY1T2gkz9ruIbU
         Zu0x1pdLgTQ+N9cYH0XR5IoHlS8O8FfYkajQcT8k0SR5y+uMsxFK0D8rtvJ2YdkGQvH8
         Fj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHHxYjn2/hQGRYF8eKWCvDVLH+u4TSh8xhqWjzOZ680=;
        b=b9SYFItXCqb0ninhFhRHwFbYfn4ZWac6GYYagjWZWTLrQGrKBYvZzj4qsALYcfe+HW
         C+zejE7Ppzb6ryAsXum27DIRyk6RcwOpso05gUpfOQOXLl2+d2OyFuG+ehtAB8Ejh2Ms
         qoU54dim1m/k1YwGkcuver5lDq1NQBO93iLwMYCEal3c5zuseRNzmpQxAmgA4u0QDx1V
         gdG8yjkg4epxzrKS1yf8o93m/v0F+DVVX6/n/JuaYUO0kXv1BshKvzNBBtnLIuikRF/a
         Phcm8eXe0bgXj5iLHoxz46DCHG8cQzZOTmwDd4pnusIHNuZwPRlBWUE+pUNwlZg63IlR
         jYFg==
X-Gm-Message-State: AOAM530nABqaPxIB9jNxWiohcE40EubrgOHmLFwG9AZeNZZ4N0xXshoQ
        od1DJsjoeOMk2oJv9N2lBBPttTbCyCI=
X-Google-Smtp-Source: ABdhPJxY2ttY0DvJRhY0ME1sSSUKgDn6FsfIE2kdkOBEHQoDckPsqVaDdl+UnRwn+4UUYE0oJwl7CA==
X-Received: by 2002:ac8:5848:: with SMTP id h8mr3946092qth.254.1630430254382;
        Tue, 31 Aug 2021 10:17:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7821:7d0e:d840:aa7e? ([2600:1700:e72:80a0:7821:7d0e:d840:aa7e])
        by smtp.gmail.com with ESMTPSA id f20sm13747212qka.64.2021.08.31.10.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:17:33 -0700 (PDT)
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com, jonathantanmy@google.com
References: <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local> <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local> <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
 <YS3AKhQJjMrFm1JO@coredump.intra.peff.net> <xmqqk0k1wp3x.fsf@gitster.g>
 <YS5cJjlV0Rkpu49n@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d23bca9b-9da2-984f-065c-6cf60a80ddef@gmail.com>
Date:   Tue, 31 Aug 2021 13:17:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS5cJjlV0Rkpu49n@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/31/2021 12:43 PM, Taylor Blau wrote:
> On Tue, Aug 31, 2021 at 09:33:38AM -0700, Junio C Hamano wrote:
>> I do not see the reasoning behind "should not be a blocker" from
>> Derrick substantiated.  What's the reason why that raw object store
>> cannot come from an existing repository, and what's the benefit we
>> get from not having to have a repository there?
> 
> I also didn't find the reasoning spelled out in his response, but I have
> definitely had off-list discussions with Stolee where it was important to
> be able to pass a value to `--object-dir` which does *not* belong to a
> Git repository (but is used as a dumping ground for packs, a MIDX, and
> loose objects).
> 
> It may be worthwhile to recapitulate that discussion here on the list.
> (I'm hoping that Stolee won't mind filling in the details, since I seem
> to have forgotten most of them).

The way we have been using alternates in VFS for Git and Scalar is as a
"shared object cache" that is shared across multiple full Git repositories
with their own working trees. The shared object cache is located in a
location that can be found during "scalar clone" such as

	~/.scalarCache/url_<hash-of-URL>/

This directory contains the same data as a .git/objects directory would.

Data is added to that cache using hooks during 'git fetch' or other
requests for remote data. This means that the second "scalar clone"
command is much faster than the first, because it already has most of
the commit and tree data required to satisfy the partial clone.

(Note: this feature does not exist in the current Scalar CLI RFC, but
would be contributed later.)

These caches were designed before the multi-pack-index -- in fact,
they were an inspiration for them because now deleting a repo would not
clean up old pack-files. The data would be added as a raw pack-file that
is processed with 'git index-pack' or as loose objects. The --object-dir
option was directly created as a way to target the creation and
maintenance of a multi-pack-index within one of these caches that don't
exist as full repositories. Clearly, there were some gaps in that
implementation and I regret creating those gaps.

If I were to redesign the shared object cache, then I would have created
the cache directories as bare repos and then create the "clone" repo as
a worktree linked to that base. That would allow all objects and refs to
be shared, achieving the same goals and an even better user experience.

I'm advocating for the position to continue allowing this feature to
exist without a necessary on-upgrade conversion of these non-repos to
full repos. Maybe that is the best thing to do in the long-term, but
will take some time to do. Keeping compatibility for now seems like it
won't hurt too much.

Thanks,
-Stolee
