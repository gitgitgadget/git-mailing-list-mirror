Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE55C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 19:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMTiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMTio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 15:38:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED71180279
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:38:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z97so4026152ede.8
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYwfsBsrMBm2/fRgr1KXV1P8q/2D+T+kZhCvDdAxosM=;
        b=RTcX80ZBxvkQrpTQq1dwDM9j5h2OoM5KCR2pejGYaWFd6p5RIon4AZJkDHDtzfrFQt
         aFMkCf/lwwNxmFjLmpGvFBj+Wdxnv7oqwg/DwB3Tsqwj62ufgy3NM92NbYU8OcEERvGa
         D+ybTw3rCJQeNIVGUzyfCAWq/oQ7blL343ytmnYaBvTT9VjtjF0HOq4CWXkrigjuYxgN
         OOfIC0TRl8PDQBYT++a4f0t+ma1+f3VBMMLgcCu6p0CPGJuz4NbI0N6rEdC2wvtdrdip
         0Zs8Opjycsa2WS95ojRR+yLQ3gZJaV3RUXhxKxFzEcGMh4EDrSNkXBZhF5W/qMtqlw9c
         TgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYwfsBsrMBm2/fRgr1KXV1P8q/2D+T+kZhCvDdAxosM=;
        b=2kOGe3M/TVA42X0ykqAQlVpSD+Mxh8m+YMJFWp55IqOWeX9gErkfD1qsyf+UtgX2j+
         tnu0uyrdy3FhHz7fJxoHmxgeAL3JZch7pw6XgDsgVspZQzcnWCDqkTWRnOYlMibK+Xfd
         4IxE2XDLhzpFHPamx86zrfznZbFiUN4qcCfTwwQdXJyXLLDfpG+9Zjxv84tGmaEdxsgN
         77NOl+1+dewaLizkHsFrZiUYL+yD0luNFRJstZNwm+r5QmRW5NZ9t2Qbd/oUEirAgTnv
         wbTCE2uCuId6+Mm2qA79zAI87GujzyZa45R7lCTBOZg4EAW3RWErSDYpVo6yrJGGn0Nb
         pKNg==
X-Gm-Message-State: ACrzQf3aOxIiZBeoHVW/2CbTATdsFIYQekVX62nPKO4VeBk11jBPDlZ2
        1isO7E1d+J24T40+JGKoJWI=
X-Google-Smtp-Source: AMsMyM6NrCcXE7elG1Yph3I1r82OEPsDirY7aZ7j0gEz0B4KxZe7mHn0MZZ68YBVVhvANgyvRiP0fw==
X-Received: by 2002:aa7:cdcb:0:b0:459:e3a6:2df9 with SMTP id h11-20020aa7cdcb000000b00459e3a62df9mr1151450edw.105.1665689921647;
        Thu, 13 Oct 2022 12:38:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078ca30ee18bsm323336ejc.95.2022.10.13.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:38:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oj42R-004wew-34;
        Thu, 13 Oct 2022 21:38:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ignacio Taranto <ignacio.taranto@eclypsium.com>,
        git@vger.kernel.org
Subject: Re: About git reporting missing newline for symlinks
Date:   Thu, 13 Oct 2022 21:33:28 +0200
References: <CAAHd=zcrU3VJro1R3xDj3hmqGXZHUA6rHuDFxwhF5aewNvA8xQ@mail.gmail.com>
 <xmqq7d14k9uh.fsf@gitster.g> <221013.86o7uflvcv.gmgdl@evledraar.gmail.com>
 <xmqq35briuel.fsf@gitster.g> <221013.86k053lkvu.gmgdl@evledraar.gmail.com>
 <xmqqtu47fti9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqtu47fti9.fsf@gitster.g>
Message-ID: <221013.8635brldj4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> 	\ The filename pointed to by the symlink does not end in a newline
>>>
>>> While I do not think it would break anybody, I doubt it would give
>>> us much value.  One line above that output is a line that any user,
>>> who is vaguely familiar with the contents being compared, can
>>> recognize as giving a pathname, the contents of the symbolic link.
>>
>> Clearly it confused the initial reporter upthread :)
>
> But to such a user, I highly suspect that the rephased message above
> still looks like a warning, and will result in the same reaction.
>
> IOW, you want to explain why "does not end in a newline" is worth
> expressing in the output.  Saying "does not end in a newline" alone
> would tell the user what they already know (i.e. the symlink stores
> the target filename without an extra LF at the end).

Yes, but isn't the point of the report/confusion that we're inserting
what looks like the warning you get when you forget a \n at the end of a
source file, so a user might wonder why they're seeing it at all.

Whereas what we're *really* doing there is not really about that at all,
but just inserting a bit of magic so that the diff format & its
consumers grok that this line we're inserting there isn't supposed to
have a \n, as we're working with a filename.

Maybe e.g.:
=09
	diff --git a/RelNotes b/RelNotes
	index d505db645be..758368388a4 120000
	--- a/RelNotes
	+++ b/RelNotes
	@@ -1 +1 @@
	-Documentation/RelNotes/2.38.0.txt
	\ No newline at end of file
	+Documentation/RelNotes/2.39.0.txt
	\ No newline at end of file

Would, for those users, be less confusing as:

	diff --git a/RelNotes b/RelNotes
	index d505db645be..758368388a4 120000
	--- a/RelNotes
	+++ b/RelNotes
	@@ -1 +1 @@
	-Documentation/RelNotes/2.38.0.txt
	\ The symlink above has no trailing NL in its filename
	+Documentation/RelNotes/2.39.0.txt
	\ The symlink above has no trailing NL in its filename

*dunno* :)
=09
