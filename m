Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FEF20958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbdCWTMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:12:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51394 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751365AbdCWTMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:12:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73E7B65353;
        Thu, 23 Mar 2017 15:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1BherfUOhVyttzKkX62ix/8d0oY=; b=Xe2WGw
        I4qxaXkALPQtNvK8Erg6s0T8Iopg+t5u3a/Q/9PvJQMwvLPoHUCT69FJUjQHhDwg
        VqCKap83FgePx6JIh4RAj0stD/1jnLhX50hvQuFJz+lM+Sl7oOZFlN6pUrH76uB7
        h10Jq33rAefANSLMKavyv+9dy8Wo7h877nVX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cxRcK13DbLlbXL7pGOvHFtTNnUkZfkmB
        7rFd5iAGWLj6qcx88aSpqfViLo6N5S1D8XfipAsy5aFZa4R5aPIAoG6SXvJdYX3T
        VRaxgNXDqP6AXjq0IwXYEp0s6/VtFHOuRQyqvXnHdTJTH1boaHtLYaJcALCYf5K8
        6yqUecVW6dQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B66F65352;
        Thu, 23 Mar 2017 15:12:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9CE26534F;
        Thu, 23 Mar 2017 15:12:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
        <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231716320.3767@virtualbox>
        <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 12:12:15 -0700
In-Reply-To: <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 14:01:34 -0400")
Message-ID: <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A12E050E-0FFC-11E7-8479-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For instance, if it's in the environment, can I push up a branch that
> does "set | grep GFW_CI_TOKEN", open a PR, and see it? I don't know the
> answer.

I think the documentation said

    Variables defined in repository settings are the same for all
    builds, and when you restart an old build, it uses the latest
    values. These variables are not automatically available to
    forks.

so we should be safe as long as we do not build against PRs.

On the other hand, perhaps a contributor may want to build and test
his own PR that may affect Windows platform, and such a contributor
may be helped if the main repository sets things up to build against
PRs.  

I personally think it is a separate issue and we shouldn't set it up
to build against PRs.  If Windows CI wants to help these
contributors, it can give out the token to them, without relying on
the travis setup for the main repository.


https://docs.travis-ci.com/user/environment-variables#Defining-Variables-in-Repository-Settings
