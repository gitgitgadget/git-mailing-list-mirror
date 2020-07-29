Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C3C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E93020829
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvWoDYOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2Wdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2Wdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:33:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43EC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:33:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q76so3248272wme.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h2EFN2JS42UqCBiwa729Z1pjxAVko2PzTUfy8fmJBWE=;
        b=qvWoDYOWm7Ng9VyfNdqB9QKu3isRV8cuTN061aKu/b2jGyk2ZON1pn2JM5j4rNM6CX
         sdQl25QkjRhGAnbI1tMa+65Ubip9vDJomeVRxu5g1DZd1ylMFFJfdsPEZcZstetpJ4df
         1D4wW35K5X7XrsQe8/gTXFUXzJ3dIYWiG3DnkZ7j4PS8L0vJLtYf8oo8YiDKKlHA6nUo
         J9zCc+FM8xzNH1KJUOLbStKSUk21p/KV+tx6N/a0J1zS4SbvlS+1DfVQ8r/KrsUZ8JCy
         QrciztP/jznB1nhAHc48vD8oWMnn45vMualqV73laMmWABuRQeYjH7E98CFFR++44fko
         LE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h2EFN2JS42UqCBiwa729Z1pjxAVko2PzTUfy8fmJBWE=;
        b=ro6vr3ou7Z3X49jIUCIOGPf6tbogl6bVYjbMsXi4dY9yt5cpGAWDDHocGfBqfZb9g/
         uXHGvFnjKzA9M8uswzCUGHHps0btPOekhe22RCLzKKOmiqaUIUenw3/Qq0rUrxZZz8AZ
         NtFR7kM0o9np3vHcE7Ifxu5zQJvrnFr7P49su6a7I/5vjnIP7ANYduj+FJpiwBE5dt5N
         d/4cp2xl9zGQixBswat4KQ7o6afpt6s6S9LC1N+jXXbrg6ZnABN33GnvZpYL0tRgxauf
         J8s2PywBtf5OhNY1Sf+JRNMeoff8CAcH5gR/D5cZgLduCoyMcpE9qiF2ZWb+6TZp8Xx/
         M6aw==
X-Gm-Message-State: AOAM530mLVW81ZXpOE+YRhji2XONFUGlDF7vLogf06yRNdEdRzGoWDq1
        Bu9VCoSu/U34t+deQfZyyr9rv+9C
X-Google-Smtp-Source: ABdhPJyXkSWR8zEKBm8CyfstJ5d6FRJGvqvaxxbTirKg0OwcXHdFGt5JOT/BAcspYhEwywltEdUWvg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr11065183wme.50.1596062030374;
        Wed, 29 Jul 2020 15:33:50 -0700 (PDT)
Received: from [192.168.1.64] ([81.141.108.232])
        by smtp.gmail.com with ESMTPSA id l10sm7535585wru.3.2020.07.29.15.33.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 15:33:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Issue when adding new files to staged changes using interactive
 mode
From:   Another Email <yetanotheroneemail@gmail.com>
In-Reply-To: <C4JFF5L90V54.1FQKYQPIC3O43@ziyou.local>
Date:   Wed, 29 Jul 2020 23:33:48 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B809D01-D744-436E-98A5-73B4BE6351CC@gmail.com>
References: <C4JFF5L90V54.1FQKYQPIC3O43@ziyou.local>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond,

Thanks for looking into this.

> Before I continue rooting around in the source, though, I wonder if =
the
> real issue here isn't the fact that add -p fails to support new files
> (requiring the intent-to-add workaround in the first place). I have
> always thought it's a confusing user experience that git add -p on a
> file that isn't yet tracked simply returns "No changes".
>=20
> The underlying problem may be, and I say this without intimate =
knowledge
> of the subsystem, that we're now trying to force add-patch.c to do
> something it doesn't actually support, namely new files, whereas =
before
> it was attempting to patch what it saw as an empty file.

I cannot comment on the internals of git, but the typical use-case for =
using git add -p on new files would be when you add them as part of the =
changes that also involve existing files in the interactive mode, =
therefore it's helpful to have support for both compared to having to =
stage new files separately.

>=20
> This (patch-adding new files) is real in my workflow; is there any
> reason why git add -p with an explicit argument shouldn't attempt to =
add
> untracked files covered by the explicit argument? (In addition to =
fixing
> it for intent-to-adds.)

If I get the question right, it's perfectly fine for me personally to =
stage a single new file via git add -p. I agree, technically, it doesn't =
make a lot of sense, probably rather a matter of muscle memory, when you =
treat new files the same way as existing ones.

