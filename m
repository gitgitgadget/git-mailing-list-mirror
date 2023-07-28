Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680AC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 02:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjG1CJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjG1CJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 22:09:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70B3A84
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 19:08:56 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba5626342so14163685ad.2
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690510136; x=1691114936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DWIGm7SzntsKddMQ4zpppNUIdMsMoy2sl0VB+Otv35E=;
        b=Xyj9FlT0KtcRyjlzq1LIlZ9OGAEaRs8Zps3E/DuUFIHAzVuIYCTUstkOMnp7Pv1+F5
         hWsrBLmzKNOlHvjrtwWLFr0wq5Lu+w/yMbFIn0mQXcWZHOcv7470RaPNo0aoU6eZjxLY
         aWFvVs00LTN7GbPDbCDaJmgQFDZPHrYb7LKrio+GlbdKfv1e6KuZ7lFsK/izK+sudyW4
         iBJRwiTM9X6t7kjr5P4vhnTL+gxWQQ8pEWIJy20wVWn2poLHKGS3XmwxTx9BTGNNzeG6
         oj7sFO7tL1AEQB5Ho/SVbAogt26+m9S7lR5H7hcMyFavMDWw6PuHYEAE0fa28ooaCG3g
         6puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690510136; x=1691114936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWIGm7SzntsKddMQ4zpppNUIdMsMoy2sl0VB+Otv35E=;
        b=TlXEclXHcWIsvPJacaSrLIQyCPosKYFvnkOCj4gQlJSIazpDdUAwY6Go3Uxk+lQOvj
         SseSgvGp4k8EwAKQKm1lnu1GaB1fdMV7awlSKeJog/Eu7d0Nrmig0aB9ktbKp4ddKMA7
         TnuuvY7W3ELY9rCQq52C431vV7jKSM4iPjSG0LFHiz8AiY5SL8JcOIHwURcdiQgsNFIn
         MQQBBjk3eRvNh25qJKf+UbivZWKrYkS8JuteTEMxmAXBslI0n0FoZ9NvaO+TT8cRXxLo
         NwFj0n749Kub8sjegIsvP+tGwKeTk6ylWYC4GjKCkfc5kuh/70FGFkW//QU2x+Yw7O+S
         Cexg==
X-Gm-Message-State: ABy/qLZQfjHRCo/hJ8OW445YQpBW9MeWu5h/7aaBHBn3nP75fFgVtNqV
        bk/r3i8mXsLuGWOJEP8dWcVTnq63R4o=
X-Google-Smtp-Source: APBJJlHMwJ+dZgltjEbA3oX1S38+PvXHa5v8kBIl8/BsxtitXragImMGITrAVQoUtrP/LJOcfIdGrh9sdW4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:d50d:b0:1bb:d8d1:3767 with SMTP id
 b13-20020a170902d50d00b001bbd8d13767mr1221plg.5.1690510136011; Thu, 27 Jul
 2023 19:08:56 -0700 (PDT)
Date:   Thu, 27 Jul 2023 19:08:54 -0700
In-Reply-To: <xmqqmszg987u.fsf_-_@gitster.g>
Mime-Version: 1.0
References: <xmqq3583uyk0.fsf@gitster.g> <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
 <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g> <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
 <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
 <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
Message-ID: <owly8rb0g53d.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too much
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "Torsten =?utf-8?Q?B=C3=B6gershausen?=" <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
>
> The inter/range-diff with my v3 was totally useless, but here is to
> show three minor edits I made to Linus's version I am responding to.
>
>  * Simplify parenthesized "because it may be the case that".
>
>  * As if you were "a" reviewer, as we do not designate "the
>    reviewer(s)" to a patch.  Anybody can (volunteer to) be a
>    reviewer for a patch, and you can be, too.
>
>  * Stress that a single polished patch that comes later (because it
>    took time to polish) is vastly preferred than flurry of "oops
>    this is better" updates.

All very reasonable and sensible. LGTM, thanks!
