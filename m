Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC4C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 17:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhKURyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhKURyt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 12:54:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C25C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:51:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so66364409edd.13
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HWqN8LYzC9H93VucYiDt/udnxH/dAl+2Jdlr467ckqI=;
        b=WXQ6lJHDL3PIZ83aUdSvRAda+LlczdOk0WhONbXBcuOlEQFQkQqYUTKrbNkn6Zq7TH
         2OoUt8jDIsj136sfs7wHWRSZPS0DLN9aDAOBSJ+Xy81eq4qNCaiuG1sWG2YpRpuIclFN
         couAD06tqCt6NOzMVJeHeauZ/UmFCZFGBOfbLAUs505o2pYNH6D9Mywcigb2dnDSbJq/
         jOTKu4z/ckE5fNycgoIBz/qwbC2ULO6Qo08GVxbFdn4U0HjtLQaGQTzeSBHjjZ2H9gQ0
         Pnvc7s/MWdS64lWEc9EiK9Kw4kUFR4y+HCshxw2jm1nbKSQ4gQiUEK6dz86axfH66mdk
         OPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HWqN8LYzC9H93VucYiDt/udnxH/dAl+2Jdlr467ckqI=;
        b=pAnKZrSoHjz6wKEZGyTQvf4QWPEuGg+Km6osv1Oh7CLUbsfgygPwuTGU6POkD+qknz
         QRpq6cg2yv+PEw0+sVPi1vqoAEq/aM5iiSwMIXg0MLK01KP1zpnQg21QHSXdn4nVYNK8
         32rRcF6TSBUrmtBbrydIGrGrIB3hQeRxyYkK1ROPxWy3Vnr67Umtg3C8ZM2MrkbeCduN
         gXRJdlZ8Hc/cHpKpCTXQTiGg6TA+4+hy8sVbUH2Ckm9egmCfUKUwyUbFaPT8889odZoO
         2vqCEccpJR5R0lPIMzONwCEeqczIEqB1yhfrPz4ohosF4TkIUh1R7C8tJEKmygCfkO9w
         QzhQ==
X-Gm-Message-State: AOAM533rphcGx2XwnUuEb9T59DHz1xVeWsK4eGLA2z3nZIgtu32LSkQf
        /dNa18m8jt60qoJy+Qw4YS8V9AHD/40=
X-Google-Smtp-Source: ABdhPJzzb/DG/wFBiNs49sFBi4rlb6kFdYOUnmIDakGg/2o7r92l8RvJ/mvf+aGdHWqv+ox1LWkC7w==
X-Received: by 2002:a05:6402:1453:: with SMTP id d19mr41521929edx.388.1637517101626;
        Sun, 21 Nov 2021 09:51:41 -0800 (PST)
Received: from gmgdl ([109.38.153.63])
        by smtp.gmail.com with ESMTPSA id q2sm2799332edh.44.2021.11.21.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 09:51:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mor08-000wfI-ET;
        Sun, 21 Nov 2021 18:51:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/8] clean: do not attempt to remove current working
 directory
Date:   Sun, 21 Nov 2021 18:51:12 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <69bcaf0aab28fec145742f7183b1d89b12eaf0f9.1637455620.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <69bcaf0aab28fec145742f7183b1d89b12eaf0f9.1637455620.git.gitgitgadget@gmail.com>
Message-ID: <211121.86bl2d1jo3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:

> +		int prefixlen = prefix ? strlen(prefix) : 0;

nit: s/int/size_t/
