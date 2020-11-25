Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B0C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5AD206D8
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2jKSkiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgKYW50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgKYW50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:57:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04AC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:57:08 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so3733455pfg.8
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Zju1x9P9FzTDh8N/atnuRAobpUGHjASLn+TSRLo3po=;
        b=F2jKSkiEQ3SpW0jmd3IQhRzlhmtiIFHBlgKIZk5NAEqS0eVHnmps8rQboXadgtuUEI
         vvSn/Ca8r3SqjRakjQXiI240aowQA4A2xcgcWHEmZDe5Ltla9TS4tIL3lhuRdg2ifzCd
         J3dIe7fbFQUaDiGlRBEdrtge41KG+KgaubDosdsIcLG2UIYne2nfvsyyrd2a1QlzLfdM
         T1hXIOk7diRaQ7PHxF/aLb3kzqbrJ++Y/a34X8rObAdyn+sEYFrpH7CejGQunfHJHlXv
         oCqoLYa2mSa1p5f7Wr9yDgG4XPQljmXizNjJ/V3FBs+mQ6o78MZymGUNlfTGgefxc7Ly
         HxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=4Zju1x9P9FzTDh8N/atnuRAobpUGHjASLn+TSRLo3po=;
        b=sbKlzVbNeoklSdOfnKSJH96wGH3j3cOtSca1A78k+yQrwJSP5wW9vaKsr3HLZJpdDq
         lAggV1irv1YIgbBllJzAhehIDxEtFknovhC0QkXumeshgvEqUT8L+sbzrUgNrIn+mqMx
         UcIPkpswDoORssBsRktwtoBf+St8xJZMMKkTvfDv2WhvaGlDygrgkfCsHvRdyMw63X5S
         IjasuCTlbNcEgFOlDDbI5wm5dhtgbKno2qbP/0hIFduZmgrAZUbqAAqA2cECO04zJ0pr
         qZ0W3UyooNbJ/gv3Wz4XxLC/PwFTuEiuJYEGyiDJl340xnwe6FsdQO+hgmmDQSGdpfWs
         PwIw==
X-Gm-Message-State: AOAM531kDpbeo1gXdpA+PxT7x0H77ANY4+IC2LHt8QFH7pSvyMEuJwLZ
        llaVKznO74B0bZ6TyHgoXe0R/+udbNDrvQ==
X-Google-Smtp-Source: ABdhPJzODvTg3GqOk6AqgVw7JwMsDkKFNFDoUQz8Mahcia2gkc9Fi7vLlXJxaFQGW9f8i7dgLt26jg==
X-Received: by 2002:a17:90a:7f93:: with SMTP id m19mr4594pjl.61.1606345026738;
        Wed, 25 Nov 2020 14:57:06 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id 16sm3736865pjf.36.2020.11.25.14.57.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:57:05 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:56:59 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Advertise session ID in protocol capabilities
Message-ID: <20201125225659.GJ36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1605136908.git.steadmon@google.com>
 <xmqqpn41ccor.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn41ccor.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.25 14:08, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In order to more easily debug remote operations, it is useful to be able
> > to identify sessions on either side of the connection. This series
> > allows clients and servers to provide a unique session ID via a new
> > "session-id" protocol capability. This session ID can be logged on each
> > side of the connection, allowing logs to be joined during debugging
> > sessions.
> >
> > Changes from V2:
> > * De-emphasize connection to trace2
> > * Renamed capability from "trace2-sid" to "session-id"
> > * Noted (lack of) session ID structure in capability docs
> > * Advertise SID regardless of whether trace2 is enabled
> > * Simplify conditionals
> > * Style cleanups
> >
> > Changes since V1:
> > * Added a public trace2_session_id() function to trace2.{h,c}. Used this
> >   in place of tr2_sid_get().
> > * Fixed a style issue regarding using NULL rather than 0.
> 
> This round didn't see any responses, but it has already been
> extensively reviewed in the previous two rounds and looking good.
> 
> Will mark to be merged to 'next', but please holler to stop me if
> needed (those in v2 review CC'ed).
> 
> Thanks.

I still intend to write some documentation to clarify the trace2 SID
structure, but I think that can be done as a separate series. Thanks!
