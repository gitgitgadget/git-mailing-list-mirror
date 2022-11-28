Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8AC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1CfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1CfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 21:35:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDA10FEC
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 18:35:13 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q1so8709930pgl.11
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 18:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCjSgRSgRON+CmDumO6Iq//+3o5eJkUQEchBVE/besw=;
        b=F0qJnyMbVxuFj8RqiF7e+7tqkL+UdzPhES5CjuRsx6owNj0eB+0l2oZbJudnnDBLmv
         eglxYDOc2nFETB+U4EIxl+ra2o8n3/lWGDoOQJs8m/s/45xpd6rm6Y1L9ZJrRuwrUCef
         BmqPDFp6CPjRiHA+MiZ4a+vaRzMK6oUSVIwAzrV+K3PjQdiZJ1S3ImBK533b3o/maD3m
         KMsvRCjDPK00jpE9VraZjTTcK8FI22WwpkuZzWz2AOkJvMbzAVk/bmH4YVbOv5R7JfeD
         SvtmDk+6c1XUH5yK8HQ95qtwQ8Pivx5lIkd4aGbbA2cldoAglWBUA4+uMwvV8KNMDn22
         8F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCjSgRSgRON+CmDumO6Iq//+3o5eJkUQEchBVE/besw=;
        b=NYLmiq7DDRdmtKwp2Z8wSLD2BHbfqBeyhWm41s0k/Nv0jipLZBC3Cp3hrhdEPF/YIP
         jsZCW9l3Khw6zDdel0SvCEarh6tqbO8hcIehKUZzpij2a3NuJFc1dl0mPuIEeQ1AlhXC
         Oo0AedVIfori1rjFFPdsX2sDgb2ZpMCXyKof7CYnjZKlvUjkVg27NG3/bVnEeS8P24Kh
         h5xGj9J927XjgX+eNDlOh5E9LRBy9EY38Obu6gqsdZ7gPjsRbEx3dBYzfvWFYirz2YWE
         zgI+yhuz1hpFgpYRxpovUd/WAs9/IxWqb58qV4LPdmhnG99C8pt0tC97cm2uhQYbGC5L
         b2dQ==
X-Gm-Message-State: ANoB5plVwaM5oyRKtqIBo2Cs8Zjdi6svGKsoxR5BbPuO5HwFlNUQCuIV
        KFI3V7xeoppLt/ZXiLQUodk=
X-Google-Smtp-Source: AA0mqf7FLyt71X3CsTxJ5JGg01D5gJxCVMB87H0LeRFmzZNl+v8b2XoALbmkocgjVR0yo0pmDOz4WQ==
X-Received: by 2002:a63:c65:0:b0:476:db6f:d436 with SMTP id 37-20020a630c65000000b00476db6fd436mr44503545pgm.394.1669602913058;
        Sun, 27 Nov 2022 18:35:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q13-20020a63e94d000000b0047063eb4098sm5837529pgj.37.2022.11.27.18.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:35:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
Date:   Mon, 28 Nov 2022 11:35:12 +0900
In-Reply-To: <20221127093721.31012-4-sorganov@gmail.com> (Sergey Organov's
        message of "Sun, 27 Nov 2022 12:37:19 +0300")
Message-ID: <xmqqedtn957j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> +	if (set_func != NULL) {

Please write it like so:

	if (set_func) {

I am not reviewing any new feature topic during -rc period (yet),
but this triggered CI failure at the tip of 'seen', so.

