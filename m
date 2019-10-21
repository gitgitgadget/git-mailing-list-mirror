Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797371F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 17:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJURkB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 13:40:01 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:61436
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfJURkB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Oct 2019 13:40:01 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E26ED340B44;
        Mon, 21 Oct 2019 17:39:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (100-96-171-212.trex.outbound.svc.cluster.local [100.96.171.212])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3271E34046A;
        Mon, 21 Oct 2019 17:39:59 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a58.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Mon, 21 Oct 2019 17:39:59 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Hysterical: 1bccac4727f12a45_1571679599519_780658091
X-MC-Loop-Signature: 1571679599519:99310828
X-MC-Ingress-Time: 1571679599519
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTP id 6CDD384935;
        Mon, 21 Oct 2019 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=olSGM
        vjazwid1Jgr4LN6Ubo+Tdw=; b=rvIF5GCu4TNUrmzxxra/wqoBXsBa24Dp8I0IW
        xIaiWchC6efYBpkNPXbosNpU0quY5SppoKoADPPAXz7+MP6vQZgyLIzMWRp6/2+5
        /cCklQvpWEFNuwmz1ewglwaVUF9sAs5giiH9x8hJMKnex6Myxxtr2ABW4uJ3Cq/i
        TSR82I=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTPSA id 6ACF48492A;
        Mon, 21 Oct 2019 10:39:54 -0700 (PDT)
Message-ID: <0f62325e46901322346184b47329940f7700a1e3.camel@novalis.org>
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
X-DH-BACKEND: pdx1-sub0-mail-a58
From:   David Turner <novalis@novalis.org>
To:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Date:   Mon, 21 Oct 2019 13:39:53 -0400
In-Reply-To: <20191021160043.701-6-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
         <20191021160043.701-6-szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2019-10-21 at 18:00 +0200, SZEDER G=C3=A1bor wrote:
> Add the missing condition to trie_find() so it will never invoke the
> match function with a non-existing value.  check_common() will then
> no
> longer have to check that it got a non-NULL value, so remove that
> condition.
...
> =20
>  	/* Partial path normalization: skip consecutive slashes */
>  	while (key[0] =3D=3D '/' && key[1] =3D=3D '/')
> @@ -345,9 +349,6 @@ static int check_common(const char *unmatched,
> void *value, void *baton)
>  {
>  	struct common_dir *dir =3D value;
> =20
> -	if (!dir)
> -		return 0;


Do we want to assert(dir) here?

Overall, LGTM.  Thanks for the clean-up.

