Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7451F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdAYXEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:04:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57358 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752638AbdAYXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:04:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DBE3639B1;
        Wed, 25 Jan 2017 18:04:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lBxmm/vtsyxnMvq9Dy/EeeM8D2U=; b=xDiPAp
        +FZ/AYKDnpT5C/O6uDtrPO9ZS5/oauHQrFg6B5aellkSjTk8T0EYeoAqVNkX1+Sa
        LqhhTIEfYqPAgFlNCyb0F83Mf3gHCL6Mt5n7yTUOLGwUG+K6K+DTLf4h4+wpZ6or
        8haXjjhNmDyA6QQD+hL0cdjP3HmO8QDo73cwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EIZkEVojSQZAZDbssIY6eLy9QsbRMWlI
        tAziu4nDaXqMkKqzUxulmz5obSHa6fJMDDeS/KOPvmHTcpBhl+DGHp8b0qb44pxF
        LgSrzjvmuKVhPFcS4AOF8FmoZJyV2w9gHmoYgsaCBtGIxyNvl3mrduhTGvreb9NV
        tSFxIh5lpHQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 455B5639B0;
        Wed, 25 Jan 2017 18:04:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A41D3639AF;
        Wed, 25 Jan 2017 18:04:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors out.
References: <20170125030434.26448-1-mh@glandium.org>
Date:   Wed, 25 Jan 2017 15:04:38 -0800
In-Reply-To: <20170125030434.26448-1-mh@glandium.org> (Mike Hommey's message
        of "Wed, 25 Jan 2017 12:04:34 +0900")
Message-ID: <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A637919A-E352-11E6-AFF9-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> For instance, after changing my laptop for a new one, I copied my
> configs, but had some environment differences that broke gpg.
> With this change applied, the output becomes, on this new machine:
>   gpg: keyblock resource '/usr/share/keyrings/debian-keyring.gpg': No
> such file or directory
>   error: gpg failed to sign the data
>   error: unable to sign the tag
>
> which makes it clearer what's wrong.

Overall I think this is a good thing to do.  Instead of eating the
status output, showing what we got, especially when we know the
command failed, would make the bug-hunting of user's environment
easier, like you showed above.

The only thing in the design that makes me wonder is the filtering
out based on "[GNUPG:]" prefix.  Why do we need to filter them out?

Implementation-wise, I'd be happier if we do not add any new
callsites of strbuf_split(), which is a horrible interface.  But
that is a minor detail.

Thanks.
