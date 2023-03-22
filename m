Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E896C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 23:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCVXgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCVXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 19:36:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D762385D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:36:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bc12so20133674plb.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679528187;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stzI67adVRP8Do889kkoiEHwxNzcFWP49S+xX1UPMaI=;
        b=Him+8xlEcAgP87xqp2nEEVPK7FYZCbJNfedxUrZlelLiJ3f64ftbw15ZG6W8GH8+Ou
         SOaOL0P5AvpJnabEV/ZVy2EcvnaNvVj4NW6DuBa9uyYjxGJ3q6OSSPIBTMmAh73slBYx
         uyIHvOZdz5ntCgJ+yrnlUnThha7LLQI22Vcr9EwbvYjlEymmAWja5l2thJZVwLr6nzMO
         I71rmi71vSw7jYrsKqnqBLGnS/wPSV54LCG0DteZ8Ad3PVdm2FgEoabZ+MvuSEbnSl94
         ZRuo57zrBBg09wIIyZ/inNBicJDvJSQi0pLqDQDbdUi+fIvrYpuVh2fph93vrAHP9I3b
         HaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679528187;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=stzI67adVRP8Do889kkoiEHwxNzcFWP49S+xX1UPMaI=;
        b=z9gqKXnvtyJvt621QFFeU/msLXyahjh5T/MGjiXFGFiFD2sB6e2WSmmKpNOOpOgRN9
         R4tVtN73XTpl8z7wLGMT9X2y072m/0FzydwgCAytSb//d9wP3R+Y0eJ0/qcHXfrKXbN0
         fTeM1EmkjlsEDUt/3IwcPnuTaWZr4kaJ41fFBegAq5ivlQf9q6IfkTWAFsP7fQ+UZud9
         8u8e0TZSdSLupzCaARlGG8Li+5s28tiBF/WOkYnkb6L7APvXxWJCl9L60K1zWeTv4jNp
         RjcR8EvueA+s/1zgYOxmijNO5ENpgdAuvxVXzgaUIKJKpqBNIQmtFp9pGyYHc5gIMpVb
         MzPw==
X-Gm-Message-State: AO0yUKVVEvkim0hizIl9hvdSHvvMafXRaX/PO1YzNUZsWoYslOt5Ei2e
        q66nj/zjjK0m00ApJVRoUlE=
X-Google-Smtp-Source: AK7set/9yjlST7Siu3SD/M24/X071Vj4AfW0v1piWaMkSJLqNggMqrpU1EZiG2dV8ZI5YNHyOPEZug==
X-Received: by 2002:a05:6a20:6a9d:b0:cc:e39e:3f64 with SMTP id bi29-20020a056a206a9d00b000cce39e3f64mr929179pzb.24.1679528187074;
        Wed, 22 Mar 2023 16:36:27 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k9-20020aa792c9000000b006293f833124sm1927461pfa.13.2023.03.22.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 16:36:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v7 0/2] diff-files: integrate with sparse index
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
        <20230322161820.3609-1-cheskaqiqi@gmail.com>
Date:   Wed, 22 Mar 2023 16:36:26 -0700
In-Reply-To: <20230322161820.3609-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Wed, 22 Mar 2023 12:18:18 -0400")
Message-ID: <xmqqilesbbph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> 3. Use `--stat` to ignore file creation time differences in unrefreshed
> index.

I am curious about this one.  Why is this a preferred solution over
say "run 'update-index --refresh' before running diff-files"?

Note that this is merely "I am curious", not "I think it is wrong".

Thanks.
