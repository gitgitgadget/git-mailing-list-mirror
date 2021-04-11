Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD5C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB46F610A6
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhDKPS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 11:18:57 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46318C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:18:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618154317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djzlr1JoOSROCS2yQfa6yDitGAa7ypuKsoDjM3PVf7w=;
        b=mzcdOEm18XHfdQfrQVc/tREr7crZzTDi4gxQFQTEgLPAdwydKYj8vAwswj5gZr5cynQY+b
        8yb6ax98AN4Vrf+SbRlbpUYiTyLo+FHr13D8xpKSutYZUx2RXI19a6tzaWflF1Vy8VrkZH
        xyj7YkvvESE8dVAfsiPOrVn825sqgsjz8hl3jdmWBK4Moy9IS/5Zjx1nJRB2ldQMr/B7rY
        MhehxAPo9mvT3mZ/JK5TkdMKGvdqxn5ki4kKHa8rG9+sLApLXp1sQGEhtjqIUvefJoHhbB
        NUN2PRBZf+zsxumPae3agl9aqpmwtc8pITXTRBID9nLoRowTpL7aaaQY9d5ujA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Apr 2021 11:18:36 -0400
Message-Id: <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com> <87blakgaxr.fsf@evledraar.gmail.com>
 <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga> <878s5ogagz.fsf@evledraar.gmail.com>
 <875z0sg8t9.fsf@evledraar.gmail.com>
In-Reply-To: <875z0sg8t9.fsf@evledraar.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun Apr 11, 2021 at 11:06 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
> 3. While I'm very much leaning to #1 being a good idea, I'm very much
> leaning towards introducing this "starttls" alias being a bad idea
> for the same reason.
>    =20
> i.e. let's not create a new 'starttls' if we can avoid it explicitly
> because we used to have the long-standing "anything unrecognized is
> empty =3D=3D no encryption" behavior.
>
> A lot of users read documentation for the latest version online, but
> may have an older version installed.

I feel quite strongly that the options here are a grave failure of
usability, and that it needs to be corrected. I help people troubleshoot
git send-email problems quite often, and this is a recurring error.
However, you make a good point in that someone might see some online
documentation which does not match their git version and end up with a
surprisingly unencrypted connection.

As a compromise, let's consider making this a gradual change. We can
start by clarifying the docs and forbiding the use of any value other
than 'ssl' or 'tls'. If an unknown value is set, the user is not getting
the encryption they expected anyway, and this should cause an error.

Then we can leave the issue aside for some agreed upon period of time to
allow the change to proliferate in the ecosystem, and then revisit this
at some point in the future to rename the options to make more sense.

Does this seem like a reasonable compromise?
