Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C229C48BC2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C8B61992
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 03:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhF1D12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1D11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 23:27:27 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C97C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:25:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a5-20020a05683012c5b029046700014863so440753otq.5
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 20:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=7AlxVwaVga3Ij8VOiSvjIc4l1SbbnmL+IhB2cHunmSY=;
        b=eMW6ExoMw7yBRJdjjQ5eoKzjTWAPRxVI4ibh9laqRNo7YggvNbxoeR9M4/wWCaDchs
         Xdce2UdpXCvXV3ik4S6WEzuXHJTMdZRXra7HRlZUW4l9jLZ88JXatGB71b2s6PtdQ3GJ
         ftZ1cH2K0uI4+UJ0moQvrzX/TjszD/e/vk2h/1QlWTw4N0OqrcyUyWM2yNbmsIgpHqL+
         +JCxoDuZaQfJpMquWy7IOSVkW61g2Cz9/okFsIOzgLXCeYUe04Do6MwxlTxYYuT9HctX
         4W29WMj6dKkIruUhRFZUR/47wPz8FhuOWzbfZGR+eUnQT6HOwNWDtJ9pVGktIinCrGxj
         9IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=7AlxVwaVga3Ij8VOiSvjIc4l1SbbnmL+IhB2cHunmSY=;
        b=WwgZbdNk2LNzvOl6eVbBJyUx217LcQmI803X+prlDWmagzbf2EXydXnBsKXdH26SLf
         vSUDEqTZMdOZrV0Pcem21fjAxt+nGWjxcyX2Ma40yTa5Axf4UMik1uW71o3l/whmTxyC
         gvI37s07RNjduBxO8kLb7BO1rXXCT7gqI43OiRlkNDq8g0PFrMVC2TI3ZtACjabwwFWI
         41sHMeK/X/0TWRUKydNZEc7pa932CO0GmpTwEpnXKSF1RdX34e7ySQLgDQIHAw0xpXiA
         xJmb16uWqt4uq7rBs1fOLnRia8RaY+VqGzVr7wgkAprd8KF2EuQ6kXRs738zXl2FNV7+
         Awjg==
X-Gm-Message-State: AOAM532ZpIhb3wRu0kT0jplbpKPYO7m3bHC4jZqbowqNhrOU5YmuNH37
        9jxhWV7JdKXl9AkID14MN7YnNIXb534LRA==
X-Google-Smtp-Source: ABdhPJybEw06eFrMzF5zJKUfNaIGP9A4bMVH55kRis7sLbApYneL1nCn2ZHAxTWCeKvoAfbbno9q6w==
X-Received: by 2002:a9d:2649:: with SMTP id a67mr19740223otb.181.1624850701277;
        Sun, 27 Jun 2021 20:25:01 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id t69sm1861927oih.19.2021.06.27.20.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 20:25:00 -0700 (PDT)
Date:   Sun, 27 Jun 2021 22:24:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
Message-ID: <60d9410bb07a1_aac5d20888@natae.notmuch>
In-Reply-To: <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
Subject: Re: Definition of "the Git repository"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Buckley wrote:

> Everything within the .git directory "belongs", in my way of thinking,
> to the "repository", that is, the directory that gets created when git
> is (init)ialised.
> 
> For me, the 'objects", the 'ref/heads', the "staging area' and the like,
> also lie within the repository.

Does it?

Suppose you have three directories, each with exactly the same contents
in their corresponding .git directory, the only difference is the
.git/index file:

 a) No .git/index file at all
 b) The .git/index file doesn't have anything staged
 c) The .git/index file contains some staged changes

Do you really consider them three different repositories?

In my mind the staging area is where you put stuff in preparation for
the commit. The commit is part of the repository, the staging area
isn't.

-- 
Felipe Contreras
