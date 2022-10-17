Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6AAC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 05:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJQFvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 01:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJQFvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 01:51:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4E558C1
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 22:51:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 596A91ADA8E;
        Mon, 17 Oct 2022 01:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=r6QZ5qkly05dFv5bYLNEESO7+BI6WfPj22/0SCW9s7k=; b=xJIi
        3/1qqKUnnXeR/FkEtZheE09QqH4b5/YfdwwlNw7/K+1jMrVGTz1fgs7UFtfl5s7e
        1NCDOnJMULZpZC3875ZsLFU6nAKkbXz4keJAIhDYXmkZXHJNvGOF21emy+0bzODk
        CreV1yG+QAu7SQ581Ps1r/GAT6Wpftn9qpp0JBs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C911ADA8D;
        Mon, 17 Oct 2022 01:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 829A41ADA89;
        Mon, 17 Oct 2022 01:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
        <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
        <xmqqczaube8o.fsf@gitster.g>
        <CAPMMpohWE17xk4fF+uQja0jfn53bjgVtg75FKEC1w0Km7U8Dvg@mail.gmail.com>
Date:   Sun, 16 Oct 2022 22:50:58 -0700
Message-ID: <xmqqa65v2e2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD193196-4DDF-11ED-A0C2-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>>  * If the command line says --gui or --no-gui that makes the setting
>>    irrelevant, it is OK for us to give a warning to remind the user
>>    that they may want to fix the spelling of the variable, but
>>    otherwise go ahead and perform the action as they asked us to.
>
> In the current implementation, there is no warning if the choice has
> been explicitly made - there is no reason to check the configured
> default under such circumstances.

Yeah, not making any noise is better.  I only meant that if the
implementation warns in this irrelevant case, it is OK (aka
"acceptable, not necessarily desired") as long as it does not stop.

>>  * If the command line lacks --gui or --no-gui, we do need to have a
>>    usable value in the configuration, and we should error out
>>    without spawning either gui or no-gui tool backend.
>
> This is *not* the current behavior - currently an error is printed,
> but execution continues with a no-gui default. I will correct this.

Sounds good.

> 'difftool.guidefault' - must be boolean or 'auto'", we get the
> *default* error message for *boolean* config settings: "fatal: bad
> boolean config value 'autod' for 'difftool.guidefault'".

Yeah, I do not think it is a problem, and it is not misleading, as
long as the user knows how to ask further information with "git
difftool --help" and the help page says what the acceptable values
are other than Boolean yes/no.

Thanks.

