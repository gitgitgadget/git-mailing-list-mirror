Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED72C3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C020866
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRZfoFPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCCWof (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:44:35 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43624 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCWof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:44:35 -0500
Received: by mail-wr1-f46.google.com with SMTP id h9so5566529wrr.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qtwtUuP9CBa4a/fcs3EolOEpMXOFT+ZY20UaN6Dpju8=;
        b=HRZfoFPsgY9myQdVeEO80z3k20akeXyVfCUgBDMEen4iTmVYs5S9sDu1aBWTI/u2nx
         A65mONGgipGaqpXlkUHQDcFT3R5bHqP5E9N/Y/J3fWqd24N041UKDdrcxs+dj7iBofzh
         zhEKbiwySssTk+uSiPl1G836MqmMZ1C9Az9ELdnc3agj+hayqNYkYCEeTJDKEnv8KvmL
         84Gi/srXzZNcMdKNVx7b+ku+tYRPFwTdrZWYagKcpttcIqNwxVxiAj2snmNG2VfXtuFQ
         7SUokaP4ecJbl/jf1nGA0gND26K2W0TWgU3HTq8U1JIYeuI+mejfEElGALhKN8JP7glh
         IX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qtwtUuP9CBa4a/fcs3EolOEpMXOFT+ZY20UaN6Dpju8=;
        b=JsolZHwlrUpUOLS7r8qdnjsELOHKy5yrCxeWo1teFG2qwRQszG330EutkRJS3cSDrr
         I1ZQL9Q3wS6HhLZOaFHoHpQd/lxRX3jK4QKKTOcjMvctQaw8fKrWZBLG9N19hHhoVbfo
         OnNkallUAeQpkDVUM3ZpdfxtADmux9k39GqHpk638VG2ysxlsLGF+N1fUoEUlMrruano
         +wUWr04Lz82oqjRBEvx+rWWphgru9WODXTCFpa3tFiAP+SjnD3NDhKZSDL/cFO0pbgUC
         mqIi8Dxrg0qk3nrqfRcyxFN70Z5wV0XOX1PuijMKIcMsk61unTcKbI/HUjyqNPZB0eXz
         xD7A==
X-Gm-Message-State: ANhLgQ2aL0UqxBv9y45p3VMUVeY+BD63En9jLXkg3V3YFVysVyVt3F68
        jdv1odBUpZiWEVVYigNHxFc=
X-Google-Smtp-Source: ADFU+vv4+KN4Dg7cNTJvvi0TkcWq5pWUr4N8lkdjnTYwxi2usC7uscF8vrAIRZ6hb3GtbZsLXZKu3A==
X-Received: by 2002:a5d:6cb3:: with SMTP id a19mr245100wra.213.1583275473072;
        Tue, 03 Mar 2020 14:44:33 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id a7sm1291601wmb.0.2020.03.03.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:44:32 -0800 (PST)
Date:   Tue, 3 Mar 2020 23:44:30 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree
 [was Re: Nested submodule status bug]
Message-ID: <20200303224430.c64dmvzr4c72f2tv@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 23:39:20 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
 <20200227100557.ydouc4n3jphzbits@feanor>
 <20200227104330.hp7zf2suquxsf6zw@feanor>
 <20200227155057.7idpa447ixo6sf6j@feanor>
 <20200228190218.GC1408759@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228190218.GC1408759@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Fri 28 Feb 2020 at 14:02:18 (-0500) :
> > Furthermore there is a question of consistency. GIT_DIR will not always be set
> > before running a shell alias. Looking at `setup_discovered_git_dir`, it will
> > be set if we are in a bare dir, or core.worktree / WORK_TREE is set, or if
> > we have a gitfile.

> We were discussing the same issue recently with regards to hooks. See:
>   https://lore.kernel.org/git/20200130102933.GE840531@coredump.intra.peff.net/
> and the responses. I think we could do better, but at the cost of
> breaking a relatively obscure git-clone feature.

Yes I found this discussion afterwards. This is related but a bit
different, the problem you discuss is that GIT_WORK_TREE is not always set
even when GIT_DIR is. The problem I have is that GIT_DIR is not always set; it
depends on the phase of the moon (are we in a worktree? ...), which makes
things that forget to unset it half broken and hard to debug.

I would argue that for scripts and hooks we should always set both. This is
easy to do (at least for scripts, I haven't looked at hooks) without
touching at setup_discovered_git_dir, so not affecting git clone.

In fact I would even argue that in setup_discovered_git_dir we should
always set both, and fix the breakages that appear, like the one you
mention for git clone. For instance I wonder if the recent report about
'git gui' setting GIT_DIR is not due to this.

> Note there are other variables you might want to unset, too, if you're
> switching repositories. Doing:
>   unset $(git rev-parse --local-env-vars)
> would cover the full list.

Thanks for the hint; I had forgotten about local-env-vars.
