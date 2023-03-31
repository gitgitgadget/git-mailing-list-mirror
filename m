Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF68C76196
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 16:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjCaQi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjCaQif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 12:38:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75D2441E
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:34:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so25968335pjb.4
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680280481;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUUryq4kbE3Nb7UAIBcDcycSEml656rderrKtCQ7jn0=;
        b=U7CV7i75hA5E6J+UriYyaVT0IH55YZLaywgd5QrX/w807kWM2tbzpG6YHJgENsSwsD
         jCryVeIojFwEm7O7JUD0QQROtBrUrlb3H/32lQEscwfdWKbUfL8BenZsj2EAiDco4/zS
         0OHSRdDm4N2by3LWyT6T7gnE8vly+nD4iY2T0kVZNWvnaJZj0smxh/0fN9aLEdgaKvFh
         SQ7i9jvI/YOqUNEQMyz1iAq18rXtHr6Qlc2+cZkUw5IiquOVk3jOzTSV1mpdtOxlkWLv
         8YliMnDTFSIvLqGIiZYgw7I01gHtf1HLxGeho6BSFnwrZxg6cW+nC1t8oDz8cghdCO4f
         6PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280481;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUUryq4kbE3Nb7UAIBcDcycSEml656rderrKtCQ7jn0=;
        b=OTZXRGGxGH2vQQXvliugKz3ZD73VOH+Bhe3XYZEK1a/JxLUD7ccD9BV3RT+rCCIaR+
         8c6SlhBWUsMl1ESg8dTUBpDc49wtzNTUKKj9heIjik4EBbpfY4sTLvBSJoMuSMsxrKAo
         76ZnhBkhsFB/8KTopw2J0R08LjcCFiKMbTf91tD5ND6rcA6CCucF5C7xWDVOfgdKJq2q
         IPFUfHRMbqBIwCXgnvZxy3cA4n+NZrb43cj9nnxeolJ7tEYCm35qS4f0nWCc/QgHZNwh
         VSFoKjJ1KwSwoKb7tmAB1XT1y2lpoz30dqm7cFiFZOrWtUKF8XDUW8wd0rrlzsNGb2Uz
         1HCw==
X-Gm-Message-State: AAQBX9cDzG8u0YJ3L/5I7WO+pVeX/3ZerxEEHjD/B/pBwhc4g+9x8Kkc
        Tq8OOVMmdZvEoYeGUkRs+L4=
X-Google-Smtp-Source: AKy350bY3bmtPggooYS1OEAfmgkjPVgx9NuZQApm8jij0atH7fmuXiTx6wzcQ7+PMLNrqGNDjlQSBw==
X-Received: by 2002:a17:90b:1c0c:b0:23f:78d6:b5cc with SMTP id oc12-20020a17090b1c0c00b0023f78d6b5ccmr29573681pjb.38.1680280481200;
        Fri, 31 Mar 2023 09:34:41 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id bh9-20020a17090b048900b0023f9782333fsm1713738pjb.13.2023.03.31.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:34:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Raghul Nanth A <nanth.raghul@gmail.com>
Cc:     vdye@github.com, derrickstolee@github.com, git@vger.kernel.org
Subject: Re: [GSOC][PATCH] describe: enable sparse index for describe
References: <4f2fda36-111d-5bac-2322-1ebb3e508e4d@github.com>
        <20230331154329.121958-1-nanth.raghul@gmail.com>
Date:   Fri, 31 Mar 2023 09:34:40 -0700
In-Reply-To: <20230331154329.121958-1-nanth.raghul@gmail.com> (Raghul Nanth
        A.'s message of "Fri, 31 Mar 2023 21:13:29 +0530")
Message-ID: <xmqqzg7sg9r3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A <nanth.raghul@gmail.com> writes:

> Add usage and performance tests for describe

I think the commit is better off without this line.

> git describe compares the index with the working tree when (and only
> when) it is run with the "--dirty" flag. This is done by the
> ...
>
> Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
> ---

Here is where you describe what got changed since the previous
iteration (and following [PATCH v<N>] notational convention would
help people to see which one is meant to be the latest).  These two
are especially helpful when you send more or less identical patches
in quick succession like within a few hours.

Thanks.
