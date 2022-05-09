Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B48C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiEIRtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiEIRtP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:49:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A528B879
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:45:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 204so10078202pfx.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6xI3yhlIPdI1YQvOIT7Nh90Q9Te3Cke7dpnjpkH1Qw=;
        b=Wu1gustkVKpssIK7tSlRs5GsXjotY8ssJHaQyq7jScx31C8C1coU+TTSIb3ckHH3t+
         PnEr1eKdaCltZ7oF/6On/TCpkIYAT4gaRhF4S+3GmTBgkMMY0wS+rM+Xs8TgnEwVk6Tq
         tF1qY2lg7CGmfYViwgMEATioyGApKPeztvolITNyCDabKYsu6FBqWEHXTkIiTw7Ls+OK
         UDr2G12fxWrhNPiVXnp/kG3Wtqlgsn2P2vNTfIjcqPMwUJZ/czXUHzVGccclcCyHbkH1
         bbQEy4kGyyTG2Y+/5FdGelleSONKqQP6M8qgUh7ZIPdGMLyekOXvolXa4b4SCv4FvkpZ
         XEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6xI3yhlIPdI1YQvOIT7Nh90Q9Te3Cke7dpnjpkH1Qw=;
        b=wrBnScNRcWj/mUDw2BCkfMcK56mjLBUtnSYy+9WcPNEpmVd7y80wsKQbXqfdTIAUuG
         X6TTBtcUjkO6+O/tzjGh0RSztShCchshZy7oFiAv1qDcbnYfzIq9t1E5PMWPVQ9ezYIW
         BhBcoIfy3Y2PFMU3yK3jKw+HfcWAUfSl2cCzcnBfpMKgvKz+IwCLly6qly2BJgm4V1iC
         2xDL3keBcSBtKaPnJh18hK5jn5ZiStp+YgqA3Ye6ihCxD5sfttCLrYULPbTAPx1I0vK9
         AUdvWHr5iHDKIhekmT3xbl9vJIK69t5xrbfAzW48sVycm1SGoF+BeI4tJVPK4m07lK8i
         CiWg==
X-Gm-Message-State: AOAM532Q9VEPG0Of7u1L42k/mlT0p9OQsLvk531mWXFaKZCi4lmsX5mx
        MdQARYTb/kCtV7CTZMTuhgE=
X-Google-Smtp-Source: ABdhPJw/Hphj2xZp6D79qqYACuhkPiC83BuQXf1rGMZg4HWy9OEs17y/xxya0gRgTityVNmUPo2oHg==
X-Received: by 2002:a05:6a00:1d8f:b0:510:9397:65b with SMTP id z15-20020a056a001d8f00b005109397065bmr11073842pfw.57.1652118319640;
        Mon, 09 May 2022 10:45:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2bc7:fe6a:45d7:9aca:a60d:d904])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b0015e8d4eb1bcsm183461plf.6.2022.05.09.10.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 May 2022 10:45:18 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon,  9 May 2022 23:14:42 +0530
Message-Id: <20220509174442.28647-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Ynk0mADTSJU/xVUd@nand.local>
References: <Ynk0mADTSJU/xVUd@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> This version looks like it has addressed many (all?) of the comments
previously discussed during review.

To my knowledge, yeah, I addressed all the comments :)


Thanks :)
