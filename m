Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610BC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiEPPjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiEPPjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 11:39:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827443C726
        for <git@vger.kernel.org>; Mon, 16 May 2022 08:39:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso14812339pjg.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLbo1OE1HvETwlLc7rfeyIctioVQkX2Csrrjha+RChU=;
        b=GMAP5PM7c2NKgDE30ogCVzwDsZgo23NRu1xMjssbq3ld5DSH01at4cMnIlxPwP4Mmc
         l2+UC5YuO3YqFGNqCAsQ99pzwNDZAElw0p91l0L9IcHGZkjiZ5iSwF/e1o/aXLeIaIyC
         b8j9uE2B1iIp72HDRIeyN5UEM8wFZJNlB0F5JmjZrW9FNCp1gLSbye1mwG8EkT2+OwF3
         SExzKCt55EopYpLQpz1M2zdTpqr1G8V//YWBlwS3kd5ciAbuOxHPz3CZcHjtq+ht1s2Y
         TXR0Vzcg/7nPTWKuo2QB/y5iJ+4ooI6OFhUXUh1lliMOHJZTCo+4O36vchUIl7lGSpYR
         DfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLbo1OE1HvETwlLc7rfeyIctioVQkX2Csrrjha+RChU=;
        b=i5dpM5HpmIrAA7e4FoqRju8Z37Q8Y6i/iQmNOgLQoPYGbjluve9DH1uSsjROaETiRV
         CGTbyOUojtiUqXt6ttFb6Vx2dESsjDGgQTGolKXs3q1P9bQx3STOASnvXqeqFKZEcp88
         NQXAPNEEJ7k5uZMSBbcY+mk29Eiyl4FPHODGba1ok3P+sYA/5fIA1upyB2jsmetn6yuD
         cSK6fT4WjXMjTIDqekMKhleSplQYY/0Uh4yuODJetvLZeFVH+uKqZbOWc7oTFzNwvgCi
         R40UWVJIq0tZdhg9/kXzqe0TjjcZKQQLOmJ/xOkCzVY24jUSeLQHqevQwWJ8s4RH3S5J
         olBw==
X-Gm-Message-State: AOAM532+UxHyyKAGxCXrxVnhHGYT7/Twz9KuXPmPhP+z431fuflUYxKr
        BrgyelxvOHOG0piS20zmCZA=
X-Google-Smtp-Source: ABdhPJzXGfJyeZLZVCqNDxYGy3L/Mu37frwE1kiCZ2YkiQ7/jiYFTBZXXhOQqyvqvYTujB5x34JEvg==
X-Received: by 2002:a17:902:d482:b0:15e:a06a:db0a with SMTP id c2-20020a170902d48200b0015ea06adb0amr18613433plg.38.1652715550836;
        Mon, 16 May 2022 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:580:30b3:94c3:fc01:afb3:2509])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b0015e8d4eb2d8sm7107090plb.290.2022.05.16.08.39.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 May 2022 08:39:09 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon, 16 May 2022 21:08:46 +0530
Message-Id: <20220516153846.18092-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqk0ap9t4f.fsf@gitster.g>
References: <xmqqk0ap9t4f.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> If majority of partial-clone users find it unnecessary noise, then
> it may be an upside to give only reduced summary that is less than
> full that may be given by `remote -v -v`.

Should I add this to `remote -v -v` then?  `remote -vv` is currently
not implemented I guess.

> Perhaps tagged output that can be easier to parse would be better
> "extensible" output format for adding more random pieces of
> information than going tabular.  I dunno.

I am not sure what exactly you are refering by 'tagged output' but
it is true that tabular form is hard to parse. That's why I suggested
`--raw` flag which would be used for parsing. It would give the info
following the currently implemented format.

If you like the tagged output format, then should we implement `-vv` which
would give the output as the tagged output format and also can be
extended?

