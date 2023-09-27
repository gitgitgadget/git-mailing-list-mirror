Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED0E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjI0UGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 16:06:45 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B164011D
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:06:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so19408075ab.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695845202; x=1696450002; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4HmIlLymTdAvxTuhETBvtWB4sC/GIkRBv1xIehrtMg=;
        b=fV1M7/2dRQZhWReVaA4FiRLIGGYRNPk23hhfjQ6fvTWwPrCzqWA+kF7CxNc9hDMZtY
         LogXzvVpfDQdOr0aAAACir09GfbG3pinCS9PhFKsILxeNPTDRA3jw4ggxvWSOLG/lVMy
         6VQgwBdTHFvZTktHyDb+2w0XAEn25DsAK0imWW/BgB81PwYWuxrayRqGP/mYv+rh/bxh
         0AhhpsMJBX8vSktd43DYpStrupEuf8JViexcM1s4YLhqopaRYm0dgiCVtpI47z6G2QH6
         I2fsmmwFu3AMNunBnanAm5aAiu41hep6OADRzhCR3S/Su3T1uIO2gOXpNvQXEkMO06qt
         s8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845202; x=1696450002;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4HmIlLymTdAvxTuhETBvtWB4sC/GIkRBv1xIehrtMg=;
        b=as8fs2lTotx9ZO+xDDMQBwUAHnxGv2V+g0xkW+loHUe/L4Lx9R8FUKqOqZG5VhH68J
         ac6NHpXpdBVifKMAmho5wQGJTpMyQQ57ohB8ECRW2tFjd6FG8tVPDNUhKAris0xpLxB6
         /U456vetIT/P0tEQYoSWgDQkzOBOqrXTKQ9ODWePRMEQfxNL2yPlDWFGuj7m/OUP1LqV
         sSbTgy+AqSwWOAEIYVemWvcJEMrC1WfOx+nrnNGxKKc/tM5c4X3yPL1r7tWmMOKmx8jR
         KpmkEZ4y0fiLosmQ+bRt0Z7vVx061ZtMwVWBb0QCyca22HoBpcJrhWvbwfppV4/mvniH
         c1cg==
X-Gm-Message-State: AOJu0YzMQtRBY9qUQVZDFfVm/oPABrHbdlGm8dPWptsDBxi2/o71g0l4
        I/ma7z7IeogERG/yLEIgvqYYr0e37BNdFQ==
X-Google-Smtp-Source: AGHT+IELp1CAs7Pf3kWBlXOwgrv2LNanTeFDkAEaYJZ813Os1Ur40GVBsJw6JTk7u0yNdCmbr97lMQ==
X-Received: by 2002:a92:ca46:0:b0:34d:ec9c:7321 with SMTP id q6-20020a92ca46000000b0034dec9c7321mr3746701ilo.3.1695845201873;
        Wed, 27 Sep 2023 13:06:41 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id b17-20020a05663801b100b00439fa6ff6a9sm4089170jaq.70.2023.09.27.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:06:41 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
        <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
        <xmqqmsx8mwr4.fsf@gitster.g> <ZROHrSmmZOIE6bl9@nand.local>
        <xmqqil7wmf50.fsf@gitster.g> <ZRQ9aSeu/wpJERuV@nand.local>
        <xmqq7cobmvjt.fsf@gitster.g>
Date:   Wed, 27 Sep 2023 15:06:40 -0500
In-Reply-To: <xmqq7cobmvjt.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        27 Sep 2023 09:26:46 -0700")
Message-ID: <87a5t7js8f.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> I am not sure that I follow. If we have an address in memory from which
>> we want to stream raw bytes directly to the packfile, that should work
>> for all objects regardless of type, no?
>
> For a single hash world, yes.  For keeping track of "the other hash"
> and correspondence, you need to (1) interpret the contents of the
> object (e.g., if you received a tree contents for SHA-1 repository,
> you'd need to split them into tree entries and know which parts of
> the bytestream are SHA-1 hashes of the tree contebnts), (2) come
> up with the corresponding tree contents in the SHA-256 world (you
> should be able to do that now you know SHA-1 names of the objects
> directly referred to by the tree) and hash that using SHA-256, and
> (3) remember the SHA-1 and the SHA-256 name correspondence of the
> tree object you just hashed, in addition to the usual (4) hashing
> the contents using SHA-1 hash algorithm without caring what the byte
> stream represents.

If it helps I just posted a patchset that implements what it takes
to deal with objects small enough to live in-core.

You can read object-file-convert.c to see what it takes to generate
an object in the other hash function world.

The exercise for the reader is how to apply this to objects that
are too large to fit in memory.

Eric

