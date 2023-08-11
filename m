Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA462C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjHKUo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKUo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:44:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C982D54
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:44:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 290491A644B;
        Fri, 11 Aug 2023 16:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JxRq999eIXRJ6Bidx4kt6ZIkZyz7UBrIvwpLwc
        CLTFA=; b=fkA+LqbuTI+9n/IL//TaIYU3O2REM4RE0ZBhFPnfI1/nGwcK9zD1RC
        k7jhueH8mw4XQYms69TFCd+txbJsCWL4EjUh1e0gWgY5IZOHOYbJL/PGCPulVrWU
        vzM3LLNg4VHDocxHNLuUUHXS5L14HJ/5LXptt6wpDrgzWdAbMt/Q8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 122681A644A;
        Fri, 11 Aug 2023 16:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AC8B1A6446;
        Fri, 11 Aug 2023 16:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
Subject: Re: "fatal: Not a git repository" issued during 'make' from source
 code
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
        <xmqqr0o9qpon.fsf@gitster.g>
Date:   Fri, 11 Aug 2023 13:44:24 -0700
In-Reply-To: <xmqqr0o9qpon.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        11 Aug 2023 13:39:20 -0700")
Message-ID: <xmqqmsyxqpg7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBCDD1CA-3887-11EE-BF10-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> <rsbecker@nexbridge.com> writes:
>
>> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
>>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I run
>> 'make
>>>prefix=/usr/local all doc', I get the following error:
>>>
>>>fatal: Not a git repository (or any parent up to mount point /tools)
>>>
>>>Which I infer means that I need to do the build within a git repo.  Is that
>> correct?  Or
>>>have I missed some basic step in the build process?
>>
>> Yes, you must be in the cloned git repository in order to run the build.
>
> Shouldn't we be able to build out of a tarball?

In other words,

    $ mkdir -p /var/tmp/x
    $ cd /var/tmp/x
    $ wget http://www.kernel.org/pub/software/scm/git/testing/git-2.42.0.rc1.tar.xz
    $ tar xf git-2.42.0.rc1.tar.xz
    $ cd git-2.42.0.rc1
    $ make prefix=/var/tmp/local all doc
    $ sudo make prefix=/var/tmp/local install

is what I just did to make sure that a build from our tarball extract
does not require a git repository (it would be a bug to require one,
as it would make it impossible to bootstrap).
