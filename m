Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D5DC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EA160F4F
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJWVPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:15:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64277 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJWVP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:15:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFD78161BA9;
        Sat, 23 Oct 2021 17:13:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MVQHCCmvmq/QsDiB5tmI1X1Cto/NfDO5xeIc/z
        JR9Qs=; b=XfVW2xdQfZ+up5c7wTrEzrYXLXTF8FSm0Wy0VwMgHeLzvVKxVlqt94
        ifVOH0ABtmnmW2OMH4LpyV49KeCMmQ8R43So5dsB5CQppsMcTo+gbhBA6BFKiQwM
        GhiqDj0823kU75sgcqXazGyR0i/adHJL8W8aFYKw8JqzLzkMpYL1Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6E89161BA8;
        Sat, 23 Oct 2021 17:13:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 382A5161BA7;
        Sat, 23 Oct 2021 17:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>, vagabon.xyz@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] archive: describe compression level option
References: <20211022064543.28950-1-bagasdotme@gmail.com>
        <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
Date:   Sat, 23 Oct 2021 14:13:05 -0700
In-Reply-To: <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 22 Oct 2021 02:57:07 -0400")
Message-ID: <xmqqcznvbg2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0414C352-3446-11EC-88C7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +-<digit>::
>> +       Regulate compression level using the specified <digit>. Higher
>> +       values enables smaller size at the expense of slower time.
>
> s/enables/enable/
>
> A couple notes:
>
> "slower time" is an unusual way to convey the concept; perhaps say it
> takes "more time".
>
> I think it was mentioned earlier in this thread that higher
> compression level does not necessarily mean better compression, though
> that is certainly the intent; it only means that the tool will "try
> harder" to make the result smaller. Perhaps it's worth using more
> exact phrasing (or perhaps it doesn't matter and that's getting too
> much into the weeds).
>
>> +       Supported values are from `-0` (store-only) to `-9` (best ratio).
>> +       Default is `-6` if isn't specified.
>
> s/if isn't/if it isn't/
> ...or...
> s/if isn't/if not/

Sounds all sensible.

In summary, perhaps something like this?  I still have "-9 (best
ratio)" which does not say it is merely the intent and not
guarantee, but the resulting text read a bit funny with "best ratio"
replaced with "try hardest".

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Bagas Sanjaya <bagasdotme@gmail.com>
Date: Fri, 22 Oct 2021 13:45:44 +0700
Subject: [PATCH] archive: describe compression level option

Describe the only <extra> option in `git archive`, that is the compression
level option. Previously this option is only described for zip backend;
add description also for tar backend.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
$ git range-diff --word-diff @{1}...
1:  c27c11dc35 ! 1:  63e8b48637 archive: describe compression level option
    @@ Metadata
     ## Commit message ##
        archive: describe compression level option
    
        Describe the only [-extra-]{+<extra>+} option in `git archive`, that is the compression
        level option. Previously this option is only described for zip backend;
        add description also for tar backend.
    
    @@ Documentation/git-archive.txt: BACKEND EXTRA OPTIONS
    -	Highest and slowest compression level.  You can specify any
    -	number from 1 to 9 to adjust compression speed and ratio.
    +-<digit>::
    +	[-Regulate-]{+Specify+} compression [-level using the specified <digit>. Higher-]
    [-+-]{+level.  Larger+} values [-enables smaller size at-]{+allows+} the [-expense of slower time.-]{+command+}
    +	{+to spend more time to compress to smaller size.+}  Supported
{+++}	values are from `-0` (store-only) to `-9` (best ratio).
    +	Default is `-6` if [-isn't specified.-]{+not given.+}
     
    +tar
    +~~~

 Documentation/git-archive.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..fea2e84fdf 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -93,12 +93,19 @@ BACKEND EXTRA OPTIONS
 
 zip
 ~~~
--0::
-	Store the files instead of deflating them.
--9::
-	Highest and slowest compression level.  You can specify any
-	number from 1 to 9 to adjust compression speed and ratio.
+-<digit>::
+	Specify compression level.  Larger values allows the command
+	to spend more time to compress to smaller size.  Supported
+	values are from `-0` (store-only) to `-9` (best ratio).
+	Default is `-6` if not given.
 
+tar
+~~~
+-<number>::
+	Specify compression level. The value will be passed to the
+	compression command configured in `tar.<format>.command`. See
+	manual page of the configured command for the list of supported
+	levels and the default level if this option isn't specified.
 
 CONFIGURATION
 -------------
-- 
2.33.1-943-g0f03e78e89

