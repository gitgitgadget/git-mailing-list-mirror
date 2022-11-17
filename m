Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26EDC43219
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiKQNs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKQNs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 08:48:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A71A5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x102so2676765ede.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BzQjoyFPQ9TX8IXzw5ERqYhNNaA/G4oT1z7sTOq8qg=;
        b=G6dtNX6uSiwJcXPlx0r9ImqiOtT+fBZd6rsBgH/j0n08u/XIwvqOQw84dv3lxk6eAu
         vYxq46Zai3XrQ5kImtqjf9bk3oZlF9GvkmzDWYHl9wRohvOEqJ40qDXPkzEiHPoIlocM
         Qz9csDvZXbh86UU0HpFoCs11bMopzgxsBg8sNB0/d86aSZBUCL62SlYyfCMcmu6cHlKn
         f1fS98yFb/LVmigjb5TvgDnboxyLtOJe2Iew9zPGHw8nBLH5pNS9VGqh05Vzd8n4dloP
         hPG2MV19koR4NrEDA4jjxLKguEPXBwJ7BykkTlmZYDP8ZIsWhmbQ/VDqa64Q6TwFXKjI
         2A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BzQjoyFPQ9TX8IXzw5ERqYhNNaA/G4oT1z7sTOq8qg=;
        b=6LkAtWabgjFfV7H0tdGvSzGz+Nn88YMWM+9DwdvBzq2yjbdx5mf9k0+BYKaR/sRyJv
         EFqikudnx19O8HkaHr4DepjLd2Z+o60oxGZjEeekSF7DVvUxORZ1kl/bJO4gT/LWRdUU
         8pe0go9hcslJ9ZXVFF0zvYTHRUi92lsMNRUo76M9rKmhTU84EYBJuTRQ4UN2bcdGxF6d
         iSxiYArPh7fEu7iDSdBV49GpqLkCid7gr/eVmytyDXeP0ww9JMKijqgmaKadC2QZ12CM
         /mBsOlHx3YAkgvKfTEmqAXJlhWYhdGDhKV7tbtRlo5BlTqDpNXL9DgePtLHRbkT4XqTB
         5qXw==
X-Gm-Message-State: ANoB5pmR9h4jKNXth8c4qKOmPEX3FUMNFFN1nSC8AIBmYLU7OAv8Judk
        dfN+rSNXsgi2SFe9bYOHnoZ+FpjLOH8=
X-Google-Smtp-Source: AA0mqf64kcGHM+Vq9LsFqc75RjPICTvSie3CMU+iGc8+h6QrcsAJB1/SnQjp1olUnK6UgpL1CT63Bg==
X-Received: by 2002:aa7:cb96:0:b0:461:bacd:c85d with SMTP id r22-20020aa7cb96000000b00461bacdc85dmr2121930edt.278.1668692901404;
        Thu, 17 Nov 2022 05:48:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a170906581b00b007ad9adabcd4sm379257ejq.213.2022.11.17.05.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:48:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/4] ls-tree: pass state in struct, not globals
Date:   Thu, 17 Nov 2022 14:48:13 +0100
Message-Id: <RFC-cover-0.4-00000000000-20221117T134528Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are patches I've been carrying locally since April-ish, as a
follow-up to the "ls-tree --format" topic.

I'm submitting them here in reply to Teng's parallel RFC[1].

Teng: This conflicts with your topic, but re my suggestion of
submitting a separate clean-up series in [2] maybe you could look this
over, see how they differ from yours, and see what would make sense to
keep/incorporate for such a clean-up series?

E.g. 1/4 here is the opposite approach of your 3/6[3], but as 3/4
eventually shows we don't need that struct for anything except that
callback case.

1. https://lore.kernel.org/git/20221117113023.65865-1-tenglong.tl@alibaba-inc.com/
2. https://lore.kernel.org/git/221117.86k03tiudl.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/20221117113023.65865-4-tenglong.tl@alibaba-inc.com/

Ævar Arnfjörð Bjarmason (4):
  ls-tree: don't use "show_tree_data" for "fast" callbacks
  ls-tree: use a "struct options"
  ls-tree: fold "show_tree_data" into "cb" struct
  ls-tree: make "line_termination" less generic

 builtin/ls-tree.c | 255 +++++++++++++++++++++++++++-------------------
 1 file changed, 149 insertions(+), 106 deletions(-)

-- 
2.38.0.1473.g172bcc0511c

