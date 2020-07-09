Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F4C433E1
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB33E207D0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUR2HFFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGISJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:09:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61528 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgGISJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 14:09:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2A86C8260;
        Thu,  9 Jul 2020 14:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gxwmb9SJFs7KOvtQ60XJ4/Zk9sE=; b=AUR2HF
        Fhmjenmu9ZyVcOi15d7cW7trtM41wjKiGew/SOTsbwv58tfA0pnMt+kCRAjihp9e
        ZwAu5h7fhQIG5TVoFpFRH5KDYqbnqMI96ZsKmcy3JtdYwFd7nYRkDHMfF5GzJ9Ep
        KNVn6lkSbhN5Xw6spvnXCpLJGwCyCLhkrDHI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CD2nkhY8f0a+EP/v6Q26e+bMn8FqX91W
        1pqHRExhDhIcHTYHT1W43Fk9OFqTwuDAH31aQY/3nCCrCTrzN37vceEXjCNh6zHf
        P6MbJLYZYbwaEPqVE43KKqsxKRI3l+5C7YObZp82tYrNLnfaRbts7PjGoTfdtcrV
        545Q6LLR6V8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DAE2AC825F;
        Thu,  9 Jul 2020 14:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19C1EC825D;
        Thu,  9 Jul 2020 14:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
        <xmqqd054y5t1.fsf@gitster.c.googlers.com>
        <CAHd-oW7sz5nGUGZDDguz3fdeRLa+8iWRdC+vyCB2jWvFMh3aXg@mail.gmail.com>
Date:   Thu, 09 Jul 2020 11:09:39 -0700
In-Reply-To: <CAHd-oW7sz5nGUGZDDguz3fdeRLa+8iWRdC+vyCB2jWvFMh3aXg@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 9 Jul 2020 14:39:18
        -0300")
Message-ID: <xmqq1rlky2zg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BF37172-C20F-11EA-A2D4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Thu, Jul 9, 2020 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The returned value from fstat_output() is suppsed to be "have we
>> done fstat() so that we do not need to do a lstat()?"  Don't you
>> instead want to extend it to "0 means we didn't, 1 means we did
>> successfully, and -1 means we did and failed"?  At least, the way
>> _this_ function is modified by this patch is in line with that.
>
> Makes sense, thanks for spotting this issue.
>
>> Which means that we'd need to update the caller(s) to match, to
>> avoid risking this change to be just half a change, very similarly
>> to how the change in 11179eb311 was just half a change.

Thinking about this again, you _could_ argue that your version is
being more defensive.  fstat_is_reliable() might lie and tell us it
is OK to use fstat() when we should do lstat(), and in such a case,
we take a failure from fstat() as a sign to pretend that we didn't
even call it, and tell the caller to do an lstat().  I am actually
OK to go in that direction, but then we probably should save away
errno before making this fstat() call, and restore it after it when
we see an error, if we were to truly pretend that we didn't make a
call.  Otherwise error_errno() call we will make later in the flow
would end up reporting the error from the fstat() we chose to pretend
that we didn't call.

And having said all that, I think fstat_is_reliable() can be trusted
(it says false on Windows and says true on all others).


