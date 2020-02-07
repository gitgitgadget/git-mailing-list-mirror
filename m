Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE3C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B320726
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGdo27nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgBGSRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:17:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54948 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBGSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 13:17:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2740ABF48E;
        Fri,  7 Feb 2020 13:17:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OXLCKPr2CiGUszNVpOvN5ivNIog=; b=XGdo27
        nkgHealFryvccBtMHX4JcmrLosf6aH9lDBG54EXz0D4jbpasOdY2eiefNy/fvKsx
        xWt2JUkGJ1gStpRuXEbCNQ1GqSDYOPu3k5V9g7Xd5K80MgvrkAwwTC3t244/7zW5
        sJBMc0H3CSCFesETYTEeA79nSYS4+PCx28U3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MG5UvuiXtFuRDnz6GHgvtur6DSDaRdUa
        7PpHpjZXUUNxCPJcLYii1/lLi4wzNWvQtlAzCQI1fqusIwvhmjlwhjoIMIO5Q5UN
        mYE5btwMyAZQ9uACZ4AtJmwBNUf3qKUTY9WQVoCtzyjNj6BHK7pRitZeAWnpRvU8
        kFzXB+XtE7k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F155BF48D;
        Fri,  7 Feb 2020 13:17:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48F31BF48C;
        Fri,  7 Feb 2020 13:17:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Markus Klein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Markus Klein <masmiseim@gmx.de>
Subject: Re: [PATCH v2] clone: use submodules.recurse option for automatically clone submodules
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
        <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
        <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002071621160.3718@tvgsbejvaqbjf.bet>
Date:   Fri, 07 Feb 2020 10:17:05 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002071621160.3718@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 7 Feb 2020 16:45:42 +0100
        (CET)")
Message-ID: <xmqqeev645zy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CB3472E-49D6-11EA-8806-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 	if (!strcmp(var, "submodule.recurse")) {
>> 		if (git_config_bool(var, value))
>> 			...
>> 		return 0; /* done with the variable either way */
>> 	}
>>
>> is more appropriate.
>
> Good catch, and I think you will have to do even more: in the "else" case,
> it is possible that the user overrode a `submodule.recurse` from the
> system config in their user-wide config, so we must _undo_ the
> `string_list_append().

Yeah, I tend to agree that submodule.recurse should not be made into
a multi-valued fields with this change; it should stay to be the
usual last-one-wins single boolean.

> Further, it is probably not a good idea to append "true" _twice_ if
> multiple configs in the chain specify `submodule.recurse = true`.

The user of this list in cmd_clone() first sorts and dedups, so
appending the same is OK, even though it may appear sloppy.
