Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE9C2BAEE
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F249F20736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHaj+E78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgCKURS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:17:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53752 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgCKURS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 16:17:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EF7ABD677;
        Wed, 11 Mar 2020 16:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0nt+u1mEnW8EbZ4deVbhRcRnJNc=; b=kHaj+E
        7889xKSzNhXXKbvSNeu3J9vsgnaxoDJlQV/ULUcONVQI2heasMnc2wL+TjFh1BzU
        y83GC/W9lxa6wrVkKaVbiCrAJEvvK/SLY24j3L2f1cNWNbZfN2P6x86ysS9rXpbd
        v7q1tU5dy0xc+toCDmCv4Ps4zjEPr+R1I2lzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uMjKEhYoXAS/Z9DQSBUZ1jNxtGfdOr8n
        k7pPc9E4k8z4b6ne4LvqaMNpW4mLiLMyOQvrTcbkiOdxHDord5UgE6X07CL/icoz
        /M7lbGgC2SFBUOtWZKbav+q/B9KRo9sledYL+OF7XJ+RTBe9MjEFITMmJN7ntZSG
        1NlDmujURkI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 766C8BD676;
        Wed, 11 Mar 2020 16:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BCA78BD673;
        Wed, 11 Mar 2020 16:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Luke Bonanomi <lbonanomi@gmail.com>
Subject: Re: [PATCH] git-gui--askpass: coerce answers to UTF-8 on Windows
References: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 13:17:12 -0700
In-Reply-To: <pull.578.git.1583954676691.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 11 Mar 2020 19:24:36
        +0000")
Message-ID: <xmqqa74mhcjb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB9AEC2-63D5-11EA-847D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/git-gui--askpass b/git-gui--askpass
> index 4277f30c411..b0704e6d91e 100755
> --- a/git-gui--askpass
> +++ b/git-gui--askpass
> @@ -56,6 +56,11 @@ proc finish {} {
>  		}
>  	}
>  
> +	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
> +		if {$::tcl_platform(platform) eq {windows}} {

The indentation looks funny here.  Dedent one level?

> +		set ::answer [encoding convertto utf-8 $::answer]
> +	}

Looks correct (assuming that $::answer we got is Unicode "string",
and I think that is a sane assumpton as it came directly from a
textvariable bound to an entry widget).

>  	puts $::answer
>  	set ::rc 0
>  }
>
> base-commit: 63a58457e094c9c9bbf562b872009d32f1f88133
