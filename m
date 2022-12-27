Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C1C4332F
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiL0XHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiL0XHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:07:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34CBC91
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:06:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso15363577pjb.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1Cg9sd2GRSswQt5BaFUoMbl0w/jDyReKXV4E3p8ueQ=;
        b=pyKdmoga++gy0XJQg7jhN07KVmZER2HBc0jss4sQ961w0VGj0qktBY/B94S7nBeCKZ
         urzIlom/p/3xEClKnD6OlPkBTeloORJG+RacxZExURssNXRyxd4kdlJ0jdCrcTC2MF/i
         UJoUVDK/pmq4sJGU5i4U4i2kXkEg1c2t+9D2XUH6EcxMQLOzKRRW9poCPHEFsrjKsQdw
         ZRtNJdf9vLqRiCNyBiX6Eh0cmeAh4bM3MkP4Q4IYt3FcGOfyt1PbyjpSoL4DTJ2NoypD
         t1WFaQJmhzeqMgGSIdp/GkdDqzPc+3IRGCRivgEoTOcMNSm2DIzoqTsHQ6/D+bToCcwO
         DBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Cg9sd2GRSswQt5BaFUoMbl0w/jDyReKXV4E3p8ueQ=;
        b=Ur8xTqgI4+STQxq2Bl2k9jzoT9Ts/6Jjk/Jv80usOUMSm3RRB9R0/tSC0vnATZcT6V
         3yXDcIp/FPOLFONsG3wGs0Gwoagt2zNhqAmZ4EOzazk/y5J8soLbyW9VKzugMBhMXU9X
         TPZoJVubx0sEqUZ+43Jn63yE96FV+iX8XNWU2Jyh193k8FAiWYMbXKhOGJGGS8AZzASD
         tfzEVw/xH8HNV/imRVQintwbx7iR0LrGJr1l6XykFTxfNPOqgjfspFp650b4h2ZQdqjN
         XFR3edAgKtfljGF8iUkXvMCciUFMkgiLwNblkUBf6bG42CG69GCD8O/tG1whWCTirnKN
         EHwQ==
X-Gm-Message-State: AFqh2krkafMZ5AOCOMTkExp/9wkpd7iPw9COLMma8/vgv6P/bAKo9JeU
        0/1DfgPGAtZKOwreMuf//zUyw0oq6MS6nQ==
X-Google-Smtp-Source: AMrXdXv+vZSC3r3r4irZNz6Le0QYvBi/UsUUZO5a6XkGvW7fAIGDBFkl0up6HhJs6BX1H2b3bgqWWw==
X-Received: by 2002:a17:903:181:b0:191:1b93:e391 with SMTP id z1-20020a170903018100b001911b93e391mr31464772plg.63.1672182369121;
        Tue, 27 Dec 2022 15:06:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b00189b2b8dbedsm9549470plf.228.2022.12.27.15.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:06:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cmake topics & js/ci-disable-cmake-by-default
References: <xmqqcz86n8bn.fsf@gitster.g>
        <221226.86y1quv1gw.gmgdl@evledraar.gmail.com>
        <xmqqilhxv5eg.fsf@gitster.g>
        <221227.86pmc4vrk3.gmgdl@evledraar.gmail.com>
Date:   Wed, 28 Dec 2022 08:06:08 +0900
In-Reply-To: <221227.86pmc4vrk3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Dec 2022 14:59:20 +0100")
Message-ID: <xmqq4jtgsazj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Dec 27 2022, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> I split up the previously merged to "next" ab/cmake-nix-and-ci and
>>> submitted the uncontroversial parts of it as:
>>
>> Not gathering any interest by folks who will be affected is
>> different from being uncontroversial, though.  It may not have seen
>> any controversy so far, but once it reappears in my tree and
>> sufficiently advances to cause trouble to other people, it would.
>>
>> In other words, I am saving time and energy of people by waiting for
>> positive support on these changes.
>
> These changes had made it to "next" already on the basis of the feedback
> the topic already got.

After the topic turned out to be unwanted, I am not sure how much
weight we want to give to the supportive opinions that initially
pushed it to 'next'.
