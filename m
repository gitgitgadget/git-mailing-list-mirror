Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E5C433EF
	for <git@archiver.kernel.org>; Sun, 29 May 2022 23:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiE2XBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 19:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE2XBT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 19:01:19 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8977F3B
        for <git@vger.kernel.org>; Sun, 29 May 2022 16:01:18 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24TN1F10029556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 May 2022 19:01:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Robert Dailey'" <rcdailey.lists@gmail.com>
References: <CAHd499D81VN=aGsM6kaNLF2ZMg-Zg10U=qU-j7gQ7uXnqqfdqg@mail.gmail.com>        <xmqqh758yz4u.fsf@gitster.g> <xmqq8rqkyyc2.fsf@gitster.g> <xmqqpmjwx8so.fsf_-_@gitster.g>
In-Reply-To: <xmqqpmjwx8so.fsf_-_@gitster.g>
Subject: RE: [PATCH] pathspec: correct an empty string used as a pathspec element
Date:   Sun, 29 May 2022 19:01:11 -0400
Organization: Nexbridge Inc.
Message-ID: <032f01d873b0$008c1b50$01a451f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG6E7/pl8aSL2yTpEd+SDptqXjLEAJqmxulAgGg4c0BqCTZAq1ClSMQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 29, 2022 6:40 PM, Junio C Hamano wrote:
>Pathspecs with only negative elements did not work with some commands that
>pass the pathspec along to a subprocess.  For instance,
>
>    $ git add -p -- ':!*.txt'
>
>should add everything except for paths ending in ".txt", but it gets
complaint from
>underlying "diff-index" and aborts.
>
>We used to error out when a pathspec with only negative elements in it,
like the
>one in the above example.  Later, 859b7f1d (pathspec:
>don't error out on all-exclusionary pathspec patterns, 2017-02-07) updated
the
>logic to add an empty string as an extra element.  The intention was to let
the
>extra element to match everything and let the negative ones given by the
user to
>subtract from it.
>
>At around the same time, we were migrating from "an empty string is a valid
>pathspec element that matches everything" to "either a dot or ":/" is used
to
>match all, and an empty string is rejected", between d426430e (pathspec:
warn on
>empty strings as pathspec,
>2016-06-22) and 9e4e8a64 (pathspec: die on empty strings as pathspec,
2017-06-
>06).  I think 9e4e8a64, which happened long after 859b7f1d happened, was
not
>careful enough to turn the empty string 859b7f1d added to either a dot or
":/".
>
>A care should be taken as the definition of "everything" depends on
>subcommand.  For the purpose of "add -p", adding a "." to add everything in
the
>current directory is the right thing to do.  But for some other commands,
":/" (i.e.
>really really everything, even things outside the current subdirectory) is
the right
>choice.
>
>We would break commands in a big way if we get this wrong, so add a handful
of
>test pieces to make sure the resulting code still excludes the paths that
are
>expected and includes "everything" else.

Thanks for the heads up. I have to check into this for some scripting. Not
worried but glad to know.
Thanks,
--Randall

