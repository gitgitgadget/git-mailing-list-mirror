Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DC11F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbdLKSyB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:54:01 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:31688 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdLKSyA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:54:00 -0500
Received: from [192.168.2.201] ([92.22.15.141])
        by smtp.talktalk.net with SMTP
        id OTDAe5cTEbjdZOTDBeQPol; Mon, 11 Dec 2017 18:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513018438;
        bh=51YSCSNJHQUG/mSiKbuMRCJH4I4rG/59sEsSAWHXmhA=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jWhWNQtsKbpPftjK3Ox3jbd27DXPh9C8EFyK9PBHI2Leb/+/SOfUyNIxQg0dhHWP9
         K7Q1Id+spTY6y8rF+VmHTnroVBB3fjQ4n7/KnzOp1MlYZ69V+I3JcKVjN0iC8Wk5qL
         z75VREFEv/V3z1ZtpXyHT8Eq3YcfhaFghD2o0fu0=
X-Originating-IP: [92.22.15.141]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=GtR6SX75q4uFXsZmIa626w==:117
 a=GtR6SX75q4uFXsZmIa626w==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=Cr1b9nZcfOjF-NT5jEMA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 7/9] sequencer: load commit related config
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
 <20171211141330.23566-8-phillip.wood@talktalk.net>
Message-ID: <8bf28a43-fe0d-67c9-0a47-3e022a406ad7@talktalk.net>
Date:   Mon, 11 Dec 2017 18:53:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211141330.23566-8-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL4TJpz1RCf8NHdTKiV6j5e42qtL96EK5aRGHQwEE+KX9DRwfWtThK/svvPs2Uj1eKq6cI+Ve9qYhulkzgp19/QGdaWdZRfShxR07Q8M4HOFM5T+CldY
 +n0NfglPvbRuMqPBc0oTb4ZvwxBoecHo3rOEDQp/R9ILbU1x6FGCMcl9Lq6MijCixnERLsXFejzWwgfj7DqA0DdzKFGwNdYJIjkAIKE7ZKAuzHJWJ82vg7da
 Bz882xrDE2p0L8taV4bJrBjybApzNtG4VGJ6Dnd7Qe7FwFFHjrCV5OWa3JH0iyQCfpPof0ZEuhxNLvc8cy6cpByMT0JE7JKGLqrgD2cnKWPmvaJYAlQ2/pmd
 D9mKgCng4hyycw3bDoJnj59hyWWp8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/17 14:13, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Load default values for message cleanup, gpg signing of commits and
> basic diff configuration in preparation for committing without forking
> 'git commit'. Note that we interpret commit.cleanup=scissors to mean
> COMMIT_MSG_CLEANUP_SPACE to be consistent with 'git commit'.
> 
> The sequencer should probably have been calling
> git_diff_basic_config() before as it creates a patch when there are
> conflicts. The shell version uses 'diff-index' to create the patch so

s/diff-index/diff-tree/
