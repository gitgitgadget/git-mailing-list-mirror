Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C4C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E65221D81
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW1qGpnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIINFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgIINEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 09:04:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B504C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:04:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so2846951wrw.11
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXDMTahRhzW3Oog5aBe8alRwRyfuoFGVu+R+eeD9HvY=;
        b=IW1qGpnVQugz0/+YRLLXfYVvqjZ9Cmot866bqK8yODk7wLCWHVmTqJlk5XfTo9lz13
         956LfC9CuEGHtmXFIsTQtxe2de65RHDDNhbpt2aUJAMqaUIGfaaxolzoAYkbXgwTh99L
         jrfQpdkI+QlGdV/s/Sq5tCcOgf+/ED7Iz55IIIOzjqQS467W6xKVV6nZy+ymir2jGrHu
         n4G3gqVgWaoQDnV9b0e8p0z9T0tTnSakJZnSth06Lz8x07TiyB9ijTvifBPeOkD4Y3Gs
         sA7XsG+5UfybYJZgXptzxjx2nrjWKaW3V8Zr5uKTlPgI/UojYMgzjeL9kBCwiGiipdsw
         JTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXDMTahRhzW3Oog5aBe8alRwRyfuoFGVu+R+eeD9HvY=;
        b=mOdZnjlKibP7nt5LYKGTPt6CO4Yb6I6/n462o+nFQ5egxGin2RIr8jK2DIDuIkSrXz
         amGUNvhboX/o40B3Oa015v7MjlcoUTEvLbOnTksMr78mKmwOBdUJ5HdKaCyG9qiZsxrv
         tSSF7/bHZa0fvk/hbOEm/SspZ83IP9iUtDrVuDnFpiM9rxJqh2iTeQsT1gm3Yb5YSxek
         FoE7tNcM+tX3h5buZAoZ2HcniZ6KRDwLZBXPRKf+YNvZ3AmrHVWFYxL7Nx0BinDkODbf
         KSfz/hIjaffHAtzF3FZhfO5PYuGdW0aYvKrfmbaesy9Tk+HT4Ede5EPmo3isqwe8Jsk6
         bE8Q==
X-Gm-Message-State: AOAM530xEBChiz76g3dzen0Yol7VpaTLOE6BN5QzUxaSy+sC0/Xijby0
        ubejiolmd/EAneBJOYTnCMg=
X-Google-Smtp-Source: ABdhPJw5KMTJp6+D5e2O1d2MvP3upKtAk2XMopy3Mq8CqRHRwFnKm4Q5WaIe1Pp9jUDNpPtj8Gnfjw==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr3774965wrq.297.1599656669761;
        Wed, 09 Sep 2020 06:04:29 -0700 (PDT)
Received: from partizan.lan ([46.98.123.218])
        by smtp.gmail.com with ESMTPSA id g131sm2790953wmf.25.2020.09.09.06.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:04:28 -0700 (PDT)
From:   Serg Tereshchenko <serg.partizan@gmail.com>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org, gitster@pobox.com, serg.partizan@gmail.com
Subject: Re: [PATCH v2] style(git-gui): Fix mixed tabs & spaces; Prefer tabs.
Date:   Wed,  9 Sep 2020 16:01:36 +0300
Message-Id: <20200909130136.39098-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909045108.j5ovnbk35cmghgcz@yadavpratyush.com>
References: <20200909045108.j5ovnbk35cmghgcz@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Thanks for suggestion about scissors, i was wondering how to do this
properly, i'll try it next time.

> I'm not on board with this entire hunk. In many C projects (like Linux, 
> Git, etc) the "switch" and the "case" are on the same indent level. I 
> can see instances of this in almost every switch-case block in 
> git-gui.sh as well. We should stick to the local convention here and 
> drop this hunk.
> 
> I can make these changes locally and merge them so no need to re-roll... 
> unless you have any counter points that is.

I have no objections, please drop that hunk.

--
Regards,
Serg Tereshchenko
