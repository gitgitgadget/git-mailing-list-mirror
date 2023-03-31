Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EDC761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjCaPkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjCaPkD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 11:40:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D520D9D
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:39:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c4so4784760pjs.4
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680277196;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUdnZXGPuKRSxmSykDVGpflzKODpBcpGZ1v3tHci8cg=;
        b=n7XFhiuQD8Ps96qQK0TMgfRUDtP+NNf+ZloMupbZ3KT0G3aEvmw+BD+1U/Bku2Su0B
         iCZLWEv13QvFP7/WkaNjyuaYmc9aEdhVTdHPFuAZN+o4bV4xFUhykZdEFIWbkAOUy7uf
         pHsbGzF2bnYibsQqmiWkCepLvTFxUmBCbE+pLhTMA3OyXf49Hghwd9+FWG9rTVyI6wMD
         JEUGJ9iqnwf5rvN7AZDLKcRQorz/sEZnMtfAJUfeHnpYJlFM2yjNTVAdxpTp8g1hwmKf
         bvdIepwC14GqYDJ3zSDxksllDOLicZmaKU7qu505M2tgp1rhRc0h74hZDp1UazKBDa5F
         ONNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277196;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bUdnZXGPuKRSxmSykDVGpflzKODpBcpGZ1v3tHci8cg=;
        b=Nk7MAlNnhoG4uNzmoS3zT1FXRQaL+4q48eTNh0/3OwL08RvJuK98kAP30oxgg1T34u
         YqK8TlLjIEuLRo2RNmSy8PrZZ0VPiX7EaIfwSVZCIbYy1boz3/5eZdR1V/oDQx+u9dJq
         KvWoQQRefNwxN3vh670KStJasTlALTfIaPL+L6n1f9WKt2KcNefaTq/tMJH/LqZDLay9
         ZiNCUyw/4YjYOMVRga9lO5KZRQGgqXhc0FaGO0cQgxOkYSlBBjM5eD4dbSJpvvK6tYJo
         59tjgBOPMqiLHXFy42rR4ovz95dBJ40b7vY+sPWZk1BfwLgoQgSov/ylNT9IqEZ0YV6y
         lzrA==
X-Gm-Message-State: AAQBX9cc4h3pyTHavsGrh2XM5Agq0Tb0MhiZvsS9JxjAkbZc3ptLYIUW
        64Q1IUKcttdZhqiCw3S7odQ=
X-Google-Smtp-Source: AKy350YfXjbqD+8RmmOJkbda5mb1MtF8kKbaSwAPG1N/QEBlFpbNPqxIBR5ldbbFlUnlHj0Rp3rh/g==
X-Received: by 2002:a17:902:d2c9:b0:19e:6700:174 with SMTP id n9-20020a170902d2c900b0019e67000174mr34723321plc.25.1680277195855;
        Fri, 31 Mar 2023 08:39:55 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0019f1264c7d7sm1728918plb.103.2023.03.31.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:39:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5563: prevent "ambiguous redirect"
References: <pull.1507.git.1680245525637.gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 08:39:55 -0700
In-Reply-To: <pull.1507.git.1680245525637.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 31 Mar 2023 06:52:05
        +0000")
Message-ID: <xmqq7cuxhqus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> (in fact, the `printf ''>$CHALLENGE` is removed because the next line
> overwrites the file anyway because it _also_ uses a single `>` to
> redirect the output).

Good eyes. I also wondered what that empty printf was doing.  While
I suspect the original intention was to start from an empty file and
keep appending contents with any meaning so that the redirection on
subsequent lines would look identical, I do not think it is
necessary in this case, primarily because it is unlikely that any
future change will swap the first line with any subsequent lines.

Thanks for spotting.  I was hoping that we could soon retire the
"quote the redirection target if it has parameter substitution to
help older bash" rule in our coding guidelines, but this example
shows that the world is not quite ready yet.

