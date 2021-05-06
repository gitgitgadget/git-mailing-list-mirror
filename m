Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E70C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81916610C8
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhEFJKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 05:10:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhEFJKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 05:10:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 265CF122532;
        Thu,  6 May 2021 05:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K7UpYMhYjhRt0qkuz2PcXVr8mGvYt04s3sGeYx
        Q3FzE=; b=sJLy1GahBmx5Nvy02P30Jb0hFyJNcR83KcdXT4PywBT/xIaSyFRwkU
        0IxWl5O0RsZVM2Bue1ltfXGToBXqfnC+y1tLCdXGWim3lE/cVtuwGDR/TXSEoAxv
        WxjB8jMRv6nj5VIF63ILCD5KssPN3TDvgVnaS+uvRrRGLFmqSwf+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DED3122531;
        Thu,  6 May 2021 05:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DAD1122530;
        Thu,  6 May 2021 05:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
        <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
        <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
        <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
        <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
        <xmqqbl9oz27g.fsf@gitster.g>
        <f1bf3086-8c89-f0af-c0c7-f427a935771f@rawbw.com>
Date:   Thu, 06 May 2021 18:09:32 +0900
In-Reply-To: <f1bf3086-8c89-f0af-c0c7-f427a935771f@rawbw.com>
        (yuri@rawbw.com's message of "Thu, 6 May 2021 01:41:13 -0700")
Message-ID: <xmqqy2csxm7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C660825C-AE4A-11EB-9CD9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> On 5/6/21 1:38 AM, Junio C Hamano wrote:
>> Unlike centralized SCM like SVN and CVS, commits in Git are private
>> until you make them public by pushing, and you do not allow other
>> people to fetch/pull from the repository you actively work in.  If
>> your commits become public immediately after you make them, perhaps
>> there is a room in your workflow for vast improvement.
>
>
> Let's say I make commit1, commit2, commit3 and then commit4.
>
>
> How can I push only commit1 and commit3, but not commit2 and commit4?

You don't.

> Can I permanently hold some commits from being pushed while pushing others?

Yes, you arrange these unrelated things (e.g. if commit1 and commit3
can become ready to be used without commit2 and commit4, there is
*no* reason to build commit2 as a direct child of commit1 *AND*
build commit3 as a direct child of commit2) into multiple branches,
keep unrelated things separate and related things together, and push
the branch commit1 & commit3 are on (obviously in your example they
become ready to be consumed together while commit2 or commit4 are
not, so they wouldn't be on the same commit as commit2 or commit4).
