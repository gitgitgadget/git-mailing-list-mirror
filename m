Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C52C433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A90C65004
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCLN4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCLN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 08:56:32 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95AAC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 05:56:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a17so3560124oto.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3YZdSUnqG16x4K+JGWW0dKB5AEzrIe4sfjuzzG9aDyE=;
        b=HdFQmQHImn1v6xGAtcZbbWlf2WvQWmEuNiN78Gy925eAMn3O9T3/kS8uptrIIBe5ng
         VUXWl/kP52dsDZ7Fnxpihuuwa3C4IS5RNwuUW+gc9LIoRK99QGz5UtHjVdalAmCsfls1
         WJArrKr6xe+kJ0aY2YtTY8oTTn5e2CcQUjhWyBouPTRiKb42NrexCUz9MwXg+V84bZpL
         B57K1DYGXpQB17N0XXjtI6REXxs6bTqYU2ggl4tLt58tMaV1OtrUG0pzsu/gX3mZSbZh
         b4+OJxN12DboLP+y2SWugem8FEHXBxvytLG4wTmX78L+vgr3gKhknan8tNDWr+gj/Pfa
         nLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YZdSUnqG16x4K+JGWW0dKB5AEzrIe4sfjuzzG9aDyE=;
        b=QhqUC2e8L15Mu5IAEid1GM+kxM/Ukn7hm8n/ErS+XLpUkoM4kzUDYZ3oDcFBiV5QeX
         45qeeE7VhJG3KWyxSZvWvo8XMvuw6PYFtRF4u1oCrQMHt/2p7NWRrE0hwQZwEEiqnE+1
         T6OXlWJBRjYfoFg8x2SYffx3IKfS8kDBlLfvKTPRb9I1gnC6CQG9GUoi7nSwL6aw6aDM
         4TZNE5lDGomPQQ2P5P8v8461uGocntBLmE7s4xd1MwcXk7GVnhmShMpwuLZPhoeOkhKV
         ji/oTjmwOwTi7+bZqzA6WZ7O1XHOkG3+kIoMocvj4I+B/jKrT7VzHycI1caMHfVD8tvw
         XiCw==
X-Gm-Message-State: AOAM532v4bzdj9CcoPsT5LOw8EjZWsCCPqP4OSLT2RxIShouZVB+LCh4
        F1zvIB8Pg938jWk1e5BiEfS8fCj8amF+9hNA
X-Google-Smtp-Source: ABdhPJxRt59/X8Tm7nOpat8G3/lDVPYt9qlJXliN2se9ztUVg5ZgE/UbZTzzom8EQPUPoG3g4IjEqQ==
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr3410495otq.34.1615557391297;
        Fri, 12 Mar 2021 05:56:31 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1448:4b23:85a8:b6a4? ([2600:1700:e72:80a0:1448:4b23:85a8:b6a4])
        by smtp.gmail.com with ESMTPSA id 33sm1347550otp.66.2021.03.12.05.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 05:56:30 -0800 (PST)
Subject: Re: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
 <xmqq1rckc1cb.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c5e42675-5f03-728a-60ec-880da368085b@gmail.com>
Date:   Fri, 12 Mar 2021 08:56:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq1rckc1cb.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2021 1:50 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  void ensure_full_index(struct index_state *istate)
>>  {
>> ...
>> +	int i;
>> +		tree = lookup_tree(istate->repo, &ce->oid);
>> +
>> +		memset(&ps, 0, sizeof(ps));
>> +		ps.recursive = 1;
>> +		ps.has_wildcard = 1;
>> +		ps.max_depth = -1;
>> +
>> +		read_tree_recursive(istate->repo, tree,
>> +				    ce->name, strlen(ce->name),
>> +				    0, &ps,
>> +				    add_path_to_index, full);
> 
> Ævar, the assumption that led to your e68237bb (tree.h API: remove
> support for starting at prefix != "", 2021-03-08) closes the door
> for this code rather badly.  Please work with Derrick to figure out
> what the best course of action would be.

Thanks for pointing this out, Junio.

My preference would be to drop "tree.h API: remove support for
starting at prefix != """, but it should be OK to keep "tree.h API:
remove "stage" parameter from read_tree_recursive()" (currently
b3a078863f6), even though it introduces a semantic conflict here.

Since I haven't seen my sparse-index topic get picked up by a
tracking branch, I'd be happy to rebase on top of Ævar's topic if
I can still set a non-root prefix.

Thanks,
-Stolee
