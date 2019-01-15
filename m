Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A035A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfAOSiT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:38:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35265 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfAOSiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:38:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4171526wrb.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=//Ok874gNZuGkjplx8I6iWxho4UQuchI/Rn5m4ny0Hs=;
        b=TzLgWskoTo1ATZVkgARIiicYAphtS+Emt7yLjHmKnR7eD/msV6NX3jTp80QeWOnt0E
         DvfLI+HGWa8ECpFhx8aJwpkxTUIlKYpeBJYRkUs+td6lx42OwUFwMxvZ5msNHK4lHtSL
         /G27vE12ulrFbUQY/ns8TwkF/K3vnzVXBANMrsaFg/MhBeyfwfYr82z923b7JX27usy1
         dCULKwTEQMOhy1Zlz1Qcik8Bjeie7INv4UALxiUj81O95RbsxuGsuVE3bSBCTpO7WNMO
         r0/+h/GK01jvi0BdrPnsXxd5yIhiwcCVO2s/lPdZXBQK78ZgV2VJiljlAT7C5a2f/C6R
         2NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=//Ok874gNZuGkjplx8I6iWxho4UQuchI/Rn5m4ny0Hs=;
        b=f4sfdyzC1mz/8VJSvernGhHXM2MQY8h4eaEm2+la00lKpnAIuaAC7HiSsuYCbqu6Zo
         cv2h2fmX2Z/frDAA+6JQOfq0VDbovl6f8IbSxnCL39vcbpeYoPt3v/mGwUQeQyYIbtWF
         ygyz06QWGJD75lo3NqMnbMQ+bMh+EudKYQJfGsG50QWIvkxloOLXOF3Ebyj/WlEVnKRG
         BW1t4ZF2ZY/u9xcUp5y8p2kvpUxnv7DveCJq2/nX5oXHGRxsCPuBtOdvrsj+0bgU97rJ
         btHAdDIIuoz1imWWXSE7srYVVPRhIe69N4zUV2it7JBTtaw+rYFmQNJ43jWCOeILAB3p
         CgHA==
X-Gm-Message-State: AJcUukeiorMdQv4bSnGRfObASCCZW0Fi1X4Go5nZdhFQ+rKQuBGfMc4U
        rlMaCKHetfBVY3TviPinIN0=
X-Google-Smtp-Source: ALg8bN4LUTskBATUggJTxe8Q44AR7Nu98/611BIRShHhFMKphlJ0EvGdMMjPpACCE8xSL2Eo+a2ERw==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr4498690wrj.58.1547577497166;
        Tue, 15 Jan 2019 10:38:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 60sm108287630wrb.81.2019.01.15.10.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:38:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the initial checkout.
References: <20190114172702.19959-1-marcnarc@xiplink.com>
        <20190114213430.GC162110@google.com>
        <xmqqwon6ud7e.fsf@gitster-ct.c.googlers.com>
        <20190114215804.GE162110@google.com>
Date:   Tue, 15 Jan 2019 10:38:16 -0800
In-Reply-To: <20190114215804.GE162110@google.com> (Jonathan Nieder's message
        of "Mon, 14 Jan 2019 13:58:04 -0800")
Message-ID: <xmqqmuo1sr53.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That said, it's better than nothing at all, which is why Marc proposes
> making it not attempt to check out the submodules right away, instead
> permitting the user to make the best of things.

OK.  Then I do agree with the hardcoded "--no-recurse" given to "git
checkout" at the last step in the code.

Thanks, both.
