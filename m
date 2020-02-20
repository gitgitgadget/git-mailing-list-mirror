Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4CAC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D670C208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kEltbHkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgBTXSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:18:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:18:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4E2548101;
        Thu, 20 Feb 2020 18:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RYlQl3QiaDIcX8mcVjsz3pSqYfg=; b=kEltbH
        kjaE0PvEs6DDcfp8gV+9rGm2icmV+c6aS6XITGWXFX+MjCj8dRWga5lxwstiVI/l
        r5oGBGBHEg0/J0osYLtYyRN1bOX+TrlypvDz3cTWWSgAkRvwpE5aAnDqgZaC0X2N
        T0J5s2jZjUTzX7G32BBt0jjHRVq+b3lk7YCHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nRW7DogqOf9Dq1jVPsasxdVFxI739pLq
        xfNaCXKVR636E2R/QCHbZqcGBoGZyjFBAUux+98XEmoKpnLjvl/VEi2rDPvY6yvV
        RZDWTt+VxU4T7zb+V5IioZcIZrJWkI4rJd5Alva0IA1AslE24zmLWTGdnY1+47u/
        uRBCrg0Asy0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C16A48100;
        Thu, 20 Feb 2020 18:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A688480FE;
        Thu, 20 Feb 2020 18:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 04/15] bugreport: gather git version and build info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-5-emilyshaffer@google.com>
        <xmqq4kvlaup9.fsf@gitster-ct.c.googlers.com>
        <20200220230320.GE2447@google.com>
Date:   Thu, 20 Feb 2020 15:18:14 -0800
In-Reply-To: <20200220230320.GE2447@google.com> (Emily Shaffer's message of
        "Thu, 20 Feb 2020 15:03:20 -0800")
Message-ID: <xmqqblps97bd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45E1BF1A-5437-11EA-9842-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Feb 20, 2020 at 12:07:46PM -0800, Junio C Hamano wrote:
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> 
>> > +static void get_system_info(struct strbuf *sys_info)
>> > +{
>> > +	/* get git version from native cmd */
>> > +	strbuf_addstr(sys_info, "git version:\n");
>> > +	get_version_info(sys_info, 1);
>> > +	strbuf_complete_line(sys_info);
>> 
>> It is a bit curious use of "don't do anything if sys_info ends with
>> a complete line, but complete it if it ends with an imcomplete
>> line".  That tells the readers that we do not know what
>> get_version_info() will do (now or in the future) to its output
>> buffer.
>>  ...
>> So, was the strbuf_complete_line() merely defensive programming?  It
>> may deserve a comment if it will stay there.
>
> It was meant defensively, here and elsewhere in the series. I figured
> that for something like this, which is mostly bounded by human writing
> in an editor and then by file IO, spurious string-checking was not such
> a big deal.
>
> Are you suggesting to comment around the strbuf_complete_line() calls,
> or to comment around get_version_info() that it should end in newline?

I meant a comment in get_system_info() next to the use of this
particular use of strbuf_complete_line(), if the use stays there.

But after reading the whole series through, I saw no need to use
strbuf_complete_line() in the first place, as there is no source of
input that is not under our control (if we do not count sloppy
programming, that is).
