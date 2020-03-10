Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60537C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C8222D9
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wXFT/p0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCJU6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:58:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62519 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJU6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 16:58:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE1B5B4A67;
        Tue, 10 Mar 2020 16:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e+aT5KV4RMB479WnJNxi9f5fxJM=; b=wXFT/p
        0Ell4oCs0afc78eYqsrfmZ9m+C8lBp5EWTqETXYaiod6FGyOLoeIgKvqUcYYiGbN
        VrKkCC/ctlOpz56oia+t1w+4yQgOpsqikGgdddKAvge8gGZZJOSEic8llyzNYhkX
        8OmxdPcpaaSkx2g2c6a16orG1KDXrtSobC5kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P2/usNpLMQTLQT+i8fAr45tUlGkaVY7z
        FT26RQS+hScrf3aYLcY6cwg48BPeBrZPx1a6wNPKZvWvjuYU6bO6EXXtpdPwp9cl
        7bo2CEfcgLQ/PpHoEfWkjplHw1Zy8obVIhJMaAi56AZSVwu+OidmlDUHmctZ4MjD
        a5GhdMRILCU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6114B4A66;
        Tue, 10 Mar 2020 16:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32E42B4A65;
        Tue, 10 Mar 2020 16:58:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
        <20200310174017.GA549010@coredump.intra.peff.net>
Date:   Tue, 10 Mar 2020 13:58:12 -0700
In-Reply-To: <20200310174017.GA549010@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 10 Mar 2020 13:40:17 -0400")
Message-ID: <xmqqa74ohqqj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC7154CA-6311-11EA-97B7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The first change is that we'll now open an editor when continuing a
> conflicted rebase. You can see it by running this:
> ...
> We won't run the editor the "apply" backend, but do for "merge".  I'm
> not sure how big a deal this is.

Back when "git am" was written, it was not considered a bug that the
"git am --resolved" option did not offer the user a chance to update
the log message to match the adjustment of the code the user made,
but honestly, I'd have to say that it is a bug in "git am" in that
over time it wasn't adjusted to the new world order where we
encourage users to describe what they did when the automation
hiccuped by opening an editor.  These days, even when automation
worked well (e.g. a clean auto-merge with "git merge"), we open an
editor.  The world has changed, and so should the expectations.

If it were that we used to let the users edit and the new behaviour
is to auto-continue, it would be a quite drastic behaviour change
that may annoy the users, but fortunately this is the other way
around, so it may not be too bad.  Having said all that, I do not
mind some workaround, e.g. "git rebase --continue --no-edit".

"GIT_EDITOR=: git rebase --continue" would be a usable workaround
that does not require any code change, hopefully.



