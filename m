Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C5ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiISWCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiISWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 18:02:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5E4363D
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 15:02:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCF331422F1;
        Mon, 19 Sep 2022 18:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ZtHq4kL05WYvVrfigVGN8O+6sfQQizPs8ky42
        eIXl0=; b=KpPJWo0ho3S0Csa1jEGZBfsLwlxJUUAuL65cyn3HHb/BASy5w2nF35
        aMU0m6+7ka998T/sjRWI6DDrIq5/F1ZlcSXvP8oEykuIomet389QCHmL8bGSOnnW
        VOn2PN8lFg2b2+CxoahzPvW6g56xditzM8Kdvz8Oq4oipdZ58o0dc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 976AC1422F0;
        Mon, 19 Sep 2022 18:02:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52F6D1422E5;
        Mon, 19 Sep 2022 18:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
        <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
        <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
Date:   Mon, 19 Sep 2022 15:02:02 -0700
In-Reply-To: <b727c25c-469f-ca56-bbd6-82f82c762523@github.com> (Derrick
        Stolee's message of "Mon, 19 Sep 2022 14:33:51 -0400")
Message-ID: <xmqqr10781lx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2B9024A-3866-11ED-AE55-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>  int32_t array_container_write(const array_container_t *container, char *buf);
>> +
>> +int array_container_network_write(const array_container_t *container,
>> +				  int (*write_fn) (void *, const void *, size_t),
>> +				  void *data);
>
> Should we make write_fn a defined type? I'm not sure I've seen this
> implicit type within a function declaration before.

Unless we can point out why having a named type is a good idea
(e.g. we add such a function pointer as a member of a struct, or we
keep a variable of that type somewhere), I actually would prefer to
do without them.

Perhaps there are some more important reasons I am missing why we
often come up with explicit types for callback function pointers in
many parts of our API, but if there aren't, my preference actually
is to lose them, not add more of them.

Hmph.... could "a typedef can become a place to give definitive
documentation for the class of callback functions" be a good reason
why we would want one?  I dunno.

In the posted patch, readers cannot tell what kind of three
parameters they are supposed to give to write_fn().

Thanks.
