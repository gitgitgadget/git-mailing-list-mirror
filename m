Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B64C636D6
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBIQiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBIQiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:38:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339085FF5
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:38:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m2so3432963plg.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZGgK5CCI1tm3hUve8zRBUxcjmgWmJ4wjksgip6sSdY=;
        b=eDmviXMLuyIjseTgkU5KXdGz80gkWY291yYE42s6uHwLXo2iCMvbvimhFFeNufMBea
         vu15Y7PGD8vlMztqKBOs+lkCZICuC4C9LdYui+YFpfYgG/d8MuWU4j319Hw9f8RS5R4p
         tTWQ/jGjXGbjavUePlmPXJ1amLGHl/bWT6flsT5HdWM34ui3Tv+3p1PVfnY5OZAHQfiX
         UAC8HtUXqvgZe2HnDMLEJYwaRJZOxeaCr3bYmkJEbMtNW+nOLraaceMi77EnlSJ3ngX4
         +608kgx/NNmm9jmQ4cGMxUS2Ha0PXN6O7hKjIx+PUGaQdZ4TuWip7pTRoS93HP9bgeUi
         hwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ZGgK5CCI1tm3hUve8zRBUxcjmgWmJ4wjksgip6sSdY=;
        b=iM3OteKr+HM4wMJIJzmp1FIuyByjrDE/KjqTU8yqfPpewsXPz75PKTgRUicmb8Sz0B
         aaVvOD6z98AybmOLnpj3J2h6XEi65iCyyl0+m06y0yXa0CzR7KSFbUbA09aOiUv2hetV
         jMU5f7mra1KDa0f8hkPMgk311/DdcvfxwcvLKlGSXtDKHXfcsPQgsXwZLxEMOtkBaTIu
         KlBE7YWLRYxKQGl0A1mWVCb/KK3RGykcUYUbPI5Kd8xPRuI9SxkugVcQreqD8Qtird85
         vCiFPiGIrTqwH66Sgx29WO/XuzvZp8NHu0mg41pmcFUyx3k71qGwZ3R/odX5wBFHK82K
         vuRQ==
X-Gm-Message-State: AO0yUKV3aLZxD4hafH2tHhd8mN2vWAeXxHLsZZCAIy1ywFERyi2tr8n6
        YHDnbqqdf4WHnKQjACGW6aU=
X-Google-Smtp-Source: AK7set/LcT8hLW6LVZCDPDLxKSSEOUhkbAwELVonqbGjSjKp7mW4IUjFt3NmwybQPJ9XQHLEpYoufA==
X-Received: by 2002:a17:902:cf50:b0:194:cc66:66f7 with SMTP id e16-20020a170902cf5000b00194cc6666f7mr9072626plg.19.1675960696581;
        Thu, 09 Feb 2023 08:38:16 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902729500b001993909eae4sm1681942pll.253.2023.02.09.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:38:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Max Gautier <max.gautier@redhat.com>
Subject: Re: [PATCH] gpg-interface: lazily initialize and read the
 configuration
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g> <xmqqh6vwrpce.fsf@gitster.g>
        <xmqqlel7rj9z.fsf_-_@gitster.g>
        <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
Date:   Thu, 09 Feb 2023 08:38:15 -0800
In-Reply-To: <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Feb 2023 07:49:26 -0500")
Message-ID: <xmqqwn4qokug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This all looks fairly sensible to me. I think we'd really want to see a
> "rev-list --format" test, too. One, because that's the immediate goal of
> this change.

Heh. I primarily wanted to see how much damage to the code does it
take to implement such a lazy-loading scheme ;-)  Which turned out
to be "not much".

Maybe when I have time next time, but no promises.

> But two, because I think we are only guessing that loading
> the config is sufficient here. We've had bug with other subsystems where
> they expected to be initialized but plumbing callers didn't (e.g., the
> lazy init of notes-refs, etc).

Yup.

> I _think_ we're probably good here. Just looking at "git log" (where we
> know --format, etc, works), it doesn't seem to do anything beyond
> initializing the config.

That was my recollection from back when gpg-interface was split out
of "git tag".

Thanks for sanity checking.
