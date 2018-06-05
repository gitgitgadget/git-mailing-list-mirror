Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB91D1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 23:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeFEXSd (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 19:18:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40222 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbeFEXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 19:18:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so2141779pfe.7
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EyxRFb/NAFnVm/L7CvnSEJvlbXsNPPNw9IwOES88cCA=;
        b=VSTDN9JBuS26d9mJDMUjbbERRxjfRc4+u+PD8Ff/12XG5cZB4gwJT9AmR3R0xJy/SX
         qx058JEO3WGxz7h5IOsEK55XwysGW70NOAbHskZ0mzPiIJWY01nqtklQn6oZz/xDPIDh
         cnk2UCkBivIse7GNdvblVZA+1t+fuzqnzHGJky5/dDLQlzOOJ4ubFK0ocPAbhPkDvW7K
         Bw3MHNMXFRZSIH99CRgxEBF5RPL6fNLQ+i9qmZ/P7xicJPE5igWs32q9zBN9trcFpssD
         5K9RQHf8Dy5M0mD9RRjstDeYupusOh+ey98L1asHeLwCNZwM28fnRX8EjpLDLjJMOOXm
         8qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyxRFb/NAFnVm/L7CvnSEJvlbXsNPPNw9IwOES88cCA=;
        b=duhV4fK2fkEO6OsbqXGD7euBtVZ+2Y+u8gbEGy0BNZQrux+DiSh3D7N8y6qU7PMV51
         h8tZ3j2zL4uoU47uZaRacecHOJoSdNYkzw6v7V5TPtWl5wg+JPc+xJYxDA8/Cf1UgGOe
         tWbVwb9Y1z1dVSRgjsEGo01xQkrdO38eSYy1Ugm6tCntCgQcJtTagsnZAs4lZqzwYuop
         hHXg+pWTz8TjtyQW5kAcJAeO6jEFXP63pOcpEIdccfywAoovMjfTmIjDC3ZfogGlkwtU
         JGAnCof1ajUajKPm7Q5l9JN+zVhiefueYMKhgAse2rPv72GzXLjjBO2ZE6l3QeOg3gTr
         PQfA==
X-Gm-Message-State: APt69E1CzTZ+lmu2V7OU+pvW0s3UVoJc09SGhI28eIuu4aFBf2vxQsWh
        zKkxeZ6KVlpioPaybrDQegU=
X-Google-Smtp-Source: ADUXVKIJKtgUijkn59hAZLrRrHaVF1E4CbKBi51cga3+4Bt9dsDKDFhjfw9648a8BW4yC0WsXfm0yg==
X-Received: by 2002:a63:8c4f:: with SMTP id q15-v6mr517278pgn.236.1528240712077;
        Tue, 05 Jun 2018 16:18:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w1-v6sm66558708pgp.3.2018.06.05.16.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 16:18:31 -0700 (PDT)
Date:   Tue, 5 Jun 2018 16:18:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bmwill@google.com
Subject: Re: [PATCH 2/6] fetch-pack: truly stop negotiation upon ACK ready
Message-ID: <20180605231829.GE9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <c79a6e6f96e2e453017669fabbed1a9fb4036cce.1527894919.git.jonathantanmy@google.com>
 <20180605231634.GD9266@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605231634.GD9266@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Jonathan Tan wrote:

>> The corresponding code for protocol v2 in process_acks() does not have
>> the same problem, because the invoker of process_acks()
>> (do_fetch_pack_v2()) proceeds immediately to processing the packfile
>
> nit: s/proceeds/procedes/

Whoops.  My spellchecker deceived me.

I even checked Wiktionary and found that it was a verb there and didn't
bother to look at the definition:

	Misspelling of proceed

You already had the right spelling.

Sorry for the noise,
Jonathan
