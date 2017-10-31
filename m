Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB7020294
	for <e@80x24.org>; Tue, 31 Oct 2017 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbdJaSnX (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:43:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46055 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932974AbdJaSnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:43:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id d28so14433284pfe.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uo8BHoefDduQprQaRrPPelT8AM64MY/DMGt6yQEKWe8=;
        b=BN17IxU3kxYdceu31M9jQ1EcoVQCA8C5M2wlrEaqDJI1+WD421lV2p3S6yccOE7gyX
         uKIMy2Iqcn335b5l0aNtb7rYqK3R3IDUlwFEiKQ4rWPDFV81H4alDR5R4U5+Oax9nnW7
         02cLndrKdfzRChjJm8/W30Jg/mmp4no6v7jCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uo8BHoefDduQprQaRrPPelT8AM64MY/DMGt6yQEKWe8=;
        b=gZWXwCFXlWqqlI8f8GOCjLyOB8g5GxjMSTw+8lbNrwPwR+iqSvPoxwprs9jqAqxM7U
         3BIhgwSG2Ftei6DNSI42ud+BXI7HCBjl6kBLoLxgVlPFgQ48JyE8lRO4H/HEn33Nsd/a
         2eu1FWuiFIMVW9BZuP+gaAI40JRuYHNx7anXh+/2/zLjc2+JSqp7LAnm7F7FuHENwDmg
         DG6Db/ZBef7UBp+b5S7PkSi0kQkScV00o7YzEfCinXMKwWeIEvV1Uxk+IDU40BzwkoB8
         eKu+Cuc0x+X/BjfV4ke65eGLS+JVp6ia6yLiU7WIoKs2ru0poK60PIBngKkRRU7u3la6
         cWWw==
X-Gm-Message-State: AMCzsaV+NPq/ZqrhNLp6elyLlvLDowP3erJ/bf8KTiskZNalHNTnRIqt
        sS52b/L0r0aG2MWTRhyCaENhhw==
X-Google-Smtp-Source: ABhQp+RxTYGPzn42r6Z1QrDHFQEWB2HQ0dv6p42yn99jdLXvtWWc9iux1aV/OGpReXYOP2KQUJ8npg==
X-Received: by 10.98.209.88 with SMTP id t24mr2983804pfl.269.1509475400266;
        Tue, 31 Oct 2017 11:43:20 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b16sm4539390pfe.58.2017.10.31.11.43.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:43:19 -0700 (PDT)
Date:   Tue, 31 Oct 2017 11:43:10 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v3 4/4] fsmonitor: Delay updating state until after split
 index is merged
In-Reply-To: <alpine.DEB.2.21.1.1710311830330.6482@virtualbox>
Message-ID: <alpine.DEB.2.10.1710311139560.5248@alexmv-linux>
References: <20171027232637.30395-1-alexmv@dropbox.com> <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com> <5cb81a33c31ffa585861f0d3f5a7c7eef5bd8fe0.1509146542.git.alexmv@dropbox.com> <xmqqa80728lo.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710311830330.6482@virtualbox>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 31 Oct 2017, Junio C Hamano wrote:
> This makes local variable "int i;" in this function unused and gets
> compiler warning.

Apologies for leaving that detritus -- I saw you added a 'SQUASH??' commit
to deal with it, which LGTM.

On Tue, 31 Oct 2017, Johannes Schindelin wrote:
> ... to which end we introduced the DEVELOPER flag to catch these: if you
> call
> 
> 	make DEVELOPER=1

Aha!  Thanks for the tip; I'll be sure to use that from now on.
 - Alex
