Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134D3CD54BF
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 19:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjIYT3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYT3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 15:29:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9AA101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 12:29:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 48FA85C2773;
        Mon, 25 Sep 2023 15:29:34 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 15:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695670174; x=
        1695756574; bh=syzQuJFxyIOvorMkuwX7l4bHFCnbUFMhXabDfWnloRo=; b=H
        5CDVpzETiUF4N6gd08cOtGP2wXcXTlRyy1Hw+MY5pyzs52gsQHGYuoJ55ALdMjlr
        MBjTicjd0G2gdn7OrQeZheXhCJmRVwvHx8vO0UwPJkyKRV+lqBfAYbSCLNwHC0w9
        4sxA9bkW9GvuebLTKJRebySAzXsAi4vKmfWWTCB4m/wFlqOs9zptMecq7auJ9QAs
        te6VX8wNoL/69uWydswd8Ltlu4NNGFy1ua4A2eQ/3xryIDdU0tnDLtY/OfyQNJRP
        P+3ITsUzw2e2LIvV3Jmm5qObzVjsT36lwR7u4E+h9zSekTo9/9NWbgHZadX7GvBj
        5p2inbGOR+oEQCsnaQ9qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695670174; x=1695756574; bh=syzQuJFxyIOvo
        rMkuwX7l4bHFCnbUFMhXabDfWnloRo=; b=Fu+j7cx/2/tDRC7tVQY1dztRNel2B
        Hg41S29whbqECP1lnoMlgiSVIuGKNncr7rwiH9ASkMr4lgBUByy264nTUU4HMKzm
        BNofqM10mRqiaTN2vIIRoYNClyFx5BxI3af6N75qiWD8Q9qhBJ8kMzTFKhs7ELZc
        yyMcbCeRQIEMTEnTKPiikPYbmd35J4nTDy+dcYK+thWdpzOVhg2e2FG7fdAr0hn7
        BhyaWCxOFdixDkKUulmNRtkKGQQGU9hH3Lf94UL8ZTjUx0EJYcJq/m4VMLPNUZH0
        CtZB7OYyXAKzO5JdTuAiqFN980AaIM76uCUYqFwfXFbliEj///C7SYNFw==
X-ME-Sender: <xms:nt8RZaLLLzapQNThE_sTn0uZfnr8l4CMxLs_Zmk4SiyFZakRn1_f3Ds>
    <xme:nt8RZSJcm4APF4ft-8MF1BJ4fINTXP8_hmTpERaqXmh9YREHMv7urp_ju33eBBq7n
    hv-1g9QGGsk-EDOqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:nt8RZasepbmZh1UdUUk7An7mbWJb5bWcndFMXRRpUYBrRaKEVfJcxA>
    <xmx:nt8RZfYcYzkwXK5zzr1-A_NJbaOFvg9VsBCzg71NkgVldxcJM5TL7A>
    <xmx:nt8RZRYdRL5pqmrIinfT3CXRpAV884ueCvaWFZ_WPu6FarylgPkxgw>
    <xmx:nt8RZVHObGab0BT6Oe4XGoF-GeNEofaKAIggFage67Bty5dmGg52dA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDFF015A0092; Mon, 25 Sep 2023 15:29:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <b2089384-4e1c-4956-ad57-0969151a09a6@app.fastmail.com>
In-Reply-To: <xmqq7coet6vm.fsf@gitster.g>
References: <xmqq1qg9qmyq.fsf@gitster.g>
 <20230821170720.577820-1-oswald.buddenhagen@gmx.de>
 <a1920050-bedc-49d4-840d-350b8fd3c003@app.fastmail.com>
 <xmqq7coet6vm.fsf@gitster.g>
Date:   Mon, 25 Sep 2023 21:29:13 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>,
        "Jeff King" <peff@peff.net>, "Taylor Blau" <me@ttaylorr.com>,
        "Derrick Stolee" <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] format-patch: add --description-file option
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023, at 21:01, Junio C Hamano wrote:
> Thanks for a positive feedback.  The changes is already in 'master'
> since the beginning of this month or so and its way to be part of
> the next release, I believe.

Yes, I tested it yesterday and it works (in conjunction with
`--cover-from-description=subject`) exactly like I want it to. :D

-- 
Kristoffer Haugsbakk
