Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC5C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiDRQbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiDRQbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:18 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3272FFDC
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:28:37 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ngUEu-0004AW-76;
        Mon, 18 Apr 2022 17:28:36 +0100
Message-ID: <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email>
Date:   Mon, 18 Apr 2022 17:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email> <xmqqczhe1jgp.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqczhe1jgp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/2022 16:48, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> The rerere man page is still magic for me. The UX here could be
>> improved. (also, could the rerere-train be focussed on each merge?)
> I am curious to see a clarification on the question in parentheses.
>
It was the feeling that the rerere-train currently (IIRC) will parse a
whole set of commits & merges to create the rerere database and then try
an apply all the potential resolutions when called upon.

Thus for the 'replay' scenario, it could be that the database is
partitioned and prioritised so that first it applies the resolutions for
that particular merge, then considers previous resolutions, and finally
starts using resolutions that occur later in the series being rebased.

There is also the possibility that the rerere database is updated after
each commit resolution (and especially as merges pass by) so that the
'prior' resolutions are up to date with any of the current semantic
changes, rather than being outdated so could be applied first (i.e. two
rerere changes being applied to the merge..).

So, essentially, it's talking a small part of the rerere-train at each
step in the replay, so that it's more focussed.

Philip

(this all assumes my mental model of the rerere magic is roughly correct ;-)
