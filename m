Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9716BC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiCGQDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiCGQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:02:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5028EB72
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:02:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so15097729edc.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Gw+iLcdSysu8B1ltV5KnuZ94GvvQ15gO688o8j+Qmbs=;
        b=T2QnI2lw+ICjoqyQP+Y+ZHsrgS54XqtZcfTk2le2butAASc06lYnyX1MttGsXC3QpH
         zxaT1SSCyuYyVFpatQJBxvH6kQ1Dz7IBWWIWQveJNsb6rTa3kiHRtNTcIfzLCyFTLDaM
         sSsITYeP91yNAgOgR8cd/LSjXACaXcAFUMKIdNOU5kr7Ek5or6wEUy8NKpo97uO3xgok
         hzJb8dgXj/Hy90SXaHedDUoWOk+TNFl4On9QpKwr5TXORHsS6JCt8Uskyz0NCxV4tvOW
         h/eSsJEq16UIaLpjatgxtObjSyeTqJ6jDRfHWjsp5NYehFE00sIyTcH12SAi6v2JRb7+
         CB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Gw+iLcdSysu8B1ltV5KnuZ94GvvQ15gO688o8j+Qmbs=;
        b=ZEYw59UHvbPz+Owh1GmDHB9VFcIXGWVTFbiruCrLl1cwQcN+tGwfonsENGN1OZGiNZ
         s9uAaeUo6gFRgS6XepyyGNORoxdpfl/dCdhYUvE6yMzRl8XFS/UyTHzEN9zIM3HJ/rXD
         kUGcNg0gR20w7HV4pJbNXXgPYT4FMHWfvORz/8iV5kvI60DDwXS9L3aHnLdgoNsj0aD7
         XWdWtGYk2kubsUvPG9NCmEsKbotCWdR5pLAoqC2Y5K2EgADDJalN+B06oz5kwGgFtkUl
         bqfR3WMjMEk3Fj2mf11EoZ6kcX+H+/W1puVxEBBPs4HofaZFpH34CFiF+eiWWyFLeqYU
         kkZw==
X-Gm-Message-State: AOAM531GAmAcJIDQ+2zTsSFPKpgGN8ocVSpblF716+m1H7mTQ73x31a6
        vvBj5DygmBeO0QjDAmANjAbXOZ8ydD6T8A==
X-Google-Smtp-Source: ABdhPJw25AnhzLA4JnPFxJ8YS94Nn7rxE2QlnrWnmbp2BC7gzZpb3ZvhEAkcNcLvtl98E30wbQm1lw==
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id i23-20020a05640200d700b004130673ba2fmr11571480edu.29.1646668918612;
        Mon, 07 Mar 2022 08:01:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p15-20020a170906784f00b006ccb9e1278csm4848420ejm.6.2022.03.07.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:01:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFo5-001aem-GS;
        Mon, 07 Mar 2022 17:01:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 08/11] bundle: parse filter capability
Date:   Mon, 07 Mar 2022 16:55:17 +0100
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
Message-ID: <220307.86y21lycne.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
>  static int parse_capability(struct bundle_header *header, const char *capability)
> @@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
>  		header->hash_algo = &hash_algos[algo];
>  		return 0;
>  	}
> +	if (skip_prefix(capability, "filter=", &arg)) {
> +		CALLOC_ARRAY(header->filter, 1);
> +		parse_list_objects_filter(header->filter, arg);
> +		return 0;
> +	}
>  	return error(_("unknown capability '%s'"), capability);
>  }

[Something I should have noted in the other reply, but missed].

Before this series we just had the object-format capability, and now we
have a 2nd one.

As before we'll return errors un unknown capabilities.

I think it's worthwhile to stop here & think how we think about
cross-version compatibility between git versions. I.e. we're not
changing the *format version* here (nor is it needed), but just adding a
new capability that older gits won't know about.

I don't know if this is a case where older versions could limp along in
some cases and still unbundle these, probably that's never happening?

So probably nothing needs to change here, I was just wondering *if* we
had capabilities that were optional in some cases whether we shouldn't
while-we're-at-it give those some prefix indicating that, and have older
versions just issue a warning().

Then have them just try to call index-pack & see if that worked.

But yeah, all of that probably isn't applicable here at all :)
