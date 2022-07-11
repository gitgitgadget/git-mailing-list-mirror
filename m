Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E08C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 03:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGKDvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 23:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 23:51:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1216583
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 20:51:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x184so3767133pfx.2
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbiGgrTA+dgq4swPOPfDADRtBT2XoLXtQujw/z+GnoA=;
        b=Rl/KKET4utLYKuCr37k/UEH+TwvrS+3jvFhNXxm36l7JjQSi+WjxPABiC0hMsBgiLq
         qQDAdbip+77xwp8IURUuJLcpNjY8OAKzM7al5ZEG0AvfMDxl8UrxqQ9olLuxebvlIJly
         c6AaTU61m1Z2c2+wNj3OG5ApBhXvuHU+W+DpzTb1+Ft/WT1AknlxlM11/eZwBQ8F1vK8
         7BK2aAb5wMeVtW9PUmuOP4EMZgAQ/i3eZhInO3dZoHJMAWqy2Xsm+WtUgVPLRMG6hKgf
         zy8XxOoJob53s2pE6FkGAIKcr64/RO0NdIHk8aTpobKRyO6rhPDVoMqR2MESZv91rfO0
         Uuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbiGgrTA+dgq4swPOPfDADRtBT2XoLXtQujw/z+GnoA=;
        b=IpoDQAtmrCWSRI1VT5OaZmSjlroytTCIrbHujpwF9o0y003OdigNtfFxfCmpmfzICB
         BqTtzeZPhwm4YRTCqxxjp91zX4HsjBtce5f4RJKlOD9BqLdWfkjtU2mqSEZUGQNOSQo/
         6/gbWfZs5JkK35adpRu4hv/fTK1MpBoJE0rvtLLcjMlJF+d6pza2eICRx8wZrvn2vOrN
         jUGadTnZba4XJSfB7mxOXbDEQ+4OQehMR3IvkmTuhr8ABUpVzi62FKr9LS/Dspxqs5oh
         oWvj0rVDx51kQmgVJ3d6TADpqLgFjb7Y+cZufl9VC+17XZFRyNyRc7T73EXPEiOG7vRC
         Unbw==
X-Gm-Message-State: AJIora+1XLmbneECiRLMd1O5bW+gAnSTNY+QYYxHH1Ob/+ucMIbdDi0C
        Bc9cRAU50k/OujbBu7wdcXY=
X-Google-Smtp-Source: AGRyM1u/S1jOwtlHfxM05H/UX3/2Iol2JPNg3pRfcT+hZc/gw4lPmz+h/DtnrOlhK7LVLJ/2SuIyaQ==
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id c16-20020a056a000ad000b004f7a3576899mr16355646pfl.80.1657511508734;
        Sun, 10 Jul 2022 20:51:48 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0016a091eb88esm3478337plr.126.2022.07.10.20.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jul 2022 20:51:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 5/5] tr2: avoid to print "interesting" config repeatedly
Date:   Mon, 11 Jul 2022 11:51:41 +0800
Message-Id: <20220711035141.12793-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.g582ccc557c.dirty
In-Reply-To: <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com>
References: <220628.86o7ydf8gi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Is tr2_cfg_load_patterns() run at early startup, but this perhaps at
> runtime? I wonder if this is OK under threading, i.e. concurrent access
> to your strset.

Yes. I think it may have at runtime.
Not for that reason, for now I think it's better to dump each config and
scope name is a better way in terms of other replied suggestions.

> The assumption you're making here doesn't hold in general, some config
> is "last vaule wins", but for some other config all configured values
> are important.

Yes. Also based on the above replies.

> Do we care in this case? I really don't know, but perhaps we can declare
> "dedup" using the same facility we're using to wildcard-match keys, and
> either make that optional or the default, e.g.:
>
> 	GIT_TRACE2_CONFIG_PARAMS='*:dedup,core.*:'
>
> I.e. to make it a list of <glob>[:<options>].
>
> Maybe not worth the effort...

I think if we could print config and scope names is enough maybe. When users
specify such as GIT_TRACE2_CONFIG_PARAMS, no one will cares about the extra
few lines config output in my opinion, but it may be useful for some
troubleshooting, so in my opinion this may not be implemented in this patch
for the time being.

Thanks.
