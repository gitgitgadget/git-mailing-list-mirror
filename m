Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B3C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E443E206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGMduRGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgHaVB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHaVB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 17:01:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C72C061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 14:01:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so8379309ljn.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fqzUCrreKUgstgqAvkyGpx5GDLuKKKaS5Hi6AozSRa8=;
        b=ZGMduRGEq5fwiOWRQyKSxGsLRBqua3dikfI27qvNKcw472onfcLmjUbI/zNQI1rNDi
         hZsIfcnAZUoH/Y89F8HH7pWPqRAQ8NpRS+ngELubDfar0EbRK8GMwIh7o72LrqVySKmK
         7bHZpAPRIDy0ZjipBwrfSrTxdhv0g4NqlT6HoTs7DvL5msZmiIlGZfv3rZkONKy6Ajyi
         7SFGJ7Xy6AHQBIj16snmYLiAHy7wBDdrJGti0LDeJayLSnOkIxwonI0fiopnlZayMArm
         DqGivGD9D08esenJqzc/309Yq/28BxNruKyXLrGcNFXrs2OXTv6vnZZsdyhNkQP3yQz+
         eU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fqzUCrreKUgstgqAvkyGpx5GDLuKKKaS5Hi6AozSRa8=;
        b=mbgfsOowEQfvMMVHBkdaBqVDbqmYy2NWM60vWm21dzXgq5QPTMubSUb84kTF9pd6JY
         5kwrmM2/KD6YxLh+hQoBS3N6fBN/35c6o+iTDnY1LHZQmSG5CrDY4iDRYAUrmkKbRHkd
         9WYZmotv8dwvUhsq9im1zphgpNo8Ugk43c2tHywtpgqACEodIQV9vIgss59UoE+HUFLs
         EA58nweq0VDhCxEtW4Ucu+bnY2Imr01RH9R7ryPsZNTvYhXdtQWOCw9uatPRrtm42X31
         t6InVyGDVFhj2FsfWthaGTTdKLitG01WOke6mrQtIaU9k1LSs2sAxuzyB4HCZksvcF0Q
         ArMg==
X-Gm-Message-State: AOAM531m7jwKuujBMQXRzbhXlMuEXSOig+JRfSWRzAVxcH1nK55UrZV3
        nWc8JE4/svRrDp/6N0G95ADFWdM6sbA=
X-Google-Smtp-Source: ABdhPJzOVZBqZX3/ivDsEZnSOgYNHGl8IqVdAnnGqQ9/qk/UuZjPDGTcVZMdat8KhkdvImJCU1AbYQ==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr1546907lji.32.1598907684117;
        Mon, 31 Aug 2020 14:01:24 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z18sm1788371lji.107.2020.08.31.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 14:01:23 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v4] revision: add separate field for "-m" of "diff-index
 -m"
References: <20200829194634.23306-1-sorganov@gmail.com>
        <20200831201422.27189-1-sorganov@gmail.com>
        <xmqqzh6aeedr.fsf@gitster.c.googlers.com>
Date:   Tue, 01 Sep 2020 00:01:22 +0300
In-Reply-To: <xmqqzh6aeedr.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 31 Aug 2020 13:42:24 -0700")
Message-ID: <878sdulecd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Add separate 'match_missing' field for diff-index to use and set it when we
>> encounter "-m" option. This field won't then be cleared when another
>> meaning of
>> "-m" is reverted (e.g., by "--no-diff-merges"), nor it will be affected by
>> future option(s) that might drive 'ignore_merges' field.
>>
>> Use this new field from diff-lib:do_oneway_diff() instead of reusing
>> 'ignore_merges' field.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>
> Looks good.  Will queue.  Thanks.

Nice! Thanks a lot!

