Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4631F731
	for <e@80x24.org>; Wed,  7 Aug 2019 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbfHGRlr (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 13:41:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51285 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfHGRlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 13:41:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BB5277816;
        Wed,  7 Aug 2019 13:41:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1vKFqrAgARIBVnR19UPgREzJS3o=; b=UVN3fW
        R44sXKO3moHQ7MeOm9KKeE6cnJ1zmAVRcFWIwwMQR/0zTQ5BBHBvMVGn+t31WTt7
        LC7U3xs08vICDnExjKBJ2nZyyIqNyJ9n3OPZ+vf+DhblV67itoJp+azgB16cVTp+
        t/35bKfLvGOxGu411EJGQWIZpm6hPxytnm464=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xevJutb68njePEukEoJlWwXm2BYb4zNP
        73VY7EqtMIxKAFwSQhSFRfUy2vWouKbLvTJpWz5r4XphuJQ9uH5Ygmelj0lrebm0
        zu+rcoQOpRnChZTcuuhf1Uqo+0Gm/xJGJjhjErKFtvMCIuWiKyli3sTmC6rl+5ua
        ZUpWVokDLus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92B7C77812;
        Wed,  7 Aug 2019 13:41:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B602777811;
        Wed,  7 Aug 2019 13:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
References: <20190804143919.10732-1-me@yadavpratyush.com>
        <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
        <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
        <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
        <xmqqmuglim9e.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 07 Aug 2019 10:41:40 -0700
In-Reply-To: <xmqqmuglim9e.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Aug 2019 22:21:17 -0700")
Message-ID: <xmqqa7ckj2jv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E5C8EBA-B93A-11E9-BE5B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Pratyush Yadav <me@yadavpratyush.com> writes:
>
>> I'm not too optimistic on finding someone to run this project. I asked
>> on the list who the maintainer is [0], and no one came up. The repo at
>> [1] also seems abandoned.
>
> In the meantime until somebody steps up, I might run my own copy.
>
> I need to allocate a block of time to see how stale Pat's tree is
> (e.g. its mainline may have more commits than what we have pulled,
> in which case we need to be extra careful---these old commits may be
> something Pat found dubious and decided to wait before telling me to
> pull, and we would be better off ignoring them) before I can say
> anything definite, but I am hoping that there won't be too many
> patches flowing to the git-gui project; anything high volume and/or
> tricky tcl/tk would be beyond my capacity as an interim maintainer
> to maintain the quality of the codebase of it.

Well it turns out that the clone I used a few years ago was still
usable X-<, so I made https://github.com/gitster/git-gui/ a
tentative and experimental home to pull from.  I munged the patch to
apply to the git-gui tree, create a topic there, pulled it via subtree
strategy to create a topic 'py/git-gui-do-quit' here, and queued the
result on 'pu'.


