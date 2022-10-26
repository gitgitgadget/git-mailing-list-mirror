Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE7C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 18:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiJZSwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZSwe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 14:52:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FFF7EFED
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:52:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y14so23935127ejd.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UF4VTLxWiX4hcBu/79iBCI8HwveG4JdNMM+NTz1Djmg=;
        b=Tzi1Ax+8W4pPcQ7pqPm3F6VCrTekwKCYs7IyeKdzeDTMe2QJzonQO6x56tFHmYQWVu
         vChp7s9miqYBGWUfOHQ6m+81MhRFhYbHJByUtNBcwnS3Vk5waYNwvVDcQ0NnG0vtrdaL
         JvNqMxiFkga7WCsR7PFgnXvRd8qMoscCpPOz+RdQLryZOFxdwfRq/FIdASMumbwFRSMa
         k91L2Ly2rCg+ETIonEqAHHLT+CevhbGWF51edH44bIiC6ILAY4RSlWZgrwfvcntP09eB
         GfsDkwDOg8WWeBapaNi9aAA4M0V1zW/M5Iw0ZJ+TL0MVI/67EdvqDLn8QBzCHCl2dW/O
         qxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UF4VTLxWiX4hcBu/79iBCI8HwveG4JdNMM+NTz1Djmg=;
        b=YjytEzbz7Jh7DXbFMBhDAuHYyPLDcvDNzKOkWKuVpsAY8vRg/CsNQeXcaqSbrDgLoH
         1nzZqT5p9+hB9R0Tlq6VoEWYXLr99Ca7Yy4v1j31CXqkSsQXxmEfziq0UHYpn/QguYd4
         lOaz9icMiPT/NVOLBfJbNgdHdO+jbqa9jdM+RgVsgj7skavw609CkW9hTLTXU/fKrbkF
         9ZEy03pJz9DnY/sRMyp11QsiPb6BcSQMvk1FrgyM6+DLwyS0kqc4C0elD7m+otdt3Jny
         Qsx+SBidw+jU9tfhdka9zt42ps2Qr9z0KKNi5IXGTs+vhc9vF0RMdlT6u9T+RLIxU+gW
         RlRg==
X-Gm-Message-State: ACrzQf2HSN5N3h8vmUE9y0j0FXFeOwVWGsmpHxIfgfvf/axHagz3Ych4
        vu4+8bxhxUPfjVibDkkfUKk=
X-Google-Smtp-Source: AMsMyM4RhHwj3r6QO/h52sCCXlbyfzxlxAhNIgwsFgsHZzo8UdLFJWEMtJGm/tJnlnrjZyzeZt8DMg==
X-Received: by 2002:a17:907:d04:b0:76e:e208:27ba with SMTP id gn4-20020a1709070d0400b0076ee20827bamr40277537ejc.652.1666810349896;
        Wed, 26 Oct 2022 11:52:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id z6-20020a50eb46000000b00458dc7e8ecasm4002661edp.72.2022.10.26.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:52:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onlVs-008qLa-1F;
        Wed, 26 Oct 2022 20:52:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] Makefile: define "TEST_{PROGRAM,OBJS}" variables
 earlier
Date:   Wed, 26 Oct 2022 20:47:43 +0200
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <patch-v2-2.3-6dcb49f25c4-20221026T143534Z-avarab@gmail.com>
 <xmqqsfjailak.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqsfjailak.fsf@gitster.g>
Message-ID: <221026.86y1t2beoj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Define the variables that make up TEST_OBJS earlier, and don't go back
>> & forth in their definition. Before we'd first append $X to
>> $(TEST_PROGRAMS), and then substitute $X back out of it to define
>> $(TEST_OBJS). Let's instead add a new $(TEST_PROGRAM_OBJS) variable,
>> which avoids this needless back & forth substitution.
>
> Makes sense, I guess.  So TEST_OBJS is no longer used?

Yes, sorry I'll clarify that in a re-roll.

>>  TEST_PROGRAMS =3D $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
>> +all:: $(TEST_PROGRAMS)
>
> This change is not necessary to achieve the stated goal of this
> step, though.  It is one of those "while at it" distraction that
> consumes our already constrained reviewer bandwidth, no?

I figured this would be better use of that bandwith, since the reviewer
doesn't need to wonder why these are still spread befo/after the main
body of the change.

Not everyone is keenly aware of the at first odd way a Makefile is read
(per "3.7 How 'make' Reads a Makefile" in the GNU make manual).

But I'm happy to eject this part if that helps, but...

> Having said that, "all::" being able to be built up with independent
> pieces shine here in this split from the original.  It probably is
> easier to reason about while seeing this isolated area of Makefile
> what is being done to TEST_PROGRAMS.

...here I'm not quite sure if you want to keep it after all or nat...

> The rest of the patch is quite straight-forward renaming of
> TEST_OBJS to TEST_PROGRAM_OBJS and an improvement of how the
> elements on the list are computed from the source-of-truth list that
> is TEST_PROGRAMS_NEED_X that looks correct.

Thanks for the quick review!
