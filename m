Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5677C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1850206DB
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AI3J+UqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAFRIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:08:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgAFRIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 12:08:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF88FA53B5;
        Mon,  6 Jan 2020 12:08:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IsqHxqfR6gUN1zkYJTTXxK9lGAM=; b=AI3J+U
        qOwiF4rDF0JAkCXuvY9T0X6Trph7XnmPJbqLU+NFMlJz+ktg7kMnGsOCKrD8r1GJ
        Fhs8y493S6EDQevK9ETkKyTVrlgM8TyviFe5nDXm+CfvRyC54sdoaP7hcWSvp460
        dZ96tSt3fmUUpcJl81VTbfuq9wDD8RssEUWao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DkOjF68qoLR8tZzNXfg3wV8zna04SZI2
        Z335CUUkjGhcSLCIwIsQTilBPUf/IJiUnoNN0AFMI7dxFJ40UjtDv+y+TrZuNCUK
        QNSFb7n0ob11oG4MUI8gTdoxgd5RFd2tbbBv3D4gPG81bkW8tCWHsWmkEgZY2DVb
        a+y/w48Q1/g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C91A53B4;
        Mon,  6 Jan 2020 12:08:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2168A53B1;
        Mon,  6 Jan 2020 12:08:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Dunlap <george.dunlap@citrix.com>
Cc:     <git@vger.kernel.org>
Subject: Re: git-am doesn't strip CRLF line endings when the mbox is base64-encoded
References: <c44c3958-b0eb-22bd-bc35-04982706162f@citrix.com>
        <dece7350-7b58-bf19-9fdf-4ccf8df268fb@citrix.com>
        <0c18df58-9d1d-550f-d69e-d6ffe6c01858@citrix.com>
Date:   Mon, 06 Jan 2020 09:07:58 -0800
In-Reply-To: <0c18df58-9d1d-550f-d69e-d6ffe6c01858@citrix.com> (George
        Dunlap's message of "Mon, 6 Jan 2020 11:58:48 +0000")
Message-ID: <xmqqpnfwa4y9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 180D02E2-30A7-11EA-8266-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Dunlap <george.dunlap@citrix.com> writes:

> On 12/18/19 12:15 PM, George Dunlap wrote:
>> On 12/18/19 11:42 AM, George Dunlap wrote:
>>> Using git 2.24.0 from Debian testing.
>>>
>>> It seems that git-am will strip CRLF endings from mails before applying
>>> patches when the mail isn't encoded in any way.  It will also decode
>>> base64-encoded mails.  But it won't strip CRLF endings from
>>> base64-encoded mails.
>>>
>>> Attached are two mbox files for two different recent series.
>>> plainenc.am applies cleanly with `git am`, while base64enc.am doesn't.
>>>
>>> Poking around the man pages, it looks like part of the issue might be
>>> that the CRLF stripping is done in `git mailsplit`, before the base64
>>> encoding, rather than after.
>> 
>> Poking around -- it looks like the CRLF stripping would be better done
>> in `git mailinfo` after the decoding.
>
> Anyone want to take this up?  I mean, I could try to send a patch, but
> since I've never looked at the git source code before, I'm sure it would
> take me about 10x as much effort for me to do it as for someone already
> familiar with the codebase.

Even before writing a patch, somebody needs to come up with a
sensible design first.  --[no-]keep-cr is about "because transfer of
e-mail messages between MTAs and to the receiving MUA is defined in
terms of CRLF delimited lines per RFC, Git cannot tell if the CRLF
in the input was meant to be part of the patch (i.e. the diff is
describing a change between preimage and postimage of a file that
uses CRLF line endings) or they are cruft added during transit.  By
default we favor LF endings so we will strip, but we leave an option
to keep CRs at the end of lines".  

What you are asking for is quite different, isn't it?  "We know the
CRLF in the payload is from the original because they were protected
from getting munged during the transfer by being MIME-encased.
Please tell Git to preprocess that payload to convert CRLF to LF
before treating it as a patch".

So, if you are imagining to change the meaning of --[no-]keep-cr, I
do not think it will fly (that is why I said that we need a sensible
design before a patch).

And by stepping back a bit like so, and once we start viewing this
as "after receiving a piece of e-mail from MUA (where --[no-]keep-cr
may affect the outermost CRLF line endings) and unwrapping possible
MIME-encasing, we can optionally tell Git to pass the payload
further through a preprocess filter", we'd realize that this does
not have to be limited to just running dos2unix (you may want to run
iconv to fix encodings, for example), which would mean that the new
flag may not just want to be --strip-cr, which is too limiting, but
rather want to be --filter-message=<how> where <how> could be one of
the canned preprocess filter (among which your dos2unix may exist)
or an external script.

I am not saying that "--filter-message=<how>" must be the "sensible
design" I mentioned at the beginning of this message---the above is
to illustrate what kind of thought needs to go in before even the
first line of the patch gets written.

Thanks.
