Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FACE1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941614AbcKQRmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 12:42:01 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33741 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936557AbcKQRl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 12:41:58 -0500
Received: by mail-qt0-f179.google.com with SMTP id p16so137293546qta.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4YzvkPR03IhcGqwCRPL9saykK8TLRH9AcTj1vIfwlOE=;
        b=YlQi8TMJ4p6UR3eSAdTN1ezXiBvqS1PUuUUWgL8E0miP5nnj9czE2wdcT25BCzLOsM
         xhWCPd8WoSEJ46qkniiZS4mV0LjrhHJvJSCRLAFYm80dQ3Z21vyJ6Iiv3b7o853xu3AX
         b75nvLtiVRPGEO+kNhchohUwXCHWNA++ACbVzFiuMW4rwajwwnpA5hgvRWyClMz26bVZ
         lmqHuHB0y4PNAwQvAtF4rwenHN1ByVzcZCzEjq+Vm9YgFOAmFzkR8LrpetDM/spm55Tz
         2JCjKNneETmJxxOaTWOHP5yEl3L1tvDlFE7LIuKb8AVOkNCDGAw0sC0ho6hmhoZ1VUSt
         c2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4YzvkPR03IhcGqwCRPL9saykK8TLRH9AcTj1vIfwlOE=;
        b=QQssVbMg2kSqMybEJX2M5NFj45XpazvLMIIyBe1qtv7e5VhNGfFI8H6HDFquFYjmoK
         /1rmKxO4lORd5yvAN+Hlr1ZFVka5/IBPRIq8zrwVWkzCTNWdvCZqboaRVTc86Vf33F9V
         uG+FKrtAuuDCUguPqPZ5SjXL+whuElfUHCjmG3fKYnvPPycggTQQs6ohFjRGCyYftG8D
         kkwcYa106UKMYCFQW2+EDCWuJWLLquddSD3ITWY5MkEg8Ay5wVYXAE/k4GjeoX4+ReuJ
         oo8vohMVNzgSMXfZaQ34Jyg497EiiASpsAzogX+kuuX/8dfQ9itzTtv8Uv17Yt5gVLje
         i5eQ==
X-Gm-Message-State: AKaTC03w+bnuvbu0R4V1g5OnUc3yiQIKSKe/6ZhwaXFyHgdK+Z5Qhs+lKzSH+bbxBfRGgVy6E2UGL/XScG+fJ6Ls
X-Received: by 10.200.53.9 with SMTP id y9mr2849086qtb.176.1479404517452; Thu,
 17 Nov 2016 09:41:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 09:41:57 -0800 (PST)
In-Reply-To: <cover.1479308877.git.hvoigt@hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 09:41:57 -0800
Message-ID: <CAGZ79kaSfPicBj9Re9+kLuF0Y+K4T8M-k+O8y1r9QNS-bX36vA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Speedup finding of unpushed submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 7:11 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> You can find the third iteration of this series here:
>
> http://public-inbox.org/git/cover.1479221071.git.hvoigt@hvoigt.net/
>
> All comments from the last iteration should be addressed.
>
> Cheers Heiko

Thanks for this series!

I looked at the updated diff of hv/submodule-not-yet-pushed-fix
(git diff a1a385d..250ab24) and the series looks good to me.

Thanks,
Stefan
