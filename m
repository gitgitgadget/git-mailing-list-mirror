Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC8C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCOXCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCOXCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 19:02:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FE80923
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:02:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3514706pjg.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678921339;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfBRM0x50hezjY/u6ZoSNOh+Zwf8IJazpPsDDWJpFmI=;
        b=fbOkSMBdfS54fGQN17eNtVkt8j/2F9rP6GULU9szH4SxhDkU8aY5vCCjaPnpqw12dO
         6sBnHCznQ0qkoeC2F8eqFPK0juZ5/bWm+A233HsSxSGq3Ge8qtTiKrEeX2lAzl86fAzG
         +VEAn3LgME802Pokf4LokhiC5QO9tRB8S8pUZLPL9/OkzxenZnanUcteir7cWWLNMFOU
         D14bIFW//zB+Rdh92+dTd6QYPADItLsg2EH2Ixu4VY9P2w6b6bbBcx7oLAah8WATE4iE
         W+zIJVFDjlO6Vhu9vQhEsKzvJ1duc+Iim9Ud3nrQgGgblImlK8wf25Cc6TFwnz2sP73L
         D5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678921339;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfBRM0x50hezjY/u6ZoSNOh+Zwf8IJazpPsDDWJpFmI=;
        b=t+UtnfziUK4olQIys/UTda6XoGlw+mQGWD34bds5QNpSo/I6UqtyC57x4WKiJq6Fc6
         Xw0mlRDz4DbCIxRe5JiGHadu51q4oZZLBtFNuMfmHYFsWUFuRF4cjJrNW0k6ro83XOC8
         aPZ+zumjTohAmswEPgFDJomEg3hLZ/nTrvm8osdcm0RyAmohAclCV7jeiOzPW7WxcL7R
         biLBc/JnvUF+9CyrhIVYPf3hqme2wKFAtGCipfM/CT0WrdpoCSyYB/Pj2lJngQZHqZyQ
         zPJzKgHGMVq6Y1a7R1pYyLTsucL2JXK8nREUTZKctkllN1M9qBKuOlfKLsF3YxDfM95+
         kW9Q==
X-Gm-Message-State: AO0yUKVZFN/66BDk8hqEuuxvcmILvsnJTMcBxaNnttWZxqRU2hq4PrCU
        J/u9ht1TdNaguhIKmOBNryI=
X-Google-Smtp-Source: AK7set/D5nNMqfDIDCbEGG+UDfH5f2N6+klq94IKUzigt5Sd9sOU6Ay+tZ/wQN2LzuK9xPDdMXBhPA==
X-Received: by 2002:a17:902:f389:b0:1a0:566c:aaf8 with SMTP id f9-20020a170902f38900b001a0566caaf8mr958815ple.27.1678921339378;
        Wed, 15 Mar 2023 16:02:19 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001a0567811fbsm4152697plv.127.2023.03.15.16.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:02:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/8] fetch: deduplicate logic to print remote URL
References: <cover.1678878623.git.ps@pks.im>
        <2ea3a4e308d2fb89f24d0cd2efc9d3867983a4b0.1678878623.git.ps@pks.im>
Date:   Wed, 15 Mar 2023 16:02:18 -0700
In-Reply-To: <2ea3a4e308d2fb89f24d0cd2efc9d3867983a4b0.1678878623.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 15 Mar 2023 12:21:28 +0100")
Message-ID: <xmqqy1nxmxdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When fetching from a remote, we not only print the actual references
> that have changed, but will also print the URL from which we have
> fetched them to standard output. The logic to handle this is duplicated
> across two different callsites with some non-trivial logic to compute
> the anonymized URL. Furthermore, we're using global state to track
> whether we have already shown the URL to the user or not.

If we are certain that store_updated_refs() is called only once for
the entire process, then storing the preprocessed url in the display
state and passing it around does sound like a good optimization and
clean-up.  What do we do when fetching from multiple remotes?

> +	display->url_len = strlen(display->url);
> +	for (i = display->url_len - 1; display->url[i] == '/' && 0 <= i; i--)
> +		;
> +	display->url_len = i + 1;

This loop is inherited from the original, but we may want to use
strrchr() or rindex() as a post clean-up after this series settles.
