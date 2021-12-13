Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB561C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhLMT3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:29:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64254 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhLMT3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:29:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BEEA15FF35;
        Mon, 13 Dec 2021 14:29:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jNqGdbFFgvlZpCaEInoXGi+lkxbCr5GQPso8qq
        NwQRY=; b=LqMZWfxoeC3Zupz5djIG5W3hbPxRh2MYR+ND0JKNEbrE1X5cpiKdku
        gnzRavGrvHWi6AoEAJP+xOBDuEW55nTpXPzxx4pY2HrNnziOWSoVnRKRZZnpyDiq
        5HDDiZUrNe56ku3jAAlv7TUsQ8CasuNMMnjGQdr/Q6vO7SKbTTTF8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 120FE15FF34;
        Mon, 13 Dec 2021 14:29:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 612B615FF32;
        Mon, 13 Dec 2021 14:29:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
        <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
        <CAE5ih7-ZoKThXefBN=znytQi=z4_notihQdSksYdMTzKDTAb=w@mail.gmail.com>
        <BN8PR12MB33619656D91E92C50FF1B86CC8749@BN8PR12MB3361.namprd12.prod.outlook.com>
Date:   Mon, 13 Dec 2021 11:29:19 -0800
In-Reply-To: <BN8PR12MB33619656D91E92C50FF1B86CC8749@BN8PR12MB3361.namprd12.prod.outlook.com>
        (Joel Holdsworth's message of "Mon, 13 Dec 2021 13:47:49 +0000")
Message-ID: <xmqqv8zsb8xc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F842E63A-5C4A-11EC-B677-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

>> > What unit tests are these? I am happy to test with them.
>> 
>>     cd t
>>     make T=t98* -j$(nproc)
>
> Awesome! Just ran the tests. We got a clean sweep.
>
> With one proviso:
>
> When running the current upstream master git-p4 version, there are errors if /usr/bin/python is not present.
>
> lib-git-p4.sh checks for the presence of python with "test_have_prereq PYTHON" - but if I only have /usr/bin/python3 installed, the prerequisite check passes, but git-p4.py itself fails because the shebang points at python not python3.
>
> On Debian installing the package "python-is-python3" fixes the issue.

Can I take that a distro allowing an installation without
python-is-python3 (or just having only python2) as a sign that
"transtion to 3 only" is a bit premature?

> Perhaps it might help to have something like "test_have_prereq PYTHON3".

Sure, but that defeats the whole notion of "python3 is everywhere,
python2 is dead, and nobody should be using the 2-year dead
version".  "test_have_prereq PYTHON" should be sufficient in such a
world, no?
