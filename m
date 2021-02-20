Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F155DC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA79D64ED7
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 09:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBTJbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 04:31:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35600 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBTJbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 04:31:45 -0500
Received: from [IPv6:2a01:c846:1980:2500:a689:6667:a216:ddf8] (unknown [IPv6:2a01:c846:1980:2500:a689:6667:a216:ddf8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B01161F46537;
        Sat, 20 Feb 2021 09:31:01 +0000 (GMT)
Subject: Re: [PATCH 0/2] Add --no-filters option to git-add
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
 <YDA9WjWOjkqlsALc@camp.crustytoothpaste.net>
 <a58d8057-9847-ba57-1bf5-5d27c235d210@collabora.co.uk>
Organization: Collabora
Message-ID: <c660bf7b-cd59-43d4-a374-11997f0b15d1@collabora.co.uk>
Date:   Sat, 20 Feb 2021 10:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a58d8057-9847-ba57-1bf5-5d27c235d210@collabora.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/2021 09:06, Andrej Shadura wrote:
> On 19/02/2021 23:36, brian m. carlson wrote:
>> So I think that while this might be a useful escape hatch for users, I
>> definitely want to see a compelling rationale for it and a big warning
>> in the documentation and an update to the relevant entry in the Git FAQ
>> before we accept such a patch.

Here’s my proposal for the updated manpage description of the option:

--no-filters::

Add the contents as is, ignoring any input filter that would have been
chosen by the attributes mechanism, including the end-of-line
conversion. Note that this option is not intended for interactive use,
since files added this way will always show up as modified if Git were
to apply transformations to them, making the situation potentially very
confusing.

And here the FAQ entry extended:

It is also possible for perpetually modified files to occur on any
platform if a smudge or clean filter is in use on your system but a file
was previously committed without running the smudge or clean filter.  To
fix this, run the following on an otherwise clean working tree:
+
----
$ git add --renormalize .
----
+
Another situation where perpetually modified may appear on any platform
is when a file has been committed without running any filters (including
the end-of-line conversion), but the `.gitattributes` file states that
this file requires a conversion.  In this case, you can either
renormalize the files if this happened by mistake, or modify
`.gitattributes` or `$GIT_DIR/info/attributes` as described above to
exempt the file from the conversion if this was intentional.

(I will send an updated patch set when we agree on the wording.)

-- 
Cheers,
  Andrej
