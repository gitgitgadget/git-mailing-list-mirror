Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168E520323
	for <e@80x24.org>; Sun, 19 Mar 2017 22:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbdCSWzF (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 18:55:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59355 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752143AbdCSWzE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 18:55:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA7237285F;
        Sun, 19 Mar 2017 18:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rnXXIPqyDj08
        y5eopArvGmV+EQc=; b=H+kz/9q+mbS1keALY2Xg8+FFNiiIZGOHxgknRiBGHsoc
        GFETOrMq+Fk2elYSIQ23FbpsDqDwAJOV4tCYXnVBpnt5Va1u9xTTKBEXoeleSGOI
        SuRI5ixGYgDDiu4kUryZjwThe122YvzLLEPQwxZjfSxktHk2EOurj9E92ZZCm/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WENg9A
        RtdntXQU1Txc4oEMvsidZAo/8cXL2aAZByXyYo4O9D2TeQydenordXD9A84Gwi6z
        ly2FCemYtcjqRSaFvFmS8TAJQN4RGY9QrJtI+cmJwn5k+j/08hbSW+vtTtURRFT2
        Fri0hw6HbgGzZpQOaMpTe+4gMxGu5UoMoFvfs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B19C17285E;
        Sun, 19 Mar 2017 18:53:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 113337285C;
        Sun, 19 Mar 2017 18:53:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
References: <20170318223409.13441-1-avarab@gmail.com>
        <xmqqtw6pzarq.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5P3eWxF0qMoi4u+Suct61PXP-hS+gd0s7b+hmMvJpS=w@mail.gmail.com>
Date:   Sun, 19 Mar 2017 15:53:35 -0700
In-Reply-To: <CACBZZX5P3eWxF0qMoi4u+Suct61PXP-hS+gd0s7b+hmMvJpS=w@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 19 Mar
 2017 15:26:33
        +0100")
Message-ID: <xmqq1stszxn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E29C26AA-0CF6-11E7-B5D4-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm not suggesting that we make all the options accept garbage like
> the date option in the name of consistency.

Then "approxidate is case insensitive so others should too" argument
does not hold water.  Not that it has to, as I would prefer to see
an honest justification for a feature.  Among @{...} and ^{...},
approxidate is the only case insensitive one; if we are shooting for
consistency we'd be making everything case sensitive, which is the
opposite of what we want here.

>> So don't pretend that this is about consistency.  You are making a
>> choice for one class of strings that can go inside @{...} and the
>> choice does not depend on the case sensitivity of different classes
>> of strings that can go the same place.
>
> I think this too is really just a reply to what Duy said...

No, everything was a direct reply to you (I haven't even read Duy's
message when I responded).  Your patch that started the thread tried
to justify it as making things consistent, and it was a direct
response to it.

> So do you mean you'd like me to change the documentation to be more
> like "While this is canonically lower case this form is case
> insensitive so e.g. so-and-so also work" ?

TL;DR

 - In proposed log message, only mention that we are doing this
   because holding SHIFT after typing "@{" makes 'Upstream' or
   'PUSH' easier to type than 'upstream' or 'push'.  Don't invoke
   the "case insensitivity for consistency" or "approximate is case
   insensitive" as a rationle.

 - In documentation, the current description that only mentions
   'push' and 'upstream' in lowercase is sufficient for signaling
   what is canonical.  Just adding a parenthetical note,
   e.g. ('push' and 'upstream' are accepted when spelled with
   uppercase and they mean the same thing no matter the case), after
   the current text finishes describing both of them is sufficient
   to help users who wonder why an otherwise undocumented @{PUSH}
   that they typed by mistake was accepted, and also help them when
   they see others write @{Push} in their scripts and wonder if it
   means something different from what they know, i.e. @{push}.

 - Do not allow upcasing ^{<type>}, at least for now.

and a longer version.

The reason why I care deeply about how a change justifies itself in
the log message is because it can set the design principle for the
future of the system.  We shouldn't say "Anything inside @{...}
should be case insensitive." to avoid limiting the design space
unnecessarily for those who design new features @{/<pattern>}
etc. in the future, for example.

Most parts of the system, not limited to @{} and ^{} syntax, are
case sensitive, and there is no point repeating "this is case
sensitive except..." all over the place. =20

However, if we make some part case insesitive without documenting,
or make any "hidden" feature without documenting in general, it
risks confusing the users in two possible ways:=20

 (1) the user may trigger an undocumented feature first by mistake,
     and will wonder why it worked as expected and will also wonder
     if that is guaranteed to work in the future;

 (2) the user may see the use of an undocumented feature, and would
     wonder if there is any difference in the behaviour with the
     documented counterpart.

A parenthetical note should be designed to help with the above two
points.

Because we do not accept "cat-file -t <type>" and "hash-object -t
<type>" in a case insensitive way, it is not a good idea to allow
"^{COMMIT}", especially because it is not clear if allowing
"cat-file -t COMMIT" is a good idea at all.  We never restricted
that the "unknown type" must be spelled in lowercase, and without
such restriction, it is never safe to allow <type> to be case
insensitive ("^{<type>}" is much less necessary these days anyway as
"$OBJECT^0" and "$OBJECT:" are shorter and easier to type and can be
used for most of the cases you may want to use "^{<type>}").
