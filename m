Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E21FC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386AD206CC
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFWyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:54:41 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.107]:30419 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFWyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 17:54:41 -0500
Received: from [84.175.189.84] (helo=[192.168.2.6])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1jALrZ-0000wY-8R; Fri, 06 Mar 2020 23:54:37 +0100
Subject: Re: [PATCH 2/4] real_path: remove unsafe API
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
 <039d3d368662f3a7e208fa7aa47549ca2654574a.1583521396.git.gitgitgadget@gmail.com>
 <xmqq4kv12kvx.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <c1c3c6ec-6361-5711-15e8-01e5ccdb651f@syntevo.com>
Date:   Fri, 6 Mar 2020 23:54:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kv12kvx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.03.2020 23:12, Junio C Hamano wrote:
> If my reading of the code is correct, however, the first thing that
> is done by strbuf_realpath() is to empty the output buffer by using
> strbuf_reset() indirectly via get_root_part().  Calling strbuf_reset()
> here should not hurt, but it is unnecessary, I would think.  An even
> worse effect such a redundant strbuf_reset() has is that by repeatedly
> seeing the "reset then call realpath" pattern, readers who do not read
> the implementation of strbuf_realpath() might mistakenly think that
> 
> 	strbuf_addf(&message, "the path '%s' is really ", path);
> 	strbuf_realpath(&message, path);
> 
> is how realpath() is expected to be used, i.e. keep the current
> contents in the buffer and append the resolved path to it.

Thanks, will change in V2 next week.
