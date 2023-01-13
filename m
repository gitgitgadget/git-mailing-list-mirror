Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB4C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAMTWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjAMTWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 14:22:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844685CA3
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:22:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so24375505plw.11
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt0BPzbCGimN3D44YJZYU8tIrs25BcS5Q7DjMphoeOc=;
        b=AOeWUB/BW5k4Ngn0Fu9YaV5PjqCaYs88wiHJeg1XksgSfrm430efHhKyBEmiKeWA13
         z9F3pWrWnUXSx+C8UDiUVM7S64OJeDqOlvGUrsLTZTNwZfmAOBN5ZUlTvueamydghN4l
         Hh3MzWW2eGQHjj2DlEm/0slArdRNkzNZOSoUUZZd9cRR0OwuUkNxssROIzQaLOQLb0N8
         hZ4yHOeBLdV4XDkHndWhJIZRgfN1Ic+tr+/rV0FsiRvTdO3QlHrSIE6Gk5hdvlDBzUsC
         BQtgHpIgh/4Dnm/wwUhM6BGo3BmfIYQLTnTcJQm7pAILkwOp9HTpotJOkqz+cvIh5bLr
         b++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt0BPzbCGimN3D44YJZYU8tIrs25BcS5Q7DjMphoeOc=;
        b=AitK9MdlsrtI+4rvmSMjNlZzdlBnOVOOu9GiCr1jZjQObm213oDwtp1bfykD0hwHZ2
         wiwzNNaUBRBwgwwG7i9dURwvz9oUKAB6ie5BUBVZNlVyNgGiEWPeNwtDCEWABF+GiPfk
         2USPrS0eFSNWHpDzodowuozO8c4u3x8+l0ixNBKYI8pjbbTzboKtJH1Urq7B2N/2/QKR
         HWUkgNRQQoHWHWLsXq0q25ZOuxmXeGf4Hgs1OVxLzeOnhu1IZwv0Iv7ol0IPK+IEujTs
         P2YdBM8ASOCZYHcfb8MY4s9CsZ7B7Vsg2AxLPjr97SZycOX1senBSpok/ZFU6WNKbTNU
         aBFA==
X-Gm-Message-State: AFqh2kr8MHy0x5zH0CUSKRmjDVrqhVrJkTFmk3iB4fEgkOMltpEIUeKp
        dpI2ZjnQ6FH7u1iqa5RBvog=
X-Google-Smtp-Source: AMrXdXsCSxY4/x5Hl/IsRELvAI2ecA3WgGlI0WuvjAFcIzbh7MRIllaOko7KILSTncNc/STVcV5K4w==
X-Received: by 2002:a17:902:f791:b0:192:5ec4:6656 with SMTP id q17-20020a170902f79100b001925ec46656mr85234827pln.3.1673637757742;
        Fri, 13 Jan 2023 11:22:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00189988a1a9esm14506957plr.135.2023.01.13.11.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:22:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
Date:   Fri, 13 Jan 2023 11:22:37 -0800
Message-ID: <xmqqtu0u2q9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The "struct index_state" contains a "repo" member, which should be a
> pointer to the repository for that index, but which due to us
> constructing such structs on an ad-hoc basis in various places wasn't
> always available.

I'd exclude 6/6 for now, as it seems to depend on some changes only
in 'next'.  Feel free to resend only that step with reduced scope so
that it applies to 'master', and send in incremental updates when
each of these topics that are only in 'next' graduates.

Thanks.
