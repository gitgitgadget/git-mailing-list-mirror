Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64215C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBFXEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBFXET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:04:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B51EFBA
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:04:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so16726042pjd.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjBsj83R4zY12aDOdSxH0CwTLEJIQ3AhpL3amdZpKB0=;
        b=VH9CuRprF0Z1vRNW0T2n2N0xkexe3fglVBk9yTcFN9WpIN8oSk8lHQWFE4SFycW8W5
         YVMHgGuWi5MyRcRNgzdpEHw0++QBm0ZUtj+iQA0YxoOC+YRnr06V81OYzopmGhTRHLtl
         XOqdIO+hqkjN7kRmYjZUXQkXpz057GFczgB63eTQytAzywAwlR8WZoGxzc9uFBoVWTMW
         FgvMEdk5KLoXx7F6CtwJkZwt3dvNfsep1eITygQOi2xFLbd7aVi5Xs4INKMLMReWgBjb
         DNmmeGV+jguT2/v9oWhDIROZ0n89o+zINRY9g40vgTzG+oJ6NMXfDvIZRqNk1rl6ZIKn
         Rcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjBsj83R4zY12aDOdSxH0CwTLEJIQ3AhpL3amdZpKB0=;
        b=P5Su8X+OzqlDJwwx7NsWb5rFXKXe+CXNJ9LNS9aFKI3mEF/e6VAJpne2ANKFRFjOKW
         8MTS9VAYGM8Eb4XCef5eRLhrj1P+QDf8+6cg1TYh8Ag49Bk9MQeMjEHVvk15Fk+mhL11
         5RQ4fAVeXCtERvACD9ste45xGVgPnEdHMQN0ddeSceb/lFdbwuitcxnNVJpVvemXCyG3
         QBg1pQVOpXBuAMndUge023ICz1dZ1XNljlHcS34dMZdbmfxZ4DozV9+AKNUeI8ljNoCl
         I0WOc/FZPckcBTnd36P+g7CWBtvf3U4xzV3BaV+SvpJXQ5Cycwez13vQMksyWYA8shmq
         vR+w==
X-Gm-Message-State: AO0yUKVxJj9zkJTEyOxxtdE0gbhBPr7akWQAS+rCWVdbVLdHj5Q1ecpF
        UA2JT6Pch/WM68hoxYVhXX0=
X-Google-Smtp-Source: AK7set8AOZXMjJCOtukCfC4rk053liXTY4NkIQVGmabrrF0FAvkMS4akQL+/xgN+qUWQ/fXFExjrjA==
X-Received: by 2002:a17:90a:7f95:b0:22c:816e:d67d with SMTP id m21-20020a17090a7f9500b0022c816ed67dmr1493979pjl.24.1675724658567;
        Mon, 06 Feb 2023 15:04:18 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id mg8-20020a17090b370800b00229ff1fd7e0sm10341698pjb.14.2023.02.06.15.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:04:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Slavica =?utf-8?B?xJB1a2k=?= =?utf-8?B?xIc=?= 
        <slawica92@hotmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/3] add: remove Perl version of "git add -[pi]"
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
Date:   Mon, 06 Feb 2023 15:04:17 -0800
In-Reply-To: <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Feb
 2023 23:58:55
        +0100")
Message-ID: <xmqqbkm62y6m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With Philippe's fix-up, this round looks good to me.

Thanks, will queue.
