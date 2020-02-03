Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490F8C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDEE2086A
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsJiNVFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgBCOJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:09:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43092 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgBCOJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 09:09:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id j20so14264066qka.10
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 06:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1DlYWRz6kg/7KrTNUaOMo1y3A0kSh6aQQhMuC/hXSJg=;
        b=MsJiNVFmty5pKmt2DrGeL6jg9lMaBZUfbPl0zMp4sXtUYeeiaa6k8GWJXe95/cWKlC
         OCMTSBQ+KGx8NgWnKNpFTYtUoCtPbeL8M1eRMp5u4iZ3PIAUMdyMsPuwawokynPo2KDQ
         rp0xJSsZZcoziBCxLiHB1YMOwpsgX1Aq37q3d2kL/dm46qykg3tViKIEHv3XDYfNRNyf
         wYLQkyiXwiqem+BUiinaxf3ipnZb6yaHx96xdi+LDzVu68er7jhYRUZIGI30sxSv2Qvs
         KRp00HVZHFlnW1s/m9nD3aOPygAF9qOH5J0oXv/zi73BzxvotB9P3ce8oEOqvHm5KC+B
         6z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1DlYWRz6kg/7KrTNUaOMo1y3A0kSh6aQQhMuC/hXSJg=;
        b=i2LrQhMbSK+xThvqLknPwVdnFKNpdyVOescaDrF6Ufr9yagbt7n2bYtlQSjt1txiQl
         vkbk/XSKVv8v2aNmmD35py/e6x2qMpcEIS/ob+tLhfE6X005nXDch/Mc2nILSHWoubrM
         Mv35dPbvAH7jVdt5V/++f4kCbikXZaSAge49jcH0a+z6xY484pvfiRqUmxCcYF/4fDhK
         Y3tpwB+XPZMLx4gP0LOkwyAUgqPLI3TzuXs+PQlcyrN0i2GxIrJcL9BwditQP8STF3M8
         Da2CAvZYZHfTHdtJzrXulv+LWCFi/kwoXDYfBVw7aYZ339mX8j3tD05RfwRTF2X//kis
         NG4w==
X-Gm-Message-State: APjAAAW1j9DmiMa7BEDxRSDCfDKbppxk+rYauJsH+RSkCpJRPZHS+THy
        3oiQiMOZ+GbYIsg4p3krNSk=
X-Google-Smtp-Source: APXvYqzpzzk/VWe0QQFztsB7EghMQaqcYlAOGdAWQNoiMySoJcd85tvMbxlixb1X1aFyFyDh1nLhZA==
X-Received: by 2002:ae9:e707:: with SMTP id m7mr23367593qka.320.1580738995943;
        Mon, 03 Feb 2020 06:09:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:f9af:5998:2ee3:6a09? ([2001:4898:a800:1012:aae3:5998:2ee3:6a09])
        by smtp.gmail.com with ESMTPSA id a145sm9344029qkg.128.2020.02.03.06.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 06:09:55 -0800 (PST)
Subject: Re: [PATCH v4 00/15] Harden the sparse-checkout builtin
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Finn Bryant <finnbryant@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
 <CABPp-BHoEgYXgzxjweWDR2BZPhLdW9wcbWzwo6N+HF2kste3WA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f28beb17-50dc-ff53-46bf-35010d48d23d@gmail.com>
Date:   Mon, 3 Feb 2020 09:09:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHoEgYXgzxjweWDR2BZPhLdW9wcbWzwo6N+HF2kste3WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/2020 3:36 PM, Elijah Newren wrote:
> On Fri, Jan 31, 2020 at 12:16 PM Derrick Stolee via GitGitGadget
>> Update in V3:
>>
>>  * Input now uses Peff's recommended pattern: unquote C-style strings over
>>    stdin and otherwise do not un-escape input.
> 
> ...and updates in V4 are?  (I looked over the range-diff which
> definitely helps, but a summary would still be nice.)

Sorry! I definitely should have double-checked before sending.

Updates in V4:

* Special-character checking now considers all glob characters
  ( '[', '*', '\\', '?' ) See Patches 8 and 13.

* Patch 10 is is now split into two (Patches 10 and 11), to properly
  escape patterns and to unquote C-style strings. 

* The file/directory path bug reported in [1] is fixed in Patch 15.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com/
