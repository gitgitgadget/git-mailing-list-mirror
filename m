Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00643C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C684E2051A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiT/gfcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAURtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:49:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61004 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAURtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 12:49:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9EC1A0952;
        Tue, 21 Jan 2020 12:49:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFi+GwDJ0yMtCU19QxfoEtXPlW0=; b=EiT/gf
        cw79NQ87BbKgKYevf3myR6DObZ9nHfHms/PD0i5R3ZG1KVo2N+b13tnqrcd1/F86
        yseG7Cf3fuLFYUnIEKZKisurxcFJp4a/H12s3PmR2EWJy1eheo/eXjiNFyoqPQMi
        wRN6ia3FxpvVQMVB6lsibxOnUSzCl4Yzd+XVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aBwds7A8r23z21vPu24lLHcx4y67wYMG
        wILe4/bAei+AfksW/bKi/IMlD8zyoOUTgV5TrY0aAS8cLM7reeXXHmAgASCUQi9X
        5ggYzRiyvNEDTl2/5H8Vt0BvRGfodCtmYRRX7L+Ube5QkFmeumKJdrgY57226Zun
        yEeXpLQpPys=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A222EA0950;
        Tue, 21 Jan 2020 12:49:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A8D71A094D;
        Tue, 21 Jan 2020 12:49:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
        <20200118145318.5177-1-shawarmakarma@gmail.com>
        <xmqqftgcd55s.fsf@gitster-ct.c.googlers.com>
        <CANsz78J93XynUJkBvvdD=BfXPQ-Wq17uzqPi3opMAPPKbt2Rwg@mail.gmail.com>
Date:   Tue, 21 Jan 2020 09:49:11 -0800
In-Reply-To: <CANsz78J93XynUJkBvvdD=BfXPQ-Wq17uzqPi3opMAPPKbt2Rwg@mail.gmail.com>
        (Eyal Soha's message of "Tue, 21 Jan 2020 08:37:33 -0800")
Message-ID: <xmqqmuagbsyw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56218DAC-3C76-11EA-9764-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> On Sat, Jan 18, 2020 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Please downcase Refactor; that way this change would not
>> meaninglessly stand out in the "git shortlog --no-merges" output.
>
> Sure, no problem.
>
>> The blank before your sign-off means all the times spent gets
>> discarded, which is not exactly encouraging to the reviewers.
>
> So I should make a better description for the patch?  Sure!  What
> should I put?  It's kind of hard to get a good description that
> describes the refactoring without digging into the reasoning behind
> it, which is in the follow-up patch.  What kind of description should
> I give?  How about like this:
>
>     color.c: refactor color_output arguments
>
>     color_output() now uses a more descriptive "background" argument
>     instead of "type".
>
>     Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
>
> Suits?

Quite a lot is missing from these two lines what I mentioned as
examples in the part you omitted from your quote, I think.

 - what design decision was made?  e.g. how .value is expressed
   differently from the code before this patch, e.g. how "fore/back"
   information is passed from the caller differently between the
   code before and after this patch, etc.

 - why these design choices are good ones?  e.g. making .value 30-37
   range instead of 0-7 range and pass 0/10 as offset from the base
   foreground value when the caller wants to give background color
   allows us to do X better than the original arrangement?

Perhaps there are some other things we discussed in the review
thread that may be worth resurrecting, but at least I recall I had
trouble understanding why you chose to do things the way the patch
did for the above two points.

After all, anything that reviewers needed help in their first
reading with your explanation to understand is a good candidate
[*1*] that needs clarification to help future readers of the "git
show" output of the commit resulting from your final version of the
patch.

Thanks.


[Footnote]

*1* There of course are cases where a simple explanation results in
    a reviewer who was initially confused to say "Ah, I misread a
    word, but your original is good after I re-read it carefully",
    so not everything a reviewer gets confused necessarily deserves
    mention in the final version of the log message.  But these are
    good starting points to anticipate confusion by future readers.
