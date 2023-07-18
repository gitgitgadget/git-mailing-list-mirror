Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80149EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGRW3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGRW3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:29:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA88198E
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:29:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98BAE363D5;
        Tue, 18 Jul 2023 18:28:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9sHYLrmfsMjL
        wnwcApVfd0VsHlv7YnpRpBKBMqr6TZg=; b=uyX5Ir7+NJ4M809zge/O26Ii8lP5
        NCUlJZEUaIpqoFTpX9IpKonuTYsJoMjJ8HGipQ7Prq7g+Bt0oYdrP6KiOaBpcg8E
        TOJRsaqYFVgheQRj06hR67lJdTaoKyaHLgq2hx9UEa/1wcdhKiYGqXycHMPQnws7
        sPH6S9RsohcgJWM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81676363D4;
        Tue, 18 Jul 2023 18:28:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA436363D3;
        Tue, 18 Jul 2023 18:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Adam_=5C=22Sinus=5C=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Cc:     git@vger.kernel.org
Subject: Re: receive.denyCurrentBranch=updateInstead won't update the repo
References: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
        <xmqqfs5mgs8v.fsf@gitster.g>
        <CAGE71k2bdy2aYy7speu=OOStopgjzVNOPQ_-V-63aCURLibFWw@mail.gmail.com>
        <CAGE71k3c+CGT=42cfkh+2Z-BcvefojNwpzWfc_XHPkBK8psJfA@mail.gmail.com>
        <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com>
Date:   Tue, 18 Jul 2023 15:28:54 -0700
In-Reply-To: <CAGE71k3tMOtyFVrmGW33RuQ3GufJg8X6ORKCwHQgg6RmXbRCQA@mail.gmail.com>
        ("Adam \"Sinus\" =?utf-8?Q?Skawi=C5=84ski=22's?= message of "Wed, 19 Jul
 2023 00:20:04
        +0200")
Message-ID: <xmqqa5vsg8gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B6A1D1E-25BA-11EE-8D71-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam \"Sinus\" Skawi=C5=84ski"  <adam.skawinski@sinpi.net> writes:

> Correct me if I'm wrong, but I'm looking at receive-pack.c and can't
> grasp one thing.
>
> In receive-pack.c:1452-1453,
>> if (!invoked_hook)
>>   retval =3D push_to_deploy(sha1, &env, worktree->path);
> ... push_to_deploy is reached only if... hook didn't get invoked?

Correct.  The hook is responsible for both DECIDING if it wants to
touch/update the working tree, AND ACTUALLY UPDATING the working
tree itself.

And the entire point of the "hook" is that its update does not have
to be just "checkout the given commit's tree", for which using the
default push-to-deply is sufficient.  It is for those who want to do
more.
