Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6839120248
	for <e@80x24.org>; Sun, 24 Feb 2019 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfBXPYc (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 10:24:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39419 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfBXPYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 10:24:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id z84so5822487wmg.4
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=K7c92d2HfoHAK/tKtFQeWPOyzBy/PXdz6vwM6JBdp+U=;
        b=FRwyqVyPf4CLvwcBTU5e3kUvQUo4J1I3Fgx7RjGnRVHqbYbxRjIJqPNECRPBl/+aH2
         gmgpxN8O22r5oVONuQny3xG2fEn7j8cW0uShfFsnfacCDQUkqabUllID3jimIV7U8nPM
         9gGQrpU8ZitOEBI3EouG41vBYpJSD3iCHW30pWKA8A0aNrbUnlMSiuN5g9geJ3Amgjvp
         cENDVRTXXnhybRa5ui2b3pwgwSYtfGY8DMbVHKxh+9auDWhgNqZcad10S7JZ3XFcZAve
         /df2K3+hwMixYXag6M2tcOVw2Aj79jma/7Qjx8XLmnnvFuxuacsNv0mc9WX95eMEzPd/
         wgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=K7c92d2HfoHAK/tKtFQeWPOyzBy/PXdz6vwM6JBdp+U=;
        b=DvMNaG+MM/UrFhoZDT0ZXwjCkw1fNsA0gS1MGBNtqKVzV7jXnrZ4zR3hCx+Rmp5bEe
         zyp/xyTFJOOfQuBZ3ddg1Y3i9KFn+JjGmVpp2e1YaYqWJ2nXJ+nlWbV4eEKbmzfukjmH
         jF1Ni8LiIcbCcEd4XyytxIjJK5+CIF8bSUcZlpdNbVQbqTRQ/g//ViukL1yCdaI0qMMO
         3N93S/6p8Ra6ahY4sNsUqq4Xosr5Fgg5qdxI2G7r7ulCAfaKPAfyBTJUkpjPj9Fysajo
         eRlpKwJ1dt42lnEXj6MjlpYLzKsV8Q6QUE6hMBZr/7wlgGaxVyqq2qysLAP4mRQhjU6o
         TCeA==
X-Gm-Message-State: AHQUAuabpcVeT2wFRiAXzrdxtzekksdvz/cMxchBTfb5ila23MSZaFTA
        2ArgPYaP/rxnUCfgYJPW840=
X-Google-Smtp-Source: AHgI3IazMGM3RK6gWHG/xAQZOtMHL2+x/5BV0J++VcHYEFNY4tfHQhTKlaSNEjWyFvnj78n+FpfwEQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr8014366wmg.111.1551021869749;
        Sun, 24 Feb 2019 07:24:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l125sm13568740wml.18.2019.02.24.07.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 07:24:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sylvain Lacaze <sylvain@lacaze.me>, git@vger.kernel.org
Subject: Re: [PATCH] diff: reuse diff setup for --no-index case
References: <CAH1FtBpcZJ8V4B=RJ0SfC+kehpmpaBGafDzXvi8i33rc++jOUw@mail.gmail.com>
        <20190213201118.GA13261@sigill.intra.peff.net>
        <xmqqo97e885l.fsf@gitster-ct.c.googlers.com>
        <20190216065755.GB27641@sigill.intra.peff.net>
        <20190224094545.GA11538@sigill.intra.peff.net>
Date:   Sun, 24 Feb 2019 07:24:28 -0800
Message-ID: <xmqqpnrhmcpf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Here's an attempt at that.  I did drop a few comments that seemed
>> pointless to me, as they're just re-stating the lines they describe.
>
> It looks like the original got merged to next. I think we at least need
> to deal with the "Otherwise..." comment, but I think the layout I posted
> in my followup is nicer overall. Was it a mistake to merge the first
> one?
>
> If so, do you want an incremental, or do you just want to drop it and
> redo as part of the post-2.21 rewind?

Will do a revert-and-replace just like I did for a few others I
screwed up recently.

Thanks.
