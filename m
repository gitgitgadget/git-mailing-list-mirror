Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5922DC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8C26139A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 07:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhFAHaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAHaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 03:30:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA97C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 00:28:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1369380pji.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 00:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=TMAbs8CwviyBRyj4Y6Sf4LUNrARToDb72Hf0JPGVYQ4=;
        b=tFdMizxbqHUTmIjOBCK+VBwuKFYvWqGeO2j0gjrJSNnGgQ8Ib8HQnBjUbvwAbQWGw0
         QdgHikSF+jHfK6Md9CS5EBUt11QGj+J5lhX8Ss3Z+om6+thYU/tXHTG07sTCXsQkBFD3
         7/igOMh0pBxuhK0G718JwKwvNaIXGlsv4BIKlUrM9wohZURNRm96UBPYeuFSPi7e5BrP
         QuRar5GN7sBVtIqLA1QKkmZBCogYHfZivpRx/SJugSxmb7xxvgFkygDIgnSnw9fWd6MW
         EF7ZKoEfH8s4lU+WMeu/mWknkZO6I34nA7ZurqhYt72kvSnaiK5gKS/v9UXYFLOVSqEQ
         Fegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TMAbs8CwviyBRyj4Y6Sf4LUNrARToDb72Hf0JPGVYQ4=;
        b=GCQGkWrvr3sEj+zC6AfV8p11folcLwX0r2HAveTl4fpigTTJoKbj9Kj8I3EvqccIzd
         mGsBSzfTuq/CEAxb30BIPp7IGTCUHZebo3WXuoukqZPow3d0c1QTN6iQGSUMi5SARVo0
         dszN6sjxmrI5Q7L28ZNle0O4jNwnScRu+LmrwyAP+TdcacyRfIV4NM3FsAmvLf/HpFyQ
         RoA2teMw3dWFFA/jnq726RnGRvmOHsdybTtTOzTFXhrZDwpnarDZgc/vBq3ZtLrM7loV
         AKY/0FN1eWsxflFmPt3FI3KbxXduWi48l5olJQRBMWsUW2pCSNJcXZ47dUegn2QgCkwt
         Kfzw==
X-Gm-Message-State: AOAM5303qPGsdKoC6CtizZdDE7SX4dzJh4iSrJouCMTfQ6sAZMTOOXME
        KdIgsky4g2yyl5UtTfmwgDvsJ4GM1ZV+7ICzTK0=
X-Google-Smtp-Source: ABdhPJx9cGmE2JxCOlTlgJfMwJgHRXYq8rXu1jd1rk93vJuYPMH2UsZ0v7UJjW/g/UhUokg8oTGIqw==
X-Received: by 2002:a17:90a:6005:: with SMTP id y5mr21676989pji.62.1622532514641;
        Tue, 01 Jun 2021 00:28:34 -0700 (PDT)
Received: from [192.168.2.150] (ec2-18-163-188-250.ap-east-1.compute.amazonaws.com. [18.163.188.250])
        by smtp.gmail.com with ESMTPSA id 21sm12348714pfh.103.2021.06.01.00.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 00:28:34 -0700 (PDT)
Subject: Re: The git spring cleanup challenge
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60b5d281552d6_e359f20828@natae.notmuch>
From:   Andy <rsstools02@gmail.com>
Message-ID: <ea3a64bb-7c1e-465a-9639-aedeeb635d0a@gmail.com>
Date:   Tue, 1 Jun 2021 15:28:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60b5d281552d6_e359f20828@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not a git developer, as I see it written on the community related page.

 > General questions or comments for the Git community can be sent to 
the mailing list by using the email address git@vger.kernel.org .

My understanding is that even if it's not an advanced question about the 
details of development, but just a general question, it's still possible 
to discuss it on this mailing list.

At the moment my configuration file is quite short, but you mentioned 
that the configuration files of the masters are often very long, which 
reminds me that there is a lot of room for optimization.

Getting out of your comfort zone is not even an easy task, and 
understanding the problem clearly does require preventing expert bias, 
which is not easy.
