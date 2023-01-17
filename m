Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F3C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 04:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjAQE3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjAQE3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 23:29:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFB658A
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:29:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i1so7439610pfk.3
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNr6eDAfYkWf5QedeDUreBv4NAlSd5DVWDXsoncRmmE=;
        b=IAS8iJBNjpkVKwey4ruOZwVnG3kPPeljQNUpyAfUaXGROZ1cf+1V8BOi8tLIkS3Ss3
         WqU/KG8OYIfh68GnjDuO+0TEVu8lIl8OJZ48H3eVCP/1BQlH15CEymJHserOFXGkvy7/
         2uPKLN+/2JCXOr5qNBKmYxYSSwFtuI3OEF2VrX1dDeDs7zBgqSxL8Voa/R+g6xFBqt2p
         CuQDsmxtg1CTancG7ZpVmeogwuSGHwXWb3Buhu45WqIdWqC5eGg3ijp13lvznXD+kKis
         VI33Lf8Aa95UJsh1G0Z6yugtcr/7384qWiBdvo2tPdJb+MlB1FpcCObdIxrGy5noTbhr
         1bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNr6eDAfYkWf5QedeDUreBv4NAlSd5DVWDXsoncRmmE=;
        b=mJBvYvHTruxGnr/3SvsgP90yguAjZyseKRKzFv4VzDLaw86rPdkHGC7T8hu7KVIk2k
         PZrNeFWuW4wk7VIJ75g1c0YvS1fvhrCF8bW0DU6QcglUUlRitZ7kibyOWYgXd58zdigv
         4Z52tZZAVgX4JGxPCJeG9DS11/tsrems+N6Qz54visyAN/Ig02BqLV9f8WqnluieE3AR
         YcodejQbP52MFM/+GwbaUvJXc4j/wBi6jF5Qajl8Qqf5XhZXiy6D6O76dEX1ofO2ixI/
         eC3PYNMbLpDw99HQat2bSNNhlOCmnprAUOZ6LKzulmFtLvBQb0jR9MnxOxS0RdZle8iE
         dyMw==
X-Gm-Message-State: AFqh2kqe6OnixEj0JsGS+dXqhQSRaagLCwesr8rTTl4UXpDIqp5P6OGH
        6NR4g7STYn5shaGk0jHrA00=
X-Google-Smtp-Source: AMrXdXvQU/eyw5/Fu1xXu5qGlezuFzo/nKCTJJx9pRFX3bYUp2tX+YgMe72KwqlhfexZXlPW+aEjYQ==
X-Received: by 2002:a05:6a00:1ca3:b0:58d:bce6:3d52 with SMTP id y35-20020a056a001ca300b0058dbce63d52mr1982144pfw.29.1673929782941;
        Mon, 16 Jan 2023 20:29:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w67-20020a628246000000b005892ea4f092sm14756224pfd.95.2023.01.16.20.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 20:29:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-3-michael.strawbridge@amd.com>
        <xmqqedrxm7bn.fsf@gitster.g> <xmqqa62lm76t.fsf@gitster.g>
        <xmqqfsccii86.fsf@gitster.g>
        <f31f1480-d611-f4b4-0e7b-589574943eef@amd.com>
Date:   Mon, 16 Jan 2023 20:29:41 -0800
In-Reply-To: <f31f1480-d611-f4b4-0e7b-589574943eef@amd.com> (Luben Tuikov's
        message of "Mon, 16 Jan 2023 23:09:00 -0500")
Message-ID: <xmqqmt6hbx6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luben Tuikov <luben.tuikov@amd.com> writes:

> We're generally not interested in "what else" is in the SMTP envelope
> and headers.
> ...
> The idea is that hook writers would merely be grepping for a particular
> header they're interested in--it could even be a custom header, "X-something"
> for instance, and if present, they'll check the contents of that header and
> validate the patch, or perform some other action.

I am following you thus far, but ...

> So, checking that the SMTP envelope and headers, $2, is not empty suffices
> for what this patch set implements. We leave it up to the hook writers to
> inspect the SMTP envelope and headers for their particular hook purpose.

... I am lost here.  To make sure that the hook writers' grepping
for a particular contents in the file $2 does find what they are
trying to find, wouldn't we want to have a test that looks for a
"known" header that should exist in the expected output (or even
better, arrange the send-email invocation so that a custom header is
injected to the output of format-patch and grep for that "known"
header)?

Thanks.
