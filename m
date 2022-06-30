Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47217C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiF3Kx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiF3Kx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:53:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BC40E6A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:53:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so25950078edb.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g/S1r95G4qGSJiFnzMs6pLelXPf5hd1KxaaX37hi6S4=;
        b=nbuQTMjuj3+EUCkiasSjlTlpX0zv2XLgHnUpfDheaHcrmOPXtAB9pJ2caJUUzJfjh1
         ZhKX0hinJvodO2TgTd/zMnh+Myo61iDfQ1LzRaT3GphrSAWFlFr0NUTkggZqPdz6snQE
         tNYtXOTmdEeSMSd8YmiD9Kp8U07rQcGrKoujfnJjLob/llJ5l7ebEhCom/dPlJ4ogkeD
         Q91yIQZz1zQvaWgsHUGtt0gqJF2EA/k4uovytXhv8x92AmlOu1TtU9D56LXwGwXQs8R9
         K9NAzxBK6h8qZASXamuOhBvfJcjCpFmsCCZZX8j7s3IZTOku7R1/zN26wmp7X3OngqE+
         rrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g/S1r95G4qGSJiFnzMs6pLelXPf5hd1KxaaX37hi6S4=;
        b=FVC1PEZzF/hx7bpHZE/VxpL2R00vYrFNGrb88y4ioV/iwf6SCuc00CwVIIuNqj790Y
         hCaAD4SHaAnsVyHeVciHkFOkzqUD/7S8LI9RZ53CVMxp4gqltLx37KTOTt1IK8a6avih
         3WTw2k7JzqQ7txusoujKoWDuhTA+AvI90XphUj09/X/5T65AgaflM6cgOw4E3jyJWd4+
         IebH1ECifl+sE0MjX8BgpnjTq++mMlEbzIguhyP3uW3vQwePjFeBL4Mja4LFYL7EqJ84
         pjKyfkQtJ71rOomrSKjScaw5NApriJQ4UuOzsHgxPJ24cKlFSQZEUj0UEQfIfdb3LEAj
         okZg==
X-Gm-Message-State: AJIora87hJ9l/B6ZbcD8JPNja5OVDp/inYyzl/i/H42MOQxf6EcKwe1i
        dN+VtQBAq783+MsjPKx9+qs=
X-Google-Smtp-Source: AGRyM1vkh6xiccdYw9OTIR9F9mXUjt0/29aR+i1S6j8YnVrJoskWE4VPnlmZdpX+Vyy+oQEW+4YKow==
X-Received: by 2002:aa7:cb52:0:b0:437:ceef:c15b with SMTP id w18-20020aa7cb52000000b00437ceefc15bmr10842853edt.60.1656586434372;
        Thu, 30 Jun 2022 03:53:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t21-20020a05640203d500b0043573c59ea0sm12596789edw.90.2022.06.30.03.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:53:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6ro1-002Fuh-2b;
        Thu, 30 Jun 2022 12:53:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/3] xdiff: introduce memory allocation macros
Date:   Thu, 30 Jun 2022 12:46:22 +0200
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
Message-ID: <220630.86h742e81q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:

> This patch series introduces macros for allocating and growing arrays in
> xdiff. The macros are similar to ALLOC_ARRAY()/ALLOC_GROW() from the rest of
> the code base but return an error on failure to allow libgit2 to handle
> memory allocation failures gracefully rather than dying. The macros
> introduce overflow checks but these checks are currently redundant as we
> limit the maximum file size passed to xdiff and these checks alone are
> insufficient to safely remove the size limit. The aim of this series is to
> make the xdiff code more readable, there should be no change in behavior (as
> such I'm open to the argument that these are just churn and should be
> dropped).

I think it's a good direction, but why not make such new macros
non-XDL_* specific, add them to git-compat-util.h, and then define our
existing macros that call xmalloc() now in terms of these new macros?

I realize that it'll take a bit more careful hacking in wrapper.c and
git-compat-util.h, but it would allow us to eventually make some other
low-level APIs of ours use such an API.

E.g. we have some hand-rolled replacements for "struct strbuf" in at
least a couple of places (e.g. vreportf() in usage.c). If you pull on
that thread you'll see that it's for no reason other than strbuf.c calls
ALLOC_GROW(), which we'll die() in, and we don't want to die on malloc
failure in e.g. BUG().

