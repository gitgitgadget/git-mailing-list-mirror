Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6699BC61DA4
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 23:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjA3X1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjA3X1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 18:27:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE61351F
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 15:27:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 203so7714723pfx.6
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 15:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgiQn6X6RHiE4Dxwg0E2eIbl/l0QvST1EIpT6Is2tgU=;
        b=iR/d/QB+Lw3ORKDrBjrPCdmWKXpswS7ETZAq8xQJQE8vFAGu72Fl5nGJihEdkZvEc+
         RJm66rvKnbGkVRY82aICRRtLkfaFa7k6/53Xz+R2M8roElSFuUqZH1JncYOF8T++88RF
         hvoVY9UmOruycuYkUj7hmERMIRXBOeISRo7g+Rj/GWZV6+FoEmMndTXPYVvhYQW+X+is
         pKT1WiXoAGEcFV4UuNGKhvkVGDvJz4eGwSUNWIScu2cnGa4noOj8oOa7BvPwiDMsPEmA
         GGoT5g+pKQ+XfdnXJKVQFzyM+aBV/Ay1yvU8PCCAfDNZNB+ZZduWI+0EG/wTfgz8CHge
         O8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgiQn6X6RHiE4Dxwg0E2eIbl/l0QvST1EIpT6Is2tgU=;
        b=TvhShtOgOOBn/fxl5+DyrDGPDf/f3ddD+Y13Sg8L3liehY17XesVL7zO7yr8vfSMnr
         5KtMCEfAR/5gWdMuRnqFqFww/GsmCwQ2AXfaMy2B2MzkaR5cBbkdBqOey0hSqJHNLxPn
         oqFSzKhY4NMb01wPuQgFzFzmGBaZigxYqKGNPGRmiE0IVtSkIwtpcOxDPN5UkxP9lOx/
         4v8qWtNbB4qTyOATHLp7dQEnyjnNFDaJ9T91NWyEDamcVuKnM+Jg1s67av7pSmVgR+Jn
         yoE6v2K3NSpopKIHrhExgOMOh+kj3kYstrWBqbdHO8+hdhLsfVttVLid35QBx8Mq0eJy
         /liA==
X-Gm-Message-State: AO0yUKV0OaorvfKI14ssmWBNlKup3HRW8scnYLV9bs5TlsjhzkBQc5DK
        bUqpjetEXXsQ3wXCrwcxk53ZZtQyWf8=
X-Google-Smtp-Source: AK7set+p4p0a0lrlZUO80w2QAq0mbaSCBjhZKaawVRWvceeXUIoy6H7cR4znoDG8bUJpc5joFNvoyA==
X-Received: by 2002:a62:1a88:0:b0:593:92b5:d99f with SMTP id a130-20020a621a88000000b0059392b5d99fmr8650291pfa.32.1675121248670;
        Mon, 30 Jan 2023 15:27:28 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7957a000000b0059393d46228sm5112533pfq.144.2023.01.30.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:27:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Mathias Krause <minipli@grsecurity.net>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
        <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
        <xmqqk0131zxi.fsf@gitster.g>
        <55c75313-79d4-1c5b-951b-5d1e75553441@ramsayjones.plus.com>
Date:   Mon, 30 Jan 2023 15:27:28 -0800
In-Reply-To: <55c75313-79d4-1c5b-951b-5d1e75553441@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 30 Jan 2023 22:30:12 +0000")
Message-ID: <xmqq5ycn1u3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> +			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'%s",
>> +			    p->pattern, jitret,
>> +			    pcre2_jit_functional() 
>> +			    ? "\nPerhaps prefix (*NO_GIT) to your pattern?" 
>
> s/NO_GIT/NO_JIT/ ? :)

Indeed.  Thanks.
