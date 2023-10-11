Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1AFCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjJKW1C convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJKW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:27:01 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667D91
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:27:00 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0358854117E;
        Wed, 11 Oct 2023 22:27:00 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 31890541140;
        Wed, 11 Oct 2023 22:26:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697063219; a=rsa-sha256;
        cv=none;
        b=wKAHIdEVULZEL2k/TSA3D31eX8ndXPuKBN16V8pIlKUM+0ytHzfFkjnvDCyp5+Yxxxu4wJ
        LzopP7Kw0OiRF9hbYx3mwkiUPb5AwEYp7FkMmPEP5iK7vfK4dILmV/zbNnGef9TGCJpa1s
        jF8H+S5MYa+hoj2JHW8vIJmXFf27GZ93s0krX/vGutdHMEHzSLtW8/Gmf14NbmKc3ed/ZF
        HjtEGrsqeYnPdCZ/zrgKozTwvC+Tul98i7y6HPHgsF05aojIVsG4yReKdKIb6DoSbU4ayU
        Z1gF8Z/KlzXaKHDVEirMIz9dJekbgCICzxoE9MQKuvdiRMLfDJlxdB/njCXorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697063219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0R+cMMJkb2wErAtghcx37sQ2zsXIx/OBr1rF/QJTtgQ=;
        b=6JxPVoX+Wj94pw3VNRAwDuwapaEjuOu2Af3soqOX/OTbxfs9IgnG6bvwMXy39ZAYP5A1mT
        LNt9rZZbP7xAcm3dy+wVaMvlP/5zne+kR++fOL4Llbn3TGasVE59mAm2dNYzhs9gL1t0bE
        2Aoayz3BhNlVRzes1hSnbNQEX3A4T0CoQETtXUySDwbKJU74PzHQ2UfwGGQLgnhBojwhxo
        b9RdGAX0D3ASE+o4H57u3NhzuS/tIVWV7UpIl5lvzwr+kqbCUhGcxi/zLNLK0FdjWvUMIE
        EfgUCkpmr5tk7Pxsc5IsMUz+YYiHdomx/txjOn9QVOmBTl/SpTQG72L5t8MejQ==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-8zxv2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Eyes-Cellar: 7bf8f6117bdd9764_1697063219861_3965503484
X-MC-Loop-Signature: 1697063219861:83432213
X-MC-Ingress-Time: 1697063219861
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.131.218 (trex/6.9.1);
        Wed, 11 Oct 2023 22:26:59 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:59214 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqhfK-0006sh-1s;
        Wed, 11 Oct 2023 22:26:57 +0000
Message-ID: <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 12 Oct 2023 00:26:52 +0200
In-Reply-To: <xmqqa5sokdd3.fsf@gitster.g>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2023-10-11 at 15:23 -0700, Junio C Hamano wrote:
> I think that was the reason we added it back in 2005.  In any case,
> asking "why" is not a useful use of anybody's time, because it is
> very unlikely to change in the official version we ship, and because
> it is so easy for any individual who does not like it to drop by
> exporting the $LESS environment variable.


Well the other commit I've mentioned kinda read as if it was thought
that either X or both F and X were needed for the effect to exit less
immediately if the output is too short ("F and X because
> sometimes the output Git pipes to less is short").

So I thought maybe that was intended, and the no-clear was just a side-
effect no one ever really thought about.


Anyway, thanks,
Chris.
