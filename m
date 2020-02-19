Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB64CC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984D724654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wLlaYwXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSURm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:17:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53120 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSURm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:17:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AE7F3DF00;
        Wed, 19 Feb 2020 15:17:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rg5xDTm3LF8GPUJ6kQV7yRYFMqo=; b=wLlaYw
        XkaSDgOdy29IO5uB2bRUMbCmg5tmxW60WkfVjv0Gw24zoxS39FoBe60iJ4DbfoF0
        Eh/VIGxN6Vw43FvsYxtC6U3BN3DOhLGDY4B4Ei1RDkBqO45Jf2UP2kUHBWaTgSG2
        p3XocYHRE65DRDHG4sCSygaBdD9VgYPpEiJ+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g9N6d4dkhzoBpGSX/iDPaCqQI7ozxTQw
        xzuBd8EZ666IKV9KCMWRGUIhDRsV3VFLPc5bjRyTmripDqnFGbfevanTeCj2aZYt
        sBihWGcDr2L2GbYsqpGX/VXLu2wjHDSCDhQg8L/4oZpunbPC99fwcYPxUyLZBeAC
        /JDAB9GDKl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51E953DEFF;
        Wed, 19 Feb 2020 15:17:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEA3A3DEFD;
        Wed, 19 Feb 2020 15:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Git List <git@vger.kernel.org>, bfields@redhat.com
Subject: Re: [PATCH 3/4] am: support --show-current-patch=raw as a synonym for--show-current-patch
References: <20200219161352.13562-1-pbonzini@redhat.com>
        <20200219161352.13562-4-pbonzini@redhat.com>
        <CAPig+cQOZwA3aAzBko-RL8UnW77DuBY-s_-J2D+35Ofn=fFfsg@mail.gmail.com>
Date:   Wed, 19 Feb 2020 12:17:35 -0800
In-Reply-To: <CAPig+cQOZwA3aAzBko-RL8UnW77DuBY-s_-J2D+35Ofn=fFfsg@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 19 Feb 2020 14:34:43 -0500")
Message-ID: <xmqqmu9ee3hc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEBAD020-5354-11EA-BC27-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I think the more typical way of coding this in this project is to
> initialize 'new_value' to -1. Doing so will make it easier to some day
> add a configuration value as fallback for when the sub-mode is not
> specified on the command line. So, it would look something like this:
>
>     int submode = -1;
>     if (arg) {
>         int i;
>         for (i = 0; i < ARRAY_SIZE(valid_modes); i++)
>             if (!strcmp(arg, valid_modes[i]))
>                 break;
>         if (i >= ARRAY_SIZE(valid_modes))
>             return error(_("invalid value for --show-current-patch: %s"), arg);
>         submode = i;
>     }
>
>     /* fall back to config value */
>     if (submode < 0) {
>         /* check if config value available and assign 'sudmode' */
>     }

Hmph?  Isn't the usual pattern more like this:


	static int submode = -1; /* unspecified */

	int cmd_foo(...)
	{
		git_config(...); /* this may update submode */
		parse_options(...); /* this may further update submode */

		if (submode < 0)
			submode = ... some default value ...;

to implement "config gives a custom default, command line overrides,
but when there is neither, there is a hard-coded default"?

Of course, the variable can be initialized to the default value to
lose the "-1 /* unspecified */" bit.

>> +       if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>> +               return error(_("--show-current-patch=%s is incompatible with "
>> +                              "--show-current-patch=%s"),
>> +                            arg, valid_modes[resume->sub_mode]);
>
> So, this allows --show-current-patch=<foo> to be specified multiple
> times but only as long as <foo> is the same each time, and errors out
> otherwise. That's rather harsh and makes it difficult for someone to
> override a value specified earlier on the command line (say, coming
> from a Git alias). The typical way this is handled is "last wins"
> rather than making it an error.

Yup, the last one wins is something I would have expected.  And if
we follow that (which is the usual pattern), I suspect that we won't
even need the first two steps of this series?

Thanks for a review.
