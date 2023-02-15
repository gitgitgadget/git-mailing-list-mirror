Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E7C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBOQUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjBOQT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 11:19:57 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D013BD9B
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:19:06 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 78so12922162pgb.8
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xqb0M5XDT/UJeH/wqNojCYiHuzG7F3t54vzd5mh+wPU=;
        b=ACXFqvntKJGaoEmgCfG4HTGj0fofC8mypHFvsrJ6ePtdEhisAjHDzqVKFoncUokfNS
         2BQRWheiO6y9YySFy9HL5wvEhvLe9fs5nb0SY4jFE/YU2HB8gKkBHRObKXxVRpxfYjAT
         0eW2crIR3KL8a+hlk9as0WUSNTheJlQzyEJGW7sju7svZ08PHNFLveYgQcUA5N25SXSw
         oKMsJM95uE3Z8+1N8WF/fujGaDg+/rtEE5Gnlh8kZZ/p3u4ZJ8MitniUeMILVWCl5g8N
         cFeurwTSS73ppgWgmbvC+DtKzekr6gQU+uYDEK4yc4gpTTVhchU4kBvR0eY1qmVF/BRQ
         tfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xqb0M5XDT/UJeH/wqNojCYiHuzG7F3t54vzd5mh+wPU=;
        b=qxfgNvbSq3MnqlJpvFmfpPz6rAP2fCDpZk28eVKU0aHh2kLzBhsykLQZra0/Y1Qk8s
         R87m6tRx/oh/t72RZNrtsrnYh11218aP7COmImz3/fBdIwOGu9RoORSigS+xRl0WVuwE
         2NE93NeWQs/0DeyH/eVlAFLTwnbV3iwDhHQYuy/FQW6eiv2um/8W2srgxhYT9FeAAlwJ
         ZFaAY+SyoRy/oEy/ez7miKs1XWX/PX1y6kDY8/O/zUDVmf6vLrcvPUDQhewuvW1TFF/X
         7pLCwyhmM50QAaA96b8Xe8YiDQTppmdOCyAv+9+D386G7PsaiOME80CO7jSwTXIKGmXr
         TIkQ==
X-Gm-Message-State: AO0yUKXvxT+obWy1YGLTj2TvwDSyUc9q/9TTBu89ekXrj/gtkShjzI5d
        Plk+2JAHXoaGoq33t115umc=
X-Google-Smtp-Source: AK7set/J44Wb8Efty2q8uhc9mnAOYN2T4Nwya+S4KgcB960kfBG43MlHQVAwFmRoQU59CHUpbJekNw==
X-Received: by 2002:a62:1d05:0:b0:5a8:9f70:18c5 with SMTP id d5-20020a621d05000000b005a89f7018c5mr1835347pfd.25.1676477946193;
        Wed, 15 Feb 2023 08:19:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b0058b9c9def36sm11858239pfh.139.2023.02.15.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:19:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jade Lovelace <lists@jade.fyi>
Subject: Re: BUG: git config --global --get ITEM ignores
 ~/.config/git/config when ~/.gitconfig is present
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
        <xmqqsffdf0ji.fsf@gitster.g> <xmqqmt5lezi3.fsf@gitster.g>
        <xmqqzg9kew1q.fsf@gitster.g>
        <kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 15 Feb 2023 08:19:05 -0800
In-Reply-To: <kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 15 Feb 2023 14:53:56 +0800")
Message-ID: <xmqqedqq296u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I mostly agree, except that I think we should leverage the existing
> "ignore" flags in "config_options".

Excellent.

The option, e.g. --system, does not have to translate to "let's see
which file does the option mean, OK, it is /etc/gitconfig so do the
same thing as --file /etc/gitconfig".  Instead, we can treat it as
"do the usual config sequence but ignore everything but the system
config".  And that would handle a class like --global that can have
more than one input source in a lot more natural way.

Very good.
