Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A7CC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 22:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJMWBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 18:01:41 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A089189C08
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 15:01:40 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id sc25so6735111ejc.12
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 15:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkIR/41ERdVl3e8LDjAKjcJlaqlN1xhMwYAGS3NmhEY=;
        b=z+jMb8NjTDMoHft8TLnVdaADgqJvR6V5soj2tQ5xrvT7ssAORfSUY+NTBb/7/VF90Z
         p8ktjVDKCA+wzwyhlzkfJyy6HoMIFx0E9iyEEfK3nhE7vNQytLt8JkqOx8b8Tu2emnEk
         QzZHg0z7l+KJmzaKoUXCAqHONiizneH5yJ+cx2THqoSElXpxH3/AvSR4l8hMIBgeKyu7
         Wm9F2ov0Pogo5hB/vV18NAXgWWdtLV2zSMonxLT3ElInqQows7kihgooCsUUB9uUcF71
         cJOG+GffnW1UJRzZImmVUDQXfV66I/4WYryFSpuBkLowaQFFgnueVzQ8GnhPeMys1g1b
         bthQ==
X-Gm-Message-State: ACrzQf0z+LN+j5zgEIu1QBOtyy8KjsKqcnyvzyMTS7oCIrJMmwSpRP78
        VKIVF0dyNbwTt+CQ0Tf3iKbZ6YL85an+yk/Aivo=
X-Google-Smtp-Source: AMsMyM76vCqaQBaQqltScPNMHlBnUt6UBj7uqj4oxQOqZnVC8PL7ZvT8VvIrimBzrLyULtxMwaHRNIIuZHvCVNi3nXI=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr1326057ejc.235.1665698498940; Thu, 13
 Oct 2022 15:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g> <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
 <xmqq35briuel.fsf@gitster.g> <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
 <xmqqtu47fti9.fsf@gitster.g> <221013.8635brldj4.gmgdl@evledraar.gmail.com> <aead3926-d87b-5fcd-4984-bb690f3fbf4e@iee.email>
In-Reply-To: <aead3926-d87b-5fcd-4984-bb690f3fbf4e@iee.email>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 14 Oct 2022 00:01:02 +0200
Message-ID: <CA+JQ7M_HJf_o=u4DOjdGet5D88kWEDJ+AbwfAWVnx487VSVu=Q@mail.gmail.com>
Subject: Re: About git reporting missing newline for symlinks
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 10:55 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Pondering on why it is thought of as a warning to be treated as an
> error, maybe the message implies something is missing via the negative
> "No" assertion, rather than simply being informative [1].

Very likely. I imagine most users use diff to view the
changes they made without knowledge of the use of diffs in git-apply.
Without that background it's more likely to be interpreted as an
opinionated comment as opposed to being informative.

> Perhaps swapping out the "No" and instead using something like "\
> Without a newline at end of file" would better convey that it's just
> information about the file's format, and in no way a real problem. Just
> a thought.

That's probably less likely to be read as a warning
