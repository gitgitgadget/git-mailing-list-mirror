Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD93C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbiBOWEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:04:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:04:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88381EEE4
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:04:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g19-20020a17090a579300b001b9d80f3714so263100pji.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=rvz9Tx4cY3v7SdQvphbf4O+EBvFznwpIa8SLaQVDPAM=;
        b=Og+UA3fksTBxqnT3IK1bO2BLIuxKRuGuLN2hTjsnk45T7oCPwaEqc6AZ3JTtfENJL6
         KQ34oRzr6RlLUDOJRzXqgEXGJEwij1vn7edqkByDK62PCaUZ9uZizPCSg0FXuVPeS3Yj
         0TDJxYbPn54ytNv5hRTZFIvK0MrervGupGhG8+nroD9gZo+TIZJmJOs8NlzuhQDudssZ
         J4avdkBkcAsDrxcrmlh+uCmvp0k+V6y4xl/YtzzixiAGIwGpqD7qzmPtMm+4VQLCKVJ7
         oBeVyu4TNd6O9skUywsmklR1EwZG5T4lQeGgvzMGCcDUu2fqbklqySpodIQurSRBeT1d
         YCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=rvz9Tx4cY3v7SdQvphbf4O+EBvFznwpIa8SLaQVDPAM=;
        b=M8COKeJe40PeH7eY8mXT1iqq2OAa3tCm+EK1bjfJbLSRzq1DQLHrP/2BM6swizz8Ux
         1liOR3FJAR4quAOi+O44lWkuhqPmYRXYcWbDcthens5RU2mkUOveqoa/DLpz4uyxcLha
         a6/DVAjK8Yvo4Nqw6oCgLcGSdRaYyHyLRzByr8e2bMvU1zdr2QWQfilYE4Mq/sDSKxJh
         ThOrEdjtZ2taJFW5ArSJhQiMkPhNoqIgTFbX5ePP8v9Kzm0q//P8iHZkt9hyTFqylQml
         MVjGw40IVuy6UyeWq4UqWJCnndTtfIStm6kDeuV2qmqSo/3DX04qiTi51sqC+7ahBiDk
         0LYQ==
X-Gm-Message-State: AOAM533FcOfKwq4Cm1WEUGnAaOiG+wTJ8TgSpVJedEdd0uuA65NpteSG
        aLi+/H3MDmdP9WoNKS+eA2zdDj6ulqAyVnTjw7nO
X-Google-Smtp-Source: ABdhPJxNDUTBabXlOId5qEe1qkcQdlj2zW0I4pZX+1UWBnkBTqNbmqcCvmWQYpQgCG4g8BnkFFEnUgXceH5wfcBqDvNz
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:4e84:: with SMTP id
 c126mr959613pfb.86.1644962674275; Tue, 15 Feb 2022 14:04:34 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:04:32 -0800
In-Reply-To: <20220215172318.73533-10-chooglen@google.com>
Message-Id: <20220215220432.1634706-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH v2 9/9] submodule: fix latent check_has_commit() bug
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> When check_has_commit() is called on a missing submodule, initialization
> of the struct repository fails, but it attempts to clear the struct
> anyway (which is a fatal error). This bug is masked by its only caller,
> submodule_has_commits(), first calling add_submodule_odb() - the latter
> fails if the submodule does not exist, making submodule_has_commits()
> exit early and not invoke check_has_commit().

This patch looks good, thanks.
