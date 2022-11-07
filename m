Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E1C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiKGPqG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 7 Nov 2022 10:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGPqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:46:05 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A6766F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:46:02 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id p141so9169820iod.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7phWv2UExupLcBwe9GwDYucVKngmkaDa98CnxgFPjU=;
        b=VNMBVJLIfrIt+9rzCc4rYgvkTXUoRinKoLTn/DzwsWrOZwxomf1I/1tlnhEfagl6MG
         smR0vQQTgPx60MuJEskRb1FY6DRzqGzTPcjf2TgbKSNorJ7QOEXTZbAdmZJIANR4norp
         K0F3n0crqQ2K4gFsBI+qj2O2VPOB1MQcIHaR62gbEgqggmSnFrYuhKL+iW5R7naRxp72
         EQsxttZVmSjqDCpFHzQsYoqIWbzKe0/KYtB0nDwwZjqPfy5TafovEVx7YiNSBEZ1YX6F
         nANW4mDBLVOvsC9edvugBcDnkBs54rui4izGUUSAhcXy7yQQboCiCW0Eflju1tRQ+gU/
         jg4Q==
X-Gm-Message-State: ACrzQf3l/yDMJ+Y5kMafQw3MR49epEWWuSyIeugiKS8rni/N4wH6fmwI
        F5bg3Hb763wvN/aRC1+FIsV603TCxROGDUYEPYQjzk7qzoo=
X-Google-Smtp-Source: AMsMyM5NqE0Us87TRCRar+l7jE4BCjs+L8jXuwpz2saYxBW9uDi+Ge9QDwFK8u7F7DFHpTWsKYic1DgtqsOSTX8G/5w=
X-Received: by 2002:a5d:8251:0:b0:6ca:d7ff:375c with SMTP id
 n17-20020a5d8251000000b006cad7ff375cmr29856890ioo.197.1667835961288; Mon, 07
 Nov 2022 07:46:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1667828335.git.dyroneteng@gmail.com> <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
 <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
In-Reply-To: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 7 Nov 2022 10:45:49 -0500
Message-ID: <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 9:56 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Nov 07 2022, Teng Long wrote:
> > When appending to a given object which has note and if the appended
> > note is not empty too, we will insert a blank line at first. The
> > blank line serves as a split line, but sometimes we just want to
> > omit it then append on the heels of the target note. So, we add
> > a new "OPT_BOOL()" option to determain whether a new blank line
> > is insert at first.
> >
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > @@ -159,6 +161,11 @@ OPTIONS
> > +--blank-line::
> > +--no-blank-line::
> > +     Controls if a blank line to split paragraphs is inserted
> > +     when appending (the default is true).
>
> Just make this:
>
>         --no-blank-line:
>                 Suppress the insertion of a blank line before the
>                 inserted notes.
>
> Or something, i.e. when adding a "true by default" let's add a "no-..." variant directly.

This is the exact opposite of Junio's advice[1], isn't it?

[1]: https://lore.kernel.org/git/xmqqsfjsi7eq.fsf@gitster.g/
