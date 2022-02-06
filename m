Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF1C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiBFVdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiBFVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:33:19 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FAEC061353
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:33:18 -0800 (PST)
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nGp9o-000Aus-7b; Sun, 06 Feb 2022 21:33:16 +0000
Message-ID: <13f21a57-1519-5ace-30e8-def598fad38b@iee.email>
Date:   Sun, 6 Feb 2022 21:33:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Commit SHA1 == SHA1 checksum?
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> <xmqqee4fix0l.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqee4fix0l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02/2022 20:02, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> I think part of Todd's question was how the tag and uncompressed archive
>> 'checksums' (e.g. hashes) relate to each other and where those
>> guarantees come from.
> There is no such linkage, and there are no guarantees.  The trust
> you may or may not have on the PGP key that signs the tag and the
> checksums of the tarball is the only source of such assurance.
>
> More importantly, I do not think there can be any such linkage
> between the Git tree and release tarball for a few fundamental
> reasons:
>
>  * We add generated files to "git archive" output when creating the
>    release tarball for builder's convenience, so if you did
>
>        rm -fr temp && git init temp
>        tar Cxf temp git-$VERSION.tar
>        git -C temp add . && git -C temp write-tree
>
>    the tree object name that you get out of the last step will not
>    match the tree object of the version from my archive (interested
>    parties can study "make dist" for more details).
>
>  * Even if we did not add any files to "git archive" output when
>    creating a release tarball, a tarball that contains all the
>    directories and files from a given git revision is *NOT* unique.
>    We do not add randomness to the "git archive" output, just to
>    make them unstable, but we have made fixes and improvements to
>    the archive generation logic in the past, and we do reserve the
>    rights to do so in the future.  And it is not just limited to
>    "git archive" binary, but how it is driven, e.g. "tar.umask"
>    settings can affect the mode bits.
Thanks for the clarification.

Thus what trust their is, is via the two PGP signatures, rather than
directly between the tarball and the git repo.
--
Philip

