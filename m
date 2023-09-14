Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1746EEAA7A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 22:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjINWRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjINWRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 18:17:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D0530D2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:17:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E83D1C6F9B;
        Thu, 14 Sep 2023 18:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=YSvgom48+yL66sOvMWN/b6mninQXkV15o5EEue
        Jg5jM=; b=hgGlKgrAJyr5YM7Mx4KAqiEG831Q65iCVjn3CFeCqDW8p80BMqR2gS
        YVENTe2XnkkJeIEeTxwpmJLN2eVR29ADLwoR92crkLvvmJ6Bxr32V8fqmHyGduF0
        uCxueexJatXXii2aySLYstnf9oEAR+p+IfMeTm/ObGQGeT3rr9ta0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 163D41C6F9A;
        Thu, 14 Sep 2023 18:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66A0A1C6F99;
        Thu, 14 Sep 2023 18:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
In-Reply-To: <87o7i7hler.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        12 Sep 2023 10:59:24 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
Date:   Thu, 14 Sep 2023 15:17:31 -0700
Message-ID: <xmqqled8h01w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FF3A278-534C-11EE-859C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> Sounds very straight-forward.
>>
>> Given that "--first-parent" in "git log --first-parent -p" already
>> defeats "-m" and shows the diff against the first parent only,
>> people may find it confusing if "git log -d" does not act as a
>> shorthand for that.
>
> It doesn't, and I believe it's a good thing, as primary function of
> --first-parent is to change history traversal rules, and if -d did that,
> it would be extremely confusing.

I am not sure about that.

> Also, --first-parent is correctly documented as implying
> --diff-merges=first-parent, not as defeating -m.

Yes, exactly.  That makes me even more convinced that the intuitive
behaviour, when we say "we have this great short-hand option that
lets your 'git log' to do the first-parent thing with patch output",
is to do the first-parent traversal _and_ show first-parent patches.

"-d" is documented as a short-hand for "--diff-merges=first-parent
--patch" and not for "--first-parent --patch", so the behaviour may
correctly match documentation, but that does not make the documented
behaviour an intuitive one.  And a behaviour that is not intuitive
is confusing.

> If we read resulting documentation with a fresh eye, -d is similar to
> --cc, and -c, just producing yet another kind of output, so I think all
> this fits together quite nicely and shouldn't cause confusion.

Another thing is that showing first-parent patch for merges while
letting the traversal also visit the second-parent chain is not as
useful an option as it could be, even though it is not so bad as the
original "-m -p" that also showed second-parent patch for merges as
well.  People would have to say "log --first-parent -p" to get the
first-parent traversal with first-parent patch output, and they
would not behefit from having "-d".
