Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04EC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F0206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgA3HVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:21:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:48156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725798AbgA3HVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:21:24 -0500
Received: (qmail 21681 invoked by uid 109); 30 Jan 2020 07:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 07:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21421 invoked by uid 111); 30 Jan 2020 07:29:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 02:29:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 02:21:22 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200130072122.GC2189233@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx>
 <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx>
 <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 08:50:13PM +0100, Han-Wen Nienhuys wrote:

> > That might be a good enough safety. I guess the next question would be,  would
> > it be OK for reftable to ignore and entries under the refs/ dir if they happen
> > to appear there somehow?
> 
> I propose to ignore refs/ if it is read-only, and fail if it is r/w.
> We're not going to look over the files under refs/ . If people
> actively try to shoot themselves in the foot, why would we stop them?

I'm worried that playing games with permissions is going to lead to
confusing outcomes. There are reasons one might want a r/o refs/
directory with the current system (e.g., you could have a repository on
a read-only mount). Or you might have a system which doesn't implement
the full POSIX permissions, and everything appears to be r/w by the
user.

-Peff
