Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE87ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiIAMfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIAMfx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 08:35:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81504A1A59
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 05:35:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so22342623edi.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=uYsGNJR+5tCNZtxFG9ZUk7JnjWp1Ge3Uj7q83JLR/q8=;
        b=Y0LuEVa4od1Z74WlT5DDDUClS47VfMr6aKBYcfbUeF3oQqEYsQFKX2Tpbr+TRbkwy/
         /LrgLTZmBihcgmmA3RVPaYLm9izPb6tdq+KgnELve68Qg5P1wLq43GDQqVoJjo1XAw7O
         QDTCx2A63jA4IcjtVKlaGOlyECRKvYbDuia9IPfuii5U3xNo/IGj0cOkbz5axzUK6TIK
         372/NP4SACvbRQC25bjpmq+0OzEIP80PkVSFS1+s/oLF+VGcmqgMdQcNxJSJiyt/dsED
         p82c3f4toWfSX19desYCplcy5Fx1ylN//GA8VfSccrc3CraPfD/Axvc0XmxK9x9waEHn
         aK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uYsGNJR+5tCNZtxFG9ZUk7JnjWp1Ge3Uj7q83JLR/q8=;
        b=MrAVcrE6tAh3ZXgQ4NX/Sb5m6eVgva2LOxqODnO4x3txjBUqNL19gfa60WDXvdL4cM
         eViiuLcSNXvpfN/tL5oFNVRDf6FWbFZSsj2efM6fzxn58MNzr9cN/yfq8G68JMJYvdHt
         h5buL2AgetHjF8vRBsi0SFc+NXW1Z/KTUMDgN5eAFT+44kWqTvelrYpAcCGOfQenA35O
         NztYGPVlk/gVIkQemnxHeK7V4gLTd2uTKgtWJpcBHksapF/yQl1txkYvKAJST7CRvbCZ
         TfN3OId/56OqrZFoDb8g8ZVeM93egVC0gER3qrcgGLEQmmlc5tVTzV7+4DcLmzz4xml9
         0coA==
X-Gm-Message-State: ACgBeo1oZvtfowFsoYHCVkKm35S4XssAj/q+o4R8WC5R2aSfx4NuiqZF
        wGmw+lJ6sNMkccJXrJrTvi3PBAC+UPG5qA==
X-Google-Smtp-Source: AA6agR6Z/C2pXWyzeEPVfezFEp1Ljj/ISAtn95fY6n6ctVrE8E7u80LRCfpFrP0NBcbLb5ivf119Cw==
X-Received: by 2002:a05:6402:2901:b0:448:3a53:c206 with SMTP id ee1-20020a056402290100b004483a53c206mr18922183edb.323.1662035749625;
        Thu, 01 Sep 2022 05:35:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lw5-20020a170906bcc500b00730a1c73288sm8322338ejb.49.2022.09.01.05.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:35:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTjQC-0009oQ-17;
        Thu, 01 Sep 2022 14:35:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/18] chainlint.pl: add POSIX shell lexical analyzer
Date:   Thu, 01 Sep 2022 14:32:49 +0200
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <c1042b9bcd94b9ecb0bf73dfbd4334b9f30ba99a.1661992197.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c1042b9bcd94b9ecb0bf73dfbd4334b9f30ba99a.1661992197.git.gitgitgadget@gmail.com>
Message-ID: <220901.86fshbjmqj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>

Just generally on this series:

> +	$tag =~ s/['"\\]//g;

I think this would be a *lot* easier to read if all of these little
regex decls could be split out into some "grammar" class, or other
helper module/namespace. So e.g.:

	my $SCRIPT_QUOTE_RX = qr/['"\\]/;

Then:

> +	return $cc if $cc =~ /^(?:&&|\|\||>>|;;|<&|>&|<>|>\|)$/;

	my $SCRIPT_WHATEVER_RX = qr/
		^(?:
		&&
		|
		\|\|
		[...]
	/x;

etc., i.e. we could then make use of /x to add inline comments to these.
