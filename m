Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C7C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F20207C4
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbhARU6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389782AbhARU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:58:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA361C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:58:07 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e17so3137279qto.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5suE1I4L39Lq5ldEP6JhPzv7DqV1v1CtyWzVsHASuBM=;
        b=W8zE4lLtD/blf1I/QKqPxjxM8FqcQYZIAZX++lj0DbTdR/sVSBp7lTVDGsFWlcH5tb
         RvAhq2jXNxJIUvv4HwajQ4jyDO0OvJO7YnXXT1FyYAykTV3RPs6iH5hgv0Y26u+ea69d
         8r2AMt3iSUCg7BdlqMdk5tgd0apm1JP+TbsSzAL1peuHwvlIxe8Fa96ZicGHDwX+uqmu
         7SRgX4eVEJK+kQyu8/ikoZiLlblqBMC+1L7nbfWBYmt+4yx33nqLPuygXnZd1A+0U0ZJ
         nWfC+5CttvHCMbkh5vKkqBEk+s2STrE5+fkFGwwfMrTKbfo+N0plquYoO9x2MNrKc9Qk
         3A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5suE1I4L39Lq5ldEP6JhPzv7DqV1v1CtyWzVsHASuBM=;
        b=VhhNmMDVD6DvVzvRn1bEws/aJeMaHVj2xkYHgonhwswZudryfZpA9Li6VT2y3uqbXH
         uW2RXd74r3LC/A7+00t2w8/QB8w4WDYaq4nZHKpyg72CMItTXu8Fk+lqY3uvZVG2DGFI
         ii6qXUJiuCYWcHAnm3se+ONLbjs5i+Nb0xEpdfpR7x0ta5uoWJ047/7oWvJ9wZwWGmcM
         JmhH/xcpm6iII0lgFdngF9gXct6g/nWuNMkk43lzCH5fjSmnebQ23iBmPe2jkmpZaPER
         5GDqvb2C0v7/bnLPJ+QbMTgUDyanIdFjufY795vyE2qRN7gNFCHvfbDlgZI4gF7fkTGU
         XLUQ==
X-Gm-Message-State: AOAM532UronSvoKe0xpRDg6QTjr0X9ez/le/nSsFO+YjWUeWcV4YMGgb
        WUHfeZTa9oPsrcGZBE3Rlzf8aFPRRBw=
X-Google-Smtp-Source: ABdhPJwhJc8dgeqWcTFro1OMK897uXJE4J512atr0hJImuKOZKArHrrB7Kym4fxGtacb4jAGNwHkxQ==
X-Received: by 2002:ac8:718d:: with SMTP id w13mr1357205qto.361.1611003486264;
        Mon, 18 Jan 2021 12:58:06 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1583:40fe:1fef:8885? ([2600:1700:e72:80a0:1583:40fe:1fef:8885])
        by smtp.gmail.com with UTF8SMTPSA id p128sm11445916qkb.101.2021.01.18.12.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 12:58:05 -0800 (PST)
Subject: Re: DEVEL: Help with feature implementation
To:     Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
Date:   Mon, 18 Jan 2021 15:58:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/2021 2:31 PM, Aiyee Bee wrote:
> Hi Antonio and Derrick!
> 
>> I think what you really want is --full-history --simplify-merges [1]. This
>> will show the merges that "fork" the history into parallel tracks where
>> at least two of them contain interesting commits.
> 
> It doesn't look like the implementation of --simplify-merges helps much
> here. That makes its decision on basis of the parents of the commit, which is
> simple to do as it's information attached freely to each commit. I think the
> problem here would be figuring out, given any commit, how many of its children
> are "relevant" commits.

You should definitely give this a try instead of assuming things about the
implementation. The algorithm uses a lot of "simplifying" that makes it look
like the decision is a local one. However, I assure you that is not the case.

Please assemble a test case that demonstrates the behavior you want and how
that is different from what is present in --simplify-merges.

-Stolee
