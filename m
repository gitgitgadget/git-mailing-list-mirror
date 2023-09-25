Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A5CD4857
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjIYSex (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjIYSeS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 14:34:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE76E50
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:34:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DB2B1B7A2F;
        Mon, 25 Sep 2023 14:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=/lhoiRz0rYExezb0O/KPj0mBGYEq7QagMvBj+e
        a6Spc=; b=tDwsQM5JusvxAJC5hg9ftBacVbXBfuzsQJXTu2z/yLHDxf05ngZdRx
        cMaNke925F/FWp3Rc/45IE7yZ7G01KDqMNgND42accsIp8lKIg+RymgL/Rhsu/gS
        KXTPmk0SRRcq6cx7pJs+FnaDTKlT2sVc2uincgDnQ2dY71Jt8Qi5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 051DE1B7A2E;
        Mon, 25 Sep 2023 14:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 346231B7A2B;
        Mon, 25 Sep 2023 14:34:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH v2 0/4] Switch links to https
In-Reply-To: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com> (Josh Soref
        via GitGitGadget's message of "Sun, 24 Sep 2023 10:57:17 +0000")
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:33:59 -0700
Message-ID: <xmqq34z2ump4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19743826-5BD2-11EE-AE70-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> There are a couple of categories of http links

The same comment applies to the previous round, but it is not clear
how the categories of links that are HTTP in the current code (the
first enumeration) are related to how HTTP links are modified in the
series (the second enumeration).  It is not like how the first one
in the first list (i.e. must be HTTP) is handled is described by the
first one in the second list (i.e. replace HTTP to HTTPS without
doing anything else), as the number of bullet points are different.

>  * links that are required to be http: because they're copied from something
>    that mandates it (the apache license, xml namespaces, xsl docbook
>    things?)

So these are in "must stay as-is" category?

>  * pages which exist at both http: and https: and can be safely switched

"Can be switched" does not mean we should switch, does it?

>  * pages that have jittered a bit but are now available as https:

... but not available over HTTP:?  If so, this falls into "must
switch to avoid a dangling link" category?

>  * pages that have jittered a bit and are not available over https:

Again, "must stay as-is"?

>  * pages that are gone and for which the best source is
>    https://web.archive.org

Unfortunate, but definitely improves things.

>  * urls that were imaginary

What is done to them?  Just leave them as they are, or replace with
another imaginary link over HTTPS?

Hopefully we will see in the proposed commit log message of
individual patches what kind of http:// links the patch deals with
and how (e.g. "For some URLs in the documentation and the code, the
original http:// links are not reachable and dangling but the same
contents are still available at https://; for these URLs, replace
http:// with https:// without doing anything else.").  Let's read
on.

> In order:
>
>  * doc: switch links to https -- the simplest
>  * doc: update links to current pages -- I found the current pages for
>    these, it should be easy enough to verify these / reject them
>  * doc: update links for andre-simon.de -- I've split this out, I don't like
>    the idea of having to download binaries over http. If this were my
>    project, I'd be tempted to remove the feature or self-host w/ https...
>  * doc: refer to internet archive -- the original urls are dead, I've found
>    internet archive date links for them. (There are some in git already, so
>    this seemed like a very reasonable choice.)



> cc: Eric Sunshine sunshine@sunshineco.com cc: Josh Soref jsoref@gmail.com

(administrivia) I am not sure what effect, if any, this line has.
