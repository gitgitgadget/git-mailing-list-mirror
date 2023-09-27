Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EBE82CCF
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 20:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjI0UNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 16:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 16:13:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309F10E
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:13:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7927f24140eso413290439f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695845615; x=1696450415; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWjgv64PifzqZIXie0Tq5/56PwQh7fBla0xQUr+CoiM=;
        b=kfgCL/p8jePmvcv2A+fyPmiyPLtDYP/6ryc+ZoDp+M6j36eYIjUCw5XewLhAleYj7w
         T8yFzcFxWy366NwsobDyJkEFe9JhNMe9GPT1+rXmfZgWX+V9Y8BmnHiHZUJi0BedHSRZ
         NE8IzkIBw6jrjujqxQCo2gLHJnAd93uif1ai2TGKWn4E0MOXKT5Bni6RoRGMpb1MMMp1
         uMTro6RvYnW+nj1VtocGuXcbQIJ+gXButGcldYC08Iw+8OiMx5aNJtilMKCuCwStRzZd
         nE1Zr6SeQainpF6c7OH+hc0DxTkcUzkjVpJVK1sP1abTaCzNeRugi8ROjH64SSUXvwGd
         dvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845615; x=1696450415;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWjgv64PifzqZIXie0Tq5/56PwQh7fBla0xQUr+CoiM=;
        b=Y+QLoGlu8DRBlxLvqDUJsq/dTDZqC5iz7tArTDU4gZnhxRftB52iMIG2aT69LZ/WLV
         47sRsOInxFFQPe4Ip9HbqEftZ11j7KHrsntibu8ysfqMQ04GI3aTM36L1XyFFiVs6nKp
         Gxj6cM/2NkUgMwALMF6+7yg0M6w6hOxzsvVS47A0QmT6a3tUdn0aunAgPN3jOd0ELeXJ
         uOUfs2IFUKltUXXVt8Y7KcktGlDz+gTlGnN8hspgZQul3GHxmeGjRF28VOz4ouprVcfb
         QbqtJAUiry1C6P8PMdOezjm9VMeHhgA0Ase50EfRwRkDWzZIhglWx3zCD4YBaNr68TtW
         rnkw==
X-Gm-Message-State: AOJu0Yw3HodP8UZHa11PXlHlASORbwQz3r25ECY/18QixH82KFx8dQGL
        piBSEGNwqYDQ9+CBOdHn28IkpzAwf5pPlA==
X-Google-Smtp-Source: AGHT+IHIlQNFlY58YSXNzEoZRqtmz4epaTXI/qLEVc1TOkSTL4MSev86hK+9aTvdM2PoylowugTp5Q==
X-Received: by 2002:a05:6602:274d:b0:790:c259:4ee5 with SMTP id b13-20020a056602274d00b00790c2594ee5mr2940512ioe.8.1695845614954;
        Wed, 27 Sep 2023 13:13:34 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id z197-20020a6bc9ce000000b0079fa1a7cd36sm3680597iof.30.2023.09.27.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:13:34 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
        <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
        <xmqqmsx8mwr4.fsf@gitster.g> <ZROHrSmmZOIE6bl9@nand.local>
Date:   Wed, 27 Sep 2023 15:13:33 -0500
In-Reply-To: <ZROHrSmmZOIE6bl9@nand.local> (Taylor Blau's message of "Tue, 26
        Sep 2023 21:38:53 -0400")
Message-ID: <87pm23idci.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Sep 26, 2023 at 02:48:31PM -0700, Junio C Hamano wrote:
>> > Avoid all of those future complications by limiting index_bulk_checkin
>> > to only work on blobs.
>>
>> Thanks.  Will queue.
>
> Hmm. I wonder if retaining some flexibility in the bulk-checkin
> mechanism may be worthwhile. We discussed at the Contributor's
> Summit[^1] today that the bulk-checkin system may be a good fit for
> packing any blobs/trees created by `merge-tree` or `replay` instead of
> writing them out as loose objects.
>
> Being able to write trees in addition to blobs is definitely important
> there, so we may want to wait on merging this down until that direction
> solidifies a bit more. (FWIW, I started working on that today and hope
> to have patches on the list in the next day or two).
>
> Alternatively, if there is an urgency to merge these down, we can always
> come back to it in the future and revert it if need be. Either way
> :-).

There are two things that index_bulk_checkin does.
- Handle objects that are too large to fit into a memory
- Place objects immediately in a pack.

Do I read things correctly that you want to take an object that is small
enough to fit into memory, and to immediately into a pack?

If so you essentially want write_object_file that directly writes to a
pack?

A version of write_object_file that that directly writes to a pack is
much easier than the chunking that index_bulk_checkin does.

Perhaps your version could be called index_pack_checkin?

Eric
