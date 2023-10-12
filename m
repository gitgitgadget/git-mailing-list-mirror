Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0019CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 03:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377491AbjJLD7S convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 23:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjJLD6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 23:58:40 -0400
X-Greylist: delayed 16709 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Oct 2023 20:55:01 PDT
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C644B7
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 20:55:00 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 12EE854198F;
        Thu, 12 Oct 2023 03:54:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 11A555419CC;
        Thu, 12 Oct 2023 03:54:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697082898; a=rsa-sha256;
        cv=none;
        b=H/QWmssmBI90VbEKCU5hqKDfRUEmgTR/Wx274vc2bHiQ4urFNkJvxManE6xdixess7MdlX
        KcCDXCEr1bozquZw3jdAUAm7UH9/DlH82296kiTMWCbKwpFLXl7q79L5d0v2s6qGR3znsP
        Z5mvB85QEA/BNUz3ZUSMMUd8pOrx/zRZsGrMxKCMYjYhOEwYd+RKZdBGUUemeKqmnOvY7G
        9dgnpq7oVr2XDX8q3XQVGlMPIZfwzkku4mB7qIUmEdVN9kY0+JxQ/yBQJBesjmK72Xv9Rd
        Ogeo7xIqM58hkfhc8NA6gmT+LWZetjC3SrdowdIZ9Jen1euT+Sh3VcGs7phR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697082898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cReTyK+LMYVu9PBfj7QmWESSXEixmJppstflFPDN+6s=;
        b=f2lYgiubu8CdaK43SMSukeFLwz5ETkbO3RRiIDaopU8IbmriAbFEXjCJpOWVcjDJJPKOE/
        M4UzSjM3hd+BxV9zkVhSJ3CkL2iu2iiZXMdRij0bKl77HjtAtwSszdzMTorTUClIz4eSs6
        CJntMDPRFFD4UVYn10athOnZmol9b0ncQuup0RtcY2fIfSQPVXv6InXAzrbAzzSHNlIWyv
        IvA1XwbLttn6tNo6dgd8gWY9o6Giy1HnkZLZtu7dn/T05Bee7V0TEf8ragevTrfoEhb+EI
        tTBwKh49Yv++Pvq5EMCGOT12YM4lgBvUgx2sDymy0u1CYiYBMHJbGvyg6QhGXg==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-scqwv;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Callous-Cold: 4f2ad535102ef7a3_1697082898910_1609382689
X-MC-Loop-Signature: 1697082898910:1332750759
X-MC-Ingress-Time: 1697082898910
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.102.135.46 (trex/6.9.1);
        Thu, 12 Oct 2023 03:54:58 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:46408 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqmmj-00084l-2M;
        Thu, 12 Oct 2023 03:54:56 +0000
Message-ID: <07bf5744c7d123635740c62a940999e089339fa4.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 12 Oct 2023 05:54:51 +0200
In-Reply-To: <20231012000416.GA520855@coredump.intra.peff.net>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
         <20231012000416.GA520855@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey.

Just noted that the popular bat utility apparently also uses -X to make
-F work (but also mention that this break scrolling).

But it seem they have a check, an if less is version 530 or newer they
don't set -X.

https://github.com/sharkdp/bat#using-a-different-pager

Could be a way to go for git.

Cheers,
Chris.
