Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3983FC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjGMTzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGMTzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:55:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8C272A
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:55:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6570191420;
        Thu, 13 Jul 2023 15:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aXWVwHVxuhVqgUcU1FQjqB4LPLJHdpqna+6CDL
        eDGmc=; b=BxYwn/KmTbrYnTcSjek3908aPt6Ml2VSL2gcE8yzzYlWVIqSI0WYO5
        LAaS/SSWsjiKOmBvKfuzt3rbOUGP3PaOGAwUZ+OrJBDYFadU03mwH/vpssvTdm0e
        +nvbxxc35ZfAjsb6mG/LHAn8asESpFZ87+cz9KUTh9NQZQCoGnkYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E1C319141F;
        Thu, 13 Jul 2023 15:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBBA919141E;
        Thu, 13 Jul 2023 15:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
        <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
Date:   Thu, 13 Jul 2023 12:55:11 -0700
In-Reply-To: <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc> (Petar Vutov's
        message of "Thu, 13 Jul 2023 21:46:55 +0200")
Message-ID: <xmqqwmz3oacg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DE564E2-21B7-11EE-98F2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> Oops, this was supposed to go under
> <7090349c-4485-d5c4-1f26-190974864f72@imap.cc>..
>
> Side question in this side thread: I was tempted to change the mention
> of "configuration variable" with "git-config variable", to highlight
> the narrow meaning of the term. But I grepped and that term is used
> everywhere in the documentation. Changing it only in this section
> would be inconsistent.

Don't.  People should be familiar with "configuration variable", but
may not be with "git-config variable".

How about doing it this way?  I moved 'none' up, as it is effective
in `.gitmodules` and as a configuration variable, just like all
others, and then completely rewrote the somewhat awkward explanation
of the custom command thing.

----- >8 --------- >8 --------- >8 --------- >8 ----
Subject: submodule: clarify that "!custom command" is the only oddball

We singled out 'none' and 'custom command' as submodule update modes
that cannot be specified in the .gitmodules file, but 'none' can
appear there, and use of a custom command is the only oddball.

Move the description of 'none' up, clarify how the custom command is
used, and explicitly say it cannot be used in the `.gitmodules` file.

Strictly speaking, the last one should not be needed, as we already
say `configuration variable`, but to new readers, the distinction
between the configuration variable and settings that appear in the
.gitmodules file may not be apparent; hopefully the new text will
help them understand where it can(not) be used.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git c/Documentation/git-submodule.txt w/Documentation/git-submodule.txt
index 4d3ab6b9f9..391ff0dbf2 100644
--- c/Documentation/git-submodule.txt
+++ w/Documentation/git-submodule.txt
@@ -160,17 +160,15 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following 'update' procedures are only available via the
-`submodule.<name>.update` configuration variable:
-
-	custom command;; arbitrary shell command that takes a single
-	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. When `submodule.<name>.update`
-	    is set to '!command', the remainder after the exclamation mark
-	    is the custom command.
-
 	none;; the submodule is not updated.
 
+	custom command;; When the `submodule.<name>.update`
+	    configuration variable is set to `!custom command`, the
+	    object name of the commit recorded in the superproject
+	    for the submodule is appended to the `custom command`
+	    string and gets executed.  Note that this mechanism
+	    cannot be used in the `.gitmodules` file.
+
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in `.gitmodules`, you can automatically initialize the
 submodule with the `--init` option.
