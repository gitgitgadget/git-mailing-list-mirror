Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC6EB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 22:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjF1WXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF1WXa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 18:23:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E905D2118
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 15:23:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5734d919156so236317b3.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687991009; x=1690583009;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EIw8wKlnxO6cMYvhMur6cz4YehA2WXjZbpIYQW1w+RI=;
        b=WGJKBPy7WdMWGZhVl5i51QfAX2vpiJrCvaJZ2PaEE2XtyQ/0tAn0VYwZDQWehNpVTX
         07Lhq2BY+63lYYKlUtf14N53/Mv8YpqsXg+g8nx6hCFjka6IWWrZ6KuWjslWl22FvG3S
         UFOr4mwgNwa7EQW77QPC+l3QGCckyMvmy1q/uAzbSFhytr7cVyvIZnSr8cFNvCmsV+Nj
         mJji5sW9Gwx7S7LDedjm2hOj1Qupz2Cbpxad5YhbGf8H6mTbQp/j2MVmBo834S+oNq9G
         jOXoZrQjt7BdUfaXv4NCAK2ghsNRZdsxTOO0ULtQWaEXJRk/EAk9F8jJinCts5lpb7G4
         uCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687991009; x=1690583009;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIw8wKlnxO6cMYvhMur6cz4YehA2WXjZbpIYQW1w+RI=;
        b=D/cSNIgxErPI1q2ia3GgRkYAHYi48RcDI7OsZ+fuZRS4WuYq+I/wQYUpOmYgUpAorV
         Ob8YX/w2yaxJCbwMRSVwmAdBCnr6H5Zpjza81xIdx8xpgrN7X6ctwFuroJz2iR9PF4PY
         2s2b8n5cFq9Lut2WFWwr+Kw9LjErnBHOLDLRn/FK8SN8Unc4ccs4Sa6J/f29lNyKbFgZ
         KrOFJD6cUC6QkSSyvaOl+toydgmrbNDt8ty4uSxzO7jbjrgj359yC9PMgdPxbjdjRcyt
         Cs+8K+Spp+d56ZtChM8F6FWzVH1Nlc5/LAwh0IQgCfGa9FY67M4lkmCWnGkc2TXUKiJW
         1Bzw==
X-Gm-Message-State: AC+VfDw7L6snHoBk1SDL9KqNBQDW7hCFVED4OJhfPzfpHmAvgqtVHF0M
        P0hA+SAaLb0HVNWIsYSu0J52KGmDSvJJUfZBS+T8
X-Google-Smtp-Source: ACHHUZ5JC4goNFnth+6rciO3QmFjwAI5n12XP585wqunZRkY+Erjk7ksN9H1BClQihylSMmZAc3ghB/hgRgFu/0XoJJq
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:4a69:b04c:7449:8793])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af0c:0:b0:570:7d9b:9b16 with
 SMTP id n12-20020a81af0c000000b005707d9b9b16mr14198587ywh.2.1687991009110;
 Wed, 28 Jun 2023 15:23:29 -0700 (PDT)
Date:   Wed, 28 Jun 2023 15:23:26 -0700
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230628222326.116535-1-jonathantanmy@google.com>
Subject: Re: [PATCH v5 00/11] config: remove global state from config iteration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> As promised, this version addresses the comments on v3.
> 
> = Changes since v4
> 
> - Squash 6-7/12 since `test_must_fail` doesn't catch BUG()
> - Move a hunk to later in the series where it belongs
> - Replace a memcpy with `*a = *b`
> 
> = Changes since v3
> 
> - Rebase onto newer 'master'
> - Move the 'remove UNUSED from tr2_cfg_cb' hunk from 9/12 -> 8/12. It should
>   have been there all along; v3 8/12 didn't build at all.

Looks like all my comments have been addressed, so this patch set looks
good to me.
