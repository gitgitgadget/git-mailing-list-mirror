Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F9C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 20:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjDCU6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDCU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 16:58:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FAF1725
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 13:58:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so31834998pjl.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680555496;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nREoqFw6z0KXEqgbCZwvFTJ9ZsIiVHBPjPD2RGj8T/0=;
        b=SaFKp8SXDBGWOPyRvp5lVFwwsf7HBXdOaDfYeBLUpdPgM/QiE5OeoTTYA9Oc1h7t5T
         cPIHH24s9G4XjKdPXv80q8ZZLLAEVbVSMiT34Meit+F+gutb77AI77rZjNd5ZM9DTNGh
         /GsW0hsXGhVgphWwfAHYDENnpHOVPwZvkmYGjNFdozkGV/SqJ0aDzGcC39dGvqXxbmO4
         Gr7ctxQShOol8aamI55JCoM1owBlGjlcaEFSFIqjcPmxn1kx3/Apr8its9OUkJzLNMBV
         QrVb3iLwZbYenArktD/qyzcZDpPuzSnBbB+s0NdZi2EKdvULCTh8edZ4X1SaMeK6rpWi
         YzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555496;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nREoqFw6z0KXEqgbCZwvFTJ9ZsIiVHBPjPD2RGj8T/0=;
        b=cHrInJpq5I9HVQ02dayDuMvQYwbLIJosW4rJf8ezyGETPs+6SCmiimfA3GDQg7jO/j
         gu/YgtU3yJO05iC0420zKyxRssdUE7gCM8uhiSZbd3/o40EYYrZ8WgViQZffIEOKyUiV
         UjpO2CEejeCr1zZxV+eMAIF/Afe0jJkPH96HcaZu8LHPnsy3hh3bL5mr/hgNAItwowsy
         ZiY7NhXSWlRxPI/aJxc0NaI3ye01lxTJaU4ZSEpoZ3T575LI3mHi9D44eYSCURw72BJ+
         EE/Z6ji71IHJ0otyRaNMFDVYqPqImhbCgEfC5LFW6cLb53eLt7WXbklTiZ8odOavg6M/
         JLqg==
X-Gm-Message-State: AAQBX9fBauYcZkC6MSKlGPc9yEY3fSzFcpOHoz7hHlk9dtnqyEDv11dB
        xtoySEWloyeP3VKcQSPAt30=
X-Google-Smtp-Source: AKy350bFMDxwQrSVLwVvp+ssQGcE3nifRY+on2Z9YYQ6rbbjuhBf4MRQV1/nIVs6xweJQdnHcfqJ0g==
X-Received: by 2002:a17:903:1d1:b0:19e:ecaf:c4b4 with SMTP id e17-20020a17090301d100b0019eecafc4b4mr477059plh.4.1680555496348;
        Mon, 03 Apr 2023 13:58:16 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b0019f1027f88bsm6972200pls.307.2023.04.03.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:58:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [RFC][PATCH v1] write-tree: integrate with sparse index
References: <20230402000117.313171-1-cheskaqiqi@gmail.com>
Date:   Mon, 03 Apr 2023 13:58:15 -0700
In-Reply-To: <20230402000117.313171-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Sat, 1 Apr 2023 20:01:17 -0400")
Message-ID: <xmqqilec4ra0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> Update 'git write-tree' to allow using the sparse-index in memory
> without expanding to a full one.
>
> The recursive algorithm for update_one() was already updated in 2de37c5
> (cache-tree: integrate with sparse directory entries, 2021-03-03) to
> handle sparse directory entries in the index. Hence we can just set the
> requires-full-index to false for "write-tree".
>
> The `p2000` tests demonstrate a ~96% execution time reduction for 'git
> write-tree' using a sparse index:
>
> Test                                           before  after
> -----------------------------------------------------------------
> 2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
> 2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
> 2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
> 2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%
>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  builtin/write-tree.c                     |  4 ++++
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)

Has the test suite been exercised with this patch?  It seems to
break at least t0012


