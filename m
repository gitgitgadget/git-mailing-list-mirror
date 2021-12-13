Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE928C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 08:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhLMIx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 03:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhLMIx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 03:53:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECFC06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:53:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so48980775edd.9
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Eu4BROIP01mm4QqCBuk5+zMps3i0OfvMh4jcs9a5r50=;
        b=evbrWgTmJ0sr3+lU0Spdt4jRqM4DKjjR4Z5FAjAqnlf3rOtZNo/1P1PTNMPaRd5P9V
         +H4eHaMNpN8y+AnTntzLg1NbG0PNpX+tMQsA4R35oLtBK6cxHI4dhMPkAuecxvh+s38J
         pTlWaILlFbkqaaX9Sfont4Ny7HBgqascUQZQ4TggBWrQxwLfrvrnIQfSi+wCdIvouCAp
         4CFCqc1Mj23m2zKGh55TdIrlYZpuEu6ByBvexELt+1VocJ96HlQTN/cQlt20HNl1O6+e
         +UR153WnmLp67d+X0t4v0UbJGFShk2ocudMjiEXAudXqadx4KPuahIA/VOmMitBA9ckG
         gxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Eu4BROIP01mm4QqCBuk5+zMps3i0OfvMh4jcs9a5r50=;
        b=19jqaG4YYbPeZ5sx5j48m1bbZA8lm2byxYG64RRzwUn8dC0lP659ygAYO2koiHoB9O
         R+4tqIqV+AcMOE9DyDbzfe0IjIsyLz1BLIIYAHU+yrcI4KgMfVN9nfBCrvmZNXW6JUt8
         j763q5da+AVHjc03EztO34uPyYK66Q5DZv7zhmlMNH+f5w1YekvvK8cT1PtPnknuFSu3
         B0a/hbI6nKA6dUDhBt3S25ICdXM8x0+L6ENknQdUvl1wDfrEvevJIHobdatFQnUK2Q6d
         BHpfTt0p10MFK7hlTiL/YH1oxKKNuMxBhVJvKU/HbmR/+RIax3iFIlcnexQIpYSO/xqP
         /Mgw==
X-Gm-Message-State: AOAM5304xmeTDUw8nz3q+z9sAshNZnJL95lJB5ZbYBvqGd/uRnSCCxFq
        HN1EooL5iasC/7paGs+hAMc=
X-Google-Smtp-Source: ABdhPJxuBiRuXHa219br7i0TwzvwMDPaL+DAFIkL15aqtn4Ng1fG2ZhZBnNy23IwHChcCYKBXal98A==
X-Received: by 2002:a50:c38c:: with SMTP id h12mr63976914edf.72.1639385606895;
        Mon, 13 Dec 2021 00:53:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn26sm5444492ejc.14.2021.12.13.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:53:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwh5J-000lzd-Oy;
        Mon, 13 Dec 2021 09:53:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v5 6/6] unpack-objects: unpack_non_delta_entry() read
 data in a stream
Date:   Mon, 13 Dec 2021 09:05:55 +0100
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
 <20211210103435.83656-7-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211210103435.83656-7-chiyutianyi@gmail.com>
Message-ID: <211213.867dc8ansq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
> [...]
> +	if ((ret = write_object_file_flags(&in_stream, size, type_name(OBJ_BLOB) ,&obj_list[nr].oid, HASH_STREAM)))

There's some odd code formatting here, i.e.. ") ,&" not "), &". Could
also use line-wrapping at 79 characters.
