Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039BC61DA4
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 03:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBTDe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 22:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBTDe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 22:34:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0698C17A
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:34:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090aa78200b00234463de251so1772953pjq.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 19:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEZ18BGGhPxwZ8q4X2Ox7NvIP9iGHQkyUecURt76JdE=;
        b=N5oLPsSoGL7qCVIeA9MwiBCET+EnRr9J40WmVjbpGklqHzAQ2LFfv6LHDSr4CinhjF
         AID5sAb9nQ13vV+3CJ1f/Ha31CQCStLLQ7eoFCa7pbV6Kqb7SJF4eF86ki1S3LshjElx
         Dz/lp4MJwN6vL8KL8k2x9rxbs9sK0a1rozrG2HKLnCD8BiYPYYbBZASA2qVG83JzIARe
         KqnMST84B/5UmW0clNZfnFOWF7SaolMkG8vzmjRbVP/miQGPXdjUbPxQWA1XnTrYd9lo
         eY+yVKrVeUZGTV85WdmW8gXnG8WEdi3XV91ODcHXgdwM385vAgvLs2sAiilh5zzp3+y3
         eZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEZ18BGGhPxwZ8q4X2Ox7NvIP9iGHQkyUecURt76JdE=;
        b=oswntPLvjC3v7EnGlMZkikcOrG1llCLJ3MADrTUwZKoJVxudSreC1J03FdFiZ+UVx1
         O4wT8QaagHGkilEGW1d1y5tTcENKhEq2UAyKHYLWR2YYbEm4n6A3RqVS/3Uj/sEE6oJ1
         62U0qB7F9I4jiGG8hiVKI2QZOzeAA5tgBeWY/WGLsiiE2DAf9vx+chQhhoN2cSXCaXmG
         6cHadlRsCF7RJa066TbbPF3nv/XjYZvMPACV3J0vEu9OI9iSvKM55RN+67mb8/SDxZMU
         P8VD02VOIqeyc5viC1IcJGMZ1G5wRNjbr7hNAjneaARWylXGpIm6lPV3XsWDAO1qUMd1
         pJvw==
X-Gm-Message-State: AO0yUKVy8YgGsTKGN6dOCE+eakkfQvUwqDuZiCvfuFza6f1LQf/99hz1
        Y9x/lAnNZZeLvQG4VFmKsfI=
X-Google-Smtp-Source: AK7set+T4ZY+z+ZHXbv3K6a1d44tstpMNLskoFzC/cCP/2RySZuhcy4H/VXFSo40Qd7AF64Xqc7Wtg==
X-Received: by 2002:a17:90b:2243:b0:234:b03:5a70 with SMTP id hk3-20020a17090b224300b002340b035a70mr3059652pjb.35.1676864064047;
        Sun, 19 Feb 2023 19:34:24 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id fh23-20020a17090b035700b00234ba1cfacbsm724930pjb.17.2023.02.19.19.34.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2023 19:34:23 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 1/3] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Mon, 20 Feb 2023 11:34:16 +0800
Message-Id: <20230220033416.3683-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.456.gb1485644.dirty
In-Reply-To: <xmqqk00hpi9i.fsf@gitster.g>
References: <xmqqk00hpi9i.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote on Thu, 16 Feb 2023 10:39:05 -0800:

> > Best guess may be that the author originally inserted "\n" manually by
> > direct manipulation of the strbuf rather than employing a strbuf
> > function, but then switched to strbuf_insert() before submitting the
> > series and forgot to remove the now-unnecessary strbuf_grow().
>
> Please do not speculate when you do not have to.  "git blame" is
> your friend.

My bad, I checked with "git blame" but did not describe in detail.

> 348f199b (builtin-notes: Refactor handling of -F option to allow
> combining -m and -F, 2010-02-13) added these to mimic the code
> introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
> appending to note objects, 2010-02-13) that reads in previous note
> before the message.  And the resulting code with explicit sizing is
> carried to this day.
>
> In the context of reading an existing note in, exact sizing may have
> made sense, but because the resulting note needs cleansing with
> stripspace() when appending with this option, such an exact sizing
> does not buy us all that much in practice.
>
> It may help avoiding overallocation due to ALLOC_GROW() slop, but
> nobody can feed so many long messages for it to matter from the
> command line.

Will apply by your content, thanks very much.
