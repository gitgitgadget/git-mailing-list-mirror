Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7091F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHVqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:46:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65387 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHVqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:46:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BEBD15687E;
        Thu,  8 Aug 2019 17:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S9SjKaBNjSrHEe9XmCWXF5Y82us=; b=mIQ0XE
        FGxk4/q4iu0FzMh0IgUQvrkKZSJ88+ItZcS/WSlMogfp1Y0DF8q51bXOBJWalabC
        ChO52Hon2WGnfUYs4Zl1FpdeU8ZTHFtJ1TdcQ69iU68kG+OWEL04KcHPzL23ThgN
        1WWHsgML2T8kq8LSDg+8/CfKyIP5/QgKKQTq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tzID+NanuHqr6DJoR6s5lhOvhmyerrdf
        Hx3C0KIsIsVw2X/oCTB/tVP/OmriwYrd1M9JR1MuIdbkcRH+1Vjcf3AEHYKnRPIJ
        RenoW7jme/jgV4G8S+y1lGKsTNHYNIGHCA16bHq9HL90ozxe8sHIwN4WxHISyfaA
        3rjgkIkzDU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53A6215687D;
        Thu,  8 Aug 2019 17:46:39 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD73F15687C;
        Thu,  8 Aug 2019 17:46:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Bryan Turner <bturner@atlassian.com>, jim.cromie@gmail.com,
        Git Users <git@vger.kernel.org>
Subject: Re: $> git branch splat response considered harmful
References: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
        <CAGyf7-FUsfKpr+HzOpS9TqE+x7GTnsVKki94gXzMVRwnnweC9g@mail.gmail.com>
        <CAJoAoZ=K0LhCmnEUk1rsan2J5APzcye7+RryjBG+mKgjGf6qzA@mail.gmail.com>
Date:   Thu, 08 Aug 2019 14:46:37 -0700
In-Reply-To: <CAJoAoZ=K0LhCmnEUk1rsan2J5APzcye7+RryjBG+mKgjGf6qzA@mail.gmail.com>
        (Emily Shaffer's message of "Thu, 8 Aug 2019 14:28:05 -0700")
Message-ID: <xmqqo90ze3eq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 004A709C-BA26-11E9-88D2-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> More generally, I think you should take a look at `git help git` and
> check out the difference between "porcelain" and "plumbing" commands.
> The former, of which `git branch` is one, are intended for interactive
> use and not really meant for scripting or piping. You can usually come
> up with an equivalent from the plumbing commands, which Bryan has
> suggested for you with `git for-each-ref`.  Git project tries very
> hard to maintain output format of the plumbing commands so as to not
> break folks' scripts, but such promises aren't usually made for
> porcelain commands.

Thanks for a detailed response.

Git project promises that output format of the Porcelain commands is
subject to change, in order to support human eyeballs better.

Unless documented otherwise (e.g. "git status --porcelain"), it is
unwise to try parsing porcelain output---your script may break any
time and you get to keep both halves.

That is not the same as saying "do not script using Porcelain".
Sending the output directly to the end user (e.g. compute the
revision range in your script that finally calls "git log" using
that computed revision range) is perfectly fine.

Thanks.
