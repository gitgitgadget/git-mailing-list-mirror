Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC563C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 16:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJMQeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJMQeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 12:34:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D9144E0C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:34:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD44C15C645;
        Thu, 13 Oct 2022 12:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4EVek/8hvA/pcj6P+mvWzj3kVznYNY15e988FksgEMc=; b=PFil
        zITmyWFHzkKRxxoP5nwneKlOj3HfzqmznwSLhuWaOtKB57fE2FxsrKe4SYm6N5aw
        SXt8cJ6B5YD2Si97GmIcm7viowk4P8A+Csk+bfLIAAmhf9hK6s7yr8vo96CNAdbY
        AvpRNK6NQTh/W8VKkuzhfDDVanUf69INVKMxtKA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D44CF15C644;
        Thu, 13 Oct 2022 12:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C0115C643;
        Thu, 13 Oct 2022 12:34:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/8] rebase: store orig_head as a commit
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <dc056b13ed5c62729f97bd2cedbe769c531f4bc4.1665650564.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 09:34:13 -0700
Message-ID: <xmqqilknhed6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFB4AF5E-4B14-11ED-831A-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To avoid changing the behavior of "git rebase <upstream> <branch>" we
> keep the existing call to read_ref() and use lookup_commit_reference()
> on the oid returned by that rather than calling
> lookup_commit_reference_by_name() which applies the ref dwim rules to
> its argument.

I agree with the above in that _by_name was an overly broad and
wrong function to call.  But ...

> lookup_commit_reference() will dereference tag objects
> but we do not expect the branch being rebased to be pointing to a tag
> object.

... if we do not expect to see a tag object, why call _reference()
in the first place?  Does lookup_commit() not work for the purpose
of this code?

A bit puzzled...

