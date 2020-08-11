Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605F5C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 13:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2182920782
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Q9/juU1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgHKNtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgHKNs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 09:48:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A367AC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 06:48:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so11635726qke.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9rJjApmBf+XzQFVhEzwcZedQfZTQSWYvVDDrl/pbls0=;
        b=Q9/juU1hvxSs4UmpvCIWoRmNgM0QIJMb7s9pdtazDYu2O/EOzuK+w+wG0/kBg14X2A
         xtnHldciBebZMelBbfIU6AeF8/aszWUHlFhX8KXfsfWQs31fM6FaBIyWy0ODv6T3bV98
         y6Kl0z+fc5Z/L+CyAhWjun9ijfBfRdVGQyIZH9HIqxDGKSFCBoA6ZrJpnhOOhbXsB2Hq
         0rEMgIaIEBpNCV2F4G2aQ82amq8wWWbu/6iX8rC9k6nmhpaVz6JKdCoBK6S2oDnyVcbx
         k4q6lFaTHLkIhbHWcn6UZ6AIUkWxdytWolz4xdXMs2LE/TLTb6GwuARSOQ93q88B+qqT
         swdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9rJjApmBf+XzQFVhEzwcZedQfZTQSWYvVDDrl/pbls0=;
        b=FgxJgc4mOi3Fr5UVT7gaA1+80cHNkftpf7BNiFRVzZ/7GfK+Z+3XlM+a6wUgiDW3sC
         J6/c5lKUr7TTk+Z2G6NkrA84yDupz0ICc12R2IlhiM2CQcQZPho/oLLZrlc0uHnL88Od
         5DBqIIOP/jrgGcb0FCCf6u+nRkhuT4PSRUttchMbVR4uwmse9DioCZGsNAyoTAM+e97E
         Fm7+p4Pda8Z5x2FkKJZgXfuvhna3m6C0p2vCm5gL6B0sQ3xiNPEMsGS4sIR/fbnibeEU
         YGuTfzatOmuFjfxUkKSmJdkj0qzLTnZGMl2RM/djXQOiz7MKYLzm2GRzwEkW1DF0a+S8
         pObg==
X-Gm-Message-State: AOAM531oQxCZ27r+hMWX2/hkdIjtcHrumG3DcBf/LN4f1ywfxmNMapZI
        fYvl1DU6fudqCt3X4Z5cVlBAZlqeSapg6g==
X-Google-Smtp-Source: ABdhPJyhZmq6hNk00G4aJEo3+dtLdRQXofsuylG/Otu76f0j2YM5eJG3nqFDgMbCrt9koh+ETq8CRA==
X-Received: by 2002:a05:620a:22e8:: with SMTP id p8mr1237962qki.491.1597153736824;
        Tue, 11 Aug 2020 06:48:56 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id g129sm17918640qkb.39.2020.08.11.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:48:56 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:48:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
Message-ID: <20200811134855.GA19871@syl.lan>
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgcub811.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 12:44:26PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
> with '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

I noticed that you picked up 'tb/bloom-improvements' in your fork, but
that it didn't make it into the list of cooking topics below. I suspect
that this is because of [1], where I got bitten by trying to sneak in an
extra 'bitmap_free()' at the last moment.

I have a fixup in [2] which needs to be squashed in at that point in the
series, along with dropping a '&' in the last patch to squelch a
compiler error introduced by the fixup.

Do you want me to resend the whole series, or would you rather apply the
fixups when queuing? Either is fine for me.

> * tb/upload-pack-filters (2020-08-05) 4 commits
>   (merged to 'next' on 2020-08-05 at 918e7092fe)
>  + t5616: use test_i18ngrep for upload-pack errors
>   (merged to 'next' on 2020-08-04 at 3ae57cc90c)
>  + upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
>  + upload-pack.c: allow banning certain object filter(s)
>  + list_objects_filter_options: introduce 'list_object_filter_config_name'
>
>  The component to respond to "git fetch" request is made more
>  configurable to selectively allow or reject object filtering
>  specification used for partial cloning.
>
>  Will merge to 'master'.
>  cf. <20200804003722.GA2726931@coredump.intra.peff.net>

Thanks, I'm glad that this made it in.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqbljoolhy.fsf@gitster.c.googlers.com/
[2]: https://lore.kernel.org/git/20200811134807.GA26715@syl.lan/
