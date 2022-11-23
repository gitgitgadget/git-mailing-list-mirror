Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82141C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiKWAbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKWAbE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:31:04 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF0C561F
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:31:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so432979pjc.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa3PnAsXzEDIX80xcYHBxHg+/TPd/VSAxE34qyBMWwI=;
        b=g0F5x5yUgy1cAfFggSiEL/lkaKVyYCObLJW5umbBNE+rQzIWsVrQXVh7FhZBOzVf1y
         YH0wCjUcaCJjrg0EWzg03h2YNdsxD9bT3gTv1eU2S3Kpr0LUKVUf7Cr3MfRNt2Pu8V+q
         3DiGpjGYRDvlLaHR28DU56S5oV21rfzzI+iOkOcFCFz2hxRQ/fDojQ218brvmJE61vV2
         KRyxIxXbp1SeMNSTkwviIqj8E3uKI0Fix2Swo5jCxzx21UNc7iDeUtMT3X9ntmQ/iRfv
         B6qp9r4tnN34D6Oyj9oY6S4fLrfe70K2wKqYCWMCwzi8kXOEBhtOy06ZPCqTV98m/xfS
         17RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fa3PnAsXzEDIX80xcYHBxHg+/TPd/VSAxE34qyBMWwI=;
        b=wiC+C8usOSlIUDHwU1KzfTOiaWu4LIKjGhNPAIgQeDqD/CIsoINr2fDHRUIaIAW7jG
         Zj5IEVO6NwxS6wUXf6JxAYKq9udU+ipl7zM22qoG3K6PkwZMo4MbucVDKI/BWkQOBZsS
         aOMxg8aTs1dKSTSI3dzP1KUCojyZRAyIIu+QT5ahzawfjW1GZo22hp/OA7xO7Z+lfdAC
         kai8qDw4tNTJpTjYsPbqoId4+r3kmRCRZnHnDKMI0DcbfnDQKWF5n5JNRiIeIcrfRV2V
         5bnDKoCXqYpeQmhA0f4ggLAcCR7vvFRsE9hS7DUx6tKLjx7a66O7Cq+mCpxO+4CPIp51
         rX3w==
X-Gm-Message-State: ANoB5pkEkuHFh13ETeGTnlMpatKsGne+nKVI/gOG6eOn/wMuxlRm9A0f
        8LOWDfMTAEJRpfmEsJHVL6g=
X-Google-Smtp-Source: AA0mqf6zEfWWwOiA5hdaoOcDi+33WMK2LbScV0ieDFR5En3ohdBbOTsTTdcLATJe4FYMwo0lFhxBHw==
X-Received: by 2002:a17:903:2013:b0:188:f7d0:3952 with SMTP id s19-20020a170903201300b00188f7d03952mr6047133pla.164.1669163461099;
        Tue, 22 Nov 2022 16:31:01 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j28-20020a63fc1c000000b004702eca61fcsm9773858pgi.36.2022.11.22.16.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:31:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/2] Implement filtering repacks
References: <20221025122856.20204-1-christian.couder@gmail.com>
        <20221122175150.366828-1-christian.couder@gmail.com>
Date:   Wed, 23 Nov 2022 09:31:00 +0900
In-Reply-To: <20221122175150.366828-1-christian.couder@gmail.com> (Christian
        Couder's message of "Tue, 22 Nov 2022 18:51:48 +0100")
Message-ID: <xmqqa64ipl4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In the discussions with Junio and Taylor following the first and
> second versions, Junio suggested adding `--filter=<filter-spec>` to
> `git gc` and I am still Ok with doing it, either later in a followup
> patch or in a v4. I haven't done it yet, as it's not clear how to
> implement it efficiently only in `git gc`.

Did I make such a suggestion?  I only said --filter=<filter-spec>
does not seem like a good option to surface and stress at the
end-user level for "git pack-objects".

The similarity of "git prune-packed" with this new operation was
brought up to illustrate the point that users of "git gc" do not
want to even know about having to remove redundantly available
objects via "prune-packed" by giving an extra option to "git gc"
(hence --prune is the default), and honoring the filter spec when
objects are known to be available via the configured promisor remote
is likely what users at the "git gc" level would want to see happen
automatically.  IOW, adding more options to "gc" would be the last
thing I would want to see.
