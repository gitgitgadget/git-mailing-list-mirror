Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D2C33C9E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 02:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3A4206ED
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 02:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xPOZ7gJP";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="sVJfwZzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgAICj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:39:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63428 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAICj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 21:39:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9005C3A61C;
        Wed,  8 Jan 2020 21:39:27 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=pCYoOA0jQkMawkvtXR9Wb/VUp1Y=; b=xPOZ7g
        JPBnTSlB+ykogMg5eDHPs97kb0GNL+rffYrAnti4J89cDx/TkDkpUwc9c49Bu3tw
        ljdycP8lajw6QYzIrTKyk0msQM6CNRuy9zXcE4PPPBc+cra9lo/tuJymqc8rPQUK
        +lL/IZQXIqXu2cM9Ti94wdQ55N3OG/K+B2HZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D6D3A61B;
        Wed,  8 Jan 2020 21:39:27 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=K1BJZDx6DjOXoCjbuarKe6f0cPqHnAdd6571CA1Z3hQ=; b=sVJfwZzHDhM/1TT7bv+Iln9mGVFJVKgScZLzhfKKmYPXfczaja4DTn4igOwQiRh1AFNskwu7/p8LFPC7a3O2uhidq3QRzmN/ugU5aLqzylDeBPSS61nUOQglSer/eiXX0YB8NB3RoxtD3dHBzStrwPncpUm7HtkwlfuEhoRGudM=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD3993A61A;
        Wed,  8 Jan 2020 21:39:26 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Yaroslav O Halchenko <debian@onerussian.com>
Subject: Re: [PATCH] submodule add: show 'add --dry-run' stderr when aborting
In-Reply-To: <20200108214136.GB63040@google.com>
References: <20200108003121.28034-1-kyle@kyleam.com> <20200108214136.GB63040@google.com>
Date:   Thu, 09 Jan 2020 02:39:25 +0000
Message-ID: <87d0btwdya.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40D6B89C-3289-11EA-AA9A-D1361DBA3BAF-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2020.01.07 19:31, Kyle Meyer wrote:
[...]
>> +test_expect_success 'submodule add relays add --dry-run stderr' '
>> +	test_when_finished "rm -rf addtest/.git/index.lock" &&
>> +	(
>> +		cd addtest &&
>> +		: >.git/index.lock &&
[...]
> I had to look up what ":" does, but it looks like it's reasonably widely
> used in other tests so that seems fine. However, it looks like you don't
> even need the : command and can just ">.git/index.lock" by itself (see
> the "setup - initial commit" test case in this file for an example).

Indeed.  I spot some recent commits that added new instances of ": >",
so I suspect it's not strongly discouraged in this project, but I'm not
particularly attached to the unneeded colon :>

> Looks good to me. Thanks for the patch!

Thanks for the review!
