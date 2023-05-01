Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C38CC77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 19:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjEATMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEATMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 15:12:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FF1708
        for <git@vger.kernel.org>; Mon,  1 May 2023 12:12:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aad55244b7so18917405ad.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682968329; x=1685560329;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Qg1kbYxJALTgBqUNsp4V283ofK+vyrWLLXWcpOsSRQ=;
        b=Vk5Gs1PpCEwaPWHO70c5SrJZYdCIWy57MvVHp07TewMGBJ4jCk9UYG5d4Lqi4hc/ks
         hjmdh2jeGWhytKG21qZLdtF6Xi+U3QHDhq3vn+uIH8C+Ye90HlIrRmqd6V+1KIL6Z+Z2
         4DNbJMGYHzyDKRhnM9BVsocO40OMW9SYPUASTNOMOAD7rRkRvQV1Kv7Ox8mxu0675ZjW
         QawUf0hf4Z/tx2gl8OnfGpB8WvDC8BQrZ8XiRyy7C8mTdGcHOEROS2qUlQvnVgRzRauh
         pWJrl1KJo2qpVMt7eHW1O5Upypz5VFvZYx/cSSWpv8yjyKNpKD3jy9D9RQrdW4gsEuZt
         Vq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682968329; x=1685560329;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Qg1kbYxJALTgBqUNsp4V283ofK+vyrWLLXWcpOsSRQ=;
        b=JN9Xlj/CbLPFX7MD7vAVoCsqt+Jo2xc6nm2ASPEhXnTh8mncC9MSuIBqkvYjc7eurX
         svkig7str9kmC2SEj/WTC9ybgtTttGqj0e8l7kESp4GY1P7xs2gB4C8Gb5VyKPFcF5AB
         JuCwqQZDgPVL+fEpsxntBCvWuG6kmdduMU9voDwdCkVEOZu9sNSmZo1bvx7RIXWQRNbC
         PBdQD95iD6gSsCuoiz6Ebe7VZ+4bylEEevyPZyV6xd1G0UBY+By8kq6kY52ISH07J/pm
         sqJBIxEWFWmXFarFtS6SqtezA08coY6EOqcs5OQFPlhyMHTHxt8jbJJPMuYlnqNhqroq
         TCXQ==
X-Gm-Message-State: AC+VfDzQPR+tSsvu1Y5I61F11+B1ymNrXgEB8yoLhYyHmVvwlAB0eN9M
        L4e3THhx+Yr5RfFSE2IRvh1FUeQcqtk=
X-Google-Smtp-Source: ACHHUZ7uiKv7SZxaNRN/x5siAld5sx0ZOi2ZKllp76KBRY6j3JlfsNXAirPHt3pWM5fNty17bFO47w==
X-Received: by 2002:a17:902:d4c8:b0:1a9:4601:a7c9 with SMTP id o8-20020a170902d4c800b001a94601a7c9mr18329687plg.12.1682968328686;
        Mon, 01 May 2023 12:12:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001aaf370b1c7sm2535058plb.278.2023.05.01.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:12:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <xmqqcz3netxr.fsf@gitster.g> <ZEwafQmat347la3/@ugly>
        <xmqq4jow6lyh.fsf@gitster.g> <ZFAOpRpoPWjn8s1B@ugly>
Date:   Mon, 01 May 2023 12:12:08 -0700
In-Reply-To: <ZFAOpRpoPWjn8s1B@ugly> (Oswald Buddenhagen's message of "Mon, 1
        May 2023 21:10:29 +0200")
Message-ID: <xmqqmt2n50jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> being so close to the top. in fact, it's probably a good idea to add a
> DISCUSSION section with some basic guidelines, like git-commit has.

;-)  Sounds quite sensible.

Thanks.
