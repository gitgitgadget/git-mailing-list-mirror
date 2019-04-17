Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F05920248
	for <e@80x24.org>; Wed, 17 Apr 2019 07:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfDQHEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:04:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40464 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfDQHEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:04:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so30422559wre.7
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cOjVwEUWczTxsNGL/yiZTSzgPxIOcFunPETqBtP4ENs=;
        b=WsdrTXoRbFFM9OCPhJrvlYlbfoCUjfOrlXVP3q5iDT3rTUZiCgHQUpqOGqqNI0iuYi
         y/zG3ARtikA4OLT1TziwYWU5kVLG5HoNxKbuVWFlmFtaVRWtUfnzBq2l+iA1DypT+V7a
         eqlLlu3EFBZl0KCQWDSu/e3TY0x+vlaSLXhqJYmrkWHtjx6lB3ug9KSLtOUKdNjzfEMk
         YSYyic16YGZen/+uuiSXGXX6C1xa5K0GYdH/PnZRpqVNb++Rpp24jaNYF4KvGtpD4s7c
         y9gY8cQex62nWb+rIRZY8HpCrL4oouxo1A1eAaPRAI+I2DpzXQofaxxWLWOMOSNk1Cri
         vgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cOjVwEUWczTxsNGL/yiZTSzgPxIOcFunPETqBtP4ENs=;
        b=QAz9JgiOo0m8WD0i/KPXeebY6Q4XCvz1tfgeB/qvabCV5XsrBxV7e20aMpMPDry7yW
         exlp01BGU2F/NGSwXt5YLhV4eLUQe5f3Tc6KQX1T3Ah+5auWq1GXY0XcaxzhpUUyHFej
         BxBfVH2rT2IGpiDNEx16s335BDBZiZHC6NmK1cNTP2PWyWhFBzXkCiuPQBgLct4QWeBG
         7nCkOS/vZU2xRS+FEfxwvtZ5HrA4f++yMMyJTx65uk5QbGYJIbPwfxK1q31HVyCutROv
         bSZ1C75qqdMEfdPcJ/uE5Xxi7vMuvOM5idrHNgMpodydCa54giFTgL0wmGeo/lgKXJfT
         cR3A==
X-Gm-Message-State: APjAAAUD/jR3f+GcdwJP+lYPiwthrigPdog6nNFhOpPCdX4ShBaX6pK0
        o51dd/MgT6P2gzD4Yk2/CNk=
X-Google-Smtp-Source: APXvYqyM/TTTmhEVdqPmE9xDBN1iWapveTZLtBXw8WfrSVVyNsyVmrgAnzns2V67115lkzOz61J/Ng==
X-Received: by 2002:adf:e449:: with SMTP id t9mr53445986wrm.204.1555484686793;
        Wed, 17 Apr 2019 00:04:46 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s18sm1466751wmc.41.2019.04.17.00.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:04:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] commit/reset: try to clean up sequencer state
References: <20190329163009.493-1-phillip.wood123@gmail.com>
        <20190416101842.16556-1-phillip.wood123@gmail.com>
        <20190416101842.16556-2-phillip.wood123@gmail.com>
Date:   Wed, 17 Apr 2019 16:04:45 +0900
In-Reply-To: <20190416101842.16556-2-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Tue, 16 Apr 2019 11:18:41 +0100")
Message-ID: <xmqqr2a1jenm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Avoid this
> potential problem by removing the sequencer state if we're committing or
> resetting the final pick in a sequence.

The use-case story before this conclusion only mentioned "commit"
that concluded the multi-step cherry-pick/revert, and never talked
about "reset", which made my eyebrows to rise.

As a part of "reset", we have already been removing CHERRY_PICK_HEAD
and REVERT_HEAD, so "git reset" during a conflicted "cherry-pick"
for example is already destructive and the user can no longer get
back to continuing the cherry-pick anyway after running it, even
without this patch.  So from that point of view, it does make sense
to remove the other sequencer states at the same time.

Thanks.
