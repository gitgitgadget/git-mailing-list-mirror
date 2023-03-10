Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EAFC6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 22:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjCJWBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjCJWAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 17:00:45 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AF786BD
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:57:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-540cb2fb5b9so19307757b3.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678485456;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RKEViFEpVhR3I93acNz9GdtU/xskLIERNDvZ6oJiggM=;
        b=KwXBYDkFIQ0vnqbUk2gU02nhpjSzHlxyDSPrSY6haS+bCxhk152ZEmV4IvNYILEssZ
         b4xdQiC0mmIYBR93NCjLH8ew9zHwgMIzxjEa+EhfTYxTJAt1P6FeWunXuIUcOKVciXDg
         Gu6Z5NOqCeQ5DhGbl73+oRQMKVYcafBdfDfdQX1DIjatsfgZRx4I2rysvi+biBCeM70B
         7ZOMq480rU+5V5C0f/bSqLgx36lyp0QX9vtT+s/e04A7luV/1DpQE9IQeGG76c99XIf7
         VJ3dNoSkLWtaJrC6dViortEp3pf61XthPxPNlAhJCFbwJQopH6OOAh5L1k4PI03Ha/9x
         iKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485456;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKEViFEpVhR3I93acNz9GdtU/xskLIERNDvZ6oJiggM=;
        b=H7Jw1fqO3SDB51QclSLVWHkEZAxSdggRsxirm5GMk6GHGbtASAI9LdshMKrXfoiCr7
         2STDW1VQJeZLwsPEgJtqkiVdAsOocAuCjFpESi/O9HMFXjJFqJq6S4TXncXzf5kRSF6+
         t//hepW16uhRKsmbdPNQy8LBd9ByK/YjbMY+zJVrpw3tmYlvUOyLjgbBqP0zQr1L/HDT
         DVWnWyvKahSfCoq3EPiUhQ8JV+7P1yOAUVQdRmBxN6d/lDQQAuVZ15RU7ra9KyVsGcBy
         xU7m3JrEVYZjhCXMhtju144OTXEITg+FDFowO4qU3QSXWMyQavbBmjCS7fSf2/+RIKCu
         TlOg==
X-Gm-Message-State: AO0yUKVfdKkPCPqmR7d8v5Sf+MpT5C8TWOpTd2fzxL6T86wDitVs72t1
        unnZSOGTBUA48u6LBTh8BR6geocFlnQ=
X-Google-Smtp-Source: AK7set+8r6uWb49IPYaksmT8pzvh/f7p45vEWi+AwkBFMn3p25X/sqqMBceRKvQce7om5U1JZ021sg==
X-Received: by 2002:a62:1850:0:b0:5dc:d34:d9f6 with SMTP id 77-20020a621850000000b005dc0d34d9f6mr20607723pfy.2.1678484844908;
        Fri, 10 Mar 2023 13:47:24 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78e52000000b005d55225fc07sm262400pfr.73.2023.03.10.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:47:24 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg5vgvc.fsf@osv.gnss.ru>
Date:   Fri, 10 Mar 2023 13:47:24 -0800
Message-ID: <xmqqjzzo46tv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> 1. The fact that -m does not imply -p is a mistake. There is no any
>    reasons this exact behavior could be useful. As such, it does not
>    make sense to support this exact behavior in --diff-merges. So the
>    reject of --diff-merges=[no-]hide.
>
> 2. This mistake is too dangerous to fix due to subtle compatibility
>    problems, so we can't just fix -m behavior. Thus the reject of my
>    earlier patch "let -m imply -p".
>
> 3. Moving behavior change under option is not worth it, as nobody
>    presumably needs this fixed -m behavior anyway (at least among 2
>    persons that are actually opposing the changes). So the reject
>    of "add diffMerges-m-imply-p configuration option" patch.
>
> 4. Staring in the face inconsistency between -m and the rest
>    of short diff-merge options is not significant enough to reconsider
>    any of the above rejects.

I do not quite understand the last one (#4), and if I were to add my
own 4., it would be that introducing --diff-merges={kind} may have
been a mistake.  It would have been fine and better to just let
users choose from whatever set of options we support, i.e. (-c,
--cc, --remerge-diff, -m -p, -m --raw, ...).

IOW, perhaps deprecate --diff-merges={kind} and eventually remove
it, if we could.  We've been fine without it and we'll be fine
without it.  Unfortunately it may be a bit too late for that,
but it certainly is much younger than "-m".

