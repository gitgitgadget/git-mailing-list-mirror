Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B47C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjDCRZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjDCRZs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:25:48 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811FC122
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:25:46 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 124D4240005;
        Mon,  3 Apr 2023 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1680542744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXzbgENvkcdhJwgEl/eBxGHrhpeIDzfwMYE5owy8oiA=;
        b=nw8bN+PEi48K7Yrf/tZ5WZyNzaPlzzTJCAV1Thg3VTavdy53eL62uJhBWmJOrc9kJPmnIp
        6ctb/0HJQtm4tv3K+7kdyO3YWRcYhXv0YTVrNwe+toriYIZqKPUc/CCqoU1moTozY+0Eep
        2xioaIP84dac7p1wXspURA7o50Pp/o6863OWluyffFZMuDaL7fB2ZUzgUn0frv5AxUkWhw
        hknhYECyrDS2ZEjWFVW4OVG1UDAQVjet9yXXUqHzTVYiVUqQf8ctCNZt6757fECk8oGv01
        ecAoQREflcVudsGnFtPSgzVSpeumlKtXfrpRBuPvGEHLB0KTb728jkkU01MfrA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 03 Apr 2023 19:25:42 +0200
Message-Id: <CRNAOLZTJKEN.3G96UM2HO763B@ringo>
Cc:     <git@vger.kernel.org>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
From:   "Robin Jarry" <robin@jarry.cc>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>
X-Mailer: aerc/0.14.0-144-gf975689ea403
References: <20230402185635.302653-1-robin@jarry.cc>
 <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
 <xmqqo7o59dlz.fsf@gitster.g>
In-Reply-To: <xmqqo7o59dlz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Apr 03, 2023 at 17:42:
> I do not know why we need another hook to do pretty much the same
> thing as the existing one (which could be taught to spool and then the
> last round to validate, in addition to each step rejecting incoming
> one as needed), but at least calling it there would be very much in
> line with the existing one, I would say.

If for example the validation would require trying to apply patches on
top of another branch in a temp repository, you would need to know the
number of patches and be able to determine whether you need to reset the
branch (patch 1/N) before applying. For that you would need to parse the
contents of the patches. This is not the end of the world but I assumed
that it would be easier to handle with a hook that fires once with all
patch files.

Another option would be to change sendemail-validate to be called only
once with all patches. That would be the ideal solution since the
existing hook is not always usable with series. But that would be
a breaking change. I personally don't mind a small breakage like this
but I don't know what is the project's policy.
