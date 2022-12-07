Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B7C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLGELl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLGELT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:11:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA356562
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:11:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o12so16411483pjo.4
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAhpH1+TReEXi09wSvWbxFjC8LF4i+FCqoKHnK0Pxp8=;
        b=c/0C3Znur76Bk0HPKggjOVtjqB1TAtG/dY/ZfudLmB7+hsQz4kObHH555XbLwd0+gQ
         aRUwLcjFbjclzOtUyKmKHUf+7A4Oh1n5olHTt7uM8u8o42Lc9n2k2Epemtc7O8TP8SKg
         sCpcoaWoOIf0YcKPCX0C9dai6o6coZYDvJoo1+fEH3CJu1S3iB2vx0ZZxObLg5lk6jvd
         neiZTKo3ETWLiT1whdPzWT9qiu4gn9Ek3WJ2LnhnwmwrXCsEuC/mg/rMlgGlUQ+DvZpI
         d6O+dlAGDka5xXHM9pw9ovIQGHQUuWv55/mDW3jDjqtbhezMGouuEvdrOouiZnnCKIXr
         Dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cAhpH1+TReEXi09wSvWbxFjC8LF4i+FCqoKHnK0Pxp8=;
        b=Gg153XRu06BTYlEetn23wrM1fIgU/pQ6lD9W+gEJtjSpwii+vY5l9sOEyBHOdfA2Iz
         FUS0CgT0+HqvkNJFiz6xgYcjqcBmWLd3tu772CnMktLfzA9KWogpvgubezby9zx6qY7b
         xaitCH3MQ9VRRa0N93fzym+91O80UCBZvPyPp7dmwemn2zhi4V/UfafMK4p/0Y1j2xYJ
         dPoLytdRevdZDOeINd1wToEZU68l+nxGVypjJatkWQOIsdDghL1vxbe3JTbDd1U6EvjK
         z3s97NEVWaqhBjAJhMGVvByWjM71ucGsKPdGev72nlUsG92LIL/J1s9b2Li5mWB/tiyG
         FkYw==
X-Gm-Message-State: ANoB5pmNnbOA6CTN0XcQrs4TXtgVOQ2kUGYldb8QIsT7tjOBdegISw3D
        2SSsSn/xP2Jo1PIwj8xMPRE=
X-Google-Smtp-Source: AA0mqf4xfSf4NPSemRKrL/lmrvkRvQFExs4E08bKIOz9UZEPdhjNmwYzH9R18ze/Yi0Nkwg83FUq0A==
X-Received: by 2002:a17:902:bc44:b0:189:b15e:a35d with SMTP id t4-20020a170902bc4400b00189b15ea35dmr30298323plz.112.1670386277620;
        Tue, 06 Dec 2022 20:11:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id hg2-20020a17090b300200b00218b47be793sm178152pjb.3.2022.12.06.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:11:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     David Caro <dcaro@wikimedia.org>, git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
        <Y4/xSObs9QXvE+xR@nand.local>
Date:   Wed, 07 Dec 2022 13:11:16 +0900
In-Reply-To: <Y4/xSObs9QXvE+xR@nand.local> (Taylor Blau's message of "Tue, 6
        Dec 2022 20:50:00 -0500")
Message-ID: <xmqqlenj7t0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> I propose enabling it for commit, merge and am.
>
> So I think that there are some legitimate uses outside of 'format-patch'
> that we may want to keep the existing behavior. So I don't think we
> should necessarily change the default to have other commands outside of
> 'format-patch' start passing APPEND_SIGNOFF_DEDUP.
>
> But I could see a future where we add a new option that controls whether
> or not we pass that flag, perhaps:
>
>     $ git commit --signoff[=[no-]dedup]

That sounds sensible.
