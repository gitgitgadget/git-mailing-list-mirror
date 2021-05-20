Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83659C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C9760E08
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhETC2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETC2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:28:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8BC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:27:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l70so10804286pga.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PVlnbGkkQ9Ek/0tTibMgWc/ekimblhXSqRSsC0Q4D38=;
        b=FEgQfup8vNVZIQkdt7jhQGc54vMflWBTBkCTfPeaJZIKR4Pdd95wlQa5k1tsFgj/8i
         IVgCp2hirxm//0a9l4HKNpY9Xv6ktTOVO+3yxxyIpG7rAw8MN86ntvBL7UPnD2WB02nc
         NEVf6dmykaYXBecrh7IMtiYkNwHwUqdH/UzIyONIGBAkoYRLBmCyzX+pK3rHO5fe63yA
         Dlm85Nwgt7cZf07pa13RR7lNAdsc0ICmxrah3PMa/vNeAPDA6+PqdJFzdVb0PbL8kmIY
         xShOhtQx9QnO28xoA4DUBW8TNeKBI/6MyR/NR+z5wkxkSGGhn0lRyENVgL4v+NO+zY7T
         ISzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PVlnbGkkQ9Ek/0tTibMgWc/ekimblhXSqRSsC0Q4D38=;
        b=IyVUC33n6AW0LBAqFCWZoeA1HLjSf8+b7c9emdW5IOnh5+yNMlIvNo8dAxkm5CREq4
         5vtkUANDLRbvgGg9OEnbnSNvRU9+4FfrDbl8w9RuExJN9T9etZci4LdH2OnwC7lIsWix
         C26LUA5kiz/XkuH0BZHl3xm3oadmI6tyWermtq0X1aaq9yJ7uExi04as6e75rbicy6pk
         1zn4Bqv4DXBqPVYxEEU6PwGmsz2W17LYorbNBGVOStsS4mUANzBHvb5s978rFLM6OPuU
         +NrNkoZoettIMrJSs90dBu/TQtAP4hEavjC4DaNK+ws1NRvbGrMizWnH9pPqwi6gAzE+
         m+sQ==
X-Gm-Message-State: AOAM530xlzQ2wSF91EVOAg8XSu0ja0Eu1sgKOXE5Kmu8ykrScyrzcwwJ
        BPOjHlAQ6/3o1H6mB27Mw2YzhOSlcdOD2g==
X-Google-Smtp-Source: ABdhPJw6yvEfi/TLTRPoua8vQ1MbQGTjdOuq42oQSUV9h5ZrItds/4dWGLo2rj/phNIpxJhGo5sGNA==
X-Received: by 2002:a62:5306:0:b029:2de:6ce0:5526 with SMTP id h6-20020a6253060000b02902de6ce05526mr2386684pfb.13.1621477649586;
        Wed, 19 May 2021 19:27:29 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-65.three.co.id. [223.255.225.65])
        by smtp.gmail.com with ESMTPSA id h26sm517757pfo.203.2021.05.19.19.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 19:27:29 -0700 (PDT)
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv97g2svd.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
Date:   Thu, 20 May 2021 09:27:26 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqv97g2svd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/21 18.17, Junio C Hamano wrote:
> +Commands that are specifically designed to take two distinct ranges
> +(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
> +they are exceptions.  Unless otherwise noted, all "git" commands
> +that operate on a set of commits work on a single revision range.
> +In other words, writing two "two-dot range notation" next to each
> +other, e.g.
> +
> +    $ git log A..B C..D
> +
> +does *not* specify two revision ranges for most commands.  Instead
> +it will name a single connected set of commits, i.e. those that are
> +reachable from either B or D but are reachable from neither A or C.
> +In a linear history like this:
> +
> +    ---A---B---o---o---C---D
> +

So "git log A..B C..D" is same as "A..D", right?

-- 
An old man doll... just what I always wanted! - Clara
