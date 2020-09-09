Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B051C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0888A21D6C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foj4G0K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIITOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:14:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A3C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 12:14:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so4388499iof.6
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrpSwVovMmr2MU0yHymwB+NfuOqq9SjY10edz1hXouc=;
        b=Foj4G0K+eRas02NZwxASVQDFCYbHYmwPQvUHQlDI0Td+5NcWh8dwP6OFGkB+NzTE8L
         c/EozVeU02q5e1O/9BWx+OYGoBGwvMx/tJd20T5cysQch34tdfYC+YDbC77F1LlZVj1i
         tr4uQZ3CwYuipl76BzMMzLALh9qnlU4dZWafuDLgDfDRh7/cpVk9EXS8RhwJNzSPXPnW
         G9JdEBYXBT17gGowwQYyhLLgEPNc+Tv9niqQy/7Hct5plwCqwfSJlpikLknuaox2uP+S
         Bk8t/3UPIiI3CwQw8n0cUf6aZshWKZAnS3MfznQPeSYnSaMTUVXd1hn+tkTqZitAdSqr
         Gnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrpSwVovMmr2MU0yHymwB+NfuOqq9SjY10edz1hXouc=;
        b=bbIAU5CxRM7egnJPbLOwPnhkgzVv4Ch6+YTTzkK5KTymQ+XvPglIIotjjTDOzRRH0V
         vNBhH6U3+p+TGBgsPoCggyjBuFuEcyyG96VESf4Ss3KsK7q3uZdKRFmJDqmoiuR1DL0o
         llnImp1ho8zcBVg7iyhFqhxPoOZyXR9bpWUZFvILithx6IAytzX3UKvPwt/YQr5gPv0K
         AqDTx2GmmFhj0Ytym7pPCfhliaGCIglmZhLcllMGtdLk6djdU+KAVQA+i/y1HABFgxIO
         F5v5qVjWp8eqhGYjr8ZSKgeScfZDrTgbAjigy3fdhsgHeGZfS53ZufiwOaUZ4aPUZlyw
         OGIw==
X-Gm-Message-State: AOAM533JBmmUZilJhfy4mNlzdmrCH7Fw6ZmGL5YA+kePvfG1HxUwbAHO
        666EE/j4HoXqfwtAI455fOqqlyZzEM5mukHv1cw=
X-Google-Smtp-Source: ABdhPJz5+p9oXz+iCCCK7cik2YVtpptzkEGIlXLShrpMCW8pba3U8XXwEjFJyK2KhJrFzhp1j2HkQ5Rd4CumLtdXS5Q=
X-Received: by 2002:a5d:80c6:: with SMTP id h6mr4570601ior.2.1599678844664;
 Wed, 09 Sep 2020 12:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200908211053.807194-1-eantoranz@gmail.com> <6b84f112-7e3f-3a78-3766-033fcf494464@gmail.com>
 <xmqqmu1yvlv7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu1yvlv7.fsf@gitster.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 9 Sep 2020 13:13:53 -0600
Message-ID: <CAOc6etZOOZLQ4Vh_94d6cwPEAoAjuoqqvPWPHWWkw0rB73=hrQ@mail.gmail.com>
Subject: Re: [PATCH v2] blame.c: replace instance of !oidcmp for oideq
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, dstolee@microsoft.com,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 12:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> I'll still
> take this patch as it is a contribution from a new contributor,

I don't know why you say I'm a new contributor. I would have sworn you
have my picture
on a wall with something written like: do not take patches from this guy. ;-)
It's good to at least know that I haven't messed up so badly that I'm
in Junio's name's cache.

>
> Thanks.

Anytime! And thanks for the help from Derrick. Very kind for helping me out with
the baby steps.
