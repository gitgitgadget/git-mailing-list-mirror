Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320F51F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 23:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfHOXky (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 19:40:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52545 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHOXky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 19:40:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F22AC160EF6;
        Thu, 15 Aug 2019 19:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ES290LVVJlJuT5J6DvW2MuR21U=; b=TU7US2
        URjbnAEs7A7GhYeTwO+Zn1TltEosomBYPP8ICa7jbzt3oHvmq7NCafuf74+tYutc
        FdboQuMvp7jQ9JhMNbAjAN8UmWCtq4z7uno7lZoJo8wUzAmvAUKz6T+pltDvHu4Y
        1ngHJ6Cuw5Gpl9zT3fm72rhkdxIQVZP/VR74M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DwfGAHKkACK3dKEZgzQ89+WXm6XeT0HK
        Vskh9j6v3XKK/jrE6pxQB3mcVSu30pEtG9jT6KT5zSw42oWSQv+M6S8eA8GRnpFD
        D9IiOVzyES6vGe73O7vJ+StNwIZucjUPtbZkUWhxwMOR1b9SpIgohuRjYJEaKI30
        ZIBRewRmFlI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EACBA160EF5;
        Thu, 15 Aug 2019 19:40:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68049160EF4;
        Thu, 15 Aug 2019 19:40:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
References: <20190815023418.33407-1-emilyshaffer@google.com>
        <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
        <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
        <20190815225231.GD208753@google.com>
Date:   Thu, 15 Aug 2019 16:40:50 -0700
In-Reply-To: <20190815225231.GD208753@google.com> (Emily Shaffer's message of
        "Thu, 15 Aug 2019 15:52:31 -0700")
Message-ID: <xmqqwofe0zgd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DAE7E68-BFB6-11E9-9999-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think a whitelist of config options to print would grow stale
> immediately, and the options we're missing would be very likely to be
> configs to turn on new experimental features - which is probably what we
> most want the bugreport for.

The implementation of your "git bugreport" command comes from the
same version of Git as such an experimental feature you want
feedback to is shipped with, so I am not sure where your concern
about staleness comes from.

If you really care about getting quality reports, you need to earn
users' trust (one way of doing so would be to maintain a good "list
of benign configuration knobs whose values help diagnosing issues"),
and you need to make sure we obtain relevant pieces of information.
Both of these things are something you need to actively work on.

We have trained ourselves to the point that we consider it a bug if
you add a new command git-bugreport without adding a corresponding
pattern in the .gitignore file.  And thanks to that discipline, we
have been fairly good at keeping .gitignore up to date.  I do not
see a reason why we cannot do something similar to the registry of
configuration variables that we care about, which may be shipped as
part of "git bugreport" command.

