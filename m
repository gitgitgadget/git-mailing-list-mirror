Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D97C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 16:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDRQYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjDRQYf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 12:24:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FEAF35
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:24:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1621645b3a.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681835061; x=1684427061;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEw0+teES2L+Bh6FHd3c6HvVSCwxUF8k6tEVVGqzn2I=;
        b=WtwuLT4Wq+QJ02DkGqSXzpRpI0o/3kb92VgsbBhfQj34pwh/OuxmJYYodWhMGJU48b
         bTP97lLLB0mrCCe8fxsfisTB8crWHjLaNVkzbGZfXuCXAWFcEO8k5auTuamaRKTETgNB
         EzRh/RxP4FWLPt8Cl3j0m2UcGSwqA3kCUJt2Y0Oxsen2wYo5hXK54x0wk2wUYybu6sce
         ku0F3Ap6rxNV9JMmgq8QPh2Obq4qfiFnXCItwJd/rbSmqJLP8S4x/SGDX6bynzlI73DS
         j/kw7QajDDb7AXqLbKUjrHcdH480R6UPcW3oFe4OJ5rNfEOXpYr+IycZwBOVtH38wIn0
         p2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835061; x=1684427061;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nEw0+teES2L+Bh6FHd3c6HvVSCwxUF8k6tEVVGqzn2I=;
        b=e02wAe7bCHNw0kPLL9E2ET4MGwwBsSpiVZvAb0D1xBpHtfVfqfBVplfs7+/tdsHSW/
         RuU49uB8lE3niSJGwY3hHuFyoKJuGE8QLuDj/H1C1wxZ8AJ9DHvWgA29eWO1egutJfz6
         BTnN8gdJqXsfYedSlT5PAYuhhMn/cFKPGGH1Z04o6sQW2VzWXqLa/EFlXEilJ8cLEaU/
         WQFjaw69Rm25ktiYCKzYggT3p/8Wmnxa0Pk+6lZr2hMb9YoKUBQpai2X0IkFYMRtYepr
         GG2i3xxQ6Tx7gTU3pg0ejtnS2s+OWGG2rndJ0oEOCaW1WcFaT6EBNir//xs4D3JN/6Ge
         bOSQ==
X-Gm-Message-State: AAQBX9d9Dx+4iBZnhBfTelEU5WnMN4Ar3m6JJKeoTHOeSFMy0d547qYM
        RbiYASDGvW4LsidEf7cxPww=
X-Google-Smtp-Source: AKy350a/at0pVJNJejw5iUBdKG1VyBzaNLzWknZ5voUJCqSm6DRwVBZ2hCuRZOliuVLvHWPWW3DrOw==
X-Received: by 2002:a05:6a00:17a0:b0:63b:8571:8102 with SMTP id s32-20020a056a0017a000b0063b85718102mr480898pfg.3.1681835061306;
        Tue, 18 Apr 2023 09:24:21 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b0063d2dae6243sm2722207pfh.115.2023.04.18.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:24:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: gpg-related crash with custom formatter (BUG:
 gpg-interface.c:915: invalid trust level requested -1)
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
        <20230418064846.GA1414@coredump.intra.peff.net>
Date:   Tue, 18 Apr 2023 09:24:20 -0700
In-Reply-To: <20230418064846.GA1414@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Apr 2023 02:48:46 -0400")
Message-ID: <xmqqy1mpduq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> which restores the original behavior, or if the original was papering
> over another bug (e.g., should this be "undefined"?). Certainly the
> empty string matches other placeholders like %GS for this case (since we
> obviously don't know anything about the signer).

Heh, I shouldn't have wasted my cycles in "git log" but in my
newsreader ;-)

Looking at the original before the gpg_trust_level_to_str() function
was introduced, the switch statement looks like it is missing the
usual "default: BUG()" for unhandled enum.  My version made it mimic
what ssh side seems to do, but I tend to prefer your empty string
that differentiates between "we never saw any trust level" and "the
system says this key should never be trusted".

Thanks.
