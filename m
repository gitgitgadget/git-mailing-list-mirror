Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6168C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 15:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDNP6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDNP6n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 11:58:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4583E3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:58:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id lh8so5736916plb.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681487920; x=1684079920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw0u4ZS0gHExBhZhwhPiFT1YDTAe1bBwciIk0C5Mi10=;
        b=gUkLE2WA5X/29nvkjypl2+mDnQaEoG2qwvD/lFNj/BnZOwUi1ylMJNjvEzF0Nu7VSN
         hfzj93F6WzElp+welh0uTMu4Uir0jFPxpCCWeWGCRUm4dP1JL+lx3Vh8TaEbHihVvfCt
         aP8qxYP/OJzHqxBAoemPENjJCiuJOiw7jUqm6T2bw2qe/GTGsGpG8DJy47vsMcvUDLWm
         OPHp3ZNSCY0YPny2ZMZSxLmmNX88XlWQpXal4Jt1I1pJjbsc99CYTTP4EB/eAMtUEiIJ
         hIlNV+JkKUmVhxigdLHltEVoPNXxDB613F+vCCTk33n1MDbcMqAuPincf/XMiRK3SY8b
         XXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487920; x=1684079920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nw0u4ZS0gHExBhZhwhPiFT1YDTAe1bBwciIk0C5Mi10=;
        b=jnzy4mDapAfE1ZvOj7kTJuFa+PpuWx51ju+iVHUEdZ2s+SOcFI7EnmYVlo+nlu0NcL
         7YD4SNAnMBICQTK4qJLAOGpMUJRujt6MM3ssyzwvARijeu1+iaAXOGfaFvY7SSd2xAmP
         TixVkZxzIs9+H9573xAQoqxkslpiPDhMRhdNLTJnTk05xyS6AQH4DrYEIJEtbjHw6ykq
         TDF6VrFyUrkV4VYTV2uOXasHx7iMw1UhsMYHnX5sVETKIqSanpwfX4c5ufP2zloJD8NM
         5r85f7ViIaPSOCFTlDiDTe8tGafYTp4AB9vXNgCFIr4VmvFDBpTr3D6veIp8c9Pp+6Sd
         50SQ==
X-Gm-Message-State: AAQBX9ceHAAV4+zMIAmRrvrGEFpcOZoHqXmbROwb1wy/t2RLOL7cdnsD
        3x5jKZAIWUsFWAcQVjwWehc=
X-Google-Smtp-Source: AKy350Zi5FXiMRjdPath0Y7OvsN9Umw56g0n9zjnXRllTFwNRLO5lfGHrTq2c6oGz4ozVXAv6nT3EA==
X-Received: by 2002:a17:902:d4d0:b0:19f:3234:fec5 with SMTP id o16-20020a170902d4d000b0019f3234fec5mr4072241plg.51.1681487920186;
        Fri, 14 Apr 2023 08:58:40 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902b7cc00b001a65fa33e62sm3230415plz.154.2023.04.14.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:58:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Question] Can git cat-file have a type filtering option?
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
        <xmqqy1n3k63p.fsf@gitster.g>
        <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
        <ZDIUvK/bF7BFqX5q@nand.local>
        <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
        <20230410201414.GC104097@coredump.intra.peff.net>
        <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
        <20230412074309.GB1695531@coredump.intra.peff.net>
        <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
        <20230414073035.GB540206@coredump.intra.peff.net>
        <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
Date:   Fri, 14 Apr 2023 08:58:39 -0700
In-Reply-To: <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
        (ZheNing Hu's message of "Fri, 14 Apr 2023 20:17:34 +0800")
Message-ID: <xmqqh6titpzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Oh, you are right, this could be to prevent conflicts between Git objects
> with identical content but different types. However, I always associate
> Git with the file system, where metadata such as file type and size is
> stored in the inode, while the file data is stored in separate chunks.

I am afraid the presentation order Peff used caused a bit of
confusion.  The true reason is what Peff brought up as "Or worse".
We need to be able to tell, given only the name of an object,
everything that we need to know about the object, and for that, we
need the type information when we ask for an object by its name.
Having size embedded in the data that comes back to us when we
consult object database with an object name helps the implementation
to pre-allocate a buffer and then inflate into it--there is no
fundamental reason why it should be there.

It is a secondary problem created by the design choice that we store
type together with contents, that the object type recorded in a tree
entry may contradict the actual type of the object recorded in the
tree entry.  We could have declared that the object type found in a
tree entry is to be trusted, if we didn't record the type in the
object database together with the object contents.

I think your original question was not "why do we store type and
size together with the contents?", but was "why do we include in the
hash computation?", and all of the above discuss related tangent
without touching the original question.

The need to have type or size available when we ask the object
database for data associated with the object does not necessarily
mean they must be hashed together with the contents.  It was done
merely because "why not? that way, we do not have to worry about
catching corrupt values for type and size information we want to
store together with the contents".  IOW, we could have checksummed
these two pieces of information separately, but why bother?
