Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3715CC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7EF61166
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbhDPPV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245712AbhDPPVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 11:21:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB3C061763
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:21:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w18so32796987edc.0
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iiIfn84OAPcE5clJYVZlUn5yooGaYuAPv99ZamRQT9U=;
        b=Neemh3BbWh3bjA7Uwc4UonPXnIN+2GFDE166OjxhTkK0WZpoeFNc59NrvygyeZ5QlX
         HjuzrgJaLFrdx0a7Y4lSiy480Oc7aLsyK9r4PLu528A8p5XRVcb74vMd7SlQ6L3G1qNY
         ksH3FxFBVfX+verdr/66E5qlZbQqD8PCmQ7Pjkm1tfA0wlGWgQOb8I4E7QBQ8nXAbMmq
         F9dNfhyfIj1fd+2XVZFX+1KttODpy+BAO0vaHAYRVOJ2pqIjfgx0I+23cMTg4IGVaC3M
         j1E9y4L1FDtfBvPcTAKPU9Hzf6dODGjz4LmcDKp/FL7kmrij8i2O5MKzlQqOaHsh1Clu
         359g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iiIfn84OAPcE5clJYVZlUn5yooGaYuAPv99ZamRQT9U=;
        b=tAezI+f7OxcRuCydeX6UOSmE+LmZfcqdVz7uNbTSIzoljkt+CG4c+ftd/PLUrhK+r0
         s/wM8oJGedBmk0dOiVDLanxXnJ+ChdW06K8YpcG7P4xKY/kL5I0DgNomj8Q9EDOgTiGf
         0AeiQ+Yrj/yXwEpbv7/Xxgo2KkGHnbPWvOxyASNjaMQhyrY8pK4GcV1gBR5L026bfV96
         Ul0QPAE+HW9IYR9x4hXsZ91gguAFEwlsdyqxEa/oQeNUIZ++6F+n1IYTJFYLn3KfKOFB
         u/FIaJY9h5NnjrhLVTtLljdEUB/NcGsAeh8ZMWk3fBXbB20BkdealrsIAEgXF9YJOhcy
         F+Ew==
X-Gm-Message-State: AOAM533fIy+1GZYoo6U4IDeXVuZQ4PLPw4qo/Q/Dlm1Lx1L4TY4Fu9/N
        ir1Oar7A9GxQBuKgnXvT5yU=
X-Google-Smtp-Source: ABdhPJzxPXd7JOXJK/i7i4/aXKcZx9/Bandtm8TPwBq4p75ghGxKQlRZQYqsT4q9EdKK/RPl3ruiMg==
X-Received: by 2002:a05:6402:154:: with SMTP id s20mr3471076edu.90.1618586478866;
        Fri, 16 Apr 2021 08:21:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w1sm5715196edt.89.2021.04.16.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:21:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 02/15] builtin/hash-object: allow literally hashing with
 a given algorithm
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-3-sandals@crustytoothpaste.net>
Date:   Fri, 16 Apr 2021 17:21:18 +0200
Message-ID: <87r1jatfv5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> @@ -103,6 +110,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
>  		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
>  		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
> +		OPT_STRING( 0 , "object-format", &object_format, N_("object-format"), N_("Use this hash algorithm")),
>  		OPT_END()

Nit: Carrrying the "0 , " v.s. "0, " formatting bug in the "path"
option, due to copy/pasting.
