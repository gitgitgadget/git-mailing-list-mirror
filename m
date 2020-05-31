Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46337C433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D820723
	for <git@archiver.kernel.org>; Sun, 31 May 2020 16:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuHA8t0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgEaQ22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 12:28:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63402 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQ22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 12:28:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC4C4D20CF;
        Sun, 31 May 2020 12:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bJBXcB9Oy32aQ1QvmHjKWX2jVFk=; b=FuHA8t
        0JUvZkAuYNihwrJBLab9Qg2k5hyzyAYk8fpGBuass+c+rDHqfZL0ul0YldW/qtiC
        jndwOgPbG5Z684P130Fd33mvhaxKmyZr8QkfqPuHPUySO8Z27fI+0fpCWjfawqsm
        VutmEq7krv6kwUbfRTUHpHDNS7Y1h4cGzrnpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MOuePSPe92+26Uy1mktrCqTw+gE4JmhG
        qu7Gw65yozdqgSZkrIAvLRL2/86KPNYvHfvD65njRGp9LKeCBwu6lTIpvo5G/VzK
        AJ3D9TjocDz29ExRBGEesa9vTX5x2F0+hggzFHdLYFvE3gX+WWKwUkE4A9iiGbBm
        BsRI2VbV7sQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D405AD20CE;
        Sun, 31 May 2020 12:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 250F7D20CD;
        Sun, 31 May 2020 12:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/4] Selectively show only blamed limes
References: <20200525215751.1735-1-philipoakley@iee.email>
        <20200527072318.GA4006199@coredump.intra.peff.net>
        <0da84168-3d81-fb14-32ad-010ef2436958@iee.email>
        <20200528164533.GA1223132@coredump.intra.peff.net>
        <xmqqtuzww0si.fsf@gitster.c.googlers.com>
Date:   Sun, 31 May 2020 09:28:23 -0700
In-Reply-To: <xmqqtuzww0si.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 31 May 2020 09:02:05 -0700")
Message-ID: <xmqqlfl8vzko.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C04A8C1E-A35B-11EA-8791-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Instead of teaching each and every tool (like "git blame", "diff",
> "grep", etc.) a special trick to remove the lines from its output,
> it may make a lot more sense to add a feature to pagers that lets
> the users selectively "hide" the matching lines given a pattern.
> Then when viewing "git blame -b" output, you can first declare
> "lines that begin with a whitespace are sometimes uninteresting" and
> then tell your pager "now unshow uninteresting lines", "the same, but
> show 3 lines at the boundary of runs of uninteresting lines", "now
> show everything", etc.

I forgot to say what I wanted to touch a bit more.  Such a feature
in pager is readily reusable for other types of payload.  "Lines
that begin with a whitespace are sometimes uninteresting" can also
be used for output from "diff -u -U<largenumber>", and "lines that
do not match '^[^:]*:[0-9]*:' are not interesting" can be used for
output from "grep n -C".  That would be a lot more sensible than
tweaking each and every tool that generates output that sometimes
needs to be read in full and sometimes needs to be shown with less
interesting parts ellided.

