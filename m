Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0AC211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 05:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeK2RDR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:03:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54414 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeK2RDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EE4D1061DB;
        Thu, 29 Nov 2018 00:59:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K7vaoAKJSl/rAfr+l0kahCTfZJ8=; b=uRC9cy
        v6fGk1Wkk6eSDbpycHupp104CxkWMitve3HfyBYdcM8VIBIIjRcW8eNPtRph1LT6
        iYwbsb8okDmI/swCyi99YIF2E8uwnOVM7ZClOV3zmeXoPIq/zvKghBVEyIbBmsHo
        CwcNCSOEq7px6dN8NWvp7AJ224S21ADboLNcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h+TVzIj1MT0oLIMaOwCG21MLkd2gSbNu
        2LkMc2olthGGgZiKJQfawMMGeDh8EDDgHcfXecGdhLq9KNGSNWbKnp4xAyrItxBf
        gVc0V7ugATsDcxu683puB38dXxR2VrqnSVP6s14cJvS0ZCX/BexaVTbzloKf9Bzs
        Z4v5NGA91Zc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26D341061DA;
        Thu, 29 Nov 2018 00:59:02 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 825431061D8;
        Thu, 29 Nov 2018 00:59:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     pclouds@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        t.gummerer@gmail.com
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-7-pclouds@gmail.com>
        <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
        <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
        <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com>
Date:   Thu, 29 Nov 2018 14:59:00 +0900
In-Reply-To: <CAPL8ZivJ+=Y=8pxvs3sJrdxVtkn9xfTA63GeHcr=J0Y2JscOMQ@mail.gmail.com>
        (Stefan Xenos's message of "Wed, 28 Nov 2018 15:26:50 -0800")
Message-ID: <xmqqd0qopgpn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEA2EAD8-F39B-11E8-B34D-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

> Although I have no problem with "switch-branch" as a command name,
> some alternative names we might consider for switch-branch might be:
>
> chbranch
> swbranch

Please never go in that direction.  So far, we made a conscious
effort to keep the names of most frequently used subcommand to
proper words that can be understood by coders (IOW, I expect they
know what 'grep' is, even though that may not be a 'proper word').

> switch
> branch change (as a subcommand for the "branch" command)

It is more like moving to the branch to work on.  I think 'switch'
is something SVN veterans may find familiar.  Both are much better
than ch/swbranch that are overly cryptic.
