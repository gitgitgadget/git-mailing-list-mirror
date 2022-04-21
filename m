Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDDC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392176AbiDUUHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386080AbiDUUHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:07:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313024BFC0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:04:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B149119C28;
        Thu, 21 Apr 2022 16:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OR926BIpFX9HHq5xLZ63tXt2aFlVB4GJHrYEXC
        pYw7M=; b=gSvhmbl0yrkTrLe37b9PSKyYKrnDIIqTWMVHnd2GpGIWNWyvXa43zX
        two5XS0mIkS98+c20AVWXyp8cPSOt1oEltjX2waWCFlKMUjo9U8xc3coY8GWYOqu
        gK7Al2bRShtJUQ0itPIEx3nRndSc3DrYpXV9nxiqtFoDh+8NKrE4s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73390119C27;
        Thu, 21 Apr 2022 16:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D883B119C26;
        Thu, 21 Apr 2022 16:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org
Subject: Re: Should sendemail.confirm default to always?
References: <20220421194832.lshqkl3bogy2f2hy@eve>
Date:   Thu, 21 Apr 2022 13:04:29 -0700
In-Reply-To: <20220421194832.lshqkl3bogy2f2hy@eve> (Alyssa Ross's message of
        "Thu, 21 Apr 2022 19:48:32 +0000")
Message-ID: <xmqq8rrygq42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41801598-C1AE-11EC-B4A3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alyssa Ross <hi@alyssa.is> writes:

> I was recently having a conversation with some people used to the
> GitHub-style Pull Request workflow, who told me that they feel scared of
> using git send-email in case they make a mistake and e.g. get the
> recipients wrong, since they can't correct it after sending.  They can
> resend, but if they do that they'll feel like they're bothering some
> very busy people by having sent them the same message twice (regardless
> of whether those people are actually bothered by it, it's scary).

If it truly makes sense to give a roadblock before sending to
prevent mistakes, I wonder if making "--dry-run" the default is even
a better idea.  Getting "are you sure [y/n]?" and saying "yes" out
of inertia is much more likely to happen than typing Ctrl-P on the
command line to take the previous command (which did a dry-run by
default) back on the command line and then adding "--no-dry-run" on
the command line to allow the command to actually send out the
files.

Another idea is to forbid the form of "git send-email" invocation
that internally runs format-patch by default and force users to
prepare format-patch into files beforehand.  Doing the format-patch
as a completely separate step means that the user has a final chance
to proofread the log messages (and correct them as needed) while
adding and verifying CC's, and removes the pressure of "pressing
this button is a point of no return; did I catch all the
embarrassing mistakes?" at the last second.
