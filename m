Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE9C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507CF206ED
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 22:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi2j+gya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391702AbgJZWCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:02:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39865 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391697AbgJZWCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 18:02:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id e15so6970443pfh.6
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vm5V3M/0iUgcB6EJZvQhYXPrggH6lZTrHDt+SXw1910=;
        b=mi2j+gya+o/E2pihmsZtM2WT0tifAsEDQu4xFpLEIDW8ZLSaZEkVJut6oQROd5P6tI
         05Z58FCOyM2J3A1pGo8IzjYk3NoEyTUA8nrsWA+wOXMmT80UHPTwceU9reyx7dVPWZ7e
         aQ3ELC6zBEBDKljizbqlB+B2v4cl1bPZKsrvtmLx+GtCj1ErrFManhFIWGsNyk4IqHxv
         z7pFoTCT30xlPtRYx+qg/Jy/Rci2+6OxCz/oes6TpZrYJRvoqBTuaKG/REX84GBOGRu6
         hiLe3301ruuf10Hhi2a2LGsMzk0AMkXGq+NnN/m37zBCozcMlUj/7c+B/hYssEpPM3CX
         7zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vm5V3M/0iUgcB6EJZvQhYXPrggH6lZTrHDt+SXw1910=;
        b=PTxag+XmvPcmAb10DbKMHhRur1CshJpxwv/wSBo7PKVv9GhXP+jwXgp6XqVwisBG6t
         anDPd2Wqp/vGFZLx6oSn6Z4G/k6+PGQu+I988a6sf/yFUxmbjWLO3ibUMyPfx2pH26ps
         OmKsDbeX0JuPG7HtRCgjmqikP/tpeqru3Lrd2zLu4hTj3+CSmu5+n7qLTlJCDwFhNsgm
         JU5JaWV7+FPztwr+3g5ee8eU9F806ggDaawzm4tIkWEnyW7lDiDHfiRDCFZKPZP8MHXb
         oK+1iF9S5cfgop9uQShw3uwpUpkbXu1loQ8qoTZZhGN6Ek/3Wv09WKkeS9WmatVXLXtk
         nOEQ==
X-Gm-Message-State: AOAM533tiaid0UIehFLVqIs0agjahlTMdA5BWGZV5L7ZvuW2roLW7TOs
        DAhN0QXzKbU7t3UBUFWgsmQ=
X-Google-Smtp-Source: ABdhPJyomturicYn2tqJkwxYCWrwsCst7NyrXEn9yW/ZKYY8gj2kEzvDCHlYoBNFv0aZzveI5sKM1A==
X-Received: by 2002:a65:689a:: with SMTP id e26mr14899142pgt.136.1603749751298;
        Mon, 26 Oct 2020 15:02:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id q84sm6071889pfq.144.2020.10.26.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 15:02:30 -0700 (PDT)
Date:   Mon, 26 Oct 2020 15:02:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201026220228.GD2645313@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
 <20201026205028.GC2645313@google.com>
 <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
 <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(administrivia: the convention on this mailing list is not to top-post.
When your mailer puts the cursor at the top of the reply, that's a
signal to go through and delete the parts you don't want to reply to,
before putting your reply below the bit you do want to reply to)

Joey Salazar wrote:

> Thank you both for the comments and update, squashing both commits
> make sense to me as well, yet I can incorporate the changes in a new
> patch (v3) if that would be preferred.

Thanks, Joey.  I think we'd prefer a v3 since that gives you a place
to put the commit message for the combined patch.

Or if you prefer for Junio to take care of the squashing, an
alternative is to write the proposed commit message here.

Thanks for your patient work,
Jonathan
