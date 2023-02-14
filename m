Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A77C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjBNVIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBNVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:08:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C82BED9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:08:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso1494pjn.5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoG6wnIQRiChfdmhabWCI9FRY02Vtz9+og7EDxEi0LU=;
        b=F0K1fKrXemOHjGXvmvvRvlF/LXOZVnsACcKjFaA7eJztQd7T73LDvedlB1O0xwzPuI
         mpNXN3Y7jKN8I5LdN1JX98OP5RFJJxGY54aqnfQopADAGb5abdnGdoPl8kbS2OBFjNZQ
         DUBUoNt/O/NXjTmSAOR0R2pdZI9BfMaCIkulL2jAB49/vLu6XfSaatMiN0wqKT6DJbQh
         1AAa3YVaFusFI6z692TElkqKk1h9ZX69y45eOnz4iMb1JUgepeS75p0bGA7fzZeZ05hG
         glUghmVBLFJe6zLJc01+9g3LQ6QPgUKpIUSKVMtekfuPv+VhFm9U7z7+jew7T0ZNELfp
         00mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hoG6wnIQRiChfdmhabWCI9FRY02Vtz9+og7EDxEi0LU=;
        b=hDcXobxpPZRZnXR/sxPsOwH1M6MwmQHwElj8skHi3SITu5QhRm4vT+Fom58218PftQ
         BLnPQEumI2EtbpF7R2GmJnISH/8oDX7f1jtcTvXez5oRA7echzjpvdXylJIqncfHRkB8
         3zXpXrFC07IRPP/RaL31nbPSu9wdDIPJrJxdjUTYJNeOVbYyn0YcHnZuMTMoh1mZpiAv
         ExTjDV94TLzat+cGBPCA6dVx+9QUBZi15E41fBbRefuJxkZnl/9eFSCJcGXExSwn6gZY
         HxNYatlCo3z8Wc+wmZaLgrsr29k9GrG/uT47jwwSRpFDLre5ALJ4slQ3Ghfvk2QCmIIy
         8bLw==
X-Gm-Message-State: AO0yUKWRU+quESpevdWgxPjeTo12eu0JkbKAcBTsJwbLXZetl0vy6SuB
        YbyGtreouwYnqaGQBtqkwacjI7TLoSU=
X-Google-Smtp-Source: AK7set/Z9zZJinYaHlbDWbu5IHoYE+mI8ypqaDFwhkZgPv7aWkTtNyb8+yF+C0nKHp8hxOAGJsUN5A==
X-Received: by 2002:a17:902:d2d1:b0:196:8292:e879 with SMTP id n17-20020a170902d2d100b001968292e879mr115486plc.1.1676408924915;
        Tue, 14 Feb 2023 13:08:44 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b00198ea7e4bafsm5102535pll.92.2023.02.14.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:08:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] leak fix: cache_put_path
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-2-calvinwan@google.com>
        <xmqqk00lbc8k.fsf@gitster.g>
        <CAFySSZBAXCGTEhTK+rpLaZz4_RhdEDV5e5QewUwN-LHgSOTe2g@mail.gmail.com>
Date:   Tue, 14 Feb 2023 13:08:44 -0800
In-Reply-To: <CAFySSZBAXCGTEhTK+rpLaZz4_RhdEDV5e5QewUwN-LHgSOTe2g@mail.gmail.com>
        (Calvin Wan's message of "Tue, 14 Feb 2023 11:56:50 -0800")
Message-ID: <xmqqa61g550j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> Assuming that the "last one wins" is the sensible thing to do, the
>> change proposed by this patch does seem reasonable way to plug the
>> leak.
>
> Swapping this functionality to "first one wins" or erroring out breaks many
> tests that are setup improperly. If we continue with the "last one wins"
> precedence, then a warning and documentation should be added. We
> definitely should not swap it to "first one wins" -- one doesn't make sense
> than the other, but "last one wins" at least has precedence. If we choose
> to error out during config parsing when duplicated submodule paths are
> detected, then those respective tests will also need to be updated.

These tests expect the same submodule to be registered at different
paths?  Is that a set-up that is expected to happen commonly in real
life?  If so, yes, the current behaviour needs to be kept (with some
documentation to explain why it makes sense and how it is usefully
used).  If not, these tests may need to be updated to test scenarios
that are closer to the real life, I guess, plus an additional test
that makes sure such a .gitmodules file is diagnosed as an error
with the code to do that some time in the future.
