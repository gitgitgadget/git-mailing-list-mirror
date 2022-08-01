Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA6BC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 12:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiHAM3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbiHAM3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 08:29:16 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5797393639
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 05:08:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tk8so19921325ejc.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=xunIkNRPh8T6P7yazWhHS+yVDCD5IMAZpOzdgMFeq00=;
        b=d72ScSKQzFfhCQ02RWaeN/fhOwJhNpJ7Naps+ZEL8VNVYFL6tZyymWTD1zkFCmWwnj
         YcGU34qKDBWR4YlyM5rQMh75agUBe2qe9PRtKMeagXspNBWfv+bhY1F+ytSs77HasRUw
         779FOkxnDbohwT9emTo0E5D8zWzu3jvax9zhDDQTzxVKiceRHBC9TlWTKHGRNu5IoolM
         lsY3dtLwb0M3suQeczOP5OHB2hb0UCcQB553KKzOgMXaiUiHCspzcVaCVuB0x6tOiA3B
         fORLcVpi+CVnAct/n8/XX6BDahHsEocW8ULXE42ZFpLYd8IhXJkSXmkgrf5SC+QKYx5c
         ZT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xunIkNRPh8T6P7yazWhHS+yVDCD5IMAZpOzdgMFeq00=;
        b=YluzypeVwzEZxgpd3Jjc9BD2SbyxPHsvjbY/URH59MigjS7J/pIL3PNDMBQCCrsNR5
         S8xZr58OFjpXhtjADZJ3ON7vtWLv5cu3lOeFI4Ve6rhUHsRKp+ErpT5wBye5O4jrAnb5
         zy0hhFc8mib/J5y7Hh2eG1olKfp6ugWiAXD4CctTxdfs/VZb6UVHvir84mvFhcm5MNIr
         yYYIf+rCB3fNN9Ksp+6tcggzCxkwZyo8dHXnvLLJqFiP55GTsisG1++7cYQNVbuIVVHt
         53yBFP+lTxfFOitt2w7jcZJHw/kuj3U1maYWIghGK8HtefCYVbMm6iyVZgHBIbtKUOkP
         4ysA==
X-Gm-Message-State: ACgBeo2/v/WnrlzCeGWi2EXy7dPUrVpayAzorfcIQZRRMONvN4aGOzJd
        G2JcrUIInf+jehsh/j3UJgs=
X-Google-Smtp-Source: AA6agR7G0IPeUGsE52o8zVyt3DgWrtXqo+0y1uyG8B+voPfWuT2xxLh7N0zhvd0X9R3nckO7ZTiLwQ==
X-Received: by 2002:a17:907:9810:b0:730:4b90:983 with SMTP id ji16-20020a170907981000b007304b900983mr8000499ejc.106.1659355707624;
        Mon, 01 Aug 2022 05:08:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906308900b007304924d07asm3060156ejv.172.2022.08.01.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:08:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oIUDi-008lz6-6N;
        Mon, 01 Aug 2022 14:08:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7] submodule merge: update conflict error message
Date:   Mon, 01 Aug 2022 14:06:42 +0200
References: <20220726210020.3397249-1-calvinwan@google.com>
 <20220728211221.2913928-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220728211221.2913928-1-calvinwan@google.com>
Message-ID: <220801.864jywi2th.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Calvin Wan wrote:

> +		strbuf_addf(&tmp, _("Recursive merging with submodules currently only supports trivial cases."));
> +		strbuf_addf(&msg, "%s\n", tmp.buf);
> +		strbuf_release(&tmp);

Aside from anything else mentioned, please run the "static-analysis" job
in CI (or coccicheck locally) to sanity check patches. The "seen" branch
is currently failing on this & similar API use:
https://github.com/git/git/runs/7587382291?check_suite_focus=true

Per my previous feedback we should change this anyway, but that would
have shown that doing this particular thing is better done with
strbuf_addbuf() (and actually buggy with strbuf_addf(), if we had a
vector where format specifiers could be inserted).
