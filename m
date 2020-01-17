Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA6C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0374C2083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqtkgrUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAQPZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:25:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45710 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQPZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:25:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so22958590qkl.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hFN5VqcJsDJRb0EN1HAwBwZjs12HoH0tpOyVsfZiIHA=;
        b=FqtkgrUMxdUpJQvb5yZ0o2IizKH4ubW503e0yRcoI9Bs080wwlmubPY7t66byCWOdh
         nV26j7WyVzBwP5TlcuhEM6yUbMuhHBl7quZU+E0+uiP4ZSz8OLxmKqD6dqKDCW02py8S
         35PwkeoSBbyu1RNhBvOr3OPA6LUh8qhkCP6xBE6s9K68ZUdZFuWCl8hfjlRORGtM0zaP
         Qd+ae5Q3UeOoq0gxc1q8zxkA+jJ3/UCpCJwGaly7wOZmgi0oQEDXeldCQGY1xAXj/n6t
         NSOIbA5hyfEnG/oQfl/eo6F00iIgE8QQCrTzalgBs+5JX6zj1aNz5gv/gNOQkJXOytjQ
         QPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hFN5VqcJsDJRb0EN1HAwBwZjs12HoH0tpOyVsfZiIHA=;
        b=VEKhfTSvNpVaj8bmmvFULdSb5/NhTCbjOVoBcQmLEOqTyqgVz676MqeOv5QH9zX5N2
         JxJ2xmKgEFNnuZUmhAOwak1fcH8Eb/K5cfd0Tc2iLEcEIesT5PPOnpgot8whJpmcQYAb
         t2nKJa0nD/0iczyD8wI3QoKdhkF+NCpkHS7XLu95LK+LG/Yi8XoQa/mq24kSMsvTm2CC
         hiu7xaWM7Hz46o0HhI5q/17Q1um/qI9pG2NQF351yjcpV4lbcLc4xjsXdvBkWEqkGOyh
         yLJwOvB0PYPb4GuBlCjw/fqfEDV+TsK03h14m3otHv3uOT4kvBX/XQEv7aFa/c3NiscL
         eXuA==
X-Gm-Message-State: APjAAAWERUCpzVuChadrO7snEf/wQ/tcPXEjLozmnr1gqDxuzPvqKWNa
        4XRsehHRgv1W3Mp91iye9xizaJhlaFmFng==
X-Google-Smtp-Source: APXvYqzQoGhw/9qf59xKHmVMb1tNRIkZO2qfNBZKIe81Z7egS7i6n4vic5FddeWiLG/P+eZ3u4tanA==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr32070939qkg.89.1579274743864;
        Fri, 17 Jan 2020 07:25:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:64d0:3701:c4c7:2368? ([2001:4898:a800:1012:1604:3701:c4c7:2368])
        by smtp.gmail.com with ESMTPSA id l17sm12028180qkk.22.2020.01.17.07.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:25:43 -0800 (PST)
Subject: Re: [PATCH v3 2/4] dir: treat_leading_path() and
 read_directory_recursive(), round 2
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
 <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
 <ea95186774762a5e1cf3cb882cff45fc904e3bf6.1579206117.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd3892c6-98fb-d0eb-2e0a-f7d6971dd4d3@gmail.com>
Date:   Fri, 17 Jan 2020 10:25:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <ea95186774762a5e1cf3cb882cff45fc904e3bf6.1579206117.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/2020 3:21 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> I was going to title this "dir: more synchronizing of
> treat_leading_path() and read_directory_recursive()", a nod to commit
> 777b42034764 ("dir: synchronize treat_leading_path() and
> read_directory_recursive()", 2019-12-19), but the title was too long.
> 
> Anyway, first the backstory...

The backstory was helpful, thanks.

> Copy the missing bits to fix the new final test in t7300.

Thanks for the quick turnaround!

-Stolee

