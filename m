Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D3C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB4220791
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKSLSVee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgH0A5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgH0A5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 20:57:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B086C061786
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 17:57:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so3431313qtd.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ci+hILDxk9B9zWmgcTUUial5cPXhGa8Ya9LVdi97vrA=;
        b=vKSLSVeesIhMRvuv2FbAdFv6YLCI6awDuXMfajPJOrTRE7xi24fQTJzM9GqVWpYUgV
         DUIyShyqu37e8Gdu7MOY7ZZlE6cZF3wUcP3d4XlqIdqRVtMTXcBTCr2oOtiUFL2EGTxL
         eklRnkUdPRFSSK20PqRr819oOG96tPNuYbb0btCl6fAjU8SIiqBxyYTVMNz8P9WXqRtW
         P9R3ur0TY6fcsOIOmwLZdOCe1B7K1ORZyHaXRE/ST2IuzfTLqtoL0xvcDDi/VxBrveXg
         I9mAaXAjavkywl9sgWDAqspQZVFfixYU5klMW22ifvb4ZyUJreV8hm8UFEmlmqd/gKn0
         CtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ci+hILDxk9B9zWmgcTUUial5cPXhGa8Ya9LVdi97vrA=;
        b=b06LYUekwsP6Iwa98HEuNraNRQw7htaxRFf+MqkN+BYwSlvP5zdX23bKC+xeEEQY8z
         QgqrlUYSmn5BsOFWRax26/bc+Qn85Ctp0BK7Po2hg027StM7PeFhX465KHcn1LP2ws1N
         1ng5I6NCxvKsEDG6VUwpzLMdgQsz0pQOImrUIKbjNmf9hCoWB+ieM4Uj5g/I3YDJWOva
         9wytJEBwhhRFU4cC9iCFovpN6iQcJPW6dxE58bc86g/2aL4/DPwxa8w3Q4Ofu71dvKVG
         QMWE1cI4ujcMbHGxQqnNehi2BoX8Gh3YkVNVTGfIwIIpKzIU2fgq4+dtEAMHwX8C+/wF
         +jwQ==
X-Gm-Message-State: AOAM531eaQ9iGebGbureUoy0Sy79LZ6mGQePsOom4Qe4+dWQUXEPvAC4
        5o7Gau/PxzZh3ZnXONeRORL/9ugj1zEQtA==
X-Google-Smtp-Source: ABdhPJxGQrlmmZMr4mdLIbaRIMSIwHruZdxZq+/gm8dQUYZfcI7cnYDxVs/fnJYkPmj+mmv0JQ43gg==
X-Received: by 2002:ac8:3752:: with SMTP id p18mr12422101qtb.161.1598489866391;
        Wed, 26 Aug 2020 17:57:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id n4sm547314qtr.73.2020.08.26.17.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 17:57:45 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] avoid running "git-subcmd" in the dashed form
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07f26226-c1cd-494d-899e-d6452ad2751f@gmail.com>
Date:   Wed, 26 Aug 2020 20:57:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200826194650.4031087-1-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2020 3:46 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I think the cvsexportcommit and transport-helper changes are worth
>> salvaging even if we don't remove builtin binaries, so I'll split
>> them and whip them a bit more into a reasonable shape to be merged
>> to 'next'.  The "break those who say 'git-cat-file'" can be left for
>> future.
> 
> And here it is.
> 
> These two patches are clean-ups that are worth doing whether we
> decide to remove on-disk binaries for the builtin commands.  

LGTM.

> I droped the third one, that actually stops users from running
> built-in commands using the dashed form, at least for now.  It can
> be resurrected later if we really wants to propose removal to the
> users, but I am not inclined to make such a proposal right now.

I think that's fine for now. A plan to fully deprecate the dashed
forms can come later.

Would an interesting in-between step include removing the dashed
forms for builtins that didn't exist in Git 2.0?

Thanks,
-Stolee
