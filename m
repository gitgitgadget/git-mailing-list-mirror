Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DBEC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiEXTLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiEXTLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:11:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575163BFA7
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:11:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 051DB126624;
        Tue, 24 May 2022 15:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5BT0MBhiUrce
        nyEoEHg9BW3Lfy929KOd7b6D+ThUaWY=; b=r8t7JoOnhJuLNS5EziaCssqDMeLi
        lmybuIK+1zRTxoa0VHsnK6/85E2KKaaW7Nxv/Dyn0BX/CMGCPUVL4TNmi6f9HT5a
        Ey4+9CAz/jelYggDuDOYS5m/HUflG6CTFM6f9XFhhtSFF88/+oAoTyzxr4d06srf
        h2isYzA17brV3vA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0630126623;
        Tue, 24 May 2022 15:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51E6F126622;
        Tue, 24 May 2022 15:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <220523.86wnecxqol.gmgdl@evledraar.gmail.com>
        <xmqqy1yrnado.fsf@gitster.g>
        <220524.867d6bxs40.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 12:11:46 -0700
In-Reply-To: <220524.867d6bxs40.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 10:12:15 +0200")
Message-ID: <xmqq1qwiiw3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B826E22-DB95-11EC-9E1D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> AFAICT all of the goals you're suggesting here will be even better if
> it's commented out, then you will need to edit it, and we'll error out
> by default if you don't. Why not use that?

Simply because I doubt that would work.  Doesn't the stripspace on
the log message with unedited comments simply discard the commented
out part and results in a title that is taken from the line that
happens to end up being the first non-blank-non-commented-out line?

> The subject you're replacing isn't content-free, it at least includes
> the OID, this one doesn't, so you won't see it in --oneline. That's les=
s
> useful.

I know.  That is the point; those who choose to use --reference want
to make sure they want to edit out the line that tell them to edit.

>
>> If we leave something like
>>
>> 	# Add one line above and explain not *what* this revert did,
>> 	# but *why* you decided to revert in 50-70 chars.  Did it
>> 	# break something? Was it premature?
>>
>> 	This reverts commit 8aa3f0dc (CI: set CC in MAKEFLAGS directly, 2022-=
04-21)
>>
>> presumably, stripspace will make the "This reverts commit ..." the
>> title of the reverted commit.  It would invite people not to edit it
>> out out of laziness.  Since the whole point of this change is to
>> encourage people to describe the reason behind the revert on the
>> subject line, such an invitation is counter-productive.
>
> If that's the concern we could also comment the "This reverts" line.

That punishes the normal use case where the title is edited and the
body is used to start the message as-is.

