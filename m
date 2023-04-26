Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF4C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 16:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjDZQKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbjDZQKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 12:10:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457D76B7
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 09:10:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so9343443b3a.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682525414; x=1685117414;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjRR50haSUQOEW/I7KhI5YQAPMCwJN8rCrxXpmb47Ok=;
        b=jHQGW3rdJ/JGu4MDz4lQ4YZL/ovktwxBiYT7OZKxAzs2E3QsDUzDzLr0brJapNvcjE
         8GjpW5XMa0A9O9E0MBiPjsS701mDdK9DprUI4xfJcnht73tz+UWCtMQwhUAdUItJ2tUc
         vyv3WvtL69XCpisu68ahQWwlOPAO69vn9WMO845Bg+aqlEsBBORr2y3A9UGrrEZ5+wIG
         WYrb6qbJOeIkyjCfBgZHjG2u5Efx7JfaeIZ8JIk2qUL+a8OOUMDktlWn0Q0xKnTRz1qL
         JheesC128rosc3JexX3p8cte991O+IQbKMx9H0/a0QfjcPK31YOirUlcCSXMbF49MgHn
         uNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525414; x=1685117414;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gjRR50haSUQOEW/I7KhI5YQAPMCwJN8rCrxXpmb47Ok=;
        b=KfWyF5UR3SSOups0bSN0TcD8q7tUPU88nFFfZWfsx90xgW3LGExQ/h5bVG7EeCpMXe
         bU58yhXdMHQYQAKzG2aI69JVWulSZn5AjXvRQcb5xGiNU7Zc2368aKU0X1vcrmjuRRQj
         1e6Okv4hU9UwfMggvRY6DphojshN1Qr71c8fhBKcZcLg/BjwCiYe4GmMIAAM00yoopVf
         oG8DVLCLL7khuBmI8oNC2zVNn8o+uJNeDAqsoI59qGJA103PDMrc2lftrgUaKccqJ1X6
         yWt0YDf0UQDpUFXjMH+OTUMO8rHajHOKT6YpKjklOMp6SQIE7ZgrfiZ1WIct9hQiwxmV
         1nvw==
X-Gm-Message-State: AAQBX9cevlKERBJ7caohJUAS1Wgxn+tmq2Iqjdt/tg35Argql1e+Fxz5
        r16RnKFx5vI4AWkamX0xkCH1wieCsx0=
X-Google-Smtp-Source: AKy350Yf4SkxZlBV3EVupAafnat7Dt50ksdu8S7awQ7QlP+eAJGvlbaDXGcGPLc03Uk2SUpXry4iVQ==
X-Received: by 2002:a05:6a20:d906:b0:f0:7b8:c788 with SMTP id jd6-20020a056a20d90600b000f007b8c788mr22948649pzb.50.1682525413718;
        Wed, 26 Apr 2023 09:10:13 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id q92-20020a17090a756500b00246f73a994esm9887704pjk.32.2023.04.26.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 09:10:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Javier Mora <cousteaulecommandant@gmail.com>, git@vger.kernel.org
Subject: Re: Commit graph not using minimal number of columns
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
        <xmqq8refy114.fsf@gitster.g>
        <86188f31-f492-d195-d4d5-b0582906621a@github.com>
Date:   Wed, 26 Apr 2023 09:10:12 -0700
In-Reply-To: <86188f31-f492-d195-d4d5-b0582906621a@github.com> (Derrick
        Stolee's message of "Wed, 26 Apr 2023 06:45:24 -0400")
Message-ID: <xmqq1qk6vd3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This width is necessary to avoid crossing lines _given the order
> of the commits_, which is picked independently of the graph
> rendering.

Thanks for giving the crucial bit.

Object listing order is determined first, and then graph algorithm
works on the series of commits that comes out of the revision
walking machinery.

> I don't think there is anything actionable to do here, as
> these commit-ordering options are well-defined and should not
> be altered. If there was an algorithm to modify the commit
> order in such a way that minimized the graph output, that
> would be interesting, but the cases it minimizes are probably
> too rare to be worth the effort.

Yes, in addition to and next to "--{topo,date}-order", if somebody
can come up with a new "--graph-friendly-order", it may be an
interesting addition.

A tangent.  I do not offhand remember if --date-order works purely
on the timestamps in the commit objects, or do we take corrections
based on the generation numbers?  It seems that we only use the
compare_commits_by_gen_then_commit_date helper for prio queue
manipulation (to avoid the "slop" thing terminating the revision
walk too early) and not actual sorting.  I wonder if it makes much
difference if we used it instead of compare_commits_by_commit_date()

Thanks.

