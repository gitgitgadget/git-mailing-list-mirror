Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD7EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFUCug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFUCuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 22:50:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11C1B4
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 19:50:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e916b880so2440189b3a.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687315834; x=1689907834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zka/1JKdk7RWd/TK5NeMoGBU8HSQdZNFW7db0zaKV5o=;
        b=YgZwlDjvAd+jxGBvg66WdT2yAAaCw/FdX8/Sanz6IX6x7nza2Un/SVBS2hqGfbDQeT
         Gt4bDOIWItue3Aj+mSWNuIQswvoZd8FIUQEYr+ukYyNhNdGU0gcRgqr2CDTTUpEc4e8S
         v/A9Nv+6V2sXUwQnWBsmgEnFX5UazOCrUZ76cMe+9TzspbmK8UnhvFhM+mDOSahg3TT8
         JwMuZypa6ofwB0KUT3vgbxw2OfXHAeJCxl6YHeOaI0ytX4qrsC5COL5uhQ+6JGOuP+pF
         omFTAN6xrnUl8dbBaHrk4/2DkBvoWZW2OfkC2bfXfEKzFIYfE6xsy0KLDiZxaQ5V/XIs
         tgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687315834; x=1689907834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zka/1JKdk7RWd/TK5NeMoGBU8HSQdZNFW7db0zaKV5o=;
        b=Q2d6CiR1vg3AfBxuZFjAWUJcDt3WNRmFni5X7Wk48TF2J7YfF2AQk8HWJRXcC5jgbq
         7daOXiKN17rSeTRQptuTYucs1tdqeCGvjFvyquS+YPkP8XmUdmjoyJezcpvCWzpAx8f1
         UNhDycGQPe3TIOpfvBc/OY7qO1LedGR7wGNne35BH3b1jA3TsnT58IMFmYVPTBgna2P4
         lrvurFrzBLmrJf/9E5qMXnH6SGYaqtcpNu9tQT8GK0kjARdGS74giwD5QjEWBRhpSDDI
         UgfeSmxx6b06Gwohpwwo8rBMBobdNzBxCrEpjkBYtmCwoA8AAU693no8SyeeOz3EZBn4
         vsXg==
X-Gm-Message-State: AC+VfDzXobyNzNnwbKk62gVZIpcC4pxn5eAZGMzDJDPAp6hlfJo1n1ez
        pDHfkl81YFBOYcd4lkutQmE=
X-Google-Smtp-Source: ACHHUZ7oWR4iIXguhl7xS9SedmZXjtbiFzLNprWKTQcor99LJwVrR+Xn0GgmaK4RIXYOUq5Z4aTyQw==
X-Received: by 2002:a05:6a00:1392:b0:651:3e9d:2a05 with SMTP id t18-20020a056a00139200b006513e9d2a05mr5462338pfg.19.1687315834088;
        Tue, 20 Jun 2023 19:50:34 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b00668717fa2d1sm1905656pfo.112.2023.06.20.19.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2023 19:50:33 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        peff@peff.net, sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Wed, 21 Jun 2023 10:50:27 +0800
Message-ID: <20230621025027.1996-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.28.gd7d8841f
In-Reply-To: <xmqq1qi5na64.fsf@gitster.g>
References: <xmqq1qi5na64.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teng Long <dyroneteng@gmail.com> writes:
> 
> > I think we are now in a new cycle, maybe we could rewind and use
> > v11 directlly? Sorry that it may have brought on extra work.
> 
> I think the tl/notes-separator topic is no longer in 'next' so we
> can do whatever you like to it ;-).  It would be easy to just
> replace the whole thing with newly reviewed version.

Yes, v11 fixed the UBSan problem which found by Peff and also the broken CI
under run a bisection (both are found in v9 which already be rewinded in
'next'). If there are no new comments on v11, I think maybe it's what we want at
present.

Thanks.
