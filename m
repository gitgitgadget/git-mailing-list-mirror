Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C489EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGLUd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLUd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:33:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619C1FC0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:33:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD5B81A2149;
        Wed, 12 Jul 2023 16:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8kM0i8TQC9J+ECnYrw5+vvRqCD79bJf1yEODhd
        kRvc8=; b=INOrM+B2NllsFmKmKIOScyYkzsTM9GsFxUmOx7KZEdX2Wj2Hf1+21r
        eKjO8s5g3/JsfEZubZCA+Fp3P4l1t3q/8I3w0p2kxSPxh33KUfLbOtPhIF/lsEtR
        oGUT97FOmsZnpTHSxZ/lTN5LfjeuL5rDJHBE6eA/3EMpbCZHaPizo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C52181A2148;
        Wed, 12 Jul 2023 16:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30ADB1A2147;
        Wed, 12 Jul 2023 16:33:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: remove mentions of .gitmodules !command syntax
References: <20230712160216.855054-1-pvutov@imap.cc>
        <xmqqleflt75z.fsf@gitster.g>
        <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <xmqqfs5tt3qz.fsf@gitster.g>
        <7090349c-4485-d5c4-1f26-190974864f72@imap.cc>
Date:   Wed, 12 Jul 2023 13:33:55 -0700
In-Reply-To: <7090349c-4485-d5c4-1f26-190974864f72@imap.cc> (Petar Vutov's
        message of "Wed, 12 Jul 2023 20:48:10 +0200")
Message-ID: <xmqqa5w0swcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C5BF368-20F3-11EE-A07F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> On 7/12/23 19:54, Junio C Hamano wrote:
>> Perhaps
>>      "... available via the ... configuration variable, and cannot
>> be
>>      used in the .gitmodules file"
>> would have helped you?
>> Thanks.
>
> I think that addition is good and makes the intent clearer.
>
> But it's slightly wrong - only 'custom command' cannot be used in
> .gitmodules. 'none' is legal (and mentioned in the gitmodules doc as
> such).

Hmph, that will be a bugfix for fc01a5d2 (submodule update
documentation: don't repeat ourselves, 2016-12-27).  I think you are
technically correct.

    Side note: but is there a useful use case to set it to 'none' in
    ".gitmodules" in the first place?  If there is not, saying that
    "'none' is only useful in the configuration files" is not quite
    wrong per-se.

>  	merge;; the commit recorded in the superproject will be merged
>  	    into the current branch in the submodule.
>
> -The following 'update' procedures are only available via the
> -`submodule.<name>.update` configuration variable:
> -
>  	custom command;; arbitrary shell command that takes a single
>  	    argument (the sha1 of the commit recorded in the
>  	    superproject) is executed. When `submodule.<name>.update`
>  	    is set to '!command', the remainder after the exclamation mark
>  	    is the custom command.
> ++
> +Custom commands are only available via the `submodule.<name>.update`
> +configuration variable. They cannot be used in the .gitmodules file.

Sounds good.  s/available/allowed/, perhaps.

>  	none;; the submodule is not updated.
> ++
> +The `none` update procedure is only available via the .gitmodules file
> +or the `submodule.<name>.update` configuration variable.

This side we do not need "only" anywhere in the sentence, do we?

Thanks.
