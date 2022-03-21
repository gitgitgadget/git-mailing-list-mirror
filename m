Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A7C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 09:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbiCUJXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbiCUJXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 05:23:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A41427F3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:22:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h1so17023564edj.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MWtuzNkfIrj9bGJDHmxIz3MA3fq+HDnE1cpFrXFDXcE=;
        b=LmQZjqL6uOPMsxaieq/eEkIqtakVQ0A6zB2rWdzDpsccMp/XnBwge7jvOchKPw/Pj3
         5Vdfq8n6S9bHbd47VF95Vg6hpj5q+OhI7bJv+oB+nY2eni6xOgu3GW4Ax3i+RnyfLGZS
         kwDsnRSPqgqC0bbIZjWXxvFw0U37C2S3JrVNCraYq9fuKNT/df+xpQH+WtFS1IReyfaw
         NJVLAavv3BOSmFVXqqF9San/z7OC2he7i1RhGT1XFj17nbTH1lN0a6BSOEoKlANvRT3d
         AaKQXfEjFwP8bDXpDdmwvWdeXQAN+NpKBWohwCOmyU4jDqnXmNxGDEjzBCzgTS/KD11H
         LV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MWtuzNkfIrj9bGJDHmxIz3MA3fq+HDnE1cpFrXFDXcE=;
        b=2c8ooSwNGW6BeINPms40rBWClyHv3om19mg99xBtWPxNJekUabunC1XfDcTUqlNS7F
         zAYAM94hEaQOueYFEC1jI+4RJqTzWU5cw1rQn9wH1kW9KkFuiiBoS4EikMyDsiWi6/Rs
         KoMgPg55pwTSNl7lGk9fxy4j774/FW4kwlfwl5MlRiC7pWT4FlL8m0tea7XfgourAv8L
         aRbp6UEQ+p9MQLLy88VPGvk2+d5ARECNxu33utgxprkYmCA/70gW0daS7H/vLofl6X7/
         4zCNYyfLWB6raqTYoeiA5aGvjfu9qHLQb/4PnCiqUcUTcfGgVc0xemcZHR8gmAVWXW7e
         5+VA==
X-Gm-Message-State: AOAM53096YcpEuHf6sEH8BjVE34gVtElIiFrq3YRJwybwV7LBGNCJ4eK
        BEqc0o7+G6vj/FEDQUBGCZc=
X-Google-Smtp-Source: ABdhPJztzWwM8ybQqg6U3OuLgJxEerkri19ce35NN/x+XS0yObV3fHmEMmqwkVTPshYKjHXa9XrH/w==
X-Received: by 2002:aa7:de10:0:b0:418:d60d:aab8 with SMTP id h16-20020aa7de10000000b00418d60daab8mr22163750edv.322.1647854532078;
        Mon, 21 Mar 2022 02:22:12 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402355100b0041925e80963sm2626807edd.41.2022.03.21.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:22:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWEEs-0007QM-Da;
        Mon, 21 Mar 2022 10:22:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v13 13/16] ls-tree tests: add tests for --name-status
Date:   Mon, 21 Mar 2022 10:21:21 +0100
References: <cover.1647846935.git.dyroneteng@gmail.com>
 <a5c73de057255cf1cfcf4695db2ae8870108da91.1647846935.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <a5c73de057255cf1cfcf4695db2ae8870108da91.1647846935.git.dyroneteng@gmail.com>
Message-ID: <220321.861qyvd5j1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Teng Long wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> The --name-status synonym for --name-only added in
> c639a5548a5 (ls-tree: --name-only, 2005-12-01) had no tests, let's
> make sure it works the same way as its sibling.

Let's move this to the front of the series, or rather have any test-only
changes go first. Then it's clear with:

    git rebase -i -x 'make test' @{u}

What does and doesn't introduce behavior changes, i.e. this is just
testing existing functionality.
