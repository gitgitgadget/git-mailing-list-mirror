Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DAAC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 17:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiF0Rmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiF0Rmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 13:42:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC361276C
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:42:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k14so8824799plh.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdTB5aYy+h1DmlnTRLIFW5LAK76H6jqG4C8KE992E2Y=;
        b=Bw4SO+D2dRpVy1ueaYXBRd7cnIKqM5x1TPvIo0hHBY94HVabDAcUxR+WDNiEWYn6Fo
         jybSro2vyJbGDrKZ1BuDog4VZcfyWAKezueeYSbzbER69YDvEpBNHfut9ByRyKqtSaXw
         fl0+ygNFHkHskm2/jgb5j9OU1SwIRZRIpLCfcTIFaINeTCaaS9nL0kd7ggMKqEJ4RLXq
         bR03lFqY6UpNabiJCg0xg3t+D73icqbiAwM5Z8edJM2b/2U6eMTjMmZuLWHhJzH9dkC+
         4ebGIvRO2jaWFDBAxSAHMcr4/6rdvS5zYiYNncMItW9BCNnui7vsMeGgKWOYli/DoWIE
         ZviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdTB5aYy+h1DmlnTRLIFW5LAK76H6jqG4C8KE992E2Y=;
        b=z6rJWMqJvfeisXV9zMriQAc6axoNSqEiBmc6p9qM33Bk6txzBI1PLl9g65vj3puwPa
         +MdlnLaY9QMG8HXlW65BHW8osJ6roVZ+GgC5+XtAhf6TXRZsQso/PZ17MMyIDAvS8EA/
         aY/or+uh3L+8tvfhWMwaTLdWUUdRcuv1YpZkV3kTIgnrfobwgNAc0pDIL2FVYOo3Az6y
         kTmbi+8uvyj3rs7OTTI7kRsG/XctZLHP83mcAHOisTB/ATBBTED2iy7Mk1nBDdZzKt8B
         yuhfnKSr2VOX/DtSzieCqnl/vCdYAqT6+d/wjhNvDHT4gRYiIvX7jB7FV9mJ6rUnaaYZ
         Ilow==
X-Gm-Message-State: AJIora/E3ZXxmh2RvqtURRNfmbNGO/1dA4M6Nqp7iXe0a5vsTsiwNQ5Q
        LZ5GciaImf+zYa9A6zVtsGg=
X-Google-Smtp-Source: AGRyM1u03r7kSeeZl2b4W8s+fAIFaQVIr1AaTCR8wi4qabYJvRWCYrjEHXlRmD7iW+1xCLOcvsQ3Rw==
X-Received: by 2002:a17:902:bb90:b0:16b:8a74:3aad with SMTP id m16-20020a170902bb9000b0016b8a743aadmr1555492pls.47.1656351763868;
        Mon, 27 Jun 2022 10:42:43 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id be9-20020a056a001f0900b005251fff13dfsm7577785pfb.155.2022.06.27.10.42.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 10:42:43 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
Date:   Mon, 27 Jun 2022 23:12:30 +0530
Message-Id: <20220627174230.16253-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <05edd01a-8b6f-b25d-0cd1-b1a46ca7c219@github.com>
References: <05edd01a-8b6f-b25d-0cd1-b1a46ca7c219@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> wrote:

> I wonder if it makes sense to have it default to 'false' for now, but to
> change that default after the feature has been shipped and running in
> production for a while.

I do not have any opinion. If most reviewers agree on it, I will surely
Set it to false.

> I think you should either use "Git" when talking about the software
> generally, OR use "`git repack --write-bitmap-index` will include..."

Ohh, yeah! Thanks for pointing out.

> s/which/that/
>
> (I'm pretty sure that "that" is better. We're trying to restrict the set
> of repositories we are talking about, not implying that all repositories
> have this property.)

Ok.

> These lines seem misplaced. Maybe they were meant for the previous
> patch?

I mainly used it for testing purpose. That's why I included it in
This patch. But I got your point and will move it to the previous
patch.

Thanks :)
