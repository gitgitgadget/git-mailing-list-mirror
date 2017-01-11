Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BCED205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031046AbdAKSIu (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 13:08:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61026 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932389AbdAKSIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 13:08:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 032A55E8FC;
        Wed, 11 Jan 2017 13:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=njOXS8ar9Db3TGYjLkp9Du1uN6A=; b=pPcvKK
        mqhXn0arKRkUxlwPoAk+YjfgBeWMZo08CMrQYkeVrH5hbjVkeHo5U+0KbzqVVMLY
        yqfTPmjgOowqkEMAhv/IwMBCQdFcXM1GtxJSAnLk3bZLOPaNVH7I7tMJ73glWiBp
        HU+2ize8Xwp9dwfDI76PwOmnr8wB2AJyLYvts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=raa2JIKGz5mq7tKOUW8hYpY1huWbfVVM
        5tkKh+3i2fliBIQxRgqdsQ2HCI088/axQCk6zYsdmIvn0fdY4VRxKwnf+IdR+KTh
        ad8cK8IAHPd93QN+9wXC03CYv9wr8obEAQdT+ZMbvEgP8Ad+h+ogejXuOrerm5Js
        ves6f/pokdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2D35E8FB;
        Wed, 11 Jan 2017 13:08:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D5895E8FA;
        Wed, 11 Jan 2017 13:08:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
References: <cover.1483354746.git.git@drmicha.warpmail.net>
        <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
        <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
        <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
        <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
        <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
Date:   Wed, 11 Jan 2017 10:08:46 -0800
In-Reply-To: <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 11 Jan 2017 06:37:25 -0500")
Message-ID: <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF3EDF58-D828-11E6-8C5A-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I would think die_errno() is a no-brainer for translation, since
> the strerror() will be translated.
>
>>     apply.c:                die(_("internal error"));
>> 
>> That is funny, too. I think we should substitute that with
>> 
>>     die("BUG: untranslated, but what went wrong instead")
>
> Yep. We did not consistently use "BUG:" in the early days. I would say
> that "BUG" lines do not need to be translated. The point is that nobody
> should ever see them, so it seems like there is little point in giving
> extra work to translators.

In addition, "BUG: " is relatively recent introduction to our
codebase.  Perhaps having a separate BUG(<string>) function help the
distinction further?
