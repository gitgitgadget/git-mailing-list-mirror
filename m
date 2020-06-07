Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819B6C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E6F2067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oIonSKQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgFGRKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:10:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55122 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgFGRKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 13:10:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C1155BE66;
        Sun,  7 Jun 2020 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/qqcpLxQQpMYmWMYgJDlwdrPxA=; b=oIonSK
        QX5BTrMTq1OJnz/eLXTiF4ORzRpIUFGbocLJR+TZs5kDtIrVitXi804iHNMrdC50
        XEEmrDMq2waG9iAW0aQ1iQQLL9OijSj2cgrZjIos36IVf3WXbzRJhq2biKyvv+0D
        nsf/gRoQ7vnITFMFZScPOu+qvu/jBBv/ms9Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vUjKsuWA19s7n4Zt1zNAMcqp8ibfuaNd
        9CubTj6+q1JnJxb47R2FXMUiffrCO24mp4wjmyDrG435+7JL1FyFAmUenuVL+Klv
        trR8JHag9aaeFSfiaIwPwLcG15swgGHsa2L4oMc7LdN7lOp8B+uUocrgrtfl5i5e
        yh7nyHjhUMo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72A6F5BE64;
        Sun,  7 Jun 2020 13:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5CCD5BE63;
        Sun,  7 Jun 2020 13:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] Recommend "git gc --auto" instead of "git prune"
References: <pull.651.git.1591546715913.gitgitgadget@gmail.com>
        <20200607162556.GJ6569@camp.crustytoothpaste.net>
Date:   Sun, 07 Jun 2020 10:10:19 -0700
In-Reply-To: <20200607162556.GJ6569@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 7 Jun 2020 16:25:56 +0000")
Message-ID: <xmqq8sgyn6o4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C413EF94-A8E1-11EA-A075-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 8e0b9cf41b3..3833a3de332 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  
>>  	if (auto_gc && too_many_loose_objects())
>>  		warning(_("There are too many unreachable loose objects; "
>> -			"run 'git prune' to remove them."));
>> +			"run 'git gc --auto' to remove them."));
>
> I'm not sure this is correct.  If we have just expelled a large number
> of objects from a pack into loose objects because they're no longer
> referenced, it's possible we may trigger another git gc --auto on the
> next time we run a command.  If so, no amount of git gc --auto is going
> to help here; you really have to run git prune.

Correct.  When running manually, after noticing the need to do a GC,
it is a mental bug to add "--auto" to it, I would think.
