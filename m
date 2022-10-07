Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E1C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 12:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJGM4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJGM4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 08:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615419C7D2
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665147388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RmOEwrdmD6jf6icNT8AaC2tiiKkLPdM2n2Q65NARpuE=;
        b=AVIjMaFZoDQXgcVRu0KaWUKn5JbNAoOlBYdw46TA3mTJvq5aLp/eyMGz9ACdN/qvIEkZHV
        Zgv6JfmvulyvZ3MPjiC2slyfU4g2+womJcLVBmQKztVto8rVdiFXpoiVfGa6B2ZgFBt6F/
        S7CeR610NWGGmeVKZcGC/8zuFRh0K98=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-6LUxavpePOSkNhxtUFy5fg-1; Fri, 07 Oct 2022 08:56:27 -0400
X-MC-Unique: 6LUxavpePOSkNhxtUFy5fg-1
Received: by mail-wr1-f69.google.com with SMTP id i26-20020adfaada000000b0022e2f38ffccso1410773wrc.14
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 05:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmOEwrdmD6jf6icNT8AaC2tiiKkLPdM2n2Q65NARpuE=;
        b=HR3ILjmGUS9LlsWoN6+Rv85VVjGZCkq3aeX3FrS+FIbCeBj1CioosR9k1DcnVR8czf
         UVCk9UTA8fOF7Cr8PE/U51JyDWQ/8XFqCJKPKcPnmv5ybMsK0GJ/Y/psncWRvL1VZYIY
         r6YFIQngLuZlyko2G3xnaX+8FATUi0RDRo6RCFIXQbzWSQxgJsZ/6qIWq2YQS2yK5Wz/
         x8nH00fZze+A7m3d7Q0OgRlmKK+PhPkSN/Po5tUFu2nJdaWCDAdvZkZ3FBlto8QhpHp7
         XDiLsLg+xG7iImiIGVAFsnIwBXMKdMCogSG6IY8+91N6YNzyTiLJcZZXhSZlzsireDiU
         NfUw==
X-Gm-Message-State: ACrzQf1En4VReuJLfR4ExltsrNrQIzviF8/svuh8Xv12uxnk3/o25Wm3
        5/Hsch3hsL9pRQo1K9J8PHCpeaZ1F/n0UaF5Fq4wUlj8Q6RQZgzMpL7PnFQqDlXfcKnawjlCcZk
        QRRuGV6JplEM4
X-Received: by 2002:a7b:c4c8:0:b0:3b4:76c8:da4f with SMTP id g8-20020a7bc4c8000000b003b476c8da4fmr9949536wmk.63.1665147385882;
        Fri, 07 Oct 2022 05:56:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53dkCTmzaFXsFxB1naYlUYyKuf2m3VdytkWOroxSAXf5te60eNPfJzFrH1rGA/kyR0n2dmlg==
X-Received: by 2002:a7b:c4c8:0:b0:3b4:76c8:da4f with SMTP id g8-20020a7bc4c8000000b003b476c8da4fmr9949528wmk.63.1665147385589;
        Fri, 07 Oct 2022 05:56:25 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b0021badf3cb26sm2545635wrp.63.2022.10.07.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:56:24 -0700 (PDT)
Date:   Fri, 7 Oct 2022 08:56:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sudmodule.<name>.recurse ignored
Message-ID: <20221007085334-mutt-send-email-mst@kernel.org>
References: <20221007060713-mutt-send-email-mst@kernel.org>
 <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 01:09:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 07 2022, Michael S. Tsirkin wrote:
> 
> > THE CONFIGURATION OF SUBMODULES
> >        Submodule operations can be configured using the following mechanisms (from highest to lowest precedence):
> >
> >        •   The command line for those commands that support taking submodules as part of their pathspecs. Most commands have a boolean
> >            flag --recurse-submodules which specify whether to recurse into submodules. Examples are grep and checkout. Some commands
> >            take enums, such as fetch and push, where you can specify how submodules are affected.
> >
> >        •   The configuration inside the submodule. This includes $GIT_DIR/config in the submodule, but also settings in the tree such
> >            as a .gitattributes or .gitignore files that specify behavior of commands inside the submodule.
> >
> >            For example an effect from the submodule’s .gitignore file would be observed when you run git status
> >            --ignore-submodules=none in the superproject. This collects information from the submodule’s working directory by running
> >            status in the submodule while paying attention to the .gitignore file of the submodule.
> >
> >            The submodule’s $GIT_DIR/config file would come into play when running git push --recurse-submodules=check in the
> >            superproject, as this would check if the submodule has any changes not published to any remote. The remotes are configured
> >            in the submodule as usual in the $GIT_DIR/config file.
> >
> >        •   The configuration file $GIT_DIR/config in the superproject. Git only recurses into active submodules (see "ACTIVE
> >            SUBMODULES" section below).
> >
> >            If the submodule is not yet initialized, then the configuration inside the submodule does not exist yet, so where to obtain
> >            the submodule from is configured here for example.
> >
> >        •   The .gitmodules file inside the superproject. A project usually uses this file to suggest defaults for the upstream
> >            collection of repositories for the mapping that is required between a submodule’s name and its path.
> >
> >            This file mainly serves as the mapping between the name and path of submodules in the superproject, such that the
> >            submodule’s Git directory can be located.
> >
> >            If the submodule has never been initialized, this is the only place where submodule configuration is found. It serves as
> >            the last fallback to specify where to obtain the submodule from.
> >
> >
> > However, when we are talking about the recurse attribute, it is
> > not taken from .gitmodules - only command line and .git/config seem
> > to be consulted.
> > Is this a bug or a feature?
> 
> It's a (security) feature. We have had disussions[1] about how to safely
> read in-repo config, but we are very far away from that becoming a
> reality (if it ever happens).
> 
> If we read this from the .gitmodules the repo could change how you
> interact with your submodules.
> 
> 1. https://lore.kernel.org/git/YzXwZQbM69eNJfm7@nand.local/

Hmm. Well we have a bunch of attributes there. Why this one? What did I miss?

-- 
MST

